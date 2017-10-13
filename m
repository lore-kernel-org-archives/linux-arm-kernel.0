From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 16:26:33 +0800
Subject: [PATCH v2 1/9] usb: xhci-mtk: use dma_set_mask_and_coherent() in
 probe function
Message-ID: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the simpler dma_set_mask_and_coherent() instead of
doing these as separate steps

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 8fb6065..c197a6d 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -606,15 +606,10 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize dma_mask and coherent_dma_mask to 32-bits */
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		goto disable_clk;
 
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
-	else
-		dma_set_mask(dev, DMA_BIT_MASK(32));
-
 	hcd = usb_create_hcd(driver, dev, dev_name(dev));
 	if (!hcd) {
 		ret = -ENOMEM;
-- 
1.7.9.5
