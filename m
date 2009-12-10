From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Dec 2009 18:49:31 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <200912061213.39183.david-b@pacbell.net> (David Brownell's
	message of "Sun\, 6 Dec 2009 12\:13\:38 -0800")
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87638k9cj6.fsf@free.fr> <200912061213.39183.david-b@pacbell.net>
Message-ID: <87tyvywwgk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Brownell <david-b@pacbell.net> writes:

> On Sunday 06 December 2009, Robert Jarzmik wrote:
> Dropping the lock before complete() is exactly the right thing to do.
Good, just as Alan said too.

> But make sure your ep_queue() method understands that sometimes it's
> only supposed to *queue* and not activate tx/rx.
Yes, I understand. A kind of atomic count, on all methods called from gadget,
which prevents reentrance (ie. no chains queue()->...->complete()->queue()).

As I have a bit of luck, all transfers are triggered through handle_ep(), which
if not called won't trigger any rx/tx (if counter was incremented).

Thanks for the info.

--
Robert
