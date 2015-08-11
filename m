From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 11 Aug 2015 17:26:54 +0800
Subject: [PATCH V1 3/3] ARM: imx6sx: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <cover.1439284957.git.shengjiu.wang@freescale.com>
References: <cover.1439284957.git.shengjiu.wang@freescale.com>
Message-ID: <d1ffad5bac99d16c3b8377a2cc9370e35efcc7e7.1439284957.git.shengjiu.wang@freescale.com>
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
 arch/arm/boot/dts/imx6sx.dtsi            | 2 +-
 drivers/clk/imx/clk-imx6sx.c             | 1 +
 include/dt-bindings/clock/imx6sx-clock.h | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index e391d63..af9c28e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -211,7 +211,7 @@
 					dmas = <&sdma 14 18 0>,
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
-					clocks = <&clks IMX6SX_CLK_SPDIF>,
+					clocks = <&clks IMX6SX_CLK_SPDIF_GCLK>,
 						 <&clks IMX6SX_CLK_OSC>,
 						 <&clks IMX6SX_CLK_SPDIF>,
 						 <&clks 0>, <&clks 0>, <&clks 0>,
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 5b95c2c..f2bc511 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -454,6 +454,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
 	clks[IMX6SX_CLK_AUDIO]        = imx_clk_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
 	clks[IMX6SX_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",  "spdif_podf",        base + 0x7c, 14, &share_count_audio);
+	clks[IMX6SX_CLK_SPDIF_GCLK]   = imx_clk_gate2_shared("spdif_gclk",    "ipg",        base + 0x7c, 14, &share_count_audio);
 	clks[IMX6SX_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clks[IMX6SX_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clks[IMX6SX_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index 9957091..36f0324 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -274,6 +274,7 @@
 #define IMX6SX_PLL5_BYPASS		261
 #define IMX6SX_PLL6_BYPASS		262
 #define IMX6SX_PLL7_BYPASS		263
-#define IMX6SX_CLK_CLK_END		264
+#define IMX6SX_CLK_SPDIF_GCLK		264
+#define IMX6SX_CLK_CLK_END		265
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
1.9.1
