From: david-b@pacbell.net (David Brownell)
Date: Sun, 6 Dec 2009 12:23:00 -0800
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <Pine.LNX.4.44L0.0912061458540.7903-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0912061458540.7903-100000@netrider.rowland.org>
Message-ID: <200912061223.00528.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2009, Alan Stern wrote:
> That's what other device controller drivers do. ?There's no choice. ?
> (Except that I'm not sure they have individual locks for endpoints -- 
> just one single big spinlock.)

Right; such fine grain locking tends to be more hassle than it's
worth.  ISTR studies from a while back showing locks need to be
quite heavily contended before splitting them is worth much.  Any
per-controller lock for a UDC is unlikely to see much contention.


> In fact, host controller drivers do the analogous thing. ?When they
> give back completed URBs, they release their private spinlocks.

For *exactly* the same reason.  Upper level driver code shouldn't
need to worry about whether it's re-entering some random bit of
lower level code.  As a rule, it can't know about that code.
