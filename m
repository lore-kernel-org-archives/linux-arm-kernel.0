From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 15:11:13 +0100
Subject: [PATCH] USB otg: use try_module_get in all usb_get_phy functions and
 add missing module_put
In-Reply-To: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
References: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1361974273-17087-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In patch "5d3c28b usb: otg: add device tree support to otg library"
devm_usb_get_phy_by_phandle() was added. It uses try_module_get() to lock the
phy driver in memory. The corresponding module_put() is missing in that patch.

This patch adds try_module_get() to usb_get_phy() and usb_get_phy_dev().
Further the missing module_put() is added to usb_put_phy().

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/otg/otg.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
index e181439..2bd03d2 100644
--- a/drivers/usb/otg/otg.c
+++ b/drivers/usb/otg/otg.c
@@ -130,7 +130,7 @@ struct usb_phy *usb_get_phy(enum usb_phy_type type)
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __usb_find_phy(&phy_list, type);
-	if (IS_ERR(phy)) {
+	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
 		pr_err("unable to find transceiver of type %s\n",
 			usb_phy_type_string(type));
 		goto err0;
@@ -228,7 +228,7 @@ struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __usb_find_phy_dev(dev, &phy_bind_list, index);
-	if (IS_ERR(phy)) {
+	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
 		pr_err("unable to find transceiver\n");
 		goto err0;
 	}
@@ -301,8 +301,12 @@ EXPORT_SYMBOL(devm_usb_put_phy);
  */
 void usb_put_phy(struct usb_phy *x)
 {
-	if (x)
+	if (x) {
+		struct module *owner = x->dev->driver->owner;
+
 		put_device(x->dev);
+		module_put(owner);
+	}
 }
 EXPORT_SYMBOL(usb_put_phy);
 
-- 
1.7.10.4
