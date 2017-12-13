From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:52 -0500
Subject: [PATCH V8 6/7] dmaengine: qcom_hidma: Add support for the new revision
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513149653-19451-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for probing the newer HW and also organize MSI capable hardware
into an array for maintenance reasons.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index e366985..c146c6d 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -50,6 +50,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
@@ -104,6 +105,9 @@ static void hidma_free(struct hidma_dev *dmadev)
 module_param(nr_desc_prm, uint, 0644);
 MODULE_PARM_DESC(nr_desc_prm, "number of descriptors (default: 0)");
 
+enum hidma_cap {
+	HIDMA_MSI_CAP = 1,
+};
 
 /* process completed descriptors */
 static void hidma_process_completed(struct hidma_chan *mchan)
@@ -736,25 +740,12 @@ static int hidma_request_msi(struct hidma_dev *dmadev,
 #endif
 }
 
-static bool hidma_msi_capable(struct device *dev)
+static bool hidma_test_capability(struct device *dev, enum hidma_cap test_cap)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	const char *of_compat;
-	int ret = -EINVAL;
-
-	if (!adev || acpi_disabled) {
-		ret = device_property_read_string(dev, "compatible",
-						  &of_compat);
-		if (ret)
-			return false;
+	enum hidma_cap cap;
 
-		ret = strcmp(of_compat, "qcom,hidma-1.1");
-	} else {
-#ifdef CONFIG_ACPI
-		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
-#endif
-	}
-	return ret == 0;
+	cap = (enum hidma_cap) device_get_match_data(dev);
+	return cap ? ((cap & test_cap) > 0) : 0;
 }
 
 static int hidma_probe(struct platform_device *pdev)
@@ -834,8 +825,7 @@ static int hidma_probe(struct platform_device *pdev)
 	 * Determine the MSI capability of the platform. Old HW doesn't
 	 * support MSI.
 	 */
-	msi = hidma_msi_capable(&pdev->dev);
-
+	msi = hidma_test_capability(&pdev->dev, HIDMA_MSI_CAP);
 	device_property_read_u32(&pdev->dev, "desc-count",
 				 &dmadev->nr_descriptors);
 
@@ -953,7 +943,8 @@ static int hidma_remove(struct platform_device *pdev)
 #if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id hidma_acpi_ids[] = {
 	{"QCOM8061"},
-	{"QCOM8062"},
+	{"QCOM8062", HIDMA_MSI_CAP},
+	{"QCOM8063", HIDMA_MSI_CAP},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
@@ -961,7 +952,8 @@ static int hidma_remove(struct platform_device *pdev)
 
 static const struct of_device_id hidma_match[] = {
 	{.compatible = "qcom,hidma-1.0",},
-	{.compatible = "qcom,hidma-1.1",},
+	{.compatible = "qcom,hidma-1.1", .data = (void *)(HIDMA_MSI_CAP),},
+	{.compatible = "qcom,hidma-1.2", .data = (void *)(HIDMA_MSI_CAP),},
 	{},
 };
 MODULE_DEVICE_TABLE(of, hidma_match);
-- 
1.9.1
