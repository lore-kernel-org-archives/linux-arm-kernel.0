From: rabin.vincent@axis.com (Rabin Vincent)
Date: Wed, 19 Aug 2015 15:43:38 +0200
Subject: [PATCH] clocksource: arm_global_timer: register delay timer
Message-ID: <1439991818-31989-1-git-send-email-rabin.vincent@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a delay timer using the lower 32-bits of the global timer so
that we can use that instead of having to calibrating delays.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/clocksource/arm_global_timer.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index e683377..f92a77d 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -16,6 +16,7 @@
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -208,6 +209,21 @@ static u64 notrace gt_sched_clock_read(void)
 }
 #endif
 
+static unsigned long gt_read_long(void)
+{
+	return readl_relaxed(gt_base + GT_COUNTER0);
+}
+
+static struct delay_timer gt_delay_timer = {
+	.read_current_timer = gt_read_long,
+};
+
+static void __init gt_delay_timer_init(void)
+{
+	gt_delay_timer.freq = gt_clk_rate;
+	register_current_timer_delay(&gt_delay_timer);
+}
+
 static void __init gt_clocksource_init(void)
 {
 	writel(0, gt_base + GT_CONTROL);
@@ -304,6 +320,7 @@ static void __init global_timer_of_register(struct device_node *np)
 	/* Immediately configure the timer on the boot CPU */
 	gt_clocksource_init();
 	gt_clockevents_init(this_cpu_ptr(gt_evt));
+	gt_delay_timer_init();
 
 	return;
 
-- 
1.7.10.4
