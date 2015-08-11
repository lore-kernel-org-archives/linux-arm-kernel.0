From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 11 Aug 2015 17:26:52 +0800
Subject: [PATCH V1 1/3] ARM: imx6q: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <cover.1439284957.git.shengjiu.wang@freescale.com>
References: <cover.1439284957.git.shengjiu.wang@freescale.com>
Message-ID: <18281cc1d1229dfe5edaf87163dc4dc140663823.1439284957.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As spdif driver will register SPDIF clock to regmap, regmap will do
clk_prepare in init function, so SPDIF clock is prepared in probe, then its
root clock (pll clock) is prepared also, which cause the arm can't enter
low power mode.
Add SPDIF_GCLK in clock tree which share same gate bits with SPDIF clock.
Its root clock is ipg clock, and register it to regmap, then the issue cam
be fixed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi            | 2 +-
 drivers/clk/imx/clk-imx6q.c               | 4 +++-
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 03858d7..66913ef 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -218,7 +218,7 @@
 					dmas = <&sdma 14 18 0>,
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
-					clocks = <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_OSC>,
+					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
 						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index c507bca..2487cf1 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -119,6 +119,7 @@ static unsigned int share_count_ssi1;
 static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 static unsigned int share_count_mipi_core_cfg;
+static unsigned int share_count_spdif;
 
 static inline int clk_on_imx6q(void)
 {
@@ -453,7 +454,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_SATA]         = imx_clk_gate2("sata",          "ahb",               base + 0x7c, 4);
 	clk[IMX6QDL_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[IMX6QDL_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
-	clk[IMX6QDL_CLK_SPDIF]        = imx_clk_gate2("spdif",         "spdif_podf",        base + 0x7c, 14);
+	clk[IMX6QDL_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",     "spdif_podf",     base + 0x7c, 14, &share_count_spdif);
+	clk[IMX6QDL_CLK_SPDIF_GCLK]   = imx_clk_gate2_shared("spdif_gclk", "ipg",           base + 0x7c, 14, &share_count_spdif);
 	clk[IMX6QDL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clk[IMX6QDL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clk[IMX6QDL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 8780868..bc3ad90 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -251,6 +251,7 @@
 #define IMX6QDL_CLK_VIDEO_27M			238
 #define IMX6QDL_CLK_MIPI_CORE_CFG		239
 #define IMX6QDL_CLK_MIPI_IPG			240
-#define IMX6QDL_CLK_END				241
+#define IMX6QDL_CLK_SPDIF_GCLK			241
+#define IMX6QDL_CLK_END				242
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
1.9.1
