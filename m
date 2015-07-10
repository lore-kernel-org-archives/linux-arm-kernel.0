From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:08 +0800
Subject: [PATCH v3 2/8] ACPI / irqchip: Add self-probe infrastructure to
 initialize IRQ controller
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This self-probe infrastructure works in the similar way as OF,
but there is some different in the mechanism:

For DT, the init fn will be called once it finds compatible strings
in DT,  but for ACPI, we init irqchips by static tables, and in
static ACPI tables, there are no compatible strings to indicate
irqchips, but thanks to the GIC version presented in ACPI table,
we can call the corresponding GIC drivers matching the GIC version
with this framework.

This mechanism can also be used for clock declare and may also works
on x86 for some table parsing too.

Part of this patch is based on Tomasz Nowicki's work.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-acpi.c    | 29 +++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 13 +++++++++++++
 include/linux/acpi.h              | 16 ++++++++++++++++
 include/linux/irqchip.h           | 13 +++++++++++++
 include/linux/mod_devicetable.h   |  8 ++++++++
 5 files changed, 79 insertions(+)

diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index 6537b43..e003a89 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -107,3 +107,32 @@ static int __init acpi_gic_version_init(void)
 
 	return 0;
 }
+
+/*
+ * This special acpi_table_id is the sentinel at the end of the
+ * acpi_table_id[] array of all irqchips. It is automatically placed at
+ * the end of the array by the linker, thanks to being part of a
+ * special section.
+ */
+static const struct acpi_table_id
+irqchip_acpi_match_end __used __section(__irqchip_acpi_table_end);
+
+extern struct acpi_table_id __irqchip_acpi_table[];
+
+void __init acpi_irqchip_init(void)
+{
+	struct acpi_table_id *id;
+
+	if (acpi_disabled)
+		return;
+
+	if (acpi_gic_version_init())
+		return;
+
+	/* scan the irqchip table to match the GIC version and its driver */
+	for (id = __irqchip_acpi_table; id->id[0]; id++) {
+		if (gic_version == (u8)id->driver_data)
+			acpi_table_parse(id->id,
+					 (acpi_tbl_table_handler)id->handler);
+	}
+}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8bd374d..625776c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -181,6 +181,18 @@
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
+#ifdef CONFIG_ACPI
+#define ACPI_TABLE(name)						\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__##name##_acpi_table) = .;			\
+	*(__##name##_acpi_table)					\
+	*(__##name##_acpi_table_end)
+
+#define IRQCHIP_ACPI_MATCH_TABLE()	ACPI_TABLE(irqchip)
+#else
+#define IRQCHIP_ACPI_MATCH_TABLE()
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	VMLINUX_SYMBOL(__dtb_start) = .;				\
@@ -516,6 +528,7 @@
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
+	IRQCHIP_ACPI_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
 	EARLYCON_OF_TABLES()
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c471dfc..7b058f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -811,4 +811,20 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
 
 #endif
 
+#ifdef CONFIG_ACPI
+#define ACPI_DECLARE(table, name, table_id, data, fn)			\
+	static const struct acpi_table_id __acpi_table_##name		\
+		__used __section(__##table##_acpi_table)		\
+		 = { .id = table_id,					\
+		     .handler = (void *)fn,				\
+		     .driver_data = data }
+#else
+#define ACPI_DECLARE(table, name, table_id, data, fn)			\
+	static const struct acpi_table_id __acpi_table_##name		\
+		__attribute__((unused))					\
+		 = { .id = table_id,					\
+		     .handler = (void *)fn,				\
+		     .driver_data = data }
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 6388873..6b66d3e 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 
 /*
@@ -25,6 +26,18 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+/*
+ * This macro must be used by the different ARM GIC drivers to declare
+ * the association between their version and their initialization function.
+ *
+ * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
+ * same file.
+ * @gic_version: version of GIC
+ * @fn: initialization function
+ */
+#define IRQCHIP_ACPI_DECLARE(name, gic_version, fn)	\
+	ACPI_DECLARE(irqchip, name, ACPI_SIG_MADT, gic_version, fn)
+
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
 #else
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 8183d66..c74855f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -191,6 +191,14 @@ struct acpi_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define ACPI_TABLE_ID_LEN	5
+
+struct acpi_table_id {
+	__u8 id[ACPI_TABLE_ID_LEN];
+	const void *handler;
+	kernel_ulong_t driver_data;
+};
+
 #define PNP_ID_LEN	8
 #define PNP_MAX_DEVICES	8
 
-- 
1.9.1
