From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Feb 2014 09:18:58 +0100
Subject: [PATCH] ARM: i.MX6: clk: Remove usbphy clock hacks
Message-ID: <1393489138-24406-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently the chipidea got broken on i.MX6 when the phy_mode property
is given in the devicetree. Since this commit:

| commit cd0b42c2a6d2a74244f0053f8960f5dad5842278
| Author: Chris Ruehl <chris.ruehl@gtsys.com.hk>
| Date:   Fri Jan 10 13:51:30 2014 +0800
|
|     usb: chipidea: put hw_phymode_configure before ci_usb_phy_init
|
|     hw_phymode_configure configures the PORTSC registers and allow the
|     following phy_inits to operate on the right parameters. This fix a problem
|     where the UPLI (ISP1504) could not be detected, because the Viewport was not
|     available and read the viewport return 0's only.
|
|     Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
|     Signed-off-by: Peter Chen <peter.chen@freescale.com>
|     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

the portsc register is configured before the phy clock is enabled. The CPU
immediately hangs once the portsc register is written to with disabled phy
clocks.

The following patch added a hack to the i.MX6 clock support. Its purpose
was to keep the usbphy clock gates enabled:

| commit a5120e89e7e187a91852896f586876c7a2030804
| Author: Peter Chen <peter.chen@freescale.com>
| Date:   Fri Jan 18 10:38:05 2013 +0800
|
|     ARM i.MX6: change mxs usbphy clock usage
|
|     This mxs usbphy is only needs to be on after system boots
|     up, and software never needs to control it anymore.
|     Meanwhile, usbphy's parent needs to be notified if usb
|     is suspend or not. So we design below mxs usbphy usage:
|
|     - usbphy1_gate and usbphy2_gate:
|     Their parents are dummy clock, we only needs to enable
|     it after system boots up.
|     - usbphy1 and usbphy2
|     Usage reserved bit for this clock, in that case, the refcount
|     will be updated, but without hardware changing.
|
|     Signed-off-by: Peter Chen <peter.chen@freescale.com>
|     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Now this patch indeed keeps the gates enabled, but it doesn't keep the parents
enabled, so the whole patch becomes a no-op once the parents get disabled. This
nowadays happens with more aggressive clock disabling for example in the UART
driver (which uses the same PLL as usbphy1).

This patch reverts the reserved register bit hackery and instead enables
the usbphy clocks when support for the mxsphy is enabled.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

The above are my current state of observations. I think I still haven't fully
understood the purpose of the clock hacks introduced with a5120e89e7e187.

 arch/arm/mach-imx/clk-imx6q.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4d677f4..a26cdcc 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -104,8 +104,8 @@ enum mx6q_clks {
 	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
 	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
 	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
-	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
-	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
+	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate_unused,
+	usbphy2_gate_unused, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow,
 	spdif, cko2_sel, cko2_podf, cko2, cko, vdoa, pll4_audio_div,
 	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, clk_max
 };
@@ -173,21 +173,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[pll6_enet]     = imx_clk_pllv3(IMX_PLLV3_ENET,	"pll6_enet",	"osc", base + 0xe0, 0x3);
 	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
 
-	/*
-	 * Bit 20 is the reserved and read-only bit, we do this only for:
-	 * - Do nothing for usbphy clk_enable/disable
-	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
-	 * the clk framework may need to enable/disable usbphy's parent
-	 */
-	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 20);
-	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
-
-	/*
-	 * usbphy*_gate needs to be on after system boots up, and software
-	 * never needs to control it anymore.
-	 */
-	clk[usbphy1_gate] = imx_clk_gate("usbphy1_gate", "dummy", base + 0x10, 6);
-	clk[usbphy2_gate] = imx_clk_gate("usbphy2_gate", "dummy", base + 0x20, 6);
+	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
+	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
 
 	clk[sata_ref] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
 	clk[pcie_ref] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
@@ -461,8 +448,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_prepare_enable(clk[clks_init_on[i]]);
 
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clk[usbphy1_gate]);
-		clk_prepare_enable(clk[usbphy2_gate]);
+		clk_prepare_enable(clk[usbphy1]);
+		clk_prepare_enable(clk[usbphy2]);
 	}
 
 	/*
-- 
1.8.5.3
