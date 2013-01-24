From: balbi@ti.com (Felipe Balbi)
Date: Thu, 24 Jan 2013 17:46:05 +0200
Subject: [RFC/PATCH 27/32] usb: renesas_usbhs: gadget: let udc-core manage
 gadget->dev
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
Message-ID: <1359042370-4358-28-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dd41f61..b42d81d 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -981,15 +981,12 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	/*
 	 * init gadget
 	 */
-	dev_set_name(&gpriv->gadget.dev, "gadget");
 	gpriv->gadget.dev.parent	= dev;
 	gpriv->gadget.dev.release	= usbhs_mod_gadget_release;
 	gpriv->gadget.name		= "renesas_usbhs_udc";
 	gpriv->gadget.ops		= &usbhsg_gadget_ops;
 	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
-	ret = device_register(&gpriv->gadget.dev);
-	if (ret < 0)
-		goto err_add_udc;
+	gpriv->gadget.register_my_device = true;
 
 	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
 
@@ -1018,15 +1015,13 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
 	if (ret)
-		goto err_register;
+		goto err_add_udc;
 
 
 	dev_info(dev, "gadget probed\n");
 
 	return 0;
 
-err_register:
-	device_unregister(&gpriv->gadget.dev);
 err_add_udc:
 	kfree(gpriv->uep);
 
@@ -1042,8 +1037,6 @@ void usbhs_mod_gadget_remove(struct usbhs_priv *priv)
 
 	usb_del_gadget_udc(&gpriv->gadget);
 
-	device_unregister(&gpriv->gadget.dev);
-
 	kfree(gpriv->uep);
 	kfree(gpriv);
 }
-- 
1.8.1.rc1.5.g7e0651a
