From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 May 2015 20:59:12 +0800
Subject: [PATCH 02/11] ACPI / irqchip: Add self-probe infrastructure to
 initialize IRQ controller
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1431953961-22706-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This self-probe infrastructure works in the similar way as OF,
but there is some different in the mechanism:

For OF, the init fn will be called once it finds comptiable strings
in DT,  but for ACPI, we init irqchips by static tables, and in
static ACPI tables, there are no comptiable strings to indicate
irqchips, so every init function with IRQCHIP_ACPI_DECLARE in the
same table will be called, but thanks to the GIC version presented
in ACPI table, we can init different GIC irqchips with this framework.

This mechanism can also be used for clock declare and may also works
on x86 for some table parsing too.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
[hj: introduce struct acpi_table_id instead of acpi_device_id]
[hj: rework it more generic to all ACPI tables and fix some issues]
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Makefile             |  1 +
 drivers/acpi/irq.c                | 37 +++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irqchip.h         | 12 ++++++++++++
 include/asm-generic/vmlinux.lds.h | 13 +++++++++++++
 include/linux/acpi.h              | 14 ++++++++++++++
 include/linux/mod_devicetable.h   |  7 +++++++
 6 files changed, 84 insertions(+)
 create mode 100644 drivers/acpi/irq.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8a063e2..3e4aec3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
+obj-$(CONFIG_IRQCHIP)		+= irq.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
new file mode 100644
index 0000000..65d6b93
--- /dev/null
+++ b/drivers/acpi/irq.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2015, Linaro Ltd.
+ * Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * Inspired by drivers/irqchip/irqchip.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/acpi.h>
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
+	for (id = __irqchip_acpi_table; id->id[0]; id++)
+		acpi_table_parse(id->id, (acpi_tbl_table_handler)id->data);
+}
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
index 0f6486d..1949546 100644
--- a/drivers/irqchip/irqchip.h
+++ b/drivers/irqchip/irqchip.h
@@ -11,6 +11,7 @@
 #ifndef _IRQCHIP_H
 #define _IRQCHIP_H
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 
 /*
@@ -25,4 +26,15 @@
  */
 #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
 
+/*
+ * This macro must be used by the different irqchip drivers to declare
+ * the association between their ACPI table and their initialization function.
+ *
+ * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
+ * same file.
+ * @table_id: name of the ACPI table signature
+ * @fn: initialization function
+ */
+#define IRQCHIP_ACPI_DECLARE(name, table_id, fn)	\
+	ACPI_DECLARE(irqchip, name, table_id, fn)
 #endif
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
index 90e4ed1e..b904af3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -820,4 +820,18 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
 
 #endif
 
+#ifdef CONFIG_ACPI
+#define ACPI_DECLARE(table, name, table_id, fn)				\
+	static const struct acpi_table_id __acpi_table_##name		\
+		__used __section(__##table##_acpi_table)		\
+		 = { .id = table_id,					\
+		     .data = (void *)fn }
+#else
+#define ACPI_DECLARE(table, name, table_id, fn)				\
+	static const struct acpi_table_id __acpi_table_##name		\
+		__attribute__((unused))					\
+		 = { .id = table_id,					\
+		     .data = (void*)fn }
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 3bfd567..47c1ea1 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -199,6 +199,13 @@ struct pnp_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define ACPI_TABLE_ID_LEN	5
+
+struct acpi_table_id {
+	__u8 id[ACPI_TABLE_ID_LEN];
+	const void *data;
+};
+
 struct pnp_card_device_id {
 	__u8 id[PNP_ID_LEN];
 	kernel_ulong_t driver_data;
-- 
1.9.1
