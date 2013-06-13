From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 13 Jun 2013 16:08:32 -0400
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306131526500.1561-100000@iolanthe.rowland.org>
Message-ID: <1371154112.9844.306.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-13 at 15:41 -0400, Alan Stern wrote:

> The test results above show a 2.4% degradation for threaded interrupts 
> as compared to tasklets.  That's in addition to the bottlenecks caused 
> by the device; no doubt it would be worse for a faster device.  This 
> result calls into question the benefits of threaded interrupts.

That's because it was written like a top half and not a full blown
interrupt. I just looked at the patch, and saw this:

+#ifndef USB_HCD_THREADED_IRQ
        if (sched) {
                if (async)
                        tasklet_schedule(&bh->bh);
                else
                        tasklet_hi_schedule(&bh->bh);
        }
+#else
+       if (sched)
+               schedule_work(&hcd->periodic_bh->work);
+#endif

What is this? The work isn't done by an interrupt thread, but by work queues!

The point of the interrupt thread is that you do *all* the work that
needs to be done when an interrupt comes in. You don't need to delay the
work.

If you just treat a threaded interrupt like a real interrupt and push
off work to something else, then yes, it will degrade performance.

If you go the threaded interrupt route, you need to rethink the
paradigm. There's no reason that the interrupt handler needs to be fast
like it needs to be in true interrupt context. The handler can now use
mutexes, and other full features that currently only threads benefit
from. It should improve locking issues, and can serialize things if
needed.

All this patch did was to switch the main irq to a thread and make a
bottom half into a work queue.

Why couldn't you just do:

	if (sched)
		usb_giveback_urb_bh(bh);

?

-- Steve
