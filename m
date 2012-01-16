From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jan 2012 07:33:17 +0100
Subject: [PATCH v2] mach-sa1100: modernize and cleanup timer code
Message-ID: <1326695597-26534-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the hairy mult/shift calculation for SA1100
timers and relies on clockevent core to figure this out, and removes
the hard-coded rate constant and instead define a timer clock in
the clock implementation and get the frequency from that. This
kills all uses of CLOCK_TICK_RATE in mach-sa1100.

Cc: Deepak Saxena <deepak.saxena@linaro.org>
Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/clock.c |    2 ++
 arch/arm/mach-sa1100/time.c  |   26 ++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
index d6df9f6..9c24b3c 100644
--- a/arch/arm/mach-sa1100/clock.c
+++ b/arch/arm/mach-sa1100/clock.c
@@ -113,10 +113,12 @@ const struct clkops clk_dummy_ops = {
 };
 
 static DEFINE_CLK(gpio27, &clk_gpio27_ops, 3686400);
+static DEFINE_CLK(timer, &clk_dummy_ops, 3686400);
 static DEFINE_CLK(dummy, &clk_dummy_ops, 0);
 
 static struct clk_lookup sa11xx_clkregs[] = {
 	INIT_CLKREG(&clk_gpio27, "sa1111.0", NULL),
+	INIT_CLKREG(&clk_timer, "sa1100-timer", NULL),
 	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 69e3353..db71bc1 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -14,6 +14,8 @@
 #include <linux/irq.h>
 #include <linux/timex.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
@@ -85,23 +87,27 @@ static struct irqaction sa1100_timer_irq = {
 
 static void __init sa1100_timer_init(void)
 {
+	struct clk *clk;
+	unsigned long rate;
+
+	/* Since this clock is vital for system operation we bug out */
+	clk = clk_get_sys("sa1100-timer", NULL);
+	BUG_ON(IS_ERR(clk));
+	BUG_ON(clk_prepare(clk));
+	BUG_ON(clk_enable(clk));
+	rate = clk_get_rate(clk);
+
 	OIER = 0;
 	OSSR = OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3;
 
-	setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
-
-	clockevents_calc_mult_shift(&ckevt_sa1100_osmr0, 3686400, 4);
-	ckevt_sa1100_osmr0.max_delta_ns =
-		clockevent_delta2ns(0x7fffffff, &ckevt_sa1100_osmr0);
-	ckevt_sa1100_osmr0.min_delta_ns =
-		clockevent_delta2ns(MIN_OSCR_DELTA * 2, &ckevt_sa1100_osmr0) + 1;
+	setup_sched_clock(sa1100_read_sched_clock, 32, rate);
 	ckevt_sa1100_osmr0.cpumask = cpumask_of(0);
-
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
-	clocksource_mmio_init(&OSCR, "oscr", CLOCK_TICK_RATE, 200, 32,
+	clocksource_mmio_init(&OSCR, "oscr", rate, 200, 32,
 		clocksource_mmio_readl_up);
-	clockevents_register_device(&ckevt_sa1100_osmr0);
+	clockevents_config_and_register(&ckevt_sa1100_osmr0, rate,
+					MIN_OSCR_DELTA * 2, 0x7fffffff);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.7.5
