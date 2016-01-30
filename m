From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat, 30 Jan 2016 03:46:19 -0300
Subject: [PATCH 2/2] clocksource/drivers/lpc32xx: Support timer-based ARM delay
In-Reply-To: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1454136379-7517-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1454136379-7517-2-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the ARM timer-based delay timer for the
LPC32xx, LPC18xx, LPC43xx family of SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/clocksource/time-lpc32xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index 9b3d4a38c716..223bb08720d6 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -55,6 +56,15 @@ static u64 notrace lpc32xx_read_sched_clock(void)
 	return readl(clocksource_timer_counter);
 }
 
+static unsigned long lpc32xx_delay_timer_read(void)
+{
+	return readl(clocksource_timer_counter);
+}
+
+static struct delay_timer lpc32xx_delay_timer = {
+	.read_current_timer = lpc32xx_delay_timer_read,
+};
+
 static int lpc32xx_clkevt_next_event(unsigned long delta,
 				     struct clock_event_device *evtdev)
 {
@@ -198,6 +208,8 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 	}
 
 	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
+	lpc32xx_delay_timer.freq = rate;
+	register_current_timer_delay(&lpc32xx_delay_timer);
 	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
 
 	return 0;
-- 
2.7.0
