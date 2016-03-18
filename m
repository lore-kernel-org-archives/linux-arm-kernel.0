From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Fri, 18 Mar 2016 16:00:50 +0800
Subject: [RESEND PATCH v4 2/5] ACPI: add GTDT table parse driver into ACPI
 driver
In-Reply-To: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1458288053-29031-3-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing all kinds of timer in GTDT:
(1)arch timer: provide a kernel API to parse all the PPIs and
always-on info in GTDT and export them by arch_timer_data struct.

(2)memory-mapped timer: provide several kernel APIs to parse
GT Block Structure in GTDT, export those info by return value
and arch_timer_mem_data struct.

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
 drivers/acpi/gtdt.c                  | 376 +++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h |  13 ++
 include/linux/acpi.h                 |  17 ++
 5 files changed, 416 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82b96ee..abf33d3 100644
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
index edeb2d1..f7ea779 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -98,5 +98,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= gtdt.o
 
 video-objs			+= acpi_video.o video_detect.o
diff --git a/drivers/acpi/gtdt.c b/drivers/acpi/gtdt.c
new file mode 100644
index 0000000..d1b851c
--- /dev/null
+++ b/drivers/acpi/gtdt.c
@@ -0,0 +1,376 @@
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
+static u32 platform_timer_count __initdata;
+static int gtdt_timers_existence __initdata;
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table, and will be run only once.
+ */
+static void __init *platform_timer_info_init(struct acpi_table_header *table)
+{
+	void *gtdt_end, *platform_timer_struct, *platform_timer;
+	struct acpi_gtdt_header *header;
+	struct acpi_table_gtdt *gtdt;
+	u32 i;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (!gtdt) {
+		pr_err("table pointer error.\n");
+		return NULL;
+	}
+	gtdt_end = (void *)table + table->length;
+	gtdt_timers_existence |= ARCH_CP15_TIMER;
+
+	if (table->revision < 2) {
+		pr_info("Revision:%d doesn't support Platform Timers.\n",
+			table->revision);
+		return NULL;
+	}
+
+	platform_timer_count = gtdt->platform_timer_count;
+	if (!platform_timer_count) {
+		pr_info("No Platform Timer structures.\n");
+		return NULL;
+	}
+
+	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
+	if (platform_timer_struct < (void *)table +
+				    sizeof(struct acpi_table_gtdt)) {
+		pr_err(FW_BUG "Platform Timer pointer error.\n");
+		return NULL;
+	}
+
+	platform_timer = platform_timer_struct;
+	for (i = 0; i < platform_timer_count; i++) {
+		if (platform_timer > gtdt_end) {
+			pr_err(FW_BUG "subtable pointer overflows.\n");
+			platform_timer_count = i;
+			break;
+		}
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_TIMER_BLOCK)
+			gtdt_timers_existence |= ARCH_MEM_TIMER;
+		else if (header->type == ACPI_GTDT_TYPE_WATCHDOG)
+			gtdt_timers_existence |= ARCH_WD_TIMER;
+		platform_timer += header->length;
+	}
+
+	return platform_timer_struct;
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
+int __init gtdt_arch_timer_data_init(struct acpi_table_header *table,
+				     struct arch_timer_data *data)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	if (acpi_disabled || !data)
+		return -EINVAL;
+
+	if (!table) {
+		if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+			return -EINVAL;
+	}
+
+	if (!gtdt_timers_existence)
+		platform_timer_info_init(table);
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	data->phys_secure_ppi =
+		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
+					    gtdt->secure_el1_flags);
+
+	data->phys_nonsecure_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
+					    gtdt->non_secure_el1_flags);
+
+	data->virt_ppi =
+		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
+					    gtdt->virtual_timer_flags);
+
+	data->hyp_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
+					    gtdt->non_secure_el2_flags);
+
+	data->c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
+
+	return 0;
+}
+
+bool __init gtdt_timer_is_available(int type)
+{
+	return gtdt_timers_existence | type;
+}
+
+/*
+ * Helper function for getting the pointer of platform_timer_struct.
+ */
+static void __init *get_platform_timer_struct(struct acpi_table_header *table)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	if (!table) {
+		pr_err("table pointer error.\n");
+		return NULL;
+	}
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	return (void *)gtdt + gtdt->platform_timer_offset;
+}
+
+ /*
+ * Get the pointer of GT Block Structure in GTDT table
+ */
+void __init *gtdt_gt_block(struct acpi_table_header *table, int index)
+{
+	struct acpi_gtdt_header *header;
+	void *platform_timer;
+	int i, j;
+
+	if (!gtdt_timers_existence)
+		platform_timer = platform_timer_info_init(table);
+	else
+		platform_timer = get_platform_timer_struct(table);
+
+	if (!gtdt_timer_is_available(ARCH_MEM_TIMER))
+		return NULL;
+
+	for (i = 0, j = 0; i < platform_timer_count; i++) {
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_TIMER_BLOCK && j++ == index)
+			return platform_timer;
+		platform_timer += header->length;
+	}
+
+	return NULL;
+}
+
+/*
+ * Get the timer_count(the number of timer frame) of a GT Block in GTDT table
+ */
+u32 __init gtdt_gt_timer_count(struct acpi_gtdt_timer_block *gt_block)
+{
+	if (!gt_block) {
+		pr_err("invalid GT Block baseaddr.\n");
+		return 0;
+	}
+
+	return gt_block->timer_count;
+}
+
+/*
+ * Get the physical address of GT Block in GTDT table
+ */
+void __init *gtdt_gt_cntctlbase(struct acpi_gtdt_timer_block *gt_block)
+{
+	if (!gt_block) {
+		pr_err("invalid GT Block baseaddr.\n");
+		return NULL;
+	}
+
+	return (void *)gt_block->block_address;
+}
+
+/*
+ * Helper function for getting the pointer of a timer frame in GT block.
+ */
+static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
+					int index)
+{
+	void *timer_frame;
+
+	if (!(gt_block && gt_block->timer_count))
+		return NULL;
+
+	timer_frame = (void *)gt_block + gt_block->timer_offset +
+		      sizeof(struct acpi_gtdt_timer_entry) * index;
+
+	if (timer_frame <= (void *)gt_block + gt_block->header.length -
+			   sizeof(struct acpi_gtdt_timer_entry))
+		return timer_frame;
+
+	pr_err(FW_BUG "invalid GT Block timer frame entry addr.\n");
+
+	return NULL;
+}
+
+/*
+ * Get the GT timer Frame Number(ID) in a GT Block Timer Structure.
+ * The maximum Frame Number(ID) is (ARCH_TIMER_MEM_MAX_FRAME - 1),
+ * so returning ARCH_TIMER_MEM_MAX_FRAME means error.
+ */
+u32 __init gtdt_gt_frame_number(struct acpi_gtdt_timer_block *gt_block,
+				int index)
+{
+	struct acpi_gtdt_timer_entry *frame;
+
+	frame = (struct acpi_gtdt_timer_entry *)gtdt_gt_timer_frame(gt_block,
+								    index);
+	if (frame)
+		return frame->frame_number;
+
+	return ARCH_TIMER_MEM_MAX_FRAME;
+}
+
+/*
+ * Get the GT timer Frame data in a GT Block Timer Structure
+ */
+int __init gtdt_gt_timer_data(struct acpi_gtdt_timer_block *gt_block,
+			      int index, bool virt,
+			      struct arch_timer_mem_data *data)
+{
+	struct acpi_gtdt_timer_entry *frame;
+
+	frame = (struct acpi_gtdt_timer_entry *)gtdt_gt_timer_frame(gt_block,
+								    index);
+	if (!frame)
+		return -EINVAL;
+
+	data->cntbase_phy = (phys_addr_t)frame->base_address;
+	if (virt)
+		data->irq = map_generic_timer_interrupt(
+				frame->virtual_timer_interrupt,
+				frame->virtual_timer_flags);
+	else
+		data->irq = map_generic_timer_interrupt(frame->timer_interrupt,
+							frame->timer_flags);
+
+	return 0;
+}
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
+					int index)
+{
+	struct platform_device *pdev;
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
+	struct acpi_gtdt_header *header;
+	void *platform_timer;
+	int i, gwdt_index;
+	int ret = 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	/*
+	 * At this proint, we have got and validate some info about platform
+	 * timer in platform_timer_info_init.
+	 */
+	if (!gtdt_timer_is_available(ARCH_WD_TIMER))
+		return -EINVAL;
+
+	platform_timer = get_platform_timer_struct(table);
+
+	for (i = 0, gwdt_index = 0; i < platform_timer_count; i++) {
+		header = (struct acpi_gtdt_header *)platform_timer;
+		if (header->type == ACPI_GTDT_TYPE_WATCHDOG) {
+			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_index);
+			if (ret)
+				pr_err("failed to import subtable %d.\n", i);
+			else
+				gwdt_index++;
+		}
+		platform_timer += header->length;
+	}
+
+	return ret;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 3e060fc..8abbe67 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -69,6 +69,19 @@ enum spi_nr {
 
 #define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */
 
+struct arch_timer_data {
+	int phys_secure_ppi;
+	int phys_nonsecure_ppi;
+	int virt_ppi;
+	int hyp_ppi;
+	bool c3stop;
+};
+
+struct arch_timer_mem_data {
+	phys_addr_t cntbase_phy;
+	int irq;
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..51bebe9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -540,6 +540,23 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
+#ifdef CONFIG_ACPI_GTDT
+bool __init gtdt_timer_is_available(int type);
+
+struct arch_timer_data;
+int __init gtdt_arch_timer_data_init(struct acpi_table_header *table,
+				     struct arch_timer_data *data);
+struct arch_timer_mem_data;
+void __init *gtdt_gt_block(struct acpi_table_header *table, int index);
+u32 __init gtdt_gt_timer_count(struct acpi_gtdt_timer_block *gt_block);
+void __init *gtdt_gt_cntctlbase(struct acpi_gtdt_timer_block *gt_block);
+u32 __init gtdt_gt_frame_number(struct acpi_gtdt_timer_block *gt_block,
+				int index);
+int __init gtdt_gt_timer_data(struct acpi_gtdt_timer_block *gt_block,
+			      int index, bool virt,
+			      struct arch_timer_mem_data *data);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.5.0
