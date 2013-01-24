From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:45:41 +0200
Subject: [RFC/PATCH 03/32] usb: musb: gadget: let udc-core manage gadget-dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can delete a little
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_gadget.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 8767874..1c4a8e8 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1871,12 +1871,11 @@ int musb_gadget_setup(struct musb *musb)
 	musb->g.speed = USB_SPEED_UNKNOWN;
 
 	/* this "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&musb->g.dev, "gadget");
 	musb->g.dev.parent = musb->controller;
 	musb->g.dev.dma_mask = musb->controller->dma_mask;
 	musb->g.dev.release = musb_gadget_release;
 	musb->g.name = musb_driver_name;
-
+	musb->g.register_my_device = true;
 	musb->g.is_otg = 1;
 
 	musb_g_init_endpoints(musb);
@@ -1884,11 +1883,6 @@ int musb_gadget_setup(struct musb *musb)
 	musb->is_active = 0;
 	musb_platform_try_idle(musb, 0);
 
-	status = device_register(&musb->g.dev);
-	if (status != 0) {
-		put_device(&musb->g.dev);
-		return status;
-	}
 	status = usb_add_gadget_udc(musb->controller, &musb->g);
 	if (status)
 		goto err;
@@ -1903,8 +1897,6 @@ err:
 void musb_gadget_cleanup(struct musb *musb)
 {
 	usb_del_gadget_udc(&musb->g);
-	if (musb->g.dev.parent)
-		device_unregister(&musb->g.dev);
 }
 
 /*
-- 
1.8.1.rc1.5.g7e0651a
