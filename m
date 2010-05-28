From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 May 2010 19:34:08 +0200
Subject: [PATCH 2/2] ARM: move IOP to use common mult/shift calculation code
Message-ID: <1275068048-17778-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the infrastructure for determining shift/mult values from a
clock rate and a minimum programmable rate is now in the kernel,
lets remove this custom code.

Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Mikael: I cannot test this change, but I have compiled it against
iop33x_defconfig. You'd have to test it and Acked-by: it before
I do anything else with it. Try to think about what a minimum range
would be for the generic IOP platform...
---
 arch/arm/plat-iop/time.c |   53 +++++++--------------------------------------
 1 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 6c8a02a..85d3e55 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -29,6 +29,11 @@
 #include <mach/time.h>
 
 /*
+ * Minimum clocksource/clockevent timer range in seconds
+ */
+#define IOP_MIN_RANGE 4
+
+/*
  * IOP clocksource (free-running timer 1).
  */
 static cycle_t iop_clocksource_read(struct clocksource *unused)
@@ -44,27 +49,6 @@ static struct clocksource iop_clocksource = {
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
@@ -130,27 +114,6 @@ static struct clock_event_device iop_clockevent = {
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
@@ -190,7 +153,8 @@ void __init iop_init_time(unsigned long tick_rate)
 	 */
 	write_tmr0(timer_ctl & ~IOP_TMR_EN);
 	setup_irq(IRQ_IOP_TIMER0, &iop_timer_irq);
-	iop_clockevent_set_hz(&iop_clockevent, tick_rate);
+	clockevents_calc_mult_shift(&iop_clockevent,
+				    tick_rate, IOP_MIN_RANGE);
 	iop_clockevent.max_delta_ns =
 		clockevent_delta2ns(0xfffffffe, &iop_clockevent);
 	iop_clockevent.min_delta_ns =
@@ -207,6 +171,7 @@ void __init iop_init_time(unsigned long tick_rate)
 	write_trr1(0xffffffff);
 	write_tcr1(0xffffffff);
 	write_tmr1(timer_ctl);
-	iop_clocksource_set_hz(&iop_clocksource, tick_rate);
+	clocksource_calc_mult_shift(&iop_clocksource, tick_rate,
+				    IOP_MIN_RANGE);
 	clocksource_register(&iop_clocksource);
 }
-- 
1.6.3.3
