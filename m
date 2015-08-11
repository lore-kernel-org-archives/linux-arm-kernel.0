From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 11 Aug 2015 17:26:53 +0800
Subject: [PATCH V1 2/3] ARM: imx6sl: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <cover.1439284957.git.shengjiu.wang@freescale.com>
References: <cover.1439284957.git.shengjiu.wang@freescale.com>
Message-ID: <22e9a375a152703a52895af8d2596f6f58b93249.1439284957.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As spdif driver will register SPDIF clock to regmap, regmap will do
clk_prepare in init function, so SPDIF clock is prepared in probe, then its
root clock (pll clock) is prepared also, which cause the arm can't enter
low power mode.
Add SPDIF_GCLK in clock tree which share same gate bits with SPDIF clock.
Its root clock is ipg clock, and register it to regmap, then the issue can
be fixed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi            | 16 ++++++++++++++++
 drivers/clk/imx/clk-imx6sl.c             |  4 +++-
 include/dt-bindings/clock/imx6sl-clock.h |  3 ++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 320a27f..c247756 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -135,8 +135,24 @@
 				ranges;
 
 				spdif: spdif at 02004000 {
+					compatible = "fsl,imx6sl-spdif",
+						"fsl,imx35-spdif";
 					reg = <0x02004000 0x4000>;
 					interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&sdma 14 18 0>,
+						<&sdma 15 18 0>;
+					dma-names = "rx", "tx";
+					clocks = <&clks IMX6SL_CLK_SPDIF_GCLK>, <&clks IMX6SL_CLK_OSC>,
+						 <&clks IMX6SL_CLK_SPDIF>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_DUMMY>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_IPG>, <&clks IMX6SL_CLK_DUMMY>,
+						 <&clks IMX6SL_CLK_DUMMY>, <&clks IMX6SL_CLK_SPBA>;
+					clock-names = "core", "rxtx0",
+						"rxtx1", "rxtx2",
+						"rxtx3", "rxtx4",
+						"rxtx5", "rxtx6",
+						"rxtx7", "dma";
+					status = "disabled";
 				};
 
 				ecspi1: ecspi at 02008000 {
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index a0d4cf2..a73cedd 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -97,6 +97,7 @@ static struct clk_div_table video_div_table[] = {
 static unsigned int share_count_ssi1;
 static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
+static unsigned int share_count_spdif;
 
 static struct clk *clks[IMX6SL_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -391,7 +392,8 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_PWM4]         = imx_clk_gate2("pwm4",         "perclk",            base + 0x78, 22);
 	clks[IMX6SL_CLK_SDMA]         = imx_clk_gate2("sdma",         "ipg",               base + 0x7c, 6);
 	clks[IMX6SL_CLK_SPBA]         = imx_clk_gate2("spba",         "ipg",               base + 0x7c, 12);
-	clks[IMX6SL_CLK_SPDIF]        = imx_clk_gate2("spdif",        "spdif0_podf",       base + 0x7c, 14);
+	clks[IMX6SL_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",     "spdif0_podf",   base + 0x7c, 14, &share_count_spdif);
+	clks[IMX6SL_CLK_SPDIF_GCLK]   = imx_clk_gate2_shared("spdif_gclk",  "ipg",         base + 0x7c, 14, &share_count_spdif);
 	clks[IMX6SL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",     "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clks[IMX6SL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",     "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clks[IMX6SL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",     "ipg",        base + 0x7c, 22, &share_count_ssi3);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index 9ce4e42..e14573e 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -174,6 +174,7 @@
 #define IMX6SL_CLK_SSI1_IPG		161
 #define IMX6SL_CLK_SSI2_IPG		162
 #define IMX6SL_CLK_SSI3_IPG		163
-#define IMX6SL_CLK_END			164
+#define IMX6SL_CLK_SPDIF_GCLK		164
+#define IMX6SL_CLK_END			165
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
1.9.1
