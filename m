From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 24 Jan 2013 01:38:39 -0500
Subject: [V5 PATCH 15/26] arm: ttc_dkb: add usb support
In-Reply-To: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1359009530-28182-16-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for ttc_dkb board, add udc/otg/ehci support

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index ce55fd8..0962791 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -27,7 +27,6 @@
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
 #include <mach/irqs.h>
-#include <mach/regs-usb.h>
 
 #include "common.h"
 
@@ -158,20 +157,24 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
 };
 
 #ifdef CONFIG_USB_SUPPORT
-#if defined(CONFIG_USB_MV_UDC) || defined(CONFIG_USB_EHCI_MV_U2O)
 
 static char *pxa910_usb_clock_name[] = {
-	[0] = "U2OCLK",
+	[0] = "usb_clk",
+};
+
+static struct mv_usb_phy_platform_data ttc_usb_phy_pdata = {
+	.clknum		= 1,
+	.clkname	= pxa910_usb_clock_name,
 };
 
+#if defined(CONFIG_USB_MV_UDC) || defined(CONFIG_USB_EHCI_MV_U2O)
+
 static struct mv_usb_platform_data ttc_usb_pdata = {
 	.clknum		= 1,
 	.clkname	= pxa910_usb_clock_name,
 	.vbus		= NULL,
 	.mode		= MV_USB_MODE_OTG,
 	.otg_force_a_bus_req = 1,
-	.phy_init	= pxa_usb_phy_init,
-	.phy_deinit	= pxa_usb_phy_deinit,
 	.set_vbus	= NULL,
 };
 #endif
@@ -198,19 +201,24 @@ static void __init ttc_dkb_init(void)
 	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#ifdef CONFIG_USB_SUPPORT
+	pxa_register_device(&pxa910_device_u2ophy, &ttc_usb_phy_pdata,
+				sizeof(ttc_usb_phy_pdata));
+#endif
+
 #ifdef CONFIG_USB_MV_UDC
-	pxa168_device_u2o.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2o);
+	pxa_register_device(&pxa910_device_u2o, &ttc_usb_pdata,
+				sizeof(ttc_usb_pdata));
 #endif
 
 #ifdef CONFIG_USB_EHCI_MV_U2O
-	pxa168_device_u2oehci.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2oehci);
+	pxa_register_device(&pxa910_device_u2oehci, &ttc_usb_pdata,
+				sizeof(ttc_usb_pdata));
 #endif
 
 #ifdef CONFIG_USB_MV_OTG
-	pxa168_device_u2ootg.dev.platform_data = &ttc_usb_pdata;
-	platform_device_register(&pxa168_device_u2ootg);
+	pxa_register_device(&pxa910_device_u2ootg, &ttc_usb_pdata,
+				sizeof(ttc_usb_pdata));
 #endif
 }
 
-- 
1.7.4.1
