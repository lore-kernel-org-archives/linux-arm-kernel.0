From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 28 Nov 2013 14:21:22 +0100
Subject: [PATCH v2] clocksource: sirf/marco+prima2: drop usage of
 CLOCK_TICK_RATE
In-Reply-To: <529729D1.7030803@linaro.org>
References: <529729D1.7030803@linaro.org>
Message-ID: <1385644882-450-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CSR SiRF was converted to multi platform in cf82e0e (ARM: sirf:
enable multiplatform support) the symbol CLOCK_TICK_RATE isn't the
platform specific definition any more, but a global dummy value. There
was no harm introduced in cf82e0e because the global value happens to
match the old platform specific one, still this dummy value isn't
intended to be used and will hopefully disappear soon, so introduce a
local #define and use that instead.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with
Message-Id: id:20131114090705.GX14892 at pengutronix.de

 - rename introduced symbols to be obviously machine specific
 - improve commit log

 drivers/clocksource/timer-marco.c  | 13 +++++++------
 drivers/clocksource/timer-prima2.c | 16 ++++++++++------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 09a17d9a..b52e1c0 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -19,7 +19,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/sched_clock.h>
-#include <asm/mach/time.h>
+
+#define MARCO_CLOCK_FREQ 1000000
 
 #define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
 #define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
@@ -191,7 +192,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
 	ce->rating = 200;
 	ce->set_mode = sirfsoc_timer_set_mode;
 	ce->set_next_event = sirfsoc_timer_set_next_event;
-	clockevents_calc_mult_shift(ce, CLOCK_TICK_RATE, 60);
+	clockevents_calc_mult_shift(ce, MARCO_CLOCK_FREQ, 60);
 	ce->max_delta_ns = clockevent_delta2ns(-2, ce);
 	ce->min_delta_ns = clockevent_delta2ns(2, ce);
 	ce->cpumask = cpumask_of(cpu);
@@ -263,11 +264,11 @@ static void __init sirfsoc_marco_timer_init(void)
 	BUG_ON(IS_ERR(clk));
 	rate = clk_get_rate(clk);
 
-	BUG_ON(rate < CLOCK_TICK_RATE);
-	BUG_ON(rate % CLOCK_TICK_RATE);
+	BUG_ON(rate < MARCO_CLOCK_FREQ);
+	BUG_ON(rate % MARCO_CLOCK_FREQ);
 
 	/* Initialize the timer dividers */
-	timer_div = rate / CLOCK_TICK_RATE - 1;
+	timer_div = rate / MARCO_CLOCK_FREQ - 1;
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL);
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_1_CTRL);
@@ -283,7 +284,7 @@ static void __init sirfsoc_marco_timer_init(void)
 	/* Clear all interrupts */
 	writel_relaxed(0xFFFF, sirfsoc_timer_base + SIRFSOC_TIMER_INTR_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, MARCO_CLOCK_FREQ));
 
 	sirfsoc_clockevent_init();
 }
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 8a492d3..1a6b2d6 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -21,6 +21,8 @@
 #include <linux/sched_clock.h>
 #include <asm/mach/time.h>
 
+#define PRIMA2_CLOCK_FREQ 1000000
+
 #define SIRFSOC_TIMER_COUNTER_LO	0x0000
 #define SIRFSOC_TIMER_COUNTER_HI	0x0004
 #define SIRFSOC_TIMER_MATCH_0		0x0008
@@ -173,7 +175,7 @@ static u64 notrace sirfsoc_read_sched_clock(void)
 static void __init sirfsoc_clockevent_init(void)
 {
 	sirfsoc_clockevent.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&sirfsoc_clockevent, CLOCK_TICK_RATE,
+	clockevents_config_and_register(&sirfsoc_clockevent, PRIMA2_CLOCK_FREQ,
 					2, -2);
 }
 
@@ -190,8 +192,8 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	rate = clk_get_rate(clk);
 
-	BUG_ON(rate < CLOCK_TICK_RATE);
-	BUG_ON(rate % CLOCK_TICK_RATE);
+	BUG_ON(rate < PRIMA2_CLOCK_FREQ);
+	BUG_ON(rate % PRIMA2_CLOCK_FREQ);
 
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base)
@@ -199,14 +201,16 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 
-	writel_relaxed(rate / CLOCK_TICK_RATE / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
+	writel_relaxed(rate / PRIMA2_CLOCK_FREQ / 2 - 1,
+		       sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
 
-	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
+	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource,
+				       PRIMA2_CLOCK_FREQ));
 
-	sched_clock_register(sirfsoc_read_sched_clock, 64, CLOCK_TICK_RATE);
+	sched_clock_register(sirfsoc_read_sched_clock, 64, PRIMA2_CLOCK_FREQ);
 
 	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
 
-- 
1.8.4.3
