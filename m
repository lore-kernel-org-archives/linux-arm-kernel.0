From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 10 Sep 2012 20:18:10 +0100
Subject: [PATCH 06/14] tty/serial/core: Introduce poll_init callback
In-Reply-To: <20120910175725.GA13673@lizard>
References: <20120910040802.GA1261@lizard> <20120910041335.GF29537@lizard>
 <20120910121320.03c9dfc7@pyramind.ukuu.org.uk>
 <20120910175725.GA13673@lizard>
Message-ID: <20120910201810.409a58ea@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > What stops a parallel open or close changing ASYNC_INITIALIZED after you
> > test and before you lock ?
> 
> Yeah, I should do the whole thing under the mutex.

Can you use test_bit() as well. I'm trying to gradually push all the code
that way so people habitually use set_bit() and we don't get any (more)
races where some compile situations and architectures otherwise create

	load to register
	register ored with constant
	write back

> Not related to this particular issue, but the fact that close() can powerdown
> the hardware is quite bad. Today it is always possible to use open,close
> sequence on /dev/ttyXXXX, and polling would break if close() deinitializes the
> hardware (e.g. via uart_change_pm()).

One of the long term goals of tty_port has always ben to have an object
with the lifetime of the physical port so this kind of thing can be fixed.

> In console= case, serial core handles the issue via uart_console(), checking if
> the port is used for console, preventing it to power down the hardware. We can
> do the same, or make tty_find_polling_driver() refcount individual ports/lines.
> But the issue is orthogonal to this particular patch, although needs to be
> fixed some day.

Agreed - however you'll need a separate refcount than the main tty one
for this, because we still need to do a hangup() on the final "tty" close
even if the hardware is 'pinned' for a debugger.

Alan
