From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  6 Nov 2017 12:26:19 -0500
Subject: [PATCH 3/3] dmaengine: qcom_hidma: add identity register support
In-Reply-To: <1509989180-22617-1-git-send-email-okaya@codeaurora.org>
References: <1509989180-22617-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1509989180-22617-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The location for destination event channel register has been relocated from
offset 0x28 to 0x40. Update the code accordingly.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 29d6aaa..50640c9 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -761,6 +761,27 @@ static bool hidma_msi_capable(struct device *dev)
 	return ret == 0;
 }
 
+static bool hidma_identity_capable(struct device *dev)
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
+		ret = strcmp(of_compat, "qcom,hidma-1.2");
+	} else {
+#ifdef CONFIG_ACPI
+		ret = strcmp(acpi_device_hid(adev), "QCOM8063");
+#endif
+	}
+	return ret == 0;
+}
+
 static int hidma_probe(struct platform_device *pdev)
 {
 	struct hidma_dev *dmadev;
@@ -852,7 +873,10 @@ static int hidma_probe(struct platform_device *pdev)
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
