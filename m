From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 29 Sep 2016 02:17:16 +0800
Subject: [PATCH v14 8/9] clocksource/drivers/arm_arch_timer: Add GTDT support
 for memory-mapped timer
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1475086637-1914-9-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the information
provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 92 +++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index e78095f..8482fba 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -660,6 +660,7 @@ out:
 static int __init arch_timer_mem_register(struct device_node *np, void *frame)
 {
 	struct device_node *frame_node = NULL;
+	struct gt_timer_data *frame_data = NULL;
 	struct arch_timer *t;
 	void __iomem *base;
 	irq_handler_t func;
@@ -678,8 +679,17 @@ static int __init arch_timer_mem_register(struct device_node *np, void *frame)
 		else
 			irq = irq_of_parse_and_map(frame_node, PHYS_SPI);
 	} else {
-		pr_err("Device node is missing.\n");
-		return -EINVAL;
+		frame_data = (struct gt_timer_data *)frame;
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTBaseN frames of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 ? 0xFFF).
+		 */
+		base = ioremap(frame_data->cntbase_phy, SZ_4K);
+		if (arch_timer_mem_use_virtual)
+			irq = frame_data->virtual_irq;
+		else
+			irq = frame_data->irq;
 	}
 
 	if (!base) {
@@ -840,13 +850,16 @@ static int __init arch_timer_of_init(struct device_node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static int __init get_cnttidr(struct device_node *np, u32 *cnttidr)
+static int __init get_cnttidr(struct device_node *np,
+			      struct gt_block_data *gt_block, u32 *cnttidr)
 {
 	if (!cnttidr)
 		return -EINVAL;
 
 	if (np)
 		cntctlbase = of_iomap(np, 0);
+	else if (gt_block)
+		cntctlbase = ioremap(gt_block->cntctlbase_phy, SZ_4K);
 	else
 		return -EINVAL;
 
@@ -885,7 +898,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 
 	arch_timers_present |= ARCH_MEM_TIMER;
 
-	ret = get_cnttidr(np, &cnttidr);
+	ret = get_cnttidr(np, NULL, &cnttidr);
 	if (ret)
 		return ret;
 
@@ -921,7 +934,72 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static struct gt_timer_data __init *arch_timer_mem_get_timer(
+						struct gt_block_data *gt_blocks)
+{
+	struct gt_block_data *gt_block = gt_blocks;
+	struct gt_timer_data *best_frame = NULL;
+	u32 cnttidr;
+	int i;
+
+	if (get_cnttidr(NULL, gt_block, &cnttidr))
+		return NULL;
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (i = 0; i < gt_block->timer_count; i++) {
+		if (is_best_frame(cnttidr, gt_block->timer[i].frame_nr)) {
+			best_frame = &gt_block->timer[i];
+			if (arch_timer_mem_use_virtual)
+				break;
+		}
+	}
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static int __init arch_timer_mem_acpi_init(size_t timer_count)
+{
+	struct gt_block_data *gt_blocks;
+	struct gt_timer_data *gt_timer;
+	int ret = -EINVAL;
+
+	/*
+	 * If we don't have any Platform Timer Structures, just return.
+	 */
+	if (!timer_count)
+		return 0;
+
+	/*
+	 * before really check all the Platform Timer Structures,
+	 * we assume they are GT block, and allocate memory for them.
+	 * We will free these memory once we finish the initialization.
+	 */
+	gt_blocks = kcalloc(timer_count, sizeof(*gt_blocks), GFP_KERNEL);
+	if (!gt_blocks)
+		return -ENOMEM;
+
+	if (gtdt_arch_timer_mem_init(gt_blocks) > 0) {
+		gt_timer = arch_timer_mem_get_timer(gt_blocks);
+		if (!gt_timer) {
+			pr_err("Failed to get mem timer info.\n");
+			goto error;
+		}
+		ret = arch_timer_mem_register(NULL, gt_timer);
+		if (ret) {
+			pr_err("Failed to register mem timer.\n");
+			goto error;
+		}
+	}
+	arch_timers_present |= ARCH_MEM_TIMER;
+error:
+	kfree(gt_blocks);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int timer_count;
@@ -945,8 +1023,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
 
-	if (timer_count < 0)
-		pr_err("Failed to get platform timer info.\n");
+	if (timer_count < 0 || arch_timer_mem_acpi_init((size_t)timer_count))
+		pr_err("Failed to initialize memory-mapped timer.\n");
 
 	return arch_timer_init();
 }
-- 
2.7.4
