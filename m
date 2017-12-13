From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:53 -0500
Subject: [PATCH V8 7/7] dmaengine: qcom_hidma: Add identity register support
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513149653-19451-8-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The location for destination event channel register has been relocated from
offset 0x28 to 0x40. Update the code accordingly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index c146c6d..963cc52 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -107,6 +107,7 @@ static void hidma_free(struct hidma_dev *dmadev)
 
 enum hidma_cap {
 	HIDMA_MSI_CAP = 1,
+	HIDMA_IDENTITY_CAP,
 };
 
 /* process completed descriptors */
@@ -838,7 +839,10 @@ static int hidma_probe(struct platform_device *pdev)
 	if (!dmadev->nr_descriptors)
 		dmadev->nr_descriptors = HIDMA_NR_DEFAULT_DESC;
 
-	dmadev->chidx = readl(dmadev->dev_trca + 0x28);
+	if (hidma_test_capability(&pdev->dev, HIDMA_IDENTITY_CAP))
+		dmadev->chidx = readl(dmadev->dev_trca + 0x40);
+	else
+		dmadev->chidx = readl(dmadev->dev_trca + 0x28);
 
 	/* Set DMA mask to 64 bits. */
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -944,7 +948,7 @@ static int hidma_remove(struct platform_device *pdev)
 static const struct acpi_device_id hidma_acpi_ids[] = {
 	{"QCOM8061"},
 	{"QCOM8062", HIDMA_MSI_CAP},
-	{"QCOM8063", HIDMA_MSI_CAP},
+	{"QCOM8063", (HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP)},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
@@ -953,7 +957,8 @@ static int hidma_remove(struct platform_device *pdev)
 static const struct of_device_id hidma_match[] = {
 	{.compatible = "qcom,hidma-1.0",},
 	{.compatible = "qcom,hidma-1.1", .data = (void *)(HIDMA_MSI_CAP),},
-	{.compatible = "qcom,hidma-1.2", .data = (void *)(HIDMA_MSI_CAP),},
+	{.compatible = "qcom,hidma-1.2",
+	 .data = (void *)(HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP),},
 	{},
 };
 MODULE_DEVICE_TABLE(of, hidma_match);
-- 
1.9.1
