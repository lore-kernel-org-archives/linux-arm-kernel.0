From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:46:06 +0200
Subject: [RFC/PATCH 28/32] usb: gadget: pxa25x_udc: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-29-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/pxa25x_udc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index fa9c344..9deffd3 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -1266,13 +1266,6 @@ static int pxa25x_udc_start(struct usb_gadget *g,
 	dev->gadget.dev.driver = &driver->driver;
 	dev->pullup = 1;
 
-	retval = device_add (&dev->gadget.dev);
-	if (retval) {
-		dev->driver = NULL;
-		dev->gadget.dev.driver = NULL;
-		return retval;
-	}
-
 	/* ... then enable host detection and ep0; and we're ready
 	 * for set_configuration as well as eventual disconnect.
 	 */
@@ -1331,7 +1324,6 @@ static int pxa25x_udc_stop(struct usb_gadget*g,
 	dev->gadget.dev.driver = NULL;
 	dev->driver = NULL;
 
-	device_del (&dev->gadget.dev);
 	dump_state(dev);
 
 	return 0;
@@ -2140,9 +2132,9 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 	dev->timer.function = udc_watchdog;
 	dev->timer.data = (unsigned long) dev;
 
-	device_initialize(&dev->gadget.dev);
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
+	dev->gadget.register_my_device = true;
 
 	the_controller = dev;
 	platform_set_drvdata(pdev, dev);
-- 
1.8.1.rc1.5.g7e0651a
