From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 17:44:26 +0100
Subject: [PATCH 09/16] clocksource: arm_arch_timer: move
 arch_timer_needs_of_probing into DT init call
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1492620273-30037-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

To cleanly split code paths specific to ACPI or DT at a higher level,
this patch removes arch_timer_init(), folding the relevant
parts of its logic into existing callers.

This pathes the way for further rework, and saves a few lines.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e38f4d4..ac6fd00 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1105,9 +1105,6 @@ static bool __init arch_timer_needs_of_probing(void)
 
 static int __init arch_timer_common_init(void)
 {
-	if (acpi_disabled && arch_timer_needs_of_probing())
-		return 0;
-
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
 	return arch_timer_arch_init();
@@ -1145,26 +1142,9 @@ static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
 	return ARCH_TIMER_PHYS_SECURE_PPI;
 }
 
-static int __init arch_timer_init(void)
-{
-	int ret;
-
-	ret = arch_timer_register();
-	if (ret)
-		return ret;
-
-	ret = arch_timer_common_init();
-	if (ret)
-		return ret;
-
-	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
-
-	return 0;
-}
-
 static int __init arch_timer_of_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 	u32 rate;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1176,6 +1156,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	rate = arch_timer_get_cntfrq;
 	arch_timer_of_configure_rate(rate, np);
 
@@ -1203,7 +1185,14 @@ static int __init arch_timer_of_init(struct device_node *np)
 	arch_counter_suspend_stop = of_property_read_bool(np,
 							 "arm,no-tick-in-suspend");
 
-	return arch_timer_init();
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	if (arch_timer_needs_of_probing())
+		return 0;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
@@ -1285,7 +1274,8 @@ static int __init arch_timer_mem_init(struct device_node *np)
 	if (ret)
 		goto out;
 
-	return arch_timer_common_init();
+	if (!arch_timer_needs_of_probing())
+		ret = arch_timer_common_init();
 out:
 	iounmap(cntctlbase);
 	of_node_put(best_frame);
@@ -1314,6 +1304,7 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
+	int ret;
 	struct acpi_table_gtdt *gtdt;
 
 	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
@@ -1341,6 +1332,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
 		gtdt->non_secure_el2_flags);
 
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
+
 	/*
 	 * When probing via ACPI, we have no mechanism to override the sysreg
 	 * CNTFRQ value. This *must* be correct.
@@ -1363,8 +1356,11 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Check for globally applicable workarounds */
 	arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table);
 
-	arch_timer_init();
-	return 0;
+	ret = arch_timer_register();
+	if (ret)
+		return ret;
+
+	return arch_timer_common_init();
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
-- 
1.9.1
