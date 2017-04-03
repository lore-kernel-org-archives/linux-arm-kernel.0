From: alan@linux.intel.com (Alan Cox)
Date: Mon, 03 Apr 2017 19:05:19 +0100
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
 <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
 <1491224186.3704.11.camel@linux.intel.com>
 <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
Message-ID: <1491242719.3704.33.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> evertheless very convenient to be able to use a standard
> shell?
> with it.

A standard shell will work over things other than a tty device. It
really doesn't care so long as it gets a stream of data punctuated by
end of statement symbols. It'll work over pipes, sockets, from files.

> I beg to disagree here.??First, before you call my code "totally?
> unmaintainable" I'd politely ask you to have a look at it first.

I said the combination makes it more unmaintainable. If you have two
tty layers one of them faking the API of the other at various interface
points then if the core tty layer wants to make a major change it no
longer can - because it'll break the other tty layer. In addition I
worry it won't be long before someone wants kgdb, gdbstubs and sysrq
over the cut down console and on it will go.

The uart layer is also known broken as an API - it is itself bloated
and over-locking (for example if it was being written today kfifo would
be used). What happens if we want to abolish it or encourage people to
move away from it (as we IMHO should be) ?

The serio code started with exactly the same problem, but now at least
talks tty layer. In your case you are tying it to something we
eventually ought to get rid of.

I also find the large scale need for it hard to believe. If you are
within 64K of running out of memory on your debug/devel device how are
you going to have space to fix security holes and do upgrades as they
occur in production (where presumably you don't need the tty driver) ?
The kernel doesn't exactly get smaller each release.

Alan
