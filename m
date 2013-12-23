From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Dec 2013 16:37:03 +0800
Subject: [PATCH 1/4] clk: sunxi: Allwinner A20 output clock support
In-Reply-To: <1387787827-11341-1-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
Message-ID: <1387787827-11341-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the external clock outputs on the
Allwinner A20 SoC. The clock outputs are similar to "module 0"
type clocks, with different offsets and widths for clock factors.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 25d99b6..19d9e9e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -330,6 +330,47 @@ static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
 
 
 /**
+ * sun7i_a20_get_out_factors() - calculates m, p factors for CLK_OUT_A/B
+ * CLK_OUT rate is calculated as follows
+ * rate = (parent_rate >> p) / (m + 1);
+ */
+
+static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
+				      u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div, calcm, calcp;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq = parent_rate;
+
+	div = parent_rate / *freq;
+
+	if (div < 32)
+		calcp = 0;
+	else if (div / 2 < 32)
+		calcp = 1;
+	else if (div / 4 < 32)
+		calcp = 2;
+	else
+		calcp = 3;
+
+	calcm = DIV_ROUND_UP(div, 1 << calcp);
+
+	*freq = (parent_rate >> calcp) / calcm;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*m = calcm - 1;
+	*p = calcp;
+}
+
+
+
+/**
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
 
@@ -384,6 +425,14 @@ static struct clk_factors_config sun4i_mod0_config = {
 	.pwidth = 2,
 };
 
+/* user manual says "n" but it's really "p" */
+static struct clk_factors_config sun7i_a20_out_config = {
+	.mshift = 8,
+	.mwidth = 5,
+	.pshift = 20,
+	.pwidth = 2,
+};
+
 static const struct factors_data sun4i_pll1_data __initconst = {
 	.enable = 31,
 	.table = &sun4i_pll1_config,
@@ -414,6 +463,13 @@ static const struct factors_data sun4i_mod0_data __initconst = {
 	.getter = sun4i_get_mod0_factors,
 };
 
+static const struct factors_data sun7i_a20_out_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.table = &sun7i_a20_out_config,
+	.getter = sun7i_a20_get_out_factors,
+};
+
 static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 						const struct factors_data *data)
 {
@@ -912,6 +968,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
 	{.compatible = "allwinner,sun4i-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun4i-mod0-clk", .data = &sun4i_mod0_data,},
+	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
 };
 
-- 
1.8.5.2
