From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 11 Nov 2013 21:20:36 +0100
Subject: [PATCH] clocksource: sirf/marco+prima2: drop usage of CLOCK_TICK_RATE
Message-ID: <1384201236-8689-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As CSR SiRF is converted to multi platform CLOCK_TICK_RATE is a dummy
value that seems to match the right value is used.
(arch/arm/mach-prima2/include/mach/timex.h which defined CLOCK_TICK_RATE
to 1000000 was removed in commit cf82e0e (ARM: sirf: enable
multiplatform support); marco used the same file.)

To not depend on that dummy value use a local #define instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-marco.c  | 13 +++++++------
 drivers/clocksource/timer-prima2.c | 14 ++++++++------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 09a17d9a..0d367a7 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -19,7 +19,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/sched_clock.h>
-#include <asm/mach/time.h>
+
+#define CLOCK_FREQ 1000000
 
 #define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
 #define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
@@ -191,7 +192,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
 	ce->rating = 200;
 	ce->set_mode = sirfsoc_timer_set_mode;
 	ce->set_next_event = sirfsoc_timer_set_next_event;
-	clockevents_calc_mult_shift(ce, CLOCK_TICK_RATE, 60);
+	clockevents_calc_mult_shift(ce, CLOCK_FREQ, 60);
 	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
 	ce->min_delta_ns = clockevent_delta2ns(2, ce);
 	ce->cpumask = cpumask_of(cpu);
@@ -263,11 +264,11 @@ static void __init sirfsoc_marco_timer_init(void)
 	BUG_ON(IS_ERR(clk));
 	rate = clk_get_rate(clk);
 
-	BUG_ON(rate < CLOCK_TICK_RATE);
-	BUG_ON(rate % CLOCK_TICK_RATE);
+	BUG_ON(rate < CLOCK_FREQ);
+	BUG_ON(rate % CLOCK_FREQ);
 
 	/* Initialize the timer dividers */
-	timer_div = rate / CLOCK_TICK_RATE - 1;
+	timer_div = rate / CLOCK_FREQ - 1;
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_1_CTRL);
@@ -283,7 +284,7 @@ static void __init sirfsoc_marco_timer_init(void)
 	/* Clear all interrupts */
 	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_FREQ));
 
 	sirfsoc_clockevent_init();
 }
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 8a492d3..ff7d49e 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -21,6 +21,8 @@
 #include <linux/sched_clock.h>
 #include <asm/mach/time.h>
 
+#define CLOCK_FREQ 1000000
+
 #define SIRFSOC_TIMER_COUNTER_LO	0x0000
 #define SIRFSOC_TIMER_COUNTER_HI	0x0004
 #define SIRFSOC_TIMER_MATCH_0		0x0008
@@ -173,7 +175,7 @@ static u64 notrace sirfsoc_read_sched_clock(void)
 static void __init sirfsoc_clockevent_init(void)
 {
 	sirfsoc_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&sirfsoc_clockevent, CLOCK_TICK_RATE,
+	clockevents_config_and_register(&sirfsoc_clockevent, CLOCK_FREQ,
 					2, -2);
 }
 
@@ -190,8 +192,8 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	rate = clk_get_rate(clk);
 
-	BUG_ON(rate < CLOCK_TICK_RATE);
-	BUG_ON(rate % CLOCK_TICK_RATE);
+	BUG_ON(rate < CLOCK_FREQ);
+	BUG_ON(rate % CLOCK_FREQ);
 
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base)
@@ -199,14 +201,14 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 
-	writel_relaxed(rate / CLOCK_TICK_RATE / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
+	writel_relaxed(rate / CLOCK_FREQ / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_FREQ));
 
-	sched_clock_register(sirfsoc_read_sched_clock, 64, CLOCK_TICK_RATE);
+	sched_clock_register(sirfsoc_read_sched_clock, 64, CLOCK_FREQ);
 
 	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
 
-- 
1.8.4.2
