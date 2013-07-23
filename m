From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:01:11 -0300
Subject: [PATCH RFC 7/8] clk: sunxi: mod0 support
In-Reply-To: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1374541272-32173-8-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements support for the "module 0" type of clocks, as
used by MMC, IR, NAND, SATA and other components.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 54 +++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 6634eac..74c8f2e 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -23,6 +23,7 @@ Required properties:
 	"allwinner,sun4i-apb1-mux-clk" - for the APB1 clock muxing
 	"allwinner,sun4i-apb1-gates-clk" - for the APB1 gates on A10
 	"allwinner,sun5i-a13-apb1-gates-clk" - for the APB1 gates on A13
+	"allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
 
 Required properties for all clocks:
 - reg : shall be the control register address for the clock.
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 743c2c2..28bf36f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -202,6 +202,44 @@ static void sunxi_get_apb1_factors(u32 *freq, u32 parent_rate,
 
 
 /**
+ * sunxi_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
+ * MMC rate is calculated as follows
+ * rate = (parent_rate >> p) / (m + 1);
+ */
+
+static void sunxi_get_mod0_factors(u32 *freq, u32 parent_rate,
+				   u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div, calcm, calcp;
+
+	/* Normalize value to a division of the parent */
+	div = parent_rate / *freq;
+	*freq = parent_rate / div;
+
+	if (div < 16)
+		calcp = 0;
+	else if (div / 2 < 16)
+		calcp = 1;
+	else if (div / 4 < 16)
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
 
@@ -239,6 +277,14 @@ static struct clk_factors_config apb1_config = {
 	.pwidth = 2,
 };
 
+/* user manual says "n" but it's really "p" */
+static struct clk_factors_config mod0_config = {
+	.mshift = 0,
+	.mwidth = 4,
+	.pshift = 16,
+	.pwidth = 2,
+};
+
 static const __initconst struct factors_data pll1_data = {
 	.enable = 31,
 	.table = &pll1_config,
@@ -256,6 +302,13 @@ static const __initconst struct factors_data apb1_data = {
 	.getter = sunxi_get_apb1_factors,
 };
 
+static const __initconst struct factors_data mod0_data = {
+	.enable = 31,
+	.mux = 24,
+	.table = &mod0_config,
+	.getter = sunxi_get_mod0_factors,
+};
+
 static void __init sunxi_factors_clk_setup(struct device_node *node,
 					   struct factors_data *data)
 {
@@ -621,6 +674,7 @@ CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);
 static const __initconst struct of_device_id clk_factors_match[] = {
 	{.compatible = "allwinner,sun4i-pll1-clk", .data = &pll1_data,},
 	{.compatible = "allwinner,sun4i-apb1-clk", .data = &apb1_data,},
+	{.compatible = "allwinner,sun4i-mod0-clk", .data = &mod0_data,},
 	{}
 };
 
-- 
1.8.3.3
