From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:45 +0200
Subject: [RFC/PATCH 07/32] usb: gadget: atmel_usba_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a7aed84..f0f9423 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1900,9 +1900,9 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "FIFO at 0x%08lx mapped at %p\n",
 		 (unsigned long)fifo->start, udc->fifo);
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	udc->gadget.register_my_device = true;
 
 	platform_set_drvdata(pdev, udc);
 
@@ -1962,12 +1962,6 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 	}
 	udc->irq = irq;
 
-	ret = device_add(&udc->gadget.dev);
-	if (ret) {
-		dev_dbg(&pdev->dev, "Could not add gadget: %d\n", ret);
-		goto err_device_add;
-	}
-
 	if (gpio_is_valid(pdata->vbus_pin)) {
 		if (!gpio_request(pdata->vbus_pin, "atmel_usba_udc")) {
 			udc->vbus_pin = pdata->vbus_pin;
@@ -2007,9 +2001,6 @@ err_add_udc:
 		gpio_free(udc->vbus_pin);
 	}
 
-	device_unregister(&udc->gadget.dev);
-
-err_device_add:
 	free_irq(irq, udc);
 err_request_irq:
 	kfree(usba_ep);
@@ -2053,8 +2044,6 @@ static int __exit usba_udc_remove(struct platform_device *pdev)
 	clk_put(udc->hclk);
 	clk_put(udc->pclk);
 
-	device_unregister(&udc->gadget.dev);
-
 	return 0;
 }
 
-- 
1.8.1.rc1.5.g7e0651a
