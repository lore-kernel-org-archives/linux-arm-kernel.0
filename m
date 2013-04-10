From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Apr 2013 19:43:25 +0000 (UTC)
Subject: [PATCH v2] ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m"
 as the main clock (fwd)
Message-ID: <alpine.DEB.2.00.1304101941550.25123@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Tony,

could you send this one upstream for v3.9-rc fixes?  Should prevent 
a MUSB regression in v3.9, mostly due to my own incompetence.


- Paul

---------- Forwarded message ----------
Date: Wed, 10 Apr 2013 19:41:38 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, rnayak at ti.com, b-cousson at ti.com,
    tony at atomide.com, linux at arm.linux.org.uk, linux-kernel at vger.kernel.org,
    Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] ARM: OMAP4: hwmod data: make
    'ocp2scp_usb_phy_phy_48m" as the main clock

From: Kishon Vijay Abraham I <kishon@ti.com>

Commit 92702df3570e ("ARM: OMAP4: PM: fix PM regression introduced by recent
clock cleanup") makes the 'ocp2scp_usb_phy_phy_48m' as optional
functional clock causing regression in MUSB. But this 48MHz clock is a
mandatory clock for usb phy attached to ocp2scp and hence made as the main
clock for ocp2scp.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[paul at pwsan.com: add comment to the hwmod data to try to prevent any
 future mistakes here]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

Nothing further received from Kishon per the request:

http://marc.info/?l=linux-omap&m=136554118302342&w=2

Since the deadline for v3.9-rc fixes is quite close, have added the 
comment myself, and have confirmed that this patch does not cause 
additional PM regressions on 4460 Panda-ES in the tests here.

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9e05765..eaba9dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2714,16 +2714,22 @@ static struct omap_ocp2scp_dev ocp2scp_dev_attr[] = {
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
+	/*
+	 * ocp2scp_usb_phy_phy_48m is provided by the OMAP4 PRCM IP
+	 * block as an "optional clock," and normally should never be
+	 * specified as the main_clk for an OMAP IP block.  However it
+	 * turns out that this clock is actually the main clock for
+	 * the ocp2scp_usb_phy IP block:
+	 * http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/119943.html
+	 * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
+	 * to be the best workaround.
+	 */
+	.main_clk	= "ocp2scp_usb_phy_phy_48m",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -2732,8 +2738,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 		},
 	},
 	.dev_attr	= ocp2scp_dev_attr,
-	.opt_clks	= ocp2scp_usb_phy_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
 
 /*
-- 
1.7.10.4
