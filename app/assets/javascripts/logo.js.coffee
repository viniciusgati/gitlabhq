NProgress.configure(showSpinner: false)

delay = 150
defaultClass = 'tanuki-shape'
pieces = [
  'path#tanuki-right-cheek',
  'path#tanuki-right-eye, path#tanuki-right-ear',
  'path#tanuki-nose',
  'path#tanuki-left-eye, path#tanuki-left-ear',
  'path#tanuki-left-cheek',
]
firstPiece = pieces[0]
timeout = null

clearHighlights = ->
  $(".#{defaultClass}.highlight").attr('class', defaultClass)

start = ->
  clearHighlights()
  pieces.reverse() unless pieces[0] == firstPiece
  work(0)

stop = ->
  window.clearTimeout(timeout)
  clearHighlights()

work = (pieceIndex) ->
  # jQuery's addClass won't work on an SVG. Who knew!
  $piece = $(pieces[pieceIndex])
  $piece.attr('class', "#{defaultClass} highlight")

  timeout = setTimeout(->
    $piece.attr('class', defaultClass)

    # If we hit the last piece, reset the index and then reverse the array to
    # get a nice back-and-forth sweeping look
    if pieceIndex + 1 >= pieces.length
      nextIndex = 0
      pieces.reverse()
    else
      nextIndex = pieceIndex + 1

    work(nextIndex)
  , delay)

$(document).on 'page:fetch',  start
$(document).on 'page:change', stop
