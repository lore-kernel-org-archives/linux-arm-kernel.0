From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri, 29 Jul 2016 11:23:11 +0200
Subject: [PATCH] clocksource: arm_arch_timer: Support reading clock rate from
 a driver
Message-ID: <1469784191-3998-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

On some devices using arch code for reading clock rate doesn't work. So
far the only option was to specify clock-frequency in a DT. This works
only if a clock frequency doesn't have to be calculated on runtime.

On BCM53573 SoC (with Cortex-A7) there is ILP clock that needs its own
driver. With this change we can query such clocks by using a standard:
clocks = <&foo>;

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 drivers/clocksource/arm_arch_timer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5effd30..5ed98a2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -405,6 +406,16 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
 			arch_timer_rate = arch_timer_get_cntfrq();
 	}
 
+	/* Get clk rate through clk driver if present */
+	if (!arch_timer_rate) {
+		struct clk *clk = of_clk_get(np, 0);
+
+		if (!IS_ERR(clk)) {
+			if (!clk_prepare_enable(clk))
+				arch_timer_rate = clk_get_rate(clk);
+		}
+	}
+
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
 		pr_warn("Architected timer frequency not available\n");
-- 
1.8.4.5
