From: trimarchi@gandalf.sssup.it (Michael Trimarchi)
Date: Tue, 30 Mar 2010 23:26:12 +0200
Subject: [BUG] pxa27x_udc: possible recursive locking detected
	in	pxa_ep_queue
In-Reply-To: <87vdfqx2xw.fsf@free.fr>
References: <20091205115754.7e1dc0fd.ospite@studenti.unina.it>	<87fx7guuzg.fsf@free.fr>	<20091212173140.f9ac2a7b.ospite@studenti.unina.it>	<87ocltsda3.fsf@free.fr>	<20091223005313.13ba5061.ospite@studenti.unina.it>
	<87vdfqx2xw.fsf@free.fr>
Message-ID: <4BB26C74.8010104@gandalf.sssup.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Robert Jarzmik wrote:
> Antonio Ospite <ospite@studenti.unina.it> writes:
>
>   
>> With your latest patch on top of 2.6.32 I get the "possible recursive
>> locking" message at the *first* cable unplug/plug cycle, I am appending
>> it here, the log is partial because I dumped it from RAM and something
>> was lost.
>>     
>
> Thanks.
> Now, lets have another try. This patch is a bit saner, and though I got the
> "locking detected" you noticed without it, I didn't manage to get it with this
> patch applied.
>
> As your test platform is far better than mine, would you mind a bit of testing
> ... again. This patch applies on top of v2.6.32.
>
> Cheers.
>
> --
> Robert
>
> >From 3ca70f842651f607790a2ff94f2b3a7ec223196d Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Sat, 12 Dec 2009 15:13:24 +0100
> Subject: [PATCH] pxa27x_udc: Fix deadlocks on request queueing
>
> As reported by Antonio, there are cases where the ep->lock
> can be taken twice, triggering a deadlock.
> The typical sequence is :
>  irq_handler
>    \
>     -> gadget.complete()
>        \
>         -> pxa27x_udc.pxa_ep_queue() : ep->lock is taken
>            \
>             -> gadget.complete()
>                \
>                 -> pxa27x_udc.pxa_ep_queue() : ep->lock is taken
>                                                ==> *deadlock*
> The patch fixes this by :
>  - releasing the lock each time gadget.complete() is called
>  - adding a check in handle_ep() to detect a recursive call,
>    in which case the function becomes on no-op.
>
> The patch is still not good enough for ep0. For this unique
> endpoint, another well thought over patch will be needed.
>
> Reported-by: Antonio Ospite <ospite@studenti.unina.it>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/usb/gadget/pxa27x_udc.c |  114 +++++++++++++++++++++++++++------------
>  drivers/usb/gadget/pxa27x_udc.h |    6 ++
>  2 files changed, 85 insertions(+), 35 deletions(-)
>   
+       /* don't modify queue heads during completion callback */
+       if (spin_is_locked(&ep->lock)) {
+               spin_unlock(&ep->lock);
+               req->req.complete(&req->udc_usb_ep->usb_ep, &req->req);
+               spin_lock(&ep->lock);
+       } else
+               req->req.complete(&req->udc_usb_ep->usb_ep, &req->req);
 }

I have fixed in the same way without pass the flag

Michael
