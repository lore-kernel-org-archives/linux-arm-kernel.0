From: dhdang@apm.com (Duc Dang)
Date: Thu, 20 Aug 2015 12:38:53 -0700
Subject: [PATCH v7 1/2] usb: make xhci platform driver use 64 bit or 32 bit DMA
In-Reply-To: <1522889.9kdnRk8vHo@wuerfel>
References: <1522889.9kdnRk8vHo@wuerfel>
Message-ID: <69e6f5bf693d02fba001d02047453bed0519499d.1440098398.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci platform driver needs to work on systems that
either only support 64-bit DMA or only support 32-bit DMA.
Attempt to set a coherent dma mask for 64-bit DMA, and
attempt again with 32-bit DMA if that fails.

[dhdang: regenerate the patch over 4.2-rc5 and address new comments]
Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Duc Dang <dhdang@apm.com>

---
Changes from v6:
	-Add WARN_ON if dma_mask is NULL
	-Use dma_coerce_mask_and_coherent to assign
	dma_mask and coherent_dma_mask

Changes from v5:
        -Change comment
        -Assign dma_mask to coherent_dma_mask if dma_mask is NULL
        to make sure dma_set_mask_and_coherent does not fail prematurely.

Changes from v4:
        -None

Changes from v3:
        -Re-generate the patch over 4.2-rc5
        -No code change.

Changes from v2:
        -None

Changes from v1:
        -Consolidated to use dma_set_mask_and_coherent
        -Got rid of the check against sizeof(dma_addr_t)

 drivers/usb/host/xhci-plat.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 890ad9d..e4c7f9d 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -93,14 +93,19 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
-	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-	else
-		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	/* Throw a waring if broken platform code didn't initialize dma_mask */
+	WARN_ON(!pdev->dev.dma_mask);
+	/*
+	 * Try setting dma_mask and coherent_dma_mask to 64 bits,
+	 * then try 32 bits
+	 */
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		ret = dma_coerce_mask_and_coherent(&pdev->dev,
+						   DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
-- 
1.9.1
