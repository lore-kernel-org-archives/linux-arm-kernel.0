From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Dec 2009 19:34:53 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <20091205115754.7e1dc0fd.ospite@studenti.unina.it> (Antonio
	Ospite's message of "Sat\, 5 Dec 2009 11\:57\:54 +0100")
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>
Message-ID: <87638k9cj6.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Hi,
>
> I've run into this recently, I get it with 2.6.32 (plus some code for
> the EZX platform) especially using ROOT_NFS over usblan. It looks like
> I can also trigger it regularly by connecting and disconnecting usb
> cable repeatedly while the kernel on the pxa system is loading
> (in a _non_ ROOT_NFS scenario).

Your discovery is very ... unfortunate for me.
What you discovered is a real locking issue in pxa27x_udc, which can be
outlined as :

 1) an irq comes in for endpoint 1 (OUT endpoint)
 2) irq handler kick in
    handle_ep()
 3) the packet is smaller than the endpoint fifo
    3a) it gets read fully
    3b) it's a usb short packet
    3c) the transfer is completed
    req_done() is called
 4) req_done() calls gadget layer
    req->req.complete()
 5) gadget layer complete() function pushes another request to pxa27x_udc
    (notice we're still in the irq handler)
    pxa_ep_queue()
    (notice we take the ep->lock)
 6) pxa27x_udc calls handle_ep()
 7) same as (3)
 8) same as (4)
 9) same as (5)
    => here, pxa_ep_queue() tries to take the ep->lock twice !!!
    => this is the deadlock

Summary is :
 irq_handler
   \
    -> gadget.complete()
       \
        -> pxa27x_udc.pxa_ep_queue() : implies ep->lock is taken
           \
            -> gadget.complete()
               \
                -> pxa27x_udc.pxa_ep_queue() : implies ep->lock is attempted
                                               ==> *deadlock*

The point here an architectural one : can the gadget layer, in its completion
method, call endpoint queuing methods ?

If so, when nuke() is called, gadget_complete() is always called, which could
call request queuing, etc ..., which will become an infinite loop.

I may modify the locking model of pxa27x_udc : whenether I call the gadget
complete() method, I relax the ep->lock, and take it just after. That makes me a
bit nervous, but I'll do it if this is the thing to do.

David, could you give me the point of view of the gadget architecture please ?

Cheers.

--
Robert
