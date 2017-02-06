From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue,  7 Feb 2017 02:50:05 +0800
Subject: [PATCH v21 03/13] clocksource: arm_arch_timer: remove
 arch_timer_detect_rate
In-Reply-To: <20170206185015.12296-1-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
Message-ID: <20170206185015.12296-4-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The original counter frequency detection call(arch_timer_detect_rate)
include getting the frequency from the per-cpu arch-timer and the
memory-mapped (MMIO) timer interfaces. But they will be needed only when
the system initializes the relevant timer.

This patch remove arch_timer_detect_rate founction, and use the
arch_timer_get_sysreg_freq and arch_timer_get_mmio_freq directly.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 38 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aa14305..63fb441 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -571,25 +571,6 @@ static u32 arch_timer_get_mmio_freq(void __iomem *cntbase)
 	return readl_relaxed(cntbase + CNTFRQ);
 }
 
-static void arch_timer_detect_rate(void __iomem *cntbase)
-{
-	/* Who has more than one independent system counter? */
-	if (arch_timer_rate)
-		return;
-
-	/*
-	 * Try to determine the frequency from the MMIO timer or the sysreg.
-	 */
-	if (cntbase)
-		arch_timer_rate = arch_timer_get_mmio_freq(cntbase);
-	else
-		arch_timer_rate = arch_timer_get_sysreg_freq();
-
-	/* Check the timer frequency. */
-	if (arch_timer_rate == 0)
-		pr_warn("frequency not available\n");
-}
-
 static void arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
@@ -970,7 +951,11 @@ static int __init arch_timer_of_init(struct device_node *np)
 	 */
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_detect_rate(NULL);
+		arch_timer_rate = arch_timer_get_sysreg_freq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -1087,7 +1072,12 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	 */
 	if (!arch_timer_rate &&
 	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
-		arch_timer_detect_rate(base);
+		arch_timer_rate = arch_timer_get_mmio_freq(base);
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available for MMIO timer.\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
@@ -1150,7 +1140,11 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		gtdt->non_secure_el2_flags);
 
 	/* Get the frequency from the sysreg CNTFRQ */
-	arch_timer_detect_rate(NULL);
+	arch_timer_rate = arch_timer_get_sysreg_freq();
+	if (!arch_timer_rate) {
+		pr_err(FW_BUG "frequency not available.\n");
+		return -EINVAL;
+	}
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3
