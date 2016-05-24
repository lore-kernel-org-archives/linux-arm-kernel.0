From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 24 May 2016 21:30:31 +0800
Subject: [PATCH v5 4/6] acpi: Add GTDT table parse driver into ACPI driver
In-Reply-To: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1464096633-9309-5-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing all kinds of timer in GTDT:
(1)arch timer: provide a kernel API to parse all the PPIs and
always-on info in GTDT and export them by filling the structs
which provided by parameters(pointer of them).

(2)memory-mapped timer: provide a kernel APIs to parse
GT Block Structure in GTDT, export all the timer info by filling
the struct which provided by parameter(pointer of the struct).

(3)SBSA Generic Watchdog: parse all info in SBSA Generic Watchdog
Structure in GTDT, and creating a platform device with that
information. This allows the operating system to obtain device
data from the resource of platform device.
The platform device named "sbsa-gwdt" can be used by the ARM SBSA
Generic Watchdog driver.

By this driver, we can simplify all the relevant drivers, and
separate all the ACPI GTDT knowledge from them.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig                 |   9 +
 drivers/acpi/Makefile                |   1 +
 drivers/acpi/acpi_gtdt.c             | 309 +++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h |  16 ++
 include/linux/acpi.h                 |   6 +
 5 files changed, 341 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..27a5cf9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,4 +521,13 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_GTDT
+	bool "ACPI GTDT Support"
+	depends on ARM64
+	help
+	  GTDT (Generic Timer Description Table) provides information
+	  for per-processor timers and Platform (memory-mapped) timers
+	  for ARM platforms. Select this option to provide information
+	  needed for the timers init.
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 251ce85..848aa8a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= acpi_gtdt.o
 
 video-objs			+= acpi_video.o video_detect.o
diff --git a/drivers/acpi/acpi_gtdt.c b/drivers/acpi/acpi_gtdt.c
new file mode 100644
index 0000000..e54fadf
--- /dev/null
+++ b/drivers/acpi/acpi_gtdt.c
@@ -0,0 +1,309 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2015, Linaro Ltd.
+ * Author: Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "GTDT: " fmt
+
+typedef int (*platform_timer_handler)(void *platform_timer, int index,
+				      void *data);
+
+static void *platform_timer_struct __initdata;
+static u32 platform_timer_count __initdata;
+static void *gtdt_end __initdata;
+
+static int __init for_platform_timer(enum acpi_gtdt_type type,
+				     platform_timer_handler handler, void *data)
+{
+	struct acpi_gtdt_header *header;
+	int i, index, ret;
+	void *platform_timer = platform_timer_struct;
+
+	for (i = 0, index = 0; i < platform_timer_count; i++) {
+		if (platform_timer > gtdt_end) {
+			pr_err(FW_BUG "subtable pointer overflows.\n");
+			platform_timer_count = i;
+			break;
+		}
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == type) {
+			ret = handler(platform_timer, index, data);
+			if (ret)
+				pr_err("failed to handler subtable %d.\n", i);
+			else
+				index++;
+		}
+		platform_timer += header->length;
+	}
+
+	return index;
+}
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table, and will be run only once.
+ */
+static void __init platform_timer_init(struct acpi_table_header *table,
+				       struct acpi_table_gtdt *gtdt)
+{
+	gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2) {
+		pr_info("Revision:%d doesn't support Platform Timers.\n",
+			table->revision);
+		return;
+	}
+
+	platform_timer_count = gtdt->platform_timer_count;
+	if (!platform_timer_count) {
+		pr_info("No Platform Timer structures.\n");
+		return;
+	}
+
+	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
+	if (platform_timer_struct < (void *)table +
+				    sizeof(struct acpi_table_gtdt)) {
+		pr_err(FW_BUG "Platform Timer pointer error.\n");
+		platform_timer_struct = NULL;
+		platform_timer_count = 0;
+	}
+}
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
+ * Get the necessary info of arch_timer from GTDT table.
+ */
+int __init gtdt_arch_timer_init(struct acpi_table_header *table, int *ppi,
+				bool *c3stop, u32 *timer_count)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	if (acpi_disabled || !table || !ppi || !c3stop)
+		return -EINVAL;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (!gtdt) {
+		pr_err("table pointer error.\n");
+		return -EINVAL;
+	}
+
+	ppi[PHYS_SECURE_PPI] =
+		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
+					    gtdt->secure_el1_flags);
+
+	ppi[PHYS_NONSECURE_PPI] =
+		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
+					    gtdt->non_secure_el1_flags);
+
+	ppi[VIRT_PPI] =
+		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
+					    gtdt->virtual_timer_flags);
+
+	ppi[HYP_PPI] =
+		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
+					    gtdt->non_secure_el2_flags);
+
+	*c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+
+	platform_timer_init(table, gtdt);
+	if (timer_count)
+		*timer_count = platform_timer_count;
+
+	return 0;
+}
+
+/*
+ * Helper function for getting the pointer of a timer frame in GT block.
+ */
+static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
+					int index)
+{
+	void *timer_frame = (void *)gt_block + gt_block->timer_offset +
+			    sizeof(struct acpi_gtdt_timer_entry) * index;
+
+	if (timer_frame <= (void *)gt_block + gt_block->header.length -
+			   sizeof(struct acpi_gtdt_timer_entry))
+		return timer_frame;
+
+	return NULL;
+}
+
+static int __init gtdt_parse_gt_block(void *platform_timer, int index,
+				      void *data)
+{
+	struct acpi_gtdt_timer_block *block;
+	struct acpi_gtdt_timer_entry *frame;
+	struct gt_block_data *block_data;
+	int i, j;
+
+	if (!platform_timer || !data)
+		return -EINVAL;
+
+	block = platform_timer;
+	block_data = data + sizeof(struct gt_block_data) * index;
+
+	if (!block->block_address || !block->timer_count) {
+		pr_err(FW_BUG "invalid GT Block data.\n");
+		return -EINVAL;
+	}
+	block_data->cntctlbase_phy = (phys_addr_t)block->block_address;
+	block_data->timer_count = block->timer_count;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0, j = 0; i < block->timer_count; i++) {
+		frame = gtdt_gt_timer_frame(block, i);
+		if (!frame || !frame->base_address || !frame->timer_interrupt) {
+			pr_err(FW_BUG "invalid GT Block Timer data, skip.\n");
+			continue;
+		}
+		block_data->timer[j].frame_nr = frame->frame_number;
+		block_data->timer[j].cntbase_phy = frame->base_address;
+		block_data->timer[j].irq = map_generic_timer_interrupt(
+						   frame->timer_interrupt,
+						   frame->timer_flags);
+		if (frame->virtual_timer_interrupt)
+			block_data->timer[j].virt_irq =
+				map_generic_timer_interrupt(
+					frame->virtual_timer_interrupt,
+					frame->virtual_timer_flags);
+		j++;
+	}
+
+	if (j)
+		return 0;
+
+	block_data->cntctlbase_phy = (phys_addr_t)NULL;
+	block_data->timer_count = 0;
+
+	return -EINVAL;
+}
+
+/*
+ * Get the GT block info for memory-mapped timer from GTDT table.
+ * Please make sure we have called gtdt_arch_timer_init, because it helps to
+ * init the global variables.
+ */
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
+{
+	int ret = for_platform_timer(ACPI_GTDT_TYPE_TIMER_BLOCK,
+				     gtdt_parse_gt_block, (void *)data);
+
+	pr_info("found %d memory-mapped timer block.\n", ret);
+
+	return ret;
+}
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(void *platform_timer,
+					int index, void *data)
+{
+	struct platform_device *pdev;
+	struct acpi_gtdt_watchdog *wd = platform_timer;
+	int irq = map_generic_timer_interrupt(wd->timer_interrupt,
+					      wd->timer_flags);
+	int no_irq = 1;
+
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 ? 0xFFF).
+	 */
+	struct resource res[] = {
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+
+	pr_debug("a Watchdog GT(0x%llx/0x%llx gsi:%u flags:0x%x).\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
+		pr_err(FW_BUG "failed getting the Watchdog GT frame addr.\n");
+		return -EINVAL;
+	}
+
+	if (!wd->timer_interrupt)
+		pr_warn(FW_BUG "failed getting the Watchdog GT GSIV.\n");
+	else if (irq <= 0)
+		pr_warn("failed to map the Watchdog GT GSIV.\n");
+	else
+		no_irq = 0;
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res) - no_irq);
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_sbsa_gwdt_init(void)
+{
+	struct acpi_table_header *table;
+	struct acpi_table_gtdt *gtdt;
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	/* global variables initialization */
+	gtdt_end = (void *)table + table->length;
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
+
+	ret = for_platform_timer(ACPI_GTDT_TYPE_WATCHDOG,
+				 gtdt_import_sbsa_gwdt, NULL);
+	pr_info("found %d SBSA generic Watchdog.\n", ret);
+
+	return 0;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 16dcd10..4e5b2a2 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -21,6 +21,7 @@
 
 #define ARCH_CP15_TIMER			BIT(0)
 #define ARCH_MEM_TIMER			BIT(1)
+#define ARCH_WD_TIMER			BIT(2)
 
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
@@ -56,6 +57,8 @@ enum spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -71,6 +74,19 @@ struct arch_timer_kvm_info {
 	int virtual_irq;
 };
 
+struct gt_timer_data {
+	int frame_nr;
+	phys_addr_t cntbase_phy;
+	int irq;
+	int virt_irq;
+};
+
+struct gt_block_data {
+	phys_addr_t cntctlbase_phy;
+	int timer_count;
+	struct gt_timer_data timer[ARCH_TIMER_MEM_MAX_FRAME];
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..53b35d4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -532,6 +532,12 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
+#ifdef CONFIG_ACPI_GTDT
+int __init gtdt_arch_timer_init(struct acpi_table_header *table, int *ppi,
+				bool *c3stop, u32 *timer_count);
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.5.5
