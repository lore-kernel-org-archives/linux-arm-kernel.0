From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 18 Feb 2013 01:10:29 -0500
Subject: [V7 PATCH 07/16] arm: brownstone: add usb support for the board
In-Reply-To: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
References: <1361167838-22929-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1361167838-22929-8-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for brownstone board, add the udc/otg/ehci support

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   68 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 5cb769c..f84613a 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -18,6 +18,9 @@
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/mv_usb2.h>
+#include <linux/platform_data/mv_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -195,6 +198,31 @@ static struct sram_platdata mmp2_isram_platdata = {
 	.granularity	= SRAM_GRANULARITY,
 };
 
+#ifdef CONFIG_USB_SUPPORT
+
+static char *mmp2_usb_clock_name[] = {
+	[0] = "usb_clk",
+};
+
+static struct mv_usb_phy_platform_data brownstone_usb_phy_pdata = {
+	.clknum		= 1,
+	.clkname	= mmp2_usb_clock_name,
+};
+
+#if defined(CONFIG_USB_MV_UDC) || defined(CONFIG_USB_EHCI_MV_U2O)
+
+static struct mv_usb_platform_data brownstone_usb_pdata = {
+	.clknum		= 1,
+	.clkname	= mmp2_usb_clock_name,
+	.vbus		= NULL,
+	.mode		= MV_USB_MODE_OTG,
+	.otg_force_a_bus_req = 1,
+	.set_vbus	= NULL,
+};
+#endif
+#endif
+
+
 static void __init brownstone_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
@@ -211,6 +239,46 @@ static void __init brownstone_init(void)
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
+
+#ifdef CONFIG_USB_SUPPORT
+	pxa_register_device(&mmp2_device_u2ophy, &brownstone_usb_phy_pdata,
+				sizeof(brownstone_usb_phy_pdata));
+#endif
+
+#ifdef CONFIG_USB_MV_UDC
+	/* for usb2 phy */
+	usb_bind_phy(mmp2_device_u2o.drv_name, MV_USB2_PHY_INDEX,
+				mmp2_device_u2ophy.drv_name);
+#ifdef CONFIG_USB_MV_OTG
+	/* for usb2 otg phy */
+	usb_bind_phy(mmp2_device_u2o.drv_name, MV_USB2_OTG_PHY_INDEX,
+				mmp2_device_u2ootg.drv_name);
+#endif
+	pxa_register_device(&mmp2_device_u2o, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
+#ifdef CONFIG_USB_EHCI_MV_U2O
+	/* for usb2 phy */
+	usb_bind_phy(mmp2_device_u2oehci.dev_name, MV_USB2_PHY_INDEX,
+				mmp2_device_u2ophy.dev_name);
+#ifdef CONFIG_USB_MV_OTG
+	/* for usb2 otg phy */
+	usb_bind_phy(mmp2_device_u2oehci.drv_name, MV_USB2_OTG_PHY_INDEX,
+				mmp2_device_u2ootg.drv_name);
+#endif
+	pxa_register_device(&mmp2_device_u2oehci, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
+#ifdef CONFIG_USB_MV_OTG
+	/* for usb2 phy */
+	usb_bind_phy(mmp2_device_u2ootg.dev_name, MV_USB2_PHY_INDEX,
+				mmp2_device_u2ophy.dev_name);
+	pxa_register_device(&mmp2_device_u2ootg, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
 }
 
 MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
-- 
1.7.4.1
