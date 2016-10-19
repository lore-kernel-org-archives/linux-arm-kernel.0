From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 19 Oct 2016 14:42:46 -0400
Subject: [PATCH V2] dmaengine: qcom_hidma: cleanup sysfs entries during remove
Message-ID: <1476902566-26676-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 4.8-rc8 kernel is printing duplicate file entry warnings while removing
the HIDMA object. This is caused by stale sysfs entries remaining from the
previous execution.

_sysfs_warn_dup+0x5c/0x78
 sysfs_add_file_mode_ns+0x13c/0x1c0
 sysfs_create_file_ns+0x2c/0x40
 device_create_file+0x54/0xa0
 hidma_probe+0x7c8/0x808

Create hidma_sysfs_init and hidma_sysfs_uninit functions and call them from
the probe and remove path. To do proper clean up, adding the attrs object
to the device data structure to keep it around until remove call is made.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 27 +++++++++++++++++++++------
 drivers/dma/qcom/hidma.h |  3 +++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index e244e10..4adf249 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -567,8 +567,13 @@ static ssize_t hidma_show_values(struct device *dev,
 	return strlen(buf);
 }
 
-static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
-				    int mode)
+static inline void  hidma_sysfs_uninit(struct hidma_dev *dev)
+{
+	device_remove_file(dev->ddev.dev, dev->chid_attrs);
+}
+
+static struct device_attribute*
+hidma_create_sysfs_entry(struct hidma_dev *dev, char *name, int mode)
 {
 	struct device_attribute *attrs;
 	char *name_copy;
@@ -576,18 +581,27 @@ static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
 	attrs = devm_kmalloc(dev->ddev.dev, sizeof(struct device_attribute),
 			     GFP_KERNEL);
 	if (!attrs)
-		return -ENOMEM;
+		return NULL;
 
 	name_copy = devm_kstrdup(dev->ddev.dev, name, GFP_KERNEL);
 	if (!name_copy)
-		return -ENOMEM;
+		return NULL;
 
 	attrs->attr.name = name_copy;
 	attrs->attr.mode = mode;
 	attrs->show = hidma_show_values;
 	sysfs_attr_init(&attrs->attr);
 
-	return device_create_file(dev->ddev.dev, attrs);
+	return attrs;
+}
+
+static int hidma_sysfs_init(struct hidma_dev *dev)
+{
+	dev->chid_attrs = hidma_create_sysfs_entry(dev, "chid", S_IRUGO);
+	if (!dev->chid_attrs)
+		return -ENOMEM;
+
+	return device_create_file(dev->ddev.dev, dev->chid_attrs);
 }
 
 static int hidma_probe(struct platform_device *pdev)
@@ -705,7 +719,7 @@ static int hidma_probe(struct platform_device *pdev)
 	dmadev->irq = chirq;
 	tasklet_init(&dmadev->task, hidma_issue_task, (unsigned long)dmadev);
 	hidma_debug_init(dmadev);
-	hidma_create_sysfs_entry(dmadev, "chid", S_IRUGO);
+	hidma_sysfs_init(dmadev);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
 	platform_set_drvdata(pdev, dmadev);
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
@@ -732,6 +746,7 @@ static int hidma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&dmadev->ddev);
 	devm_free_irq(dmadev->ddev.dev, dmadev->irq, dmadev->lldev);
 	tasklet_kill(&dmadev->task);
+	hidma_sysfs_uninit(dmadev);
 	hidma_debug_uninit(dmadev);
 	hidma_ll_uninit(dmadev->lldev);
 	hidma_free(dmadev);
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index e52e207..b4a512f 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -128,6 +128,9 @@ struct hidma_dev {
 	struct dentry			*debugfs;
 	struct dentry			*stats;
 
+	/* sysfs entry for the channel id */
+	struct device_attribute		*chid_attrs;
+
 	/* Task delivering issue_pending */
 	struct tasklet_struct		task;
 };
-- 
1.9.1
