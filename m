From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 15 Sep 2015 18:01:01 +0800
Subject: [PATCH V2 1/2] clk: imx6: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <cover.1442310569.git.shengjiu.wang@freescale.com>
References: <cover.1442310569.git.shengjiu.wang@freescale.com>
Message-ID: <113f1cecf1d83c6b96fd23ab9d7a73d1923e0d21.1442310569.git.shengjiu.wang@freescale.com>
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
 drivers/clk/imx/clk-imx6q.c               | 4 +++-
 drivers/clk/imx/clk-imx6sl.c              | 4 +++-
 drivers/clk/imx/clk-imx6sx.c              | 1 +
 include/dt-bindings/clock/imx6qdl-clock.h | 3 ++-
 include/dt-bindings/clock/imx6sl-clock.h  | 3 ++-
 include/dt-bindings/clock/imx6sx-clock.h  | 3 ++-
 6 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b2c1c04..e6b5944 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -119,6 +119,7 @@ static unsigned int share_count_ssi1;
 static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 static unsigned int share_count_mipi_core_cfg;
+static unsigned int share_count_spdif;
 
 static inline int clk_on_imx6q(void)
 {
@@ -456,7 +457,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_SATA]         = imx_clk_gate2("sata",          "ahb",               base + 0x7c, 4);
 	clk[IMX6QDL_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[IMX6QDL_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
-	clk[IMX6QDL_CLK_SPDIF]        = imx_clk_gate2("spdif",         "spdif_podf",        base + 0x7c, 14);
+	clk[IMX6QDL_CLK_SPDIF]        = imx_clk_gate2_shared("spdif",     "spdif_podf",     base + 0x7c, 14, &share_count_spdif);
+	clk[IMX6QDL_CLK_SPDIF_GCLK]   = imx_clk_gate2_shared("spdif_gclk", "ipg",           base + 0x7c, 14, &share_count_spdif);
 	clk[IMX6QDL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
 	clk[IMX6QDL_CLK_SSI2_IPG]     = imx_clk_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
 	clk[IMX6QDL_CLK_SSI3_IPG]     = imx_clk_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
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
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index 8de173f..77985cc 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -254,6 +254,7 @@
 #define IMX6QDL_CLK_CAAM_MEM			241
 #define IMX6QDL_CLK_CAAM_ACLK			242
 #define IMX6QDL_CLK_CAAM_IPG			243
-#define IMX6QDL_CLK_END				244
+#define IMX6QDL_CLK_SPDIF_GCLK			244
+#define IMX6QDL_CLK_END				245
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
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
