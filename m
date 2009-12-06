From: david-b@pacbell.net (David Brownell)
Date: Sun, 6 Dec 2009 12:13:38 -0800
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87638k9cj6.fsf@free.fr>
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
	<87638k9cj6.fsf@free.fr>
Message-ID: <200912061213.39183.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2009, Robert Jarzmik wrote:
> I may modify the locking model of pxa27x_udc : whenether I call the gadget
> complete() method, I relax the ep->lock, and take it just after. That makes me a
> bit nervous, but I'll do it if this is the thing to do.
> 
> David, could you give me the point of view of the gadget architecture please ?

Dropping the lock before complete() is exactly the right thing to do.

But make sure your ep_queue() method understands that sometimes it's
only supposed to *queue* and not activate tx/rx.

So the IRQ handler sets some "don't touch the hardware" flag before
it drops that lock, reentrant queue() sees it, complete() returns with
the only change being queue updates ... and before the IRQ handler
returns, it looks to see if there's work to be done on that EP.

Most UDC drivers don't have hardware queues to worry about, so the
completion callback should also be able to dequeue() requests that
aren't yet being handled by the HW ... another nuance, but one that
won't usually mean extra work.

- Dave
