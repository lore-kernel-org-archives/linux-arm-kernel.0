From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 30 Oct 2014 13:16:28 -0500
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32 bit DMA
In-Reply-To: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
Message-ID: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xhci platform driver needs to work on systems that either only
support 64-bit DMA or only support 32-bit DMA. Attempt to set a
coherent dma mask for 64-bit DMA, and attempt again with 32-bit
DMA if that fails.

Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/usb/host/xhci-plat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 1a0cf9f..3045e77 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -147,14 +147,17 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
+	/* Try setting the coherent_dma_mask to 64 bits, then try 32 bits */
+	if (sizeof(dma_addr_t) < 8 ||
+		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	else
-		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		dma_set_mask(&pdev->dev, pdev->dev.coherent_dma_mask);
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
-- 
1.9.3
