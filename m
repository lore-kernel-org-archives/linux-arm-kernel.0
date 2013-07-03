From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed,  3 Jul 2013 14:50:16 -0700
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
Message-ID: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse the TTC clocksource timer as sched clock, too. Since only a single
sched clock is supported in Linux, this feature optional and can be
selected through Kconfig.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/Kconfig             |  7 +++++++
 drivers/clocksource/cadence_ttc_timer.c | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5871933..8dda767 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -36,6 +36,13 @@ config VT8500_TIMER
 config CADENCE_TTC_TIMER
 	bool
 
+config CADENCE_TTC_TIMER_SCHED_CLOCK
+	bool "Cadence TTC Sched Clock"
+	depends on CADENCE_TTC_TIMER
+	help
+	  Use the clocksource timer provided by the TTC as
+	  sched clock, also.
+
 config CLKSRC_NOMADIK_MTU
 	bool
 	depends on (ARCH_NOMADIK || ARCH_U8500)
diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 4cbe28c..ef0f52b 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
+#include <asm/sched_clock.h>
 
 /*
  * This driver configures the 2 16-bit count-up timers as follows:
@@ -95,6 +96,10 @@ struct ttc_timer_clockevent {
 #define to_ttc_timer_clkevent(x) \
 		container_of(x, struct ttc_timer_clockevent, ce)
 
+#ifdef CONFIG_CADENCE_TTC_TIMER_SCHED_CLOCK
+static void __iomem *ttc_sched_clock_val_reg;
+#endif
+
 /**
  * ttc_set_interval - Set the timer interval value
  *
@@ -156,6 +161,13 @@ static cycle_t __ttc_clocksource_read(struct clocksource *cs)
 				TTC_COUNT_VAL_OFFSET);
 }
 
+#ifdef CONFIG_CADENCE_TTC_TIMER_SCHED_CLOCK
+static u32 notrace ttc_sched_clock_read(void)
+{
+	return __raw_readl(ttc_sched_clock_val_reg);
+}
+#endif
+
 /**
  * ttc_set_next_event - Sets the time interval for next event
  *
@@ -297,6 +309,12 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 		kfree(ttccs);
 		return;
 	}
+
+#ifdef CONFIG_CADENCE_TTC_TIMER_SCHED_CLOCK
+	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
+	setup_sched_clock(ttc_sched_clock_read, 16,
+			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
+#endif
 }
 
 static int ttc_rate_change_clockevent_cb(struct notifier_block *nb,
-- 
1.8.3.2
