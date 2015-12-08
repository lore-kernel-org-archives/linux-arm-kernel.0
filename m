From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:30:50 +0100
Subject: [PATCH] soc: TI knav_qmss: fix dma_addr_t printing
Message-ID: <2560281.KhcNzi0XgD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The knav_qmss driver is currently broken when CONFIG_LPAE is
set, which is a bit surprising because I'd expect that any serious
users of this platforms would have more than 2GB of RAM and require
LPAE.

The compiler clearly warns about an incorrect use of dma_addr_t
in the debug kernel messages:

ti/knav_qmss_queue.c: In function 'knav_queue_setup_region':
ti/knav_qmss_queue.c:1025:117: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
ti/knav_qmss_queue.c:1025:117: warning: format '%x' expects argument of type 'unsigned int', but argument 10 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
ti/knav_qmss_queue.c: In function 'knav_queue_setup_link_ram':
ti/knav_qmss_queue.c:1175:118: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]

This patch changes all the debugging output to use the correct
%pad format string that works with both 32-bit and 64-bit dma_addr_t.
As the variable naming is somewhat confusing here, I also change
all *_phys names to *_dma when they refer to bus addresses that
are used for DMA rather than a physical memory address as seen from
the CPU. This is particularly important on keystone, because the
two things are not the same there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/ti/knav_qmss.h       |  4 ++--
 drivers/soc/ti/knav_qmss_acc.c   | 14 +++++++-------
 drivers/soc/ti/knav_qmss_queue.c | 22 +++++++++++-----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index 6ff936cacb70..905b974d1bdc 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -93,13 +93,13 @@ struct knav_reg_pdsp_regs {
 struct knav_reg_acc_command {
 	u32		command;
 	u32		queue_mask;
-	u32		list_phys;
+	u32		list_dma;
 	u32		queue_num;
 	u32		timer_config;
 };
 
 struct knav_link_ram_block {
-	dma_addr_t	 phys;
+	dma_addr_t	 dma;
 	void		*virt;
 	size_t		 size;
 };
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index d2d48f2802bc..0612ebae0a09 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -122,8 +122,8 @@ static irqreturn_t knav_acc_int_handler(int irq, void *_instdata)
 	channel = acc->channel;
 	list_dma = acc->list_dma[acc->list_index];
 	list_cpu = acc->list_cpu[acc->list_index];
-	dev_dbg(kdev->dev, "acc-irq: channel %d, list %d, virt %p, phys %x\n",
-		channel, acc->list_index, list_cpu, list_dma);
+	dev_dbg(kdev->dev, "acc-irq: channel %d, list %d, virt %p, dma %pad\n",
+		channel, acc->list_index, list_cpu, &list_dma);
 	if (atomic_read(&acc->retrigger_count)) {
 		atomic_dec(&acc->retrigger_count);
 		__knav_acc_notify(range, acc);
@@ -297,12 +297,12 @@ knav_acc_write(struct knav_device *kdev, struct knav_pdsp_info *pdsp,
 	u32 result;
 
 	dev_dbg(kdev->dev, "acc command %08x %08x %08x %08x %08x\n",
-		cmd->command, cmd->queue_mask, cmd->list_phys,
+		cmd->command, cmd->queue_mask, cmd->list_dma,
 		cmd->queue_num, cmd->timer_config);
 
 	writel_relaxed(cmd->timer_config, &pdsp->acc_command->timer_config);
 	writel_relaxed(cmd->queue_num, &pdsp->acc_command->queue_num);
-	writel_relaxed(cmd->list_phys, &pdsp->acc_command->list_phys);
+	writel_relaxed(cmd->list_dma, &pdsp->acc_command->list_dma);
 	writel_relaxed(cmd->queue_mask, &pdsp->acc_command->queue_mask);
 	writel_relaxed(cmd->command, &pdsp->acc_command->command);
 
@@ -337,7 +337,7 @@ static void knav_acc_setup_cmd(struct knav_device *kdev,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->command    = acc->channel;
 	cmd->queue_mask = queue_mask;
-	cmd->list_phys  = acc->list_dma[0];
+	cmd->list_dma   = (u32)acc->list_dma[0];
 	cmd->queue_num  = info->list_entries << 16;
 	cmd->queue_num |= queue_base;
 
@@ -591,8 +591,8 @@ int knav_init_acc_range(struct knav_device *kdev,
 		acc->list_cpu[1] = list_mem + list_size;
 		acc->list_dma[0] = list_dma;
 		acc->list_dma[1] = list_dma + list_size;
-		dev_dbg(kdev->dev, "%s: channel %d, phys %08x, virt %8p\n",
-			acc->name, acc->channel, list_dma, list_mem);
+		dev_dbg(kdev->dev, "%s: channel %d, dma %pad, virt %8p\n",
+			acc->name, acc->channel, &list_dma, list_mem);
 	}
 
 	range->ops = &knav_acc_range_ops;
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8c03a80b482d..b73e3534f67b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1023,9 +1023,9 @@ static void knav_queue_setup_region(struct knav_device *kdev,
 	list_add(&pool->region_inst, &region->pools);
 
 	dev_dbg(kdev->dev,
-		"region %s (%d): size:%d, link:%d@%d, phys:%08x-%08x, virt:%p-%p\n",
+		"region %s (%d): size:%d, link:%d@%d, dma:%pad-%pad, virt:%p-%p\n",
 		region->name, id, region->desc_size, region->num_desc,
-		region->link_index, region->dma_start, region->dma_end,
+		region->link_index, &region->dma_start, &region->dma_end,
 		region->virt_start, region->virt_end);
 
 	hw_desc_size = (region->desc_size / 16) - 1;
@@ -1033,7 +1033,7 @@ static void knav_queue_setup_region(struct knav_device *kdev,
 
 	for_each_qmgr(kdev, qmgr) {
 		regs = qmgr->reg_region + id;
-		writel_relaxed(region->dma_start, &regs->base);
+		writel_relaxed((u32)region->dma_start, &regs->base);
 		writel_relaxed(region->link_index, &regs->start_index);
 		writel_relaxed(hw_desc_size << 16 | hw_num_desc,
 			       &regs->size_count);
@@ -1145,14 +1145,14 @@ static int knav_get_link_ram(struct knav_device *kdev,
 			 * queue_base specified => using internal or onchip
 			 * link ram WARNING - we do not "reserve" this block
 			 */
-			block->phys = (dma_addr_t)temp[0];
+			block->dma = (dma_addr_t)temp[0];
 			block->virt = NULL;
 			block->size = temp[1];
 		} else {
 			block->size = temp[1];
 			/* queue_base not specific => allocate requested size */
 			block->virt = dmam_alloc_coherent(kdev->dev,
-						  8 * block->size, &block->phys,
+						  8 * block->size, &block->dma,
 						  GFP_KERNEL);
 			if (!block->virt) {
 				dev_err(kdev->dev, "failed to alloc linkram\n");
@@ -1172,18 +1172,18 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
 
 	for_each_qmgr(kdev, qmgr) {
 		block = &kdev->link_rams[0];
-		dev_dbg(kdev->dev, "linkram0: phys:%x, virt:%p, size:%x\n",
-			block->phys, block->virt, block->size);
-		writel_relaxed(block->phys, &qmgr->reg_config->link_ram_base0);
+		dev_dbg(kdev->dev, "linkram0: dma:%pad, virt:%p, size:%x\n",
+			&block->dma, block->virt, block->size);
+		writel_relaxed((u32)block->dma, &qmgr->reg_config->link_ram_base0);
 		writel_relaxed(block->size, &qmgr->reg_config->link_ram_size0);
 
 		block++;
 		if (!block->size)
 			continue;
 
-		dev_dbg(kdev->dev, "linkram1: phys:%x, virt:%p, size:%x\n",
-			block->phys, block->virt, block->size);
-		writel_relaxed(block->phys, &qmgr->reg_config->link_ram_base1);
+		dev_dbg(kdev->dev, "linkram1: dma:%pad, virt:%p, size:%x\n",
+			&block->dma, block->virt, block->size);
+		writel_relaxed(block->dma, &qmgr->reg_config->link_ram_base1);
 	}
 
 	return 0;
-- 
2.1.0.rc2
