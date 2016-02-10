From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Tue,  9 Feb 2016 22:54:27 -0300
Subject: [PATCH v2 3/3] clocksource/drivers/lpc32xx: Support timer-based ARM
 delay
In-Reply-To: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1455069267-4784-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <1455069267-4784-4-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the ARM timer-based delay timer for the
LPC32xx, LPC18xx, LPC43xx family of SoCs.

Also, add a dependency to restrict compiling this driver for
the ARM architecture.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/clocksource/Kconfig        |  1 +
 drivers/clocksource/time-lpc32xx.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 33db7406c0e2..c346be650892 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -160,6 +160,7 @@ config CLKSRC_EFM32
 config CLKSRC_LPC32XX
 	bool "Clocksource for LPC32XX" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
+	depends on ARM
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	help
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index 5694eddade15..daae61e8c820 100644
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
@@ -54,6 +55,15 @@ static u64 notrace lpc32xx_read_sched_clock(void)
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
@@ -192,6 +202,8 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 	}
 
 	clocksource_timer_counter = base + LPC32XX_TIMER_TC;
+	lpc32xx_delay_timer.freq = rate;
+	register_current_timer_delay(&lpc32xx_delay_timer);
 	sched_clock_register(lpc32xx_read_sched_clock, 32, rate);
 
 	return 0;
-- 
2.7.0
