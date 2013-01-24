From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:53 +0200
Subject: [RFC/PATCH 15/32] usb: gadget: lpc32xx_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-16-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/lpc32xx_udc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index dd1c9b1..077e021 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -3090,6 +3090,7 @@ static int __init lpc32xx_udc_probe(struct platform_device *pdev)
 
 	/* init software state */
 	udc->gadget.dev.parent = dev;
+	udc->gadget.register_my_device = true;
 	udc->pdev = pdev;
 	udc->dev = &pdev->dev;
 	udc->enabled = 0;
@@ -3248,12 +3249,6 @@ static int __init lpc32xx_udc_probe(struct platform_device *pdev)
 	udc_disable(udc);
 	udc_reinit(udc);
 
-	retval = device_register(&udc->gadget.dev);
-	if (retval < 0) {
-		dev_err(udc->dev, "Device registration failure\n");
-		goto dev_register_fail;
-	}
-
 	/* Request IRQs - low and high priority USB device IRQs are routed to
 	 * the same handler, while the DMA interrupt is routed elsewhere */
 	retval = request_irq(udc->udp_irq[IRQ_USB_LP], lpc32xx_usb_lp_irq,
@@ -3320,8 +3315,6 @@ irq_dev_fail:
 irq_hp_fail:
 	free_irq(udc->udp_irq[IRQ_USB_LP], udc);
 irq_lp_fail:
-	device_unregister(&udc->gadget.dev);
-dev_register_fail:
 	dma_pool_destroy(udc->dd_cache);
 dma_alloc_fail:
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
@@ -3376,8 +3369,6 @@ static int lpc32xx_udc_remove(struct platform_device *pdev)
 	free_irq(udc->udp_irq[IRQ_USB_HP], udc);
 	free_irq(udc->udp_irq[IRQ_USB_LP], udc);
 
-	device_unregister(&udc->gadget.dev);
-
 	clk_disable(udc->usb_otg_clk);
 	clk_put(udc->usb_otg_clk);
 	clk_disable(udc->usb_slv_clk);
-- 
1.8.1.rc1.5.g7e0651a
