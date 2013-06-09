From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 9 Jun 2013 11:58:18 -0400 (EDT)
Subject: [RFC PATCH 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <1370791112-18464-2-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306091148270.13202-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Jun 2013, Ming Lei wrote:

> This patch implements the mechanism of giveback of URB in
> tasklet context, so that hardware interrupt handling time for
> usb host controller can be saved much, and HCD interrupt handling
> can be simplified.

Why do you want to minimize the hardware interrupt handling time?  The 
total interrupt handling time will actually be increased by your 
change; the only advantage is that much of the work will not be in 
hardirq context.

Also, I suspect that this will make HCD interrupt handling _more_ 
complicated, not less.

> Motivations:
> 
> 1), on some arch(such as ARM), DMA mapping/unmapping is a bit
> time-consuming, for example: when accessing usb mass storage
> via EHCI on pandaboard, the common length of transfer buffer is 120KB,
> the time consumed on DMA unmapping may reach hundreds of microseconds;
> even on A15 based box, the time is still about scores of microseconds

DMA mapping/unmapping will remain just as time-consuming as before.  
This patch won't change that.

> 2), on some arch, reading DMA coherent memoery is very time-consuming,
> the most common example is usb video class driver[1]

Reading DMA-coherent memory will remain just as time-consuming as 
before.

> 3), driver's complete() callback may do much things which is driver
> specific, so the time is consumed unnecessarily in hardware irq context.

With this patch, the time is consumed in softirq context.  What is the 
advantage?

> 4), running driver's complete() callback in hardware irq context causes
> that host controller driver has to release its lock in interrupt handler,
> so reacquiring the lock after return may busy wait a while and increase
> interrupt handling time. More seriously, releasing the HCD lock makes
> HCD becoming quite complicated to deal with introduced races.

There is no choice; the lock _has_ to be released before giving back 
completed URBs.  Therefore the races are unavoidable, as is the 
busy-wait.

> So the patch proposes to run giveback of URB in tasklet context, then
> time consumed in HCD irq handling doesn't depend on drivers' complete and
> DMA mapping/unmapping any more, also we can simplify HCD since the HCD
> lock isn't needed to be released during irq handling.

I'm not convinced.  In particular, I'm not convinced that this is 
better than using a threaded interrupt handler.

> The patch should be reasonable and doable:
> 
> 1), for drivers, they don't care if the complete() is called in hard irq
> context or softirq context

True.

> 2), the biggest change is the situation in which usb_submit_urb() is called
> in complete() callback, so the introduced tasklet schedule delay might be a
> con, but it shouldn't be a big deal:
> 
> 	- control/bulk asynchronous transfer isn't sensitive to schedule
> 	  delay

Mass-storage device access (which uses bulk async transfers) certainly
_is_ sensitive to scheduling delays.

> 	- the patch schedules giveback of periodic URBs using
> 	  tasklet_hi_schedule, so the introduced delay should be very
> 	  small
> 
> 	- use percpu tasklset for each HCD to schedule giveback of URB,
> 	  which are running as much as parallel

That might be an advantage; it depends on the work load.  But if the 
tasklet ends up running on a different CPU from the task that submitted 
the URB originally, it would be less of an advantage.

> 	- for ISOC transfer, generally, drivers submit several URBs
> 	  concurrently to avoid interrupt delay, so it is OK with the
> 	  little schedule delay.

This varies.  Some drivers use very low overheads for isochronous 
transfers.  A delay of even one millisecond might be too long for them.

> 	- for interrupt transfer, generally, drivers only submit one URB
> 	  at the same time, but interrupt transfer is often used in event
> 	  report, polling, ... situations, and a little delay should be OK.

Agreed.

Alan Stern
