From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Nov 2014 10:36:09 +0100
Subject: [PATCH] usb: phy: fix twl4030 build regression
Message-ID: <7831012.jlbEUURqIo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent changes to the common OTG handling broke building the twl4030
OTG driver as found during an allmodconfig build of linux-next:

drivers/phy/phy-twl4030-usb.c: In function 'twl4030_set_peripheral':
drivers/phy/phy-twl4030-usb.c:609:11: error: 'struct phy' has no member named 'state'
drivers/phy/phy-twl4030-usb.c: In function 'twl4030_usb_probe':
drivers/phy/phy-twl4030-usb.c:679:12: warning: assignment from incompatible pointer type

This applies the same changes that were done to the other phy drivers
to get it to build cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 19c1eac2685b6 ("usb: rename phy to usb_phy in OTG")
Fixes: e47d92545c297 ("usb: move the OTG state from the USB PHY to the OTG structure")
---

I have no idea if this is the correct fix, this is just a mechanical
conversion, so please review carefully.

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 7b04befd5271..e2698d29f436 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -606,7 +606,7 @@ static int twl4030_set_peripheral(struct usb_otg *otg,
 
 	otg->gadget = gadget;
 	if (!gadget)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -618,7 +618,7 @@ static int twl4030_set_host(struct usb_otg *otg, struct usb_bus *host)
 
 	otg->host = host;
 	if (!host)
-		otg->phy->state = OTG_STATE_UNDEFINED;
+		otg->state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -676,7 +676,7 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	twl->phy.otg		= otg;
 	twl->phy.type		= USB_PHY_TYPE_USB2;
 
-	otg->phy		= &twl->phy;
+	otg->usb_phy		= &twl->phy;
 	otg->set_host		= twl4030_set_host;
 	otg->set_peripheral	= twl4030_set_peripheral;
 
