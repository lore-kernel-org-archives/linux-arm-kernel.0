From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 29 Dec 2009 16:26:41 +0100
Subject: [PATCH] iop: use generic clock mult/shift compute functions
Message-ID: <19258.8113.311122.46281@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2.6.33-rc kernel now has generic functions for computing
mult and shift factors for clocksources and clockevents. Thus
we can remove the equivalent private code from the ARM IOP
platform and use the generic code instead.

Tested on an n2100 iop32x machine. Verfied to result in the
exact same mult and shift factors as before.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/plat-iop/time.c |   50 +++++------------------------------------------
 1 file changed, 6 insertions(+), 44 deletions(-)

diff -rupN linux-2.6.33-rc2/arch/arm/plat-iop/time.c linux-2.6.33-rc2.arm-iop-use-generic-clock-mult-shift-functions/arch/arm/plat-iop/time.c
--- linux-2.6.33-rc2/arch/arm/plat-iop/time.c	2009-12-26 15:20:55.000000000 +0100
+++ linux-2.6.33-rc2.arm-iop-use-generic-clock-mult-shift-functions/arch/arm/plat-iop/time.c	2009-12-26 21:34:26.000000000 +0100
@@ -44,27 +44,6 @@ static struct clocksource iop_clocksourc
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init iop_clocksource_set_hz(struct clocksource *cs, unsigned int hz)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find shift and mult values for hz. */
-	shift = 32;
-	do {
-		temp = (u64) NSEC_PER_SEC << shift;
-		do_div(temp, hz);
-		if ((temp >> 32) == 0)
-			break;
-	} while (--shift != 0);
-
-	cs->shift = shift;
-	cs->mult = (u32) temp;
-
-	printk(KERN_INFO "clocksource: %s uses shift %u mult %#x\n",
-	       cs->name, cs->shift, cs->mult);
-}
-
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
@@ -130,27 +109,6 @@ static struct clock_event_device iop_clo
 	.set_mode	= iop_set_mode,
 };
 
-static void __init iop_clockevent_set_hz(struct clock_event_device *ce, unsigned int hz)
-{
-	u64 temp;
-	u32 shift;
-
-	/* Find shift and mult values for hz. */
-	shift = 32;
-	do {
-		temp = (u64) hz << shift;
-		do_div(temp, NSEC_PER_SEC);
-		if ((temp >> 32) == 0)
-			break;
-	} while (--shift != 0);
-
-	ce->shift = shift;
-	ce->mult = (u32) temp;
-
-	printk(KERN_INFO "clockevent: %s uses shift %u mult %#lx\n",
-	       ce->name, ce->shift, ce->mult);
-}
-
 static irqreturn_t
 iop_timer_interrupt(int irq, void *dev_id)
 {
@@ -190,7 +148,9 @@ void __init iop_init_time(unsigned long 
 	 */
 	write_tmr0(timer_ctl & ~IOP_TMR_EN);
 	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
-	iop_clockevent_set_hz(&iop_clockevent, tick_rate);
+	clockevents_calc_mult_shift(&iop_clockevent, tick_rate, 4);
+	printk(KERN_INFO "clockevent: %s uses shift %u mult %#x\n",
+	       iop_clockevent.name, iop_clockevent.shift, iop_clockevent.mult);
 	iop_clockevent.max_delta_ns =
 		clockevent_delta2ns(0xfffffffe, &iop_clockevent);
 	iop_clockevent.min_delta_ns =
@@ -207,6 +167,8 @@ void __init iop_init_time(unsigned long 
 	write_trr1(0xffffffff);
 	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
-	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
+	clocksource_calc_mult_shift(&iop_clocksource, tick_rate, 4);
+	printk(KERN_INFO "clocksource: %s uses shift %u mult %#x\n",
+	       iop_clocksource.name, iop_clocksource.shift, iop_clocksource.mult);
 	clocksource_register(&iop_clocksource);
 }
