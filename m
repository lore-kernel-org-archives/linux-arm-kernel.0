From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Oct 2015 10:08:57 +0200
Subject: [PATCH v5 3/5] clk: sunxi: pll2: Add A13 support
In-Reply-To: <1445242139-20965-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445242139-20965-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445242139-20965-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13, unlike the A10 and A20, doesn't use a pass-through exception for
the 0 value in the pre and post dividers, but increments all the values
written in the register by one.

Add an exception for both these cases to handle them nicely.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-a10-pll2.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
index a57742a8576d..5484c31ec568 100644
--- a/drivers/clk/sunxi/clk-a10-pll2.c
+++ b/drivers/clk/sunxi/clk-a10-pll2.c
@@ -41,9 +41,15 @@
 
 #define SUN4I_PLL2_OUTPUTS		4
 
+struct sun4i_pll2_data {
+	u32	post_div_offset;
+	u32	pre_div_flags;
+};
+
 static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
 
-static void __init sun4i_pll2_setup(struct device_node *node)
+static void __init sun4i_pll2_setup(struct device_node *node,
+				    struct sun4i_pll2_data *data)
 {
 	const char *clk_name = node->name, *parent;
 	struct clk **clks, *base_clk, *prediv_clk;
@@ -70,8 +76,7 @@ static void __init sun4i_pll2_setup(struct device_node *node)
 					  parent, 0, reg,
 					  SUN4I_PLL2_PRE_DIV_SHIFT,
 					  SUN4I_PLL2_PRE_DIV_WIDTH,
-					  CLK_DIVIDER_ONE_BASED |
-					  CLK_DIVIDER_ALLOW_ZERO,
+					  data->pre_div_flags,
 					  &sun4i_a10_pll2_lock);
 	if (!prediv_clk) {
 		pr_err("Couldn't register the prediv clock\n");
@@ -122,7 +127,7 @@ static void __init sun4i_pll2_setup(struct device_node *node)
 	 */
 	val = readl(reg);
 	val &= ~(SUN4I_PLL2_POST_DIV_MASK << SUN4I_PLL2_POST_DIV_SHIFT);
-	val |= SUN4I_PLL2_POST_DIV_VALUE << SUN4I_PLL2_POST_DIV_SHIFT;
+	val |= (SUN4I_PLL2_POST_DIV_VALUE - data->post_div_offset) << SUN4I_PLL2_POST_DIV_SHIFT;
 	writel(val, reg);
 
 	of_property_read_string_index(node, "clock-output-names",
@@ -185,4 +190,27 @@ err_free_data:
 err_unmap:
 	iounmap(reg);
 }
-CLK_OF_DECLARE(sun4i_pll2, "allwinner,sun4i-a10-pll2-clk", sun4i_pll2_setup);
+
+static struct sun4i_pll2_data sun4i_a10_pll2_data = {
+	.pre_div_flags	= CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
+};
+
+static void __init sun4i_a10_pll2_setup(struct device_node *node)
+{
+	sun4i_pll2_setup(node, &sun4i_a10_pll2_data);
+}
+
+CLK_OF_DECLARE(sun4i_a10_pll2, "allwinner,sun4i-a10-pll2-clk",
+	       sun4i_a10_pll2_setup);
+
+static struct sun4i_pll2_data sun5i_a13_pll2_data = {
+	.post_div_offset	= 1,
+};
+
+static void __init sun5i_a13_pll2_setup(struct device_node *node)
+{
+	sun4i_pll2_setup(node, &sun5i_a13_pll2_data);
+}
+
+CLK_OF_DECLARE(sun5i_a13_pll2, "allwinner,sun5i-a13-pll2-clk",
+	       sun5i_a13_pll2_setup);
-- 
2.5.3
