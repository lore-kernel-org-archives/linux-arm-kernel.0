From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed,  8 Nov 2017 11:29:42 -0500
Subject: [PATCH V2 3/3] dmaengine: qcom_hidma: add identity register support
In-Reply-To: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1510158582-5343-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The location for destination event channel register has been relocated from
offset 0x28 to 0x40. Update the code accordingly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 4ef7d6f..e8b7be0 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -126,6 +126,18 @@ struct hidma_cap {
 	}
 };
 
+static struct hidma_cap hidma_identity_cap = {
+	.of = {
+		{.compatible = "qcom,hidma-1.2",},
+		{},
+	},
+
+	.acpi = {
+		{"QCOM8063"},
+		{},
+	}
+};
+
 /* process completed descriptors */
 static void hidma_process_completed(struct hidma_chan *mchan)
 {
@@ -772,6 +784,22 @@ static bool hidma_msi_capable(struct device *dev)
 	return ret;
 }
 
+static bool hidma_identity_capable(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	int ret;
+
+	if (!adev || acpi_disabled)
+		ret = of_match_device(hidma_identity_cap.of, dev) != NULL;
+	else {
+#ifdef CONFIG_ACPI
+		ret = acpi_match_device(hidma_identity_cap.acpi, dev) != NULL;
+#endif
+	}
+
+	return ret;
+}
+
 static int hidma_probe(struct platform_device *pdev)
 {
 	struct hidma_dev *dmadev;
@@ -863,7 +891,10 @@ static int hidma_probe(struct platform_device *pdev)
 	if (!dmadev->nr_descriptors)
 		dmadev->nr_descriptors = HIDMA_NR_DEFAULT_DESC;
 
-	dmadev->chidx = readl(dmadev->dev_trca + 0x28);
+	if (hidma_identity_capable(&pdev->dev))
+		dmadev->chidx = readl(dmadev->dev_trca + 0x40);
+	else
+		dmadev->chidx = readl(dmadev->dev_trca + 0x28);
 
 	/* Set DMA mask to 64 bits. */
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-- 
1.9.1
