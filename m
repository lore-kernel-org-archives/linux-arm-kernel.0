From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:40 -0400
Subject: [PATCh V10 09/12] arm: ttc_dkb: modify usb support
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-10-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for ttc_dkb board, we use phy driver for usb support.
Modify the usb support for udc/otg/ehci support.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 6528a5f..c8b9ed8 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -18,6 +18,8 @@
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
 #include <linux/mfd/88pm860x.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/mv_usb2.h>
 #include <linux/platform_data/mv_usb.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
@@ -29,7 +31,6 @@
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
 #include <mach/irqs.h>
-#include <mach/regs-usb.h>
 
 #include "common.h"
 
@@ -166,8 +167,6 @@ static struct mv_usb_platform_data ttc_usb_pdata = {
 	.vbus		= NULL,
 	.mode		= MV_USB_MODE_OTG,
 	.otg_force_a_bus_req = 1,
-	.phy_init	= pxa_usb_phy_init,
-	.phy_deinit	= pxa_usb_phy_deinit,
 	.set_vbus	= NULL,
 };
 #endif
@@ -280,19 +279,41 @@ static void __init ttc_dkb_init(void)
 	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#ifdef CONFIG_USB_SUPPORT
+	pxa_register_device(&pxa910_device_u2ophy, NULL, 0);
+#endif
+
 #ifdef CONFIG_USB_MV_UDC
-	pxa168_device_u2o.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2o);
+	/* for usb2 phy */
+	usb_bind_phy(pxa910_device_u2o.drv_name, MV_USB2_PHY_INDEX,
+		     pxa910_device_u2ophy.drv_name);
+#ifdef CONFIG_USB_MV_OTG
+	/* for usb2 otg phy */
+	usb_bind_phy(pxa910_device_u2o.drv_name, MV_USB2_OTG_PHY_INDEX,
+		     pxa910_device_u2ootg.drv_name);
+#endif
+	pxa_register_device(&pxa910_device_u2o, &ttc_usb_pdata,
+			    sizeof(ttc_usb_pdata));
 #endif
 
 #ifdef CONFIG_USB_EHCI_MV_U2O
-	pxa168_device_u2oehci.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2oehci);
+	/* for usb2 phy */
+	usb_bind_phy(pxa910_device_u2oehci.drv_name, MV_USB2_PHY_INDEX,
+		     pxa910_device_u2ophy.drv_name);
+#ifdef CONFIG_USB_MV_OTG
+	/* for usb2 otg phy */
+	usb_bind_phy(pxa910_device_u2oehci.drv_name, MV_USB2_OTG_PHY_INDEX,
+		     pxa910_device_u2ootg.drv_name);
+#endif
+	pxa_register_device(&pxa910_device_u2oehci, &ttc_usb_pdata,
+			    sizeof(ttc_usb_pdata));
 #endif
 
 #ifdef CONFIG_USB_MV_OTG
-	pxa168_device_u2ootg.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2ootg);
+	usb_bind_phy(pxa910_device_u2ootg.drv_name, MV_USB2_PHY_INDEX,
+		     pxa910_device_u2ophy.drv_name);
+	pxa_register_device(&pxa910_device_u2ootg, &ttc_usb_pdata,
+			    sizeof(ttc_usb_pdata));
 #endif
 
 #ifdef CONFIG_MMP_DISP
-- 
1.7.4.1
