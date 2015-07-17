From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jul 2015 21:33:26 +0200
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup and remove the interrupt handler in clock event mode selection.
This avoids calling the (shared) interrupt handler when the device is not
used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-st.c | 43 +++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 41b7b6dc1d0d..a498b7446006 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -31,6 +31,7 @@
 
 static unsigned long last_crtr;
 static u32 irqmask;
+static int irq;
 static struct clock_event_device clkevt;
 static struct regmap *regmap_st;
 
@@ -121,17 +122,45 @@ static int clkevt32k_shutdown(struct clock_event_device *evt)
 	clkdev32k_disable_and_flush_irq();
 	irqmask = 0;
 	regmap_write(regmap_st, AT91_ST_IER, irqmask);
+
+	if (clockevent_state_periodic(evt) || clockevent_state_oneshot(evt))
+		free_irq(irq, regmap_st);
+
+	return 0;
+}
+
+static int atmel_st_request_irq(struct clock_event_device *dev)
+{
+	int ret;
+
+	if (clockevent_state_periodic(dev) || clockevent_state_oneshot(dev))
+		return 0;
+
+	ret = request_irq(irq, at91rm9200_timer_interrupt,
+			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
+			  "at91_tick", regmap_st);
+	if (ret) {
+		pr_alert("Unable to setup IRQ\n");
+		return ret;
+	}
+
 	return 0;
 }
 
 static int clkevt32k_set_oneshot(struct clock_event_device *dev)
 {
+	int ret;
+
 	clkdev32k_disable_and_flush_irq();
 
 	/*
 	 * ALM for oneshot irqs, set by next_event()
 	 * before 32 seconds have passed.
 	 */
+	ret = atmel_st_request_irq(dev);
+	if (ret)
+		return ret;
+
 	irqmask = AT91_ST_ALMS;
 	regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
 	regmap_write(regmap_st, AT91_ST_IER, irqmask);
@@ -140,9 +169,15 @@ static int clkevt32k_set_oneshot(struct clock_event_device *dev)
 
 static int clkevt32k_set_periodic(struct clock_event_device *dev)
 {
+	int ret;
+
 	clkdev32k_disable_and_flush_irq();
 
 	/* PIT for periodic irqs; fixed rate of 1/HZ */
+	ret = atmel_st_request_irq(dev);
+	if (ret)
+		return ret;
+
 	irqmask = AT91_ST_PITS;
 	regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
 	regmap_write(regmap_st, AT91_ST_IER, irqmask);
@@ -198,7 +233,6 @@ static struct clock_event_device clkevt = {
 static void __init atmel_st_timer_init(struct device_node *node)
 {
 	unsigned int val;
-	int irq, ret;
 
 	regmap_st = syscon_node_to_regmap(node);
 	if (IS_ERR(regmap_st))
@@ -214,13 +248,6 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	if (!irq)
 		panic(pr_fmt("Unable to get IRQ from DT\n"));
 
-	/* Make IRQs happen for the system timer */
-	ret = request_irq(irq, at91rm9200_timer_interrupt,
-			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
-			  "at91_tick", regmap_st);
-	if (ret)
-		panic(pr_fmt("Unable to setup IRQ\n"));
-
 	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
 	 * directly for the clocksource and all clockevents, after adjusting
 	 * its prescaler from the 1 Hz default.
-- 
2.1.4
