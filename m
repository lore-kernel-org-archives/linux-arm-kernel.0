From: mattia.jona@gmail.com (Mattia Jona-Lasinio)
Date: Thu, 22 Jul 2010 13:00:34 +0200
Subject: Introducing the LCD-Linux project
Message-ID: <AANLkTil5Gz4i6iGZcaAcU0hg_ynNP1UR7bLwv_VQU6Wm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Pfaff <blp@cs.stanford.edu> writes:

> When I wanted to solve the same problem for a small
> serial-connected LCD panel (sold under the name EZIO), I wrote a
> program called "ezio-term" that has the same functionality but
> runs entirely in userspace.  It connects to the serial port and
> speaks the EZIO protocol on the serial port, and it creates a pty
> and acts like an ANSI terminal on that pty.  Thus, it translates
> back and forth between the two protocols.
>
> ezio-term also comes with a terminfo description that lets
> programs take advantage of the special features of the LCD panel.
> ezio-term also has the "virtual screen larger than physical
> screen" feature that you mention elsewhere, although it currently
> only implements an extra-wide screen, not an extra-tall one.

This is indeed a possibility. However, in my opinion, it always suffers
the same problems: if you change the display, you have to rewrite everything
from scratch since the protocol for a different display will be different.
The big problem is that there is no standard protocol or connection type for
these small devices; nothing comparable with the VGA standard, for example.
The idea is therefore to write a minimal terminal emulation for a general
abstract display so that the general question about WHAT has to be done
is solved once for all, pushing the question about HOW to do it in a very small
piece of code.

> ezio-term solves the first problem you mention.  I'm not sure I
> understand how the second one would come about across a serial or
> parallel or USB connection.

Hmmmm, you are probably right about serial and USB (which is in any case serial)
connections. But for parallel port connections the situation is
different, since you
speak directly with the display controller, so all timing issues are
up to you. For
instance the hd44780 needs timings in the microsecond range. How would you
obtain this in userspace without doing something like real time scheduling?
Of course you can also increase timing but the display refresh will be obviously
worse. In embedded systems these devices can be connected to GPIO lines. The
access is through memory mapped ports. In some sense this is similar to a
parallel port connection but still you are concerned with timing issues.

I downloaded your program and I'm going through it.

Regards,

Mattia
