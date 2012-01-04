From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jan 2012 11:21:53 +0100
Subject: [PATCH 2/2] mach-sa1100: modernize and cleanup timer code
Message-ID: <1325672513-16725-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the hairy mult/shift calculation for SA1100
timers and relies on clockevent core to figure this out, and removes
the hard-coded rate constant in favor of the CLOCK_TICK_RATE
already used by the clocksource.

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/time.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 69e3353..5cb8c7b 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -88,20 +88,14 @@ static void __init sa1100_timer_init(void)
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
-
-	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
-	ckevt_sa1100_osmr0.max_delta_ns =
-		clockevent_delta2ns(0x7fffffff, &ckevt_sa1100_osmr0);
-	ckevt_sa1100_osmr0.min_delta_ns =
-		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_sa1100_osmr0) + 1;
+	setup_sched_clock(sa1100_read_sched_clock, 32, CLOCK_TICK_RATE);
 	ckevt_sa1100_osmr0.cpumask = cpumask_of(0);
-
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
 	clocksource_mmio_init(&OSCR, "oscr", CLOCK_TICK_RATE, 200, 32,
 		clocksource_mmio_readl_up);
-	clockevents_register_device(&ckevt_sa1100_osmr0);
+	clockevents_config_and_register(&ckevt_sa1100_osmr0, CLOCK_TICK_RATE,
+					MIN_OSCR_DELTA * 2, 0x7fffffff);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.6.4
