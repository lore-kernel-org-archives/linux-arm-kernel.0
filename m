From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 4 Apr 2016 14:33:31 +0300
Subject: [PATCH] usb: dwc3: keystone: drop dma_mask configuration
Message-ID: <1459769611-16862-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 supports DT-boot only, as result dma_mask will be
always configured properly from DT -
of_platform_device_create_pdata()->of_dma_configure(). More over,
dwc3-keystone.c can be built as module and in this case it's unsafe to
assign local variable as dma_mask.

Hence, remove dma_mask configuration code.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 2be268d..7266470 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -39,8 +39,6 @@
 #define USBSS_IRQ_COREIRQ_EN	BIT(0)
 #define USBSS_IRQ_COREIRQ_CLR	BIT(0)
 
-static u64 kdwc3_dma_mask;
-
 struct dwc3_keystone {
 	struct device			*dev;
 	struct clk			*clk;
@@ -108,9 +106,6 @@ static int kdwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(kdwc->usbss))
 		return PTR_ERR(kdwc->usbss);
 
-	kdwc3_dma_mask = dma_get_mask(dev);
-	dev->dma_mask = &kdwc3_dma_mask;
-
 	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
 
 	error = clk_prepare_enable(kdwc->clk);
-- 
2.8.0
