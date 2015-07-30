From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:22:05 +0200
Subject: [PATCH 19/20] clocksource: atmel-st: get and use slow clock
In-Reply-To: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215726-27452-20-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current slow clock rate is hardcoded. Properly get the slow clock
and use its rate.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
 drivers/clocksource/timer-atmel-st.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 1692e17e096b..c61089d990c6 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/export.h>
 #include <linux/mfd/syscon.h>
@@ -33,9 +34,8 @@ static unsigned long last_crtr;
 static u32 irqmask;
 static struct clock_event_device clkevt;
 static struct regmap *regmap_st;
-
-#define AT91_SLOW_CLOCK		32768
-#define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
+struct clk *sclk;
+int timer_latch;
 
 /*
  * The ST_CRTR is updated asynchronously to the master clock ... but
@@ -82,8 +82,8 @@ static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
 	if (sr & AT91_ST_PITS) {
 		u32	crtr = read_CRTR();
 
-		while (((crtr - last_crtr) & AT91_ST_CRTV) >= RM9200_TIMER_LATCH) {
-			last_crtr += RM9200_TIMER_LATCH;
+		while (((crtr - last_crtr) & AT91_ST_CRTV) >= timer_latch) {
+			last_crtr += timer_latch;
 			clkevt.event_handler(&clkevt);
 		}
 		return IRQ_HANDLED;
@@ -120,7 +120,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 	case CLOCK_EVT_MODE_PERIODIC:
 		/* PIT for periodic irqs; fixed rate of 1/HZ */
 		irqmask = AT91_ST_PITS;
-		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
+		regmap_write(regmap_st, AT91_ST_PIMR, timer_latch);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		/* ALM for oneshot irqs, set by next_event()
@@ -182,7 +182,7 @@ static struct clock_event_device clkevt = {
  */
 static void __init atmel_st_timer_init(struct device_node *node)
 {
-	unsigned int val;
+	unsigned int sclk_rate, val;
 	int irq, ret;
 
 	regmap_st = syscon_node_to_regmap(node);
@@ -206,6 +206,19 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	if (ret)
 		panic(pr_fmt("Unable to setup IRQ\n"));
 
+	sclk = of_clk_get(node, 0);
+	if (IS_ERR(sclk))
+		panic(pr_fmt("Unable to get slow clock\n"));
+
+	clk_prepare_enable(sclk);
+	if (ret)
+		panic(pr_fmt("Could not enable slow clock\n"));
+
+	sclk_rate = clk_get_rate(sclk);
+	if (!sclk_rate)
+		panic(pr_fmt("Invalid slow clock rate\n"));
+	timer_latch = (sclk_rate + HZ / 2) / HZ;
+
 	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
 	 * directly for the clocksource and all clockevents, after adjusting
 	 * its prescaler from the 1 Hz default.
@@ -214,11 +227,11 @@ static void __init atmel_st_timer_init(struct device_node *node)
 
 	/* Setup timer clockevent, with minimum of two ticks (important!!) */
 	clkevt.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clkevt, AT91_SLOW_CLOCK,
+	clockevents_config_and_register(&clkevt, sclk_rate,
 					2, AT91_ST_ALMV);
 
 	/* register clocksource */
-	clocksource_register_hz(&clk32k, AT91_SLOW_CLOCK);
+	clocksource_register_hz(&clk32k, sclk_rate);
 }
 CLOCKSOURCE_OF_DECLARE(atmel_st_timer, "atmel,at91rm9200-st",
 		       atmel_st_timer_init);
-- 
2.1.4
