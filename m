From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Feb 2016 14:37:14 +0100
Subject: [PATCH 6/9] clocksource/drivers/arm_global_timer: Register delay timer
In-Reply-To: <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
References: <56CF00F6.9010301@linaro.org>
 <1456407438-6131-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1456407438-6131-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@axis.com>

Provide a delay timer using the lower 32-bits of the global timer so
that we can use that instead of having to calibrating delays.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index d189d8c..36998fa 100644
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
@@ -221,6 +222,21 @@ static u64 notrace gt_sched_clock_read(void)
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
@@ -317,6 +333,7 @@ static void __init global_timer_of_register(struct device_node *np)
 	/* Immediately configure the timer on the boot CPU */
 	gt_clocksource_init();
 	gt_clockevents_init(this_cpu_ptr(gt_evt));
+	gt_delay_timer_init();
 
 	return;
 
-- 
1.9.1
