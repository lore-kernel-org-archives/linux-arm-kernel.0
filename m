From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 6 Dec 2009 15:01:19 -0500 (EST)
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <87638k9cj6.fsf@free.fr>
Message-ID: <Pine.LNX.4.44L0.0912061458540.7903-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Dec 2009, Robert Jarzmik wrote:

> Your discovery is very ... unfortunate for me.
> What you discovered is a real locking issue in pxa27x_udc, which can be
> outlined as :
> 
>  1) an irq comes in for endpoint 1 (OUT endpoint)
>  2) irq handler kick in
>     handle_ep()
>  3) the packet is smaller than the endpoint fifo
>     3a) it gets read fully
>     3b) it's a usb short packet
>     3c) the transfer is completed
>     req_done() is called
>  4) req_done() calls gadget layer
>     req->req.complete()
>  5) gadget layer complete() function pushes another request to pxa27x_udc
>     (notice we're still in the irq handler)
>     pxa_ep_queue()
>     (notice we take the ep->lock)
>  6) pxa27x_udc calls handle_ep()
>  7) same as (3)
>  8) same as (4)
>  9) same as (5)
>     => here, pxa_ep_queue() tries to take the ep->lock twice !!!
>     => this is the deadlock
> 
> Summary is :
>  irq_handler
>    \
>     -> gadget.complete()
>        \
>         -> pxa27x_udc.pxa_ep_queue() : implies ep->lock is taken
>            \
>             -> gadget.complete()
>                \
>                 -> pxa27x_udc.pxa_ep_queue() : implies ep->lock is attempted
>                                                ==> *deadlock*
> 
> The point here an architectural one : can the gadget layer, in its completion
> method, call endpoint queuing methods ?
> 
> If so, when nuke() is called, gadget_complete() is always called, which could
> call request queuing, etc ..., which will become an infinite loop.
> 
> I may modify the locking model of pxa27x_udc : whenether I call the gadget
> complete() method, I relax the ep->lock, and take it just after. That makes me a
> bit nervous, but I'll do it if this is the thing to do.

That's what other device controller drivers do.  There's no choice.  
(Except that I'm not sure they have individual locks for endpoints -- 
just one single big spinlock.)

In fact, host controller drivers do the analogous thing.  When they
give back completed URBs, they release their private spinlocks.

> David, could you give me the point of view of the gadget architecture please ?

Alan Stern
