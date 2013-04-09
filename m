From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 9 Apr 2013 13:58:21 +0530
Subject: =?UTF-8?q?=5BPATCH=5D=20ARM=3A=20OMAP4=3A=20HWMOD=3A=20make=20=27ocp2scp=5Fusb=5Fphy=5Fphy=5F48m=22=20as=20the=20main=20clock?=
Message-ID: <1365496101-7829-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 92702d (ARM: OMAP4: PM: fix PM regression introduced by recent
clock cleanup) makes the 'ocp2scp_usb_phy_phy_48m' as optional
functional clock causing regression in MUSB. But this 48MHz clock is a
mandatory clock for usb phy attached to ocp2scp and hence made as the main
clock for ocp2scp.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9e05765..c1fb090 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2714,16 +2714,12 @@ static struct omap_ocp2scp_dev ocp2scp_dev_attr[] = {
 	{ }
 };
 
-static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] = {
-	{ .role = "48mhz", .clk = "ocp2scp_usb_phy_phy_48m" },
-};
-
 /* ocp2scp_usb_phy */
 static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 	.name		= "ocp2scp_usb_phy",
 	.class		= &omap44xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "ocp2scp_usb_phy_phy_48m",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -2732,8 +2728,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 		},
 	},
 	.dev_attr	= ocp2scp_dev_attr,
-	.opt_clks	= ocp2scp_usb_phy_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
 
 /*
-- 
1.7.10.4
