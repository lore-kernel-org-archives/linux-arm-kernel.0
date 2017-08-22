From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:27:04 +0530
Subject: [PATCH v3 15/17] dmaengine: bcm-sba-raid: Add debugfs support
In-Reply-To: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
References: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1503395827-19428-16-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds debugfs support to report stats via debugfs
which in-turn will help debug hang or error situations.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/dma/bcm-sba-raid.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index f0a0e80..12310aa 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -36,6 +36,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/list.h>
@@ -162,6 +163,9 @@ struct sba_device {
 	struct list_head reqs_completed_list;
 	struct list_head reqs_aborted_list;
 	struct list_head reqs_free_list;
+	/* DebugFS directory entries */
+	struct dentry *root;
+	struct dentry *stats;
 };
 
 /* ====== Command helper routines ===== */
@@ -486,6 +490,45 @@ static void sba_process_received_request(struct sba_device *sba,
 	}
 }
 
+static void sba_write_stats_in_seqfile(struct sba_device *sba,
+				       struct seq_file *file)
+{
+	unsigned long flags;
+	struct sba_request *req;
+	u32 free_count = 0, alloced_count = 0, pending_count = 0;
+	u32 active_count = 0, aborted_count = 0, completed_count = 0;
+
+	spin_lock_irqsave(&sba->reqs_lock, flags);
+
+	list_for_each_entry(req, &sba->reqs_free_list, node)
+		free_count++;
+
+	list_for_each_entry(req, &sba->reqs_alloc_list, node)
+		alloced_count++;
+
+	list_for_each_entry(req, &sba->reqs_pending_list, node)
+		pending_count++;
+
+	list_for_each_entry(req, &sba->reqs_active_list, node)
+		active_count++;
+
+	list_for_each_entry(req, &sba->reqs_aborted_list, node)
+		aborted_count++;
+
+	list_for_each_entry(req, &sba->reqs_completed_list, node)
+		completed_count++;
+
+	spin_unlock_irqrestore(&sba->reqs_lock, flags);
+
+	seq_printf(file, "maximum requests   = %d\n", sba->max_req);
+	seq_printf(file, "free requests      = %d\n", free_count);
+	seq_printf(file, "alloced requests   = %d\n", alloced_count);
+	seq_printf(file, "pending requests   = %d\n", pending_count);
+	seq_printf(file, "active requests    = %d\n", active_count);
+	seq_printf(file, "aborted requests   = %d\n", aborted_count);
+	seq_printf(file, "completed requests = %d\n", completed_count);
+}
+
 /* ====== DMAENGINE callbacks ===== */
 
 static void sba_free_chan_resources(struct dma_chan *dchan)
@@ -1451,6 +1494,19 @@ static void sba_receive_message(struct mbox_client *cl, void *msg)
 	sba_process_received_request(sba, req);
 }
 
+/* ====== Debugfs callbacks ====== */
+
+static int sba_debugfs_stats_show(struct seq_file *file, void *offset)
+{
+	struct platform_device *pdev = to_platform_device(file->private);
+	struct sba_device *sba = platform_get_drvdata(pdev);
+
+	/* Write stats in file */
+	sba_write_stats_in_seqfile(sba, file);
+
+	return 0;
+}
+
 /* ====== Platform driver routines ===== */
 
 static int sba_prealloc_channel_resources(struct sba_device *sba)
@@ -1721,6 +1777,25 @@ static int sba_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_free_mchans;
 
+	/* Check availability of debugfs */
+	if (!debugfs_initialized())
+		goto skip_debugfs;
+
+	/* Create debugfs root entry */
+	sba->root = debugfs_create_dir(dev_name(sba->dev), NULL);
+	if (IS_ERR_OR_NULL(sba->root)) {
+		dev_err(sba->dev, "failed to create debugfs root entry\n");
+		sba->root = NULL;
+		goto skip_debugfs;
+	}
+
+	/* Create debugfs stats entry */
+	sba->stats = debugfs_create_devm_seqfile(sba->dev, "stats", sba->root,
+						 sba_debugfs_stats_show);
+	if (IS_ERR_OR_NULL(sba->stats))
+		dev_err(sba->dev, "failed to create debugfs stats file\n");
+skip_debugfs:
+
 	/* Register DMA device with Linux async framework */
 	ret = sba_async_register(sba);
 	if (ret)
@@ -1734,6 +1809,7 @@ static int sba_probe(struct platform_device *pdev)
 	return 0;
 
 fail_free_resources:
+	debugfs_remove_recursive(sba->root);
 	sba_freeup_channel_resources(sba);
 fail_free_mchans:
 	for (i = 0; i < sba->mchans_count; i++)
@@ -1748,6 +1824,8 @@ static int sba_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(&sba->dma_dev);
 
+	debugfs_remove_recursive(sba->root);
+
 	sba_freeup_channel_resources(sba);
 
 	for (i = 0; i < sba->mchans_count; i++)
-- 
2.7.4
