From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 11 Mar 2017 17:42:34 +0000
Subject: [PATCH 2/2] clocksource: orion: add delay_timer implementation
Message-ID: <E1cml2I-0007CQ-Q1@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an implementation for the ARM delay timer, which is used for
udelay().  This provides less CPU dependent and more accurate delays -
the CPU loop on Marvell Dove appears to calibrate to around 6% too
short.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/clocksource/time-orion.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index c4818a5dc8e5..7eb2ab0bd114 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -36,6 +37,21 @@
 
 static void __iomem *timer_base;
 
+static unsigned long notrace orion_read_timer(void)
+{
+	return ~readl(timer_base + TIMER0_VAL);
+}
+
+static struct delay_timer orion_delay_timer = {
+	.read_current_timer = orion_read_timer,
+};
+
+static void orion_delay_timer_init(unsigned long rate)
+{
+	orion_delay_timer.freq = rate;
+	register_current_timer_delay(&orion_delay_timer);
+}
+
 /*
  * Free-running clocksource handling.
  */
@@ -168,6 +184,9 @@ static int __init orion_timer_init(struct device_node *np)
 	clockevents_config_and_register(&orion_clkevt, rate,
 					ORION_ONESHOT_MIN, ORION_ONESHOT_MAX);
 
+
+	orion_delay_timer_init(rate);
+
 	return 0;
 }
 CLOCKSOURCE_OF_DECLARE(orion_timer, "marvell,orion-timer", orion_timer_init);
-- 
2.7.4
