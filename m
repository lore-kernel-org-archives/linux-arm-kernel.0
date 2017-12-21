From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 21 Dec 2017 12:06:42 +0000
Subject: [PATCH] of: usb: Fix definition of of_usb_get_dr_mode_by_phy
Message-ID: <20171221120642.2899-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declaration of of_usb_get_dr_mode_by_phy only depends on CONFIG_OF
and not on CONFIG_USB_SUPPORT, which actually defines it. This can
break the build like below, if USB_SUPPORT is not selected :

 drivers/phy/renesas/phy-rcar-gen3-usb2.o: In function `rcar_gen3_phy_usb2_probe':
 drivers/phy/renesas/phy-rcar-gen3-usb2.c:444: undefined reference to `of_usb_get_dr_mode_by_phy'
 drivers/phy/renesas/phy-rcar-gen3-usb2.c:444:(.text+0x2d4): relocation
  truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_usb_get_dr_mode_by_phy'
 drivers/phy/renesas/phy-rcar-gen3-usb2.c:444: undefined reference to `of_usb_get_dr_mode_by_phy'
 drivers/phy/renesas/phy-rcar-gen3-usb2.c:444:(.text+0x3bc): relocation truncated to
  fit: R_AARCH64_CALL26 against undefined symbol `of_usb_get_dr_mode_by_phy'
 make: *** [Makefile:993: vmlinux] Error 1

Fixes: commit 98bfb39466954c69d2 ("usb: of: add an api to get dr_mode by the phy node")
Cc: linux-renesas-soc at vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
Cc: Bin Liu <b-liu@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/usb/of.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index 6cbe7a5c2b57..181245e5fe36 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -13,7 +13,6 @@
 #include <linux/usb/phy.h>
 
 #if IS_ENABLED(CONFIG_OF)
-enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0);
 bool of_usb_host_tpl_support(struct device_node *np);
 int of_usb_update_otg_caps(struct device_node *np,
 			struct usb_otg_caps *otg_caps);
@@ -21,11 +20,6 @@ struct device_node *usb_of_get_child_node(struct device_node *parent,
 			int portnum);
 struct device *usb_of_get_companion_dev(struct device *dev);
 #else
-static inline enum usb_dr_mode
-of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
-{
-	return USB_DR_MODE_UNKNOWN;
-}
 static inline bool of_usb_host_tpl_support(struct device_node *np)
 {
 	return false;
@@ -48,7 +42,13 @@ static inline struct device *usb_of_get_companion_dev(struct device *dev)
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
 enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);
+enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0);
 #else
+static inline enum usb_dr_mode
+of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
+{
+	return USB_DR_MODE_UNKNOWN;
+}
 static inline enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
 {
 	return USBPHY_INTERFACE_MODE_UNKNOWN;
-- 
2.13.6
