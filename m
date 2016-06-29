From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 30 Jun 2016 02:15:48 +0800
Subject: [PATCH v6 05/10] acpi: Add arch_timer support in GTDT table parse
 driver
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1467224153-22873-6-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch adds support for parsing arch timer in GTDT,
provides some kernel APIs to parse all the PPIs and
always-on info in GTDT and export them.

By this driver, we can simplify arm_arch_timer drivers, and
separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_gtdt.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  6 +++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/acpi/acpi_gtdt.c b/drivers/acpi/acpi_gtdt.c
index 54d7644e..edb5a8c 100644
--- a/drivers/acpi/acpi_gtdt.c
+++ b/drivers/acpi/acpi_gtdt.c
@@ -16,6 +16,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <clocksource/arm_arch_timer.h>
+
 #undef pr_fmt
 #define pr_fmt(fmt) "GTDT: " fmt
 
@@ -83,3 +85,71 @@ static int __init acpi_gtdt_desc_init(struct acpi_table_header *table)
 
 	return gtdt->platform_timer_count;
 }
+
+static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	if (!interrupt)
+		return 0;
+
+	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
+}
+
+/*
+ * Map the PPIs of per-cpu arch_timer.
+ * @type: the type of PPI
+ * Returns 0 if error.
+ */
+int __init acpi_gtdt_map_ppi(int type)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	switch (type) {
+	case PHYS_SECURE_PPI:
+		return map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
+						   gtdt->secure_el1_flags);
+	case PHYS_NONSECURE_PPI:
+		return map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
+						   gtdt->non_secure_el1_flags);
+	case VIRT_PPI:
+		return map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
+						   gtdt->virtual_timer_flags);
+
+	case HYP_PPI:
+		return map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
+						   gtdt->non_secure_el2_flags);
+	default:
+		pr_err("ppi type error.\n");
+	}
+
+	return 0;
+}
+
+/*
+ * acpi_gtdt_c3stop - got c3stop info from GTDT
+ *
+ * Returns 1 if the timer is powered in deep idle state, 0 otherwise.
+ */
+int __init acpi_gtdt_c3stop(void)
+{
+	struct acpi_table_gtdt *gtdt = acpi_gtdt_desc.gtdt;
+
+	return !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+}
+
+int __init gtdt_arch_timer_init(struct acpi_table_header *table)
+{
+	if (table)
+		return acpi_gtdt_desc_init(table);
+
+	pr_err("table pointer error.\n");
+
+	return -EINVAL;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..8439579 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -532,6 +532,12 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
+#ifdef CONFIG_ACPI_GTDT
+int __init gtdt_arch_timer_init(struct acpi_table_header *table);
+int __init acpi_gtdt_map_ppi(int type);
+int __init acpi_gtdt_c3stop(void);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.5.5
