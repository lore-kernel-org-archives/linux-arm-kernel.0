From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:46:07 +0200
Subject: [RFC/PATCH 29/32] usb: gadget: pxa27x_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-30-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/pxa27x_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index f7d2579..23a3eed 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -1814,11 +1814,6 @@ static int pxa27x_udc_start(struct usb_gadget *g,
 	udc->gadget.dev.driver = &driver->driver;
 	dplus_pullup(udc, 1);
 
-	retval = device_add(&udc->gadget.dev);
-	if (retval) {
-		dev_err(udc->dev, "device_add error %d\n", retval);
-		goto fail;
-	}
 	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		retval = otg_set_peripheral(udc->transceiver->otg,
 						&udc->gadget);
@@ -1876,8 +1871,6 @@ static int pxa27x_udc_stop(struct usb_gadget *g,
 
 	udc->driver = NULL;
 
-	device_del(&udc->gadget.dev);
-
 	if (!IS_ERR_OR_NULL(udc->transceiver))
 		return otg_set_peripheral(udc->transceiver->otg, NULL);
 	return 0;
@@ -2462,9 +2455,9 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 		goto err_map;
 	}
 
-	device_initialize(&udc->gadget.dev);
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
+	udc->gadget.register_my_device = true;
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
1.8.1.rc1.5.g7e0651a
