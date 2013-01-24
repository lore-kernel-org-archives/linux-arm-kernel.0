From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:43 +0200
Subject: [RFC/PATCH 05/32] usb: gadget: amd5536udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we drop some boilerplate
code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/amd5536udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
index 3dac001..1827d4c 100644
--- a/drivers/usb/gadget/amd5536udc.c
+++ b/drivers/usb/gadget/amd5536udc.c
@@ -3080,7 +3080,6 @@ static void udc_pci_remove(struct pci_dev *pdev)
 	if (dev->active)
 		pci_disable_device(pdev);
 
-	device_unregister(&dev->gadget.dev);
 	pci_set_drvdata(pdev, NULL);
 
 	udc_remove(dev);
@@ -3276,6 +3275,7 @@ static int udc_probe(struct udc *dev)
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
+	dev->gadget.register_my_device = true;
 
 	/* init registers, interrupts, ... */
 	startup_registers(dev);
@@ -3301,13 +3301,6 @@ static int udc_probe(struct udc *dev)
 	if (retval)
 		goto finished;
 
-	retval = device_register(&dev->gadget.dev);
-	if (retval) {
-		usb_del_gadget_udc(&dev->gadget);
-		put_device(&dev->gadget.dev);
-		goto finished;
-	}
-
 	/* timer init */
 	init_timer(&udc_timer);
 	udc_timer.function = udc_timer_function;
-- 
1.8.1.rc1.5.g7e0651a
