From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 18 Jan 2017 21:25:31 +0800
Subject: [PATCH v20 07/17] clocksource/drivers/arm_arch_timer: Separate out
 device-tree code from arch_timer_detect_rate
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Message-ID: <20170118132541.8989-8-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

Currently, the counter frequency detection call(arch_timer_detect_rate)
include getting the frequency from the device-tree property.
But reading device-tree property will be needed only when system boot with
device-tree.

This patch separate out device-tree code, keep them in device-tree init
function.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 38 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 674d89f..6484f84 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -488,24 +488,19 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void
-arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
+static void arch_timer_detect_rate(void __iomem *cntbase)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
 		return;
 
 	/*
-	 * Try to determine the frequency from the device tree or CNTFRQ,
-	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
+	 * Try to determine the frequency from the MMIO timer or the sysreg.
 	 */
-	if (!acpi_disabled ||
-	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
-		if (cntbase)
-			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
-		else
-			arch_timer_rate = arch_timer_get_cntfrq();
-	}
+	if (cntbase)
+		arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
+	else
+		arch_timer_rate = arch_timer_get_cntfrq();
 
 	/* Check the timer frequency. */
 	if (arch_timer_rate == 0)
@@ -886,7 +881,13 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
-	arch_timer_detect_rate(NULL, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from the sysreg CNTFRQ.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate(NULL);
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
@@ -994,7 +995,14 @@ static int __init arch_timer_mem_init(struct device_node *np)
 		goto out;
 	}
 
-	arch_timer_detect_rate(base, np);
+	/*
+	 * Try to determine the frequency from the device tree,
+	 * if fail, get the frequency from the CNTFRQ reg of MMIO timer.
+	 */
+	if (!arch_timer_rate &&
+	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate))
+		arch_timer_detect_rate(base);
+
 	ret = arch_timer_mem_register(base, irq);
 	if (ret)
 		goto out;
@@ -1055,8 +1063,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
-	/* Get the frequency from CNTFRQ */
-	arch_timer_detect_rate(NULL, NULL);
+	/* Get the frequency from the sysreg CNTFRQ */
+	arch_timer_detect_rate(NULL);
 
 	arch_timer_uses_ppi = arch_timer_select_ppi();
 	if (!arch_timer_ppi[arch_timer_uses_ppi]) {
-- 
2.9.3
