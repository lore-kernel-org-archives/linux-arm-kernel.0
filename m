From: blp@cs.stanford.edu (Ben Pfaff)
Date: Wed, 21 Jul 2010 09:38:54 -0700
Subject: Introducing the LCD-Linux project
References: <AANLkTikitTGpiE5Oe_P5a4f2OCOnlB9j_LVm5CQhQIno@mail.gmail.com>
Message-ID: <874ofsdc2p.fsf@benpfaff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mattia Jona-Lasinio <mattia.jona@gmail.com> writes:

> The possibility to connect to the computer small alphanumeric
> as well as graphic displays, has always attracted some
> interest. These small devices are connected to the computer and
> can be used to display system diagnostics like network usage,
> RAM or disk usage or even to replace the usual
> monitor. Possible applications can be found in embedded systems
> or clusters. These displays are connected to the computer
> through serial lines, parallel ports and more recently through
> USB connections. Appropriate programs in userspace gather the
> desired information and output it on the display. However for
> this to work, the userspace program has to implement some sort
> of display management, to determine what must be displayed
> where. This has two major disadvantages. First. Every userspace
> program willing to drive a display must solve the very same
> problems (display scroll and refresh, for instance), resulting
> in an overall duplication of code. Second. Display controllers
> usually require quite strict timings for proper operation and
> it is not trivial neither efficient to obtain this in
> userspace, whereas it is straightforward in kernel space
> through the usual delay functions. A solution is therefore to
> provide a sort of minimal terminal emulation in kernel space,
> that can be accessed through the standard character device
> interface. In this way the problem of the display management is
> reduced to some calls to the usual read/write/seek/ioctl
> routines. At the same time one has the possibility to implement
> handling of escape sequences, thus opening the way to standard
> applications based on the ncurses library.

When I wanted to solve the same problem for a small
serial-connected LCD panel (sold under the name EZIO), I wrote a
program called "ezio-term" that has the same functionality but
runs entirely in userspace.  It connects to the serial port and
speaks the EZIO protocol on the serial port, and it creates a pty
and acts like an ANSI terminal on that pty.  Thus, it translates
back and forth between the two protocols.

ezio-term also comes with a terminfo description that lets
programs take advantage of the special features of the LCD panel.
ezio-term also has the "virtual screen larger than physical
screen" feature that you mention elsewhere, although it currently
only implements an extra-wide screen, not an extra-tall one.

ezio-term solves the first problem you mention.  I'm not sure I
understand how the second one would come about across a serial or
parallel or USB connection.

ezio-term is distributed as part of Open vSwitch, in the
directory extras/ezio.  You can clone the Open vSwitch Git
repository with:
        git clone git://openvswitch.org/openvswitch
-- 
"Premature optimization is the root of all evil."
--D. E. Knuth, "Structured Programming with go to Statements"
