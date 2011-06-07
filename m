From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 07 Jun 2011 14:29:08 -0400 (EDT)
Subject: [PATCH,RFC] mmp clockevent handling race
In-Reply-To: <20110607140456.GE11275@wantstofly.org>
References: <20110607140456.GE11275@wantstofly.org>
Message-ID: <alpine.LFD.2.00.1106071416230.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Jun 2011, Lennert Buytenhek wrote:

> Hi!
> 
> The patch below has been sitting around in the OLPC XO-1.75 (MMP2-based
> XO) bringup kernel tree for some time now, and upon recent rebasing of
> this tree to 3.0, it was discovered that something like this patch is
> still needed.
> 
> Symptoms: e.g. as described here: http://dev.laptop.org/ticket/10945
> -- applications hang for a couple of minutes at a time, and sometimes
> there are several-minute hangs during the boot process.
> 
> >From the ticket:
> 
> 	The problem in the current upstream mmp timer handling code
> 	that appears to be triggered here is that it handles clockevents
> 	by setting up a comparator on the free-running clocksource timer
> 	to match and trigger an interrupt at 'current_time + delta',
> 	which if delta is small enough can lead to 'current_time + delta'
> 	already being in the past when comparator setup has finished,
> 	and the requested event will not trigger. 

This is a classical issue that was solved on the SA1100 more than 10 
years ago.

> What this patch does is to rewrite the timer handling code to use
> two timers, one for the free-running clocksource, and one to trigger
> clockevents with, which is more or less the standard approach to this.
> It's kind of invasive, though (certainly more invasive than it strictly
> needs to be, as it reorganises time.c somewhat at the same time), and
> something like this is probably too invasive for 3.0 at this point.
> 
> A safer "fix" for 3.0 may be to disallow NO_HZ/HIGH_RES_TIMERS on mmp.
> 
> Any thoughts?

What about simply this:

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 99833b9..8b8f99a 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -39,7 +39,7 @@
 
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
 
-#define MAX_DELTA		(0xfffffffe)
+#define MAX_DELTA		(0xfffffffe - 16)
 #define MIN_DELTA		(16)
 
 static DEFINE_CLOCK_DATA(cd);
@@ -85,7 +85,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 static int timer_set_next_event(unsigned long delta,
 				struct clock_event_device *dev)
 {
-	unsigned long flags, next;
+	unsigned long flags, next, now;
 
 	local_irq_save(flags);
 
@@ -95,9 +95,10 @@ static int timer_set_next_event(unsigned long delta,
 
 	next = timer_read() + delta;
 	__raw_writel(next, TIMERS_VIRT_BASE + TMR_TN_MM(0, 0));
+	now = timer_read();
 
 	local_irq_restore(flags);
-	return 0;
+	return (signed)(next - now) <= MIN_DELTA ? -ETIME : 0;
 }
 
 static void timer_set_mode(enum clock_event_mode mode,


Nicolas
