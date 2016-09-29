From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:47 -0400
Subject: [PATCH V4 10/10] dmaengine: qcom_hidma: add MSI support for interrupts
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-11-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupts can now be delivered as platform MSI interrupts
on newer platforms. The code looks for a new OF and ACPI strings
in order to enable the functionality.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c    | 129 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/dma/qcom/hidma.h    |   2 +
 drivers/dma/qcom/hidma_ll.c |   8 +++
 3 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index e244e10..f4fe4ee 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -56,6 +56,7 @@
 #include <linux/irq.h>
 #include <linux/atomic.h>
 #include <linux/pm_runtime.h>
+#include <linux/msi.h>
 
 #include "../dmaengine.h"
 #include "hidma.h"
@@ -70,6 +71,7 @@
 #define HIDMA_ERR_INFO_SW			0xFF
 #define HIDMA_ERR_CODE_UNEXPECTED_TERMINATE	0x0
 #define HIDMA_NR_DEFAULT_DESC			10
+#define HIDMA_MSI_INTS				11
 
 static inline struct hidma_dev *to_hidma_dev(struct dma_device *dmadev)
 {
@@ -553,6 +555,15 @@ static irqreturn_t hidma_chirq_handler(int chirq, void *arg)
 	return hidma_ll_inthandler(chirq, lldev);
 }
 
+static irqreturn_t hidma_chirq_handler_msi(int chirq, void *arg)
+{
+	struct hidma_lldev **lldevp = arg;
+	struct hidma_dev *dmadev = to_hidma_dev_from_lldev(lldevp);
+
+	return hidma_ll_inthandler_msi(chirq, *lldevp,
+				       1 << (chirq - dmadev->msi_virqbase));
+}
+
 static ssize_t hidma_show_values(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -590,6 +601,99 @@ static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
 	return device_create_file(dev->ddev.dev, attrs);
 }
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static void hidma_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct hidma_dev *dmadev = dev_get_drvdata(dev);
+
+	if (!desc->platform.msi_index) {
+		writel(msg->address_lo, dmadev->dev_evca + 0x118);
+		writel(msg->address_hi, dmadev->dev_evca + 0x11C);
+		writel(msg->data, dmadev->dev_evca + 0x120);
+	}
+}
+
+static void hidma_free_msis(void *data)
+{
+	struct device *dev = data;
+
+	platform_msi_domain_free_irqs(dev);
+}
+#endif
+
+static int hidma_request_msi(struct hidma_dev *dmadev,
+			     struct platform_device *pdev)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	int rc;
+	struct msi_desc *desc;
+	struct msi_desc *failed_desc = NULL;
+
+	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
+					    hidma_write_msi_msg);
+	if (rc)
+		return rc;
+
+	for_each_msi_entry(desc, &pdev->dev) {
+		if (!desc->platform.msi_index)
+			dmadev->msi_virqbase = desc->irq;
+
+		rc = devm_request_irq(&pdev->dev, desc->irq,
+				       hidma_chirq_handler_msi,
+				       0, "qcom-hidma-msi",
+				       &dmadev->lldev);
+		if (rc) {
+			failed_desc = desc;
+			break;
+		}
+	}
+
+	if (rc) {
+		/* free allocated MSI interrupts above */
+		for_each_msi_entry(desc, &pdev->dev) {
+			if (desc == failed_desc)
+				break;
+			devm_free_irq(&pdev->dev, desc->irq,
+				      &dmadev->lldev);
+		}
+	} else {
+		/* Add callback to free MSIs on teardown */
+		devm_add_action(&pdev->dev, hidma_free_msis,
+				&pdev->dev);
+		hidma_ll_setup_irq(dmadev->lldev, true);
+
+	}
+	if (rc)
+		dev_warn(&pdev->dev,
+			 "failed to request MSI irq, falling back to wired IRQ\n");
+	return rc;
+#else
+	return -EINVAL;
+#endif
+}
+
+static bool hidma_msi_capable(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	const char *of_compat;
+	int ret = -EINVAL;
+
+	if (!adev || acpi_disabled) {
+		ret = device_property_read_string(dev, "compatible",
+						  &of_compat);
+		if (ret)
+			return false;
+
+		ret = strcmp(of_compat, "qcom,hidma-1.1");
+	} else {
+#ifdef CONFIG_ACPI
+		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
+#endif
+	}
+	return ret == 0;
+}
+
 static int hidma_probe(struct platform_device *pdev)
 {
 	struct hidma_dev *dmadev;
@@ -599,6 +703,7 @@ static int hidma_probe(struct platform_device *pdev)
 	void __iomem *evca;
 	void __iomem *trca;
 	int rc;
+	bool msi;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, HIDMA_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -660,6 +765,12 @@ static int hidma_probe(struct platform_device *pdev)
 	dmadev->ddev.device_terminate_all = hidma_terminate_all;
 	dmadev->ddev.copy_align = 8;
 
+	/*
+	 * Determine the MSI capability of the platform. Old HW doesn't
+	 * support MSI.
+	 */
+	msi = hidma_msi_capable(&pdev->dev);
+
 	device_property_read_u32(&pdev->dev, "desc-count",
 				 &dmadev->nr_descriptors);
 
@@ -688,10 +799,17 @@ static int hidma_probe(struct platform_device *pdev)
 		goto dmafree;
 	}
 
-	rc = devm_request_irq(&pdev->dev, chirq, hidma_chirq_handler, 0,
-			      "qcom-hidma", dmadev->lldev);
-	if (rc)
-		goto uninit;
+	platform_set_drvdata(pdev, dmadev);
+	if (msi)
+		rc = hidma_request_msi(dmadev, pdev);
+
+	if (!msi || rc) {
+		hidma_ll_setup_irq(dmadev->lldev, false);
+		rc = devm_request_irq(&pdev->dev, chirq, hidma_chirq_handler,
+				      0, "qcom-hidma", dmadev->lldev);
+		if (rc)
+			goto uninit;
+	}
 
 	INIT_LIST_HEAD(&dmadev->ddev.channels);
 	rc = hidma_chan_init(dmadev, 0);
@@ -707,7 +825,6 @@ static int hidma_probe(struct platform_device *pdev)
 	hidma_debug_init(dmadev);
 	hidma_create_sysfs_entry(dmadev, "chid", S_IRUGO);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
-	platform_set_drvdata(pdev, dmadev);
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return 0;
@@ -746,12 +863,14 @@ static int hidma_remove(struct platform_device *pdev)
 #if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id hidma_acpi_ids[] = {
 	{"QCOM8061"},
+	{"QCOM8062"},
 	{},
 };
 #endif
 
 static const struct of_device_id hidma_match[] = {
 	{.compatible = "qcom,hidma-1.0",},
+	{.compatible = "qcom,hidma-1.1",},
 	{},
 };
 MODULE_DEVICE_TABLE(of, hidma_match);
diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index 181f7e0..05f8ba4 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -115,6 +115,7 @@ struct hidma_dev {
 	int				irq;
 	int				chidx;
 	u32				nr_descriptors;
+	int				msi_virqbase;
 
 	struct hidma_lldev		*lldev;
 	void				__iomem *dev_trca;
@@ -153,6 +154,7 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 max_channels,
 			u8 chidx);
 int hidma_ll_uninit(struct hidma_lldev *llhndl);
 irqreturn_t hidma_ll_inthandler(int irq, void *arg);
+irqreturn_t hidma_ll_inthandler_msi(int irq, void *arg, int cause);
 void hidma_cleanup_pending_tre(struct hidma_lldev *llhndl, u8 err_info,
 				u8 err_code);
 int hidma_debug_init(struct hidma_dev *dmadev);
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 386a64c..5518d82 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -424,6 +424,14 @@ irqreturn_t hidma_ll_inthandler(int chirq, void *arg)
 	return IRQ_HANDLED;
 }
 
+irqreturn_t hidma_ll_inthandler_msi(int chirq, void *arg, int cause)
+{
+	struct hidma_lldev *lldev = arg;
+
+	hidma_ll_int_handler_internal(lldev, cause);
+	return IRQ_HANDLED;
+}
+
 int hidma_ll_enable(struct hidma_lldev *lldev)
 {
 	u32 val;
-- 
1.9.1
