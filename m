From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Mar 2016 18:57:16 +0200
Subject: [PATCH 3/3] clk: sunxi: Add sun8i PLL audio support
In-Reply-To: <cover.1459358017.git.moinejf@free.fr>
References: <cover.1459358017.git.moinejf@free.fr>
Message-ID: <8ba2e0d78c70ea4c54fb25969956fc31674df612.1459358017.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PLL type which is used by the sun8i family for audio.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 48 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index ff93aee..917d4aa 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -10,6 +10,7 @@ Required properties:
 	"allwinner,sun4i-a10-pll1-clk" - for the main PLL clock and PLL4
 	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
 	"allwinner,sun8i-a23-pll1-clk" - for the main PLL clock on A23
+	"allwinner,sun8i-pll2-clk" - for the audio PLL clock
 	"allwinner,sun6i-a31-pll3-clk" - for the video PLL clock
 	"allwinner,sun9i-a80-pll4-clk" - for the peripheral PLLs on A80
 	"allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 270f2a9..7386141 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1130,6 +1130,54 @@ CLK_OF_DECLARE(sun6i_pll6, "allwinner,sun6i-a31-pll6-clk",
 	       sun6i_pll6_clk_setup);
 
 /*
+ * sun8i pll2
+ *
+ * rate = parent_rate / (m + 1) * (n + 1) / (p + 1);
+ */
+static void sun8i_pll2_factors(struct factors_request *req)
+{
+	unsigned long n, m;
+
+	/* set p = 4 so that pll2 = pll2x8 / 8 */
+	req->p = 4 - 1;
+	rational_best_approximation(req->rate,
+				req->parent_rate / 4,
+				1 << 7, 1 << 5, &n, &m);
+	req->rate = req->parent_rate / m * n / 4;
+	req->m = m - 1;
+	req->n = n - 1;
+}
+
+static void sun8i_pll2_recalc(struct factors_request *req)
+{
+	req->rate = req->parent_rate / (req->m + 1) * (req->n + 1) /
+						(req->p + 1);
+}
+
+static const struct clk_factors_config sun8i_pll2_config = {
+	.mshift = 0,
+	.mwidth = 5,
+	.nshift = 8,
+	.nwidth = 7,
+	.pshift = 16,
+	.pwidth = 4,
+};
+
+static const struct factors_data sun8i_pll2_data __initconst = {
+	.enable = 31,
+	.table = &sun8i_pll2_config,
+	.getter = sun8i_pll2_factors,
+	.recalc = sun8i_pll2_recalc,
+};
+
+static void __init sun8i_pll2_setup(struct device_node *node)
+{
+	sunxi_factors_clk_setup(node, &sun8i_pll2_data);
+}
+CLK_OF_DECLARE(sun8i_pll2, "allwinner,sun8i-pll2-clk",
+	       sun8i_pll2_setup);
+
+/*
  * sun6i pll3
  *
  * if (p == 0) rate = k ? 270MHz : 297MHz
-- 
2.8.0
