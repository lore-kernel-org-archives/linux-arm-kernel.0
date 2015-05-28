From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 16:08:02 +0200
Subject: [PATCH] usb: phy: add static inline wrapper for
 devm_usb_get_phy_by_node
Message-ID: <2411449.AC4sAk3Y8u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced devm_usb_get_phy_by_node function only has
an extern declaration, but no alternative for the case that
CONFIG_USB_PHY is disabled, which leads to a build error when
it is used anyway:

drivers/power/twl4030_charger.c: In function 'twl4030_bci_probe':
drivers/power/twl4030_charger.c:648:23: error: implicit declaration of function 'devm_usb_get_phy_by_node' [-Werror=implicit-function-declaration]
    bci->transceiver = devm_usb_get_phy_by_node(

This adds the wrapper in the same way that we have one for
all other usb-phy API functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e842b84c8e7 ("usb: phy: Add interface to get phy give of device_node.")

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 8ed1e29ef329..e39f251cf861 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -240,6 +240,12 @@ static inline struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
 	return ERR_PTR(-ENXIO);
 }
 
+static inline struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
+	struct device_node *node, struct notifier_block *nb)
+{
+	return ERR_PTR(-ENXIO);
+}
+
 static inline void usb_put_phy(struct usb_phy *x)
 {
 }
