From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:25:38 +0530
Subject: [PATCH 2/6] mailbox: bcm-flexrm-mailbox: Add debugfs support
In-Reply-To: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
References: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1500458142-19243-3-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds debugfs support to Broadcom FlexRM driver
so that we can see FlexRM ring state when any issue happens.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 136 ++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index e8c3666..a0be2ea 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -17,6 +17,8 @@
 
 #include <asm/barrier.h>
 #include <asm/byteorder.h>
+#include <linux/atomic.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -270,6 +272,9 @@ struct flexrm_ring {
 	u32 bd_write_offset;
 	void *cmpl_base;
 	dma_addr_t cmpl_dma_base;
+	/* Atomic stats */
+	atomic_t msg_send_count;
+	atomic_t msg_cmpl_count;
 	/* Protected members */
 	spinlock_t lock;
 	struct brcm_message *last_pending_msg;
@@ -283,6 +288,9 @@ struct flexrm_mbox {
 	struct flexrm_ring *rings;
 	struct dma_pool *bd_pool;
 	struct dma_pool *cmpl_pool;
+	struct dentry *root;
+	struct dentry *config;
+	struct dentry *stats;
 	struct mbox_controller controller;
 };
 
@@ -913,6 +921,62 @@ static void *flexrm_write_descs(struct brcm_message *msg, u32 nhcnt,
 
 /* ====== FlexRM driver helper routines ===== */
 
+static void flexrm_write_config_in_seqfile(struct flexrm_mbox *mbox,
+					   struct seq_file *file)
+{
+	int i;
+	const char *state;
+	struct flexrm_ring *ring;
+
+	seq_printf(file, "%-5s %-9s %-18s %-10s %-18s %-10s\n",
+		   "Ring#", "State", "BD_Addr", "BD_Size",
+		   "Cmpl_Addr", "Cmpl_Size");
+
+	for (i = 0; i < mbox->num_rings; i++) {
+		ring = &mbox->rings[i];
+		if (readl(ring->regs + RING_CONTROL) &
+		    BIT(CONTROL_ACTIVE_SHIFT))
+			state = "active";
+		else
+			state = "inactive";
+		seq_printf(file,
+			   "%-5d %-9s 0x%016llx 0x%08x 0x%016llx 0x%08x\n",
+			   ring->num, state,
+			   (unsigned long long)ring->bd_dma_base,
+			   (u32)RING_BD_SIZE,
+			   (unsigned long long)ring->cmpl_dma_base,
+			   (u32)RING_CMPL_SIZE);
+	}
+}
+
+static void flexrm_write_stats_in_seqfile(struct flexrm_mbox *mbox,
+					  struct seq_file *file)
+{
+	int i;
+	u32 val, bd_read_offset;
+	struct flexrm_ring *ring;
+
+	seq_printf(file, "%-5s %-10s %-10s %-10s %-11s %-11s\n",
+		   "Ring#", "BD_Read", "BD_Write",
+		   "Cmpl_Read", "Submitted", "Completed");
+
+	for (i = 0; i < mbox->num_rings; i++) {
+		ring = &mbox->rings[i];
+		bd_read_offset = readl_relaxed(ring->regs + RING_BD_READ_PTR);
+		val = readl_relaxed(ring->regs + RING_BD_START_ADDR);
+		bd_read_offset *= RING_DESC_SIZE;
+		bd_read_offset += (u32)(BD_START_ADDR_DECODE(val) -
+					ring->bd_dma_base);
+		seq_printf(file, "%-5d 0x%08x 0x%08x 0x%08x %-11d %-11d\n",
+			   ring->num,
+			   (u32)bd_read_offset,
+			   (u32)ring->bd_write_offset,
+			   (u32)ring->cmpl_read_offset,
+			   (u32)atomic_read(&ring->msg_send_count),
+			   (u32)atomic_read(&ring->msg_cmpl_count));
+	}
+}
+
 static int flexrm_new_request(struct flexrm_ring *ring,
 				struct brcm_message *batch_msg,
 				struct brcm_message *msg)
@@ -1013,6 +1077,9 @@ static int flexrm_new_request(struct flexrm_ring *ring,
 	/* Save ring BD write offset */
 	ring->bd_write_offset = (unsigned long)(next - ring->bd_base);
 
+	/* Increment number of messages sent */
+	atomic_inc_return(&ring->msg_send_count);
+
 exit:
 	/* Update error status in message */
 	msg->error = ret;
@@ -1106,12 +1173,37 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 		mbox_chan_received_data(chan, msg);
 
 		/* Increment number of completions processed */
+		atomic_inc_return(&ring->msg_cmpl_count);
 		count++;
 	}
 
 	return count;
 }
 
+/* ====== FlexRM Debugfs callbacks ====== */
+
+static int flexrm_debugfs_conf_show(struct seq_file *file, void *offset)
+{
+	struct platform_device *pdev = to_platform_device(file->private);
+	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+
+	/* Write config in file */
+	flexrm_write_config_in_seqfile(mbox, file);
+
+	return 0;
+}
+
+static int flexrm_debugfs_stats_show(struct seq_file *file, void *offset)
+{
+	struct platform_device *pdev = to_platform_device(file->private);
+	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+
+	/* Write stats in file */
+	flexrm_write_stats_in_seqfile(mbox, file);
+
+	return 0;
+}
+
 /* ====== FlexRM interrupt handler ===== */
 
 static irqreturn_t flexrm_irq_event(int irq, void *dev_id)
@@ -1272,6 +1364,10 @@ static int flexrm_startup(struct mbox_chan *chan)
 	val = BIT(CONTROL_ACTIVE_SHIFT);
 	writel_relaxed(val, ring->regs + RING_CONTROL);
 
+	/* Reset stats to zero */
+	atomic_set(&ring->msg_send_count, 0);
+	atomic_set(&ring->msg_cmpl_count, 0);
+
 	return 0;
 
 fail_free_irq:
@@ -1491,6 +1587,8 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		ring->bd_dma_base = 0;
 		ring->cmpl_base = NULL;
 		ring->cmpl_dma_base = 0;
+		atomic_set(&ring->msg_send_count, 0);
+		atomic_set(&ring->msg_cmpl_count, 0);
 		spin_lock_init(&ring->lock);
 		ring->last_pending_msg = NULL;
 		ring->cmpl_read_offset = 0;
@@ -1532,6 +1630,36 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		ring->irq = desc->irq;
 	}
 
+	/* Check availability of debugfs */
+	if (!debugfs_initialized())
+		goto skip_debugfs;
+
+	/* Create debugfs root entry */
+	mbox->root = debugfs_create_dir(dev_name(mbox->dev), NULL);
+	if (IS_ERR_OR_NULL(mbox->root)) {
+		ret = PTR_ERR_OR_ZERO(mbox->root);
+		goto fail_free_msis;
+	}
+
+	/* Create debugfs config entry */
+	mbox->config = debugfs_create_devm_seqfile(mbox->dev,
+						   "config", mbox->root,
+						   flexrm_debugfs_conf_show);
+	if (IS_ERR_OR_NULL(mbox->config)) {
+		ret = PTR_ERR_OR_ZERO(mbox->config);
+		goto fail_free_debugfs_root;
+	}
+
+	/* Create debugfs stats entry */
+	mbox->stats = debugfs_create_devm_seqfile(mbox->dev,
+						  "stats", mbox->root,
+						  flexrm_debugfs_stats_show);
+	if (IS_ERR_OR_NULL(mbox->stats)) {
+		ret = PTR_ERR_OR_ZERO(mbox->stats);
+		goto fail_free_debugfs_root;
+	}
+skip_debugfs:
+
 	/* Initialize mailbox controller */
 	mbox->controller.txdone_irq = false;
 	mbox->controller.txdone_poll = true;
@@ -1544,7 +1672,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 				sizeof(*mbox->controller.chans), GFP_KERNEL);
 	if (!mbox->controller.chans) {
 		ret = -ENOMEM;
-		goto fail_free_msis;
+		goto fail_free_debugfs_root;
 	}
 	for (index = 0; index < mbox->num_rings; index++)
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
@@ -1552,13 +1680,15 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	/* Register mailbox controller */
 	ret = mbox_controller_register(&mbox->controller);
 	if (ret)
-		goto fail_free_msis;
+		goto fail_free_debugfs_root;
 
 	dev_info(dev, "registered flexrm mailbox with %d channels\n",
 			mbox->controller.num_chans);
 
 	return 0;
 
+fail_free_debugfs_root:
+	debugfs_remove_recursive(mbox->root);
 fail_free_msis:
 	platform_msi_domain_free_irqs(dev);
 fail_destroy_cmpl_pool:
@@ -1578,6 +1708,8 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 
 	mbox_controller_unregister(&mbox->controller);
 
+	debugfs_remove_recursive(mbox->root);
+
 	platform_msi_domain_free_irqs(dev);
 
 	dma_pool_destroy(mbox->cmpl_pool);
-- 
2.7.4
