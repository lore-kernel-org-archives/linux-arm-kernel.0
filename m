From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 17:09:43 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1371154112.9844.306.camel@gandalf.local.home>
Message-ID: <Pine.LNX.4.44L0.1306131656560.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Steven Rostedt wrote:

> On Thu, 2013-06-13 at 15:41 -0400, Alan Stern wrote:
> 
> > The test results above show a 2.4% degradation for threaded interrupts 
> > as compared to tasklets.  That's in addition to the bottlenecks caused 
> > by the device; no doubt it would be worse for a faster device.  This 
> > result calls into question the benefits of threaded interrupts.
> 
> That's because it was written like a top half and not a full blown
> interrupt. I just looked at the patch, and saw this:
> 
> +#ifndef USB_HCD_THREADED_IRQ
>         if (sched) {
>                 if (async)
>                         tasklet_schedule(&bh->bh);
>                 else
>                         tasklet_hi_schedule(&bh->bh);
>         }
> +#else
> +       if (sched)
> +               schedule_work(&hcd->periodic_bh->work);
> +#endif
> 
> What is this? The work isn't done by an interrupt thread, but by work queues!

You don't understand the patch.  Most of the time, sched will be 0 
here and hence the work queue won't be involved.

Yes, part of the work is done by a work queue rather than the interrupt 
thread.  But it is an unimportant part, the part that involves 
transfers to root hubs or transfers that were cancelled.  These things 
can complete without any interrupt occurring, so they can't be handled 
by the interrupt thread.  However, they are the abnormal case; the 
transfers we care about are not to root hubs and they do complete 
normally.

> The point of the interrupt thread is that you do *all* the work that
> needs to be done when an interrupt comes in. You don't need to delay the
> work.

You've got it backward.  The patch doesn't leave part of the work 
undone when an interrupt occurs.  Rather it's the other way around -- 
sometimes work needs to be done when there isn't any interrupt.  This 
could happen in a timer callback, or it could happen as a direct result 
of a function call.

Since there doesn't seem to be any way to invoke the interrupt thread 
in the absence of an interrupt, Ming pushed the job off to a work 
queue.

> If you just treat a threaded interrupt like a real interrupt and push
> off work to something else, then yes, it will degrade performance.
> 
> If you go the threaded interrupt route, you need to rethink the
> paradigm. There's no reason that the interrupt handler needs to be fast
> like it needs to be in true interrupt context. The handler can now use
> mutexes, and other full features that currently only threads benefit
> from. It should improve locking issues, and can serialize things if
> needed.
> 
> All this patch did was to switch the main irq to a thread and make a
> bottom half into a work queue.

In case it's not clear, the code you quoted above is part of the 
interrupt handler, not part of the thread.

> Why couldn't you just do:
> 
> 	if (sched)
> 		usb_giveback_urb_bh(bh);
> 
> ?

Because usb_giveback_urb_bh() is supposed to run in the context of the
tasklet or interrupt thread or work queue, not in the context of the
interrupt handler.

Alan Stern
