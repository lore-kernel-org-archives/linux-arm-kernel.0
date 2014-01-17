From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:11 +0800
Subject: [PATCH 17/20] clocksource / arch_timer: Use ACPI GTDT table to
 initialize arch timer
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-18-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI GTDT (Generic Timer Description Table) contains information for
arch timer initialization, this patch use this table to probe arm timer.

GTDT table is used for ARM/ARM64 only, please refer to chapter 5.2.24
of ACPI 5.0 spec for detailed inforamtion

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c |  100 +++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 95fb944..1fa5f67 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
+#include <linux/acpi.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -632,20 +633,8 @@ static void __init arch_timer_common_init(void)
 	arch_timer_arch_init();
 }
 
-static void __init arch_timer_init(struct device_node *np)
+static void __init arch_timer_init(void)
 {
-	int i;
-
-	if (arch_timers_present & ARCH_CP15_TIMER) {
-		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
-		return;
-	}
-
-	arch_timers_present |= ARCH_CP15_TIMER;
-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
-		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
-	arch_timer_detect_rate(NULL, np);
-
 	/*
 	 * If HYP mode is available, we know that the physical timer
 	 * has been configured to be accessible from PL1. Use it, so
@@ -667,8 +656,89 @@ static void __init arch_timer_init(struct device_node *np)
 	arch_timer_register();
 	arch_timer_common_init();
 }
-CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_init);
-CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_init);
+
+static void __init arch_timer_of_init(struct device_node *np)
+{
+	int i;
+
+	if (arch_timers_present & ARCH_CP15_TIMER) {
+		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
+		return;
+	}
+
+	arch_timers_present |= ARCH_CP15_TIMER;
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
+	arch_timer_detect_rate(NULL, np);
+
+	arch_timer_init();
+}
+CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
+CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
+
+#ifdef CONFIG_ACPI
+static void __init register_arch_interrupt(u32 interrupt, u32 flags,
+					int *arch_timer_ppi)
+{
+	int trigger, polarity;
+
+	if (!interrupt || !arch_timer_ppi)
+		return;
+
+	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	*arch_timer_ppi = acpi_register_gsi(NULL, interrupt, trigger,
+						polarity);
+}
+
+static int __init acpi_parse_gtdt(struct acpi_table_header *table)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = (struct acpi_table_gtdt *)table;
+	if (!gtdt)
+		return -EINVAL;
+
+	arch_timer_rate = arch_timer_get_cntfrq();
+
+	if (!arch_timer_rate) {
+		pr_warn("arch_timer: Could not get frequency from CNTFREG\n");
+		return -EINVAL;
+	}
+
+	register_arch_interrupt(gtdt->secure_pl1_interrupt,
+		gtdt->secure_pl1_flags, &arch_timer_ppi[PHYS_SECURE_PPI]);
+
+	register_arch_interrupt(gtdt->non_secure_pl1_interrupt,
+		gtdt->non_secure_pl1_flags, &arch_timer_ppi[PHYS_NONSECURE_PPI]);
+
+	register_arch_interrupt(gtdt->virtual_timer_interrupt,
+		gtdt->virtual_timer_flags, &arch_timer_ppi[VIRT_PPI]);
+
+	register_arch_interrupt(gtdt->non_secure_pl2_interrupt,
+		gtdt->non_secure_pl2_flags, &arch_timer_ppi[HYP_PPI]);
+
+	return 0;
+}
+
+void __init arch_timer_acpi_init(struct acpi_table_header *table)
+{
+	if (arch_timers_present & ARCH_CP15_TIMER) {
+		pr_warn("arch_timer: already initialized, skipping\n");
+		return;
+	}
+
+	if (acpi_parse_gtdt(table))
+		return;
+
+	arch_timers_present |= ARCH_CP15_TIMER;
+	arch_timer_init();
+}
+#endif
 
 static void __init arch_timer_mem_init(struct device_node *np)
 {
-- 
1.7.9.5
