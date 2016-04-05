From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 5 Apr 2016 15:09:44 +0300
Subject: [PATCH] usb: dwc3: omap: drop dma_mask configuration
Message-ID: <1459858184-1962-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DWC3 OMAP driver supports DT-boot only, as result dma_mask will be
always configured properly from DT -
of_platform_device_create_pdata()->of_dma_configure(). More over,
dwc3-omap.c can be built as module and in this case it's unsafe to
assign local variable as dma_mask.

Hence, remove dma_mask configuration code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 22e9606..e92a992 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -331,8 +331,6 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
 	dwc3_omap_write_irqmisc_clr(omap, reg);
 }
 
-static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
-
 static int dwc3_omap_id_notifier(struct notifier_block *nb,
 	unsigned long event, void *ptr)
 {
@@ -490,7 +488,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	omap->irq	= irq;
 	omap->base	= base;
 	omap->vbus_reg	= vbus_reg;
-	dev->dma_mask	= &dwc3_omap_dma_mask;
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-- 
2.8.0
