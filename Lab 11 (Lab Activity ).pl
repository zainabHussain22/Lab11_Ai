
:- dynamic letters/1.

letters([a,b,c]).

start :-
    menu.

menu :-
    nl,
    write('Hi. This is the Name Game.'), nl,
    write('You will be given a set of English letters'), nl,
    write('to create your name.'), nl, nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    action(Choice).

action(1) :-
    letters(L),
    write('Current letters: '),
    write(L), nl,
    menu.

action(2) :-
    write('Enter a letter: '),
    read(X),
    letters(L),
    append(L, [X], NewL),
    retract(letters(L)),
    assertz(letters(NewL)),
    write('Letter added.'), nl,
    menu.

action(3) :-
    write('Enter a letter: '),
    read(X),
    letters(L),
    NewL = [X|L],
    retract(letters(L)),
    asserta(letters(NewL)),
    write('Letter added at the top.'), nl,
    menu.

action(4) :-
    write('Enter a letter: '),
    read(X),
    letters(L),
    append(L, [X], NewL),
    retract(letters(L)),
    assertz(letters(NewL)),
    write('Letter added at the bottom.'), nl,
    menu.

action(5) :-
    write('Enter the letter to delete: '),
    read(X),
    letters(L),
    (   select(X, L, NewL)
    ->  retract(letters(L)),
        assertz(letters(NewL)),
        write('Letter deleted.'), nl
    ;   write('Letter not found.'), nl
    ),
    menu.

action(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    write('All letters deleted.'), nl,
    menu.

action(7) :-
    write('Goodbye!'), nl.

action(_) :-
    write('Invalid choice.'), nl,
    menu.
