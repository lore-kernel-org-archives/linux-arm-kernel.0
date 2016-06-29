From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 30 Jun 2016 02:15:51 +0800
Subject: [PATCH v6 08/10] acpi: Add memory-mapped timer support in GTDT driver
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1467224153-22873-9-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing memory-mapped timer in GTDT:
provide a kernel APIs to parse GT Block Structure in GTDT,
export all the info by filling the struct which provided
by parameter(pointer of the struct).

By this driver, we can add ACPI support for memory-mapped timer in
arm_arch_timer drivers, and separate the ACPI GTDT knowledge from it.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_gtdt.c             | 89 ++++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 15 ++++++
 include/linux/acpi.h                 |  1 +
 3 files changed, 105 insertions(+)

diff --git a/drivers/acpi/acpi_gtdt.c b/drivers/acpi/acpi_gtdt.c
index edb5a8c..4592dba 100644
--- a/drivers/acpi/acpi_gtdt.c
+++ b/drivers/acpi/acpi_gtdt.c
@@ -153,3 +153,92 @@ int __init gtdt_arch_timer_init(struct acpi_table_header *table)
 
 	return -EINVAL;
 }
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
+			pr_err(FW_BUG "invalid GT Block Timer data.\n");
+			return -EINVAL;
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
+	void *platform_timer;
+	int index = 0;
+
+	for_each_gtdt_timer(platform_timer) {
+		if (!gtdt_parse_gt_block(platform_timer, index, data))
+			index++;
+	}
+
+	if (index)
+		pr_info("found %d memory-mapped timer block.\n", index);
+
+	return index;
+}
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 16dcd10..ece6b3b 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,8 @@ enum spi_nr {
 #define ARCH_TIMER_MEM_PHYS_ACCESS	2
 #define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
+#define ARCH_TIMER_MEM_MAX_FRAME	8
+
 #define ARCH_TIMER_USR_PCT_ACCESS_EN	(1 << 0) /* physical counter */
 #define ARCH_TIMER_USR_VCT_ACCESS_EN	(1 << 1) /* virtual counter */
 #define ARCH_TIMER_VIRT_EVT_EN		(1 << 2)
@@ -71,6 +73,19 @@ struct arch_timer_kvm_info {
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
index 8439579..b1cacbc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -536,6 +536,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *);
 int __init gtdt_arch_timer_init(struct acpi_table_header *table);
 int __init acpi_gtdt_map_ppi(int type);
 int __init acpi_gtdt_c3stop(void);
+int __init gtdt_arch_timer_mem_init(struct gt_block_data *data);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.5.5
