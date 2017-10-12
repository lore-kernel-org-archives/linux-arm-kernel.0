From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 12 Oct 2017 15:30:19 +0200
Subject: [PATCH] ARM: dts: imx6ul-14x14-evk: switch lcdif pixel clock to video
 pll
Message-ID: <20171012133019.17086-1-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, the lcdif_pre_sel mux is switched to the pll3_pfd1_540m PFD
source. If this mux is allowed to propagate rate changes to its parent,
setting the LCDIF pixel clock rate to 9 MHz, as required by the LCD
panel, will cause the pll3_pfd1_540m PFD to be switched away from its
nominal rate to 288 MHz.
This has no negative side effects, as there are no other children to
this PFD. Still, to avoid surprises, it might be preferrable to switch
to the designated video PLL (pll5_video_div) as clock source for the
LCDIF pixel clock.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 9c23e017d86ad..e5d3ef88be608 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -147,6 +147,8 @@
 
 
 &lcdif {
+	assigned-clocks = <&clks IMX6UL_CLK_LCDIF_PRE_SEL>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL5_VIDEO_DIV>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
-- 
2.11.0
