From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:32 -0500
Subject: [V4 PATCH 14/26] arm: brownstone: add usb support for the board
In-Reply-To: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
References: <xiechao.mail@gmail.com>
 <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1358762864-9249-15-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for brownstone board, add the udc/otg/ehci support

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   47 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 5cb769c..90c0340 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
 #include <linux/mfd/max8925.h>
+#include <linux/platform_data/mv_usb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -195,6 +196,31 @@ static struct sram_platdata mmp2_isram_platdata = {
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
@@ -211,6 +237,27 @@ static void __init brownstone_init(void)
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
+
+#ifdef CONFIG_USB_SUPPORT
+	pxa_register_device(&mmp2_device_u2ophy, &brownstone_usb_phy_pdata,
+				sizeof(brownstone_usb_phy_pdata));
+#endif
+
+#ifdef CONFIG_USB_MV_UDC
+	pxa_register_device(&mmp2_device_u2o, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
+#ifdef CONFIG_USB_EHCI_MV_U2O
+	pxa_register_device(&mmp2_device_u2oehci, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
+#ifdef CONFIG_USB_MV_OTG
+	pxa_register_device(&mmp2_device_u2ootg, &brownstone_usb_pdata,
+				sizeof(brownstone_usb_pdata));
+#endif
+
 }
 
 MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
-- 
1.7.4.1
