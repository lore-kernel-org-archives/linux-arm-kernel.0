From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:55 +0200
Subject: [RFC/PATCH 17/32] usb: gadget: mv_u3d_core: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-18-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/mv_u3d_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index b5cea27..565addc 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1792,8 +1792,6 @@ static int mv_u3d_remove(struct platform_device *dev)
 
 	clk_put(u3d->clk);
 
-	device_unregister(&u3d->gadget.dev);
-
 	platform_set_drvdata(dev, NULL);
 
 	kfree(u3d);
@@ -1957,15 +1955,11 @@ static int mv_u3d_probe(struct platform_device *dev)
 	u3d->gadget.speed = USB_SPEED_UNKNOWN;	/* speed */
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&u3d->gadget.dev, "gadget");
 	u3d->gadget.dev.parent = &dev->dev;
 	u3d->gadget.dev.dma_mask = dev->dev.dma_mask;
 	u3d->gadget.dev.release = mv_u3d_gadget_release;
 	u3d->gadget.name = driver_name;		/* gadget name */
-
-	retval = device_register(&u3d->gadget.dev);
-	if (retval)
-		goto err_register_gadget_device;
+	u3d->gadget.register_my_device = true;
 
 	mv_u3d_eps_init(u3d);
 
@@ -1991,8 +1985,6 @@ static int mv_u3d_probe(struct platform_device *dev)
 	return 0;
 
 err_unregister:
-	device_unregister(&u3d->gadget.dev);
-err_register_gadget_device:
 	free_irq(u3d->irq, &dev->dev);
 err_request_irq:
 err_get_irq:
-- 
1.8.1.rc1.5.g7e0651a
