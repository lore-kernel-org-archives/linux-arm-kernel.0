From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 18 Mar 2016 16:00:51 +0800
Subject: [RESEND PATCH v4 3/5] clocksource: simplify ACPI code in
 arm_arch_timer.c
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1458288053-29031-4-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch update arm_arch_timer driver to use the function
provided by the new GTDT driver of ACPI.
By this way, arm_arch_timer.c can be simplified, and separate
all the ACPI GTDT knowledge from this timer driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/arm_arch_timer.c | 48 ++++++++----------------------------
 2 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c346be6..68d2f40 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -8,6 +8,7 @@ config CLKSRC_OF
 config CLKSRC_ACPI
 	bool
 	select CLKSRC_PROBE
+	select ACPI_GTDT
 
 config CLKSRC_PROBE
 	bool
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 11744c0..d0b01fb5 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -843,60 +843,32 @@ out:
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
-#ifdef CONFIG_ACPI
-static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-{
-	int trigger, polarity;
-
-	if (!interrupt)
-		return 0;
-
-	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
-			: ACPI_LEVEL_SENSITIVE;
-
-	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
-			: ACPI_ACTIVE_HIGH;
-
-	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
-}
-
+#ifdef CONFIG_ACPI_GTDT
 /* Initialize per-processor generic timer */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	struct acpi_table_gtdt *gtdt;
+	struct arch_timer_data data;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
 		pr_warn("arch_timer: already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-	gtdt = container_of(table, struct acpi_table_gtdt, header);
-
 	arch_timers_present |= ARCH_CP15_TIMER;
 
-	arch_timer_ppi[PHYS_SECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-		gtdt->secure_el1_flags);
-
-	arch_timer_ppi[PHYS_NONSECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
-		gtdt->non_secure_el1_flags);
-
-	arch_timer_ppi[VIRT_PPI] =
-		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
-		gtdt->virtual_timer_flags);
+	if (gtdt_arch_timer_data_init(table, &data))
+		return -EINVAL;
 
-	arch_timer_ppi[HYP_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
-		gtdt->non_secure_el2_flags);
+	arch_timer_ppi[PHYS_SECURE_PPI] = data.phys_secure_ppi;
+	arch_timer_ppi[PHYS_NONSECURE_PPI] = data.phys_nonsecure_ppi;
+	arch_timer_ppi[VIRT_PPI] = data.virt_ppi;
+	arch_timer_ppi[HYP_PPI] = data.hyp_ppi;
+	arch_timer_c3stop = data.c3stop; /* Always-on capability */
 
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
-
-	/* Always-on capability */
-	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
-
 	arch_timer_init();
+
 	return 0;
 }
 CLOCKSOURCE_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
-- 
2.5.0
