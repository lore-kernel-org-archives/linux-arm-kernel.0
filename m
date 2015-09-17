From: dhdang@apm.com (Duc Dang)
Date: Thu, 17 Sep 2015 11:19:46 -0700
Subject: [PATCH v8 1/3] usb: make xhci platform driver use 64 bit or 32 bit DMA
In-Reply-To: <cover.1442513540.git.dhdang@apm.com>
References: <cover.1442513540.git.dhdang@apm.com>
Message-ID: <41fbbb49c112705a8c14a342e98bd557c15c8f0c.1442513540.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci platform driver needs to work on systems that
either only support 64-bit DMA or only support 32-bit DMA.
Attempt to set a coherent dma mask for 64-bit DMA, and
attempt again with 32-bit DMA if that fails.

[dhdang: regenerate the patch over v4.3-rc1 and address new comments]
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Duc Dang <dhdang@apm.com>

---
 drivers/usb/host/xhci-plat.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 890ad9d..34c93e8 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -93,14 +93,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
-	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!pdev->dev.dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(&pdev->dev,
+						   DMA_BIT_MASK(64));
 	else
-		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
-- 
1.9.1
