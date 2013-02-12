From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 12 Feb 2013 20:28:12 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: PM: fix PM regression introduced by recent clock
 cleanup
Message-ID: <alpine.DEB.2.00.1302122026530.29149@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Commit 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb ("ARM: OMAP4:
clock/hwmod data: start to remove some IP block control "clocks"")
introduced a regression preventing the L3INIT clockdomain of OMAP4
systems from entering idle.  This in turn prevented these systems from
entering full chip clock-stop.

The regression was caused by the incorrect removal of a so-called
"optional functional clock" from the OMAP4 clock data.  This wasn't
caught for two reasons.  First, I missed the retention entry failure
in the branch test logs:

http://www.pwsan.com/omap/testlogs/cleanup_a_3.9/20130126014242/pm/4460pandaes/4460pandaes_log.txt

Second, the integration data for the OCP2SCP PHY IP block, added by
commit 0c6688753f9912c6a7013549ec31c8844020bbc1 ("ARM: OMAP4: hwmod
data: add remaining USB-related IP blocks"), should have associated this
clock with the IP block, but did not.

Fix by adding back the so-called "optional" functional clock to the
clock data, and by linking that clock to the OCP2SCP PHY IP block
integration hwmod data.

The problem patch was discovered by J, Keerthy <j-keerthy@ti.com>.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

It'd be nice, but certainly not necessary, to get this in for the v3.9 
merge window.  Otherwise, will send it for -rc1.

 arch/arm/mach-omap2/cclock44xx_data.c      |    5 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index cebe2b3..54ebb89 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1000,6 +1000,10 @@ DEFINE_CLK_OMAP_MUX(hsmmc2_fclk, "l3_init_clkdm", hsmmc1_fclk_sel,
 		    OMAP4430_CM_L3INIT_MMC2_CLKCTRL, OMAP4430_CLKSEL_MASK,
 		    hsmmc1_fclk_parents, func_dmic_abe_gfclk_ops);
 
+DEFINE_CLK_GATE(ocp2scp_usb_phy_phy_48m, "func_48m_fclk", &func_48m_fclk, 0x0,
+		OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
+		OMAP4430_OPTFCLKEN_PHY_48M_SHIFT, 0x0, NULL);
+
 DEFINE_CLK_GATE(sha2md5_fck, "l3_div_ck", &l3_div_ck, 0x0,
 		OMAP4430_CM_L4SEC_SHA2MD51_CLKCTRL,
 		OMAP4430_MODULEMODE_SWCTRL_SHIFT, 0x0, NULL);
@@ -1527,6 +1531,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"per_mcbsp4_gfclk",			&per_mcbsp4_gfclk,	CK_443X),
 	CLK(NULL,	"hsmmc1_fclk",			&hsmmc1_fclk,	CK_443X),
 	CLK(NULL,	"hsmmc2_fclk",			&hsmmc2_fclk,	CK_443X),
+	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
 	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1,	CK_443X),
 	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index a1849a8..d55c769 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2720,6 +2720,10 @@ static struct omap_ocp2scp_dev ocp2scp_dev_attr[] = {
 	{ }
 };
 
+static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] = {
+	{ .role = "48mhz", .clk = "ocp2scp_usb_phy_phy_48m" },
+};
+
 /* ocp2scp_usb_phy */
 static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 	.name		= "ocp2scp_usb_phy",
@@ -2734,6 +2738,8 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 		},
 	},
 	.dev_attr	= ocp2scp_dev_attr,
+	.opt_clks	= ocp2scp_usb_phy_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
 
 /*
-- 
1.7.10.4
