From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 11 Jan 2012 10:05:04 +0100
Subject: [PATCH 3/3] plat-nomadik: modernize MTU timer
Message-ID: <1326272704-5746-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Modernize the MTU timer to rely on the clockevents core to
calculate mult and shift and setup the clock event.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/timer.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 954a862..6ae6f86 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -21,12 +21,6 @@
 #include <asm/sched_clock.h>
 
 /*
- * Guaranteed runtime conversion range in seconds for
- * the clocksource and clockevent.
- */
-#define MTU_MIN_RANGE 4
-
-/*
  * The MTU device hosts four different counters, with 4 set of
  * registers. These are register names.
  */
@@ -102,7 +96,6 @@ static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
 void nmdk_clkevt_reset(void)
 {
 	if (clkevt_periodic) {
-
 		/* Timer: configure load and background-load, and fire it up */
 		writel(nmdk_cycle, mtu_base + MTU_LR(1));
 		writel(nmdk_cycle, mtu_base + MTU_BGLR(1));
@@ -120,7 +113,6 @@ void nmdk_clkevt_reset(void)
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
 {
-
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		clkevt_periodic = true;
@@ -224,17 +216,7 @@ void __init nmdk_timer_init(void __iomem *base)
 	setup_sched_clock(nomadik_read_sched_clock, 32, rate);
 #endif
 
-	/* Timer 1 is used for events */
-
-	clockevents_calc_mult_shift(&nmdk_clkevt, rate, MTU_MIN_RANGE);
-
-	nmdk_clkevt.max_delta_ns =
-		clockevent_delta2ns(0xffffffff, &nmdk_clkevt);
-	nmdk_clkevt.min_delta_ns =
-		clockevent_delta2ns(0x00000002, &nmdk_clkevt);
-	nmdk_clkevt.cpumask	= cpumask_of(0);
-
-	/* Register irq and clockevents */
+	/* Timer 1 is used for events, register irq and clockevents */
 	setup_irq(IRQ_MTU0, &nmdk_timer_irq);
-	clockevents_register_device(&nmdk_clkevt);
+	clockevents_config_and_register(&nmdk_clkevt, rate, 2, 0xffffffffU);
 }
-- 
1.7.8
