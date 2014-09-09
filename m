From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 9 Sep 2014 17:13:25 +0800
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <cover.1410253534.git.shengjiu.wang@freescale.com>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
Message-ID: <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each SSI has "ssi", "ssi_ipg" clocks, and they share same gate bits.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sl.c           |   13 ++++++++++---
 include/dt-bindings/clock/imx6sl-clock.h |    5 ++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 6791ff3..c8de87b 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -95,6 +95,10 @@ static struct clk_div_table video_div_table[] = {
 	{ }
 };
 
+static unsigned int share_count_ssi1;
+static unsigned int share_count_ssi2;
+static unsigned int share_count_ssi3;
+
 static struct clk *clks[IMX6SL_CLK_END];
 static struct clk_onecell_data clk_data;
 static void __iomem *ccm_base;
@@ -392,9 +396,12 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SL_CLK_SDMA]         = imx_clk_gate2("sdma",         "ipg",               base + 0x7c, 6);
 	clks[IMX6SL_CLK_SPBA]         = imx_clk_gate2("spba",         "ipg",               base + 0x7c, 12);
 	clks[IMX6SL_CLK_SPDIF]        = imx_clk_gate2("spdif",        "spdif0_podf",       base + 0x7c, 14);
-	clks[IMX6SL_CLK_SSI1]         = imx_clk_gate2("ssi1",         "ssi1_podf",         base + 0x7c, 18);
-	clks[IMX6SL_CLK_SSI2]         = imx_clk_gate2("ssi2",         "ssi2_podf",         base + 0x7c, 20);
-	clks[IMX6SL_CLK_SSI3]         = imx_clk_gate2("ssi3",         "ssi3_podf",         base + 0x7c, 22);
+	clks[IMX6SL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",     "ipg",        base + 0x7c, 18, &share_count_ssi1);
+	clks[IMX6SL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",     "ipg",        base + 0x7c, 20, &share_count_ssi2);
+	clks[IMX6SL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",     "ipg",        base + 0x7c, 22, &share_count_ssi3);
+	clks[IMX6SL_CLK_SSI1]         = imx_clk_gate2_shared("ssi1",         "ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
+	clks[IMX6SL_CLK_SSI2]         = imx_clk_gate2_shared("ssi2",         "ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
+	clks[IMX6SL_CLK_SSI3]         = imx_clk_gate2_shared("ssi3",         "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
 	clks[IMX6SL_CLK_UART]         = imx_clk_gate2("uart",         "ipg",               base + 0x7c, 24);
 	clks[IMX6SL_CLK_UART_SERIAL]  = imx_clk_gate2("uart_serial",  "uart_root",         base + 0x7c, 26);
 	clks[IMX6SL_CLK_USBOH3]       = imx_clk_gate2("usboh3",       "ipg",               base + 0x80, 0);
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index f10a928..9ce4e42 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -171,6 +171,9 @@
 #define IMX6SL_PLL5_BYPASS		158
 #define IMX6SL_PLL6_BYPASS		159
 #define IMX6SL_PLL7_BYPASS		160
-#define IMX6SL_CLK_END			161
+#define IMX6SL_CLK_SSI1_IPG		161
+#define IMX6SL_CLK_SSI2_IPG		162
+#define IMX6SL_CLK_SSI3_IPG		163
+#define IMX6SL_CLK_END			164
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
1.7.9.5
