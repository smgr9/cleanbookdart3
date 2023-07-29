// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/user_cases/fetch_newset_books_use_case.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'newset_book_state.dart';

class NewsetBookCubit extends Cubit<NewsetBookState> {
  NewsetBookCubit(this.fetchNewsetBooksUseCase) : super(NewsetBookInitial());

  final FetchNewsetBooksUseCase fetchNewsetBooksUseCase;
  Future<void> fetchNewsetsBooks() async {
    emit(NewsetBookLoading());
    var result = await fetchNewsetBooksUseCase.call();
    result.fold((failure) {
      emit(NewsetBookFailure(failure.errMessage));
    }, (books) {
      emit(NewsetBookSuccess(books));
    });
  }
}
