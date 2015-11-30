From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 16:34:59 +0100
Subject: [PATCH] clk: sunxi: pll2: Fix clock running too fast
Message-ID: <1448897699-20475-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to what the datasheet says, the pre divider doesn't seem to be
incremented by one in the PLL2, but just uses the value from the register,
with 0 being a bypass.

This fixes the audio playing too fast.

Since we now have the same pre-divider flags, and the only difference with
the A10 is the post-divider offset, also remove the structure to just pass
the offset as an argument.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Hi Stephen, Mike,

Could you apply this patch for 4.4?

Thanks,
Maxime

 drivers/clk/sunxi/clk-a10-pll2.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
index 5484c31ec568..30d4bfb4cd3d 100644
--- a/drivers/clk/sunxi/clk-a10-pll2.c
+++ b/drivers/clk/sunxi/clk-a10-pll2.c
@@ -41,15 +41,10 @@
 
 #define SUN4I_PLL2_OUTPUTS		4
 
-struct sun4i_pll2_data {
-	u32	post_div_offset;
-	u32	pre_div_flags;
-};
-
 static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
 
 static void __init sun4i_pll2_setup(struct device_node *node,
-				    struct sun4i_pll2_data *data)
+				    int post_div_offset)
 {
 	const char *clk_name = node->name, *parent;
 	struct clk **clks, *base_clk, *prediv_clk;
@@ -76,7 +71,7 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 					  parent, 0, reg,
 					  SUN4I_PLL2_PRE_DIV_SHIFT,
 					  SUN4I_PLL2_PRE_DIV_WIDTH,
-					  data->pre_div_flags,
+					  CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 					  &sun4i_a10_pll2_lock);
 	if (!prediv_clk) {
 		pr_err("Couldn't register the prediv clock\n");
@@ -127,7 +122,7 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 	 */
 	val = readl(reg);
 	val &= ~(SUN4I_PLL2_POST_DIV_MASK << SUN4I_PLL2_POST_DIV_SHIFT);
-	val |= (SUN4I_PLL2_POST_DIV_VALUE - data->post_div_offset) << SUN4I_PLL2_POST_DIV_SHIFT;
+	val |= (SUN4I_PLL2_POST_DIV_VALUE - post_div_offset) << SUN4I_PLL2_POST_DIV_SHIFT;
 	writel(val, reg);
 
 	of_property_read_string_index(node, "clock-output-names",
@@ -191,25 +186,17 @@ err_unmap:
 	iounmap(reg);
 }
 
-static struct sun4i_pll2_data sun4i_a10_pll2_data = {
-	.pre_div_flags	= CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
-};
-
 static void __init sun4i_a10_pll2_setup(struct device_node *node)
 {
-	sun4i_pll2_setup(node, &sun4i_a10_pll2_data);
+	sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);
 }
 
 CLK_OF_DECLARE(sun4i_a10_pll2, "allwinner,sun4i-a10-pll2-clk",
 	       sun4i_a10_pll2_setup);
 
-static struct sun4i_pll2_data sun5i_a13_pll2_data = {
-	.post_div_offset	= 1,
-};
-
 static void __init sun5i_a13_pll2_setup(struct device_node *node)
 {
-	sun4i_pll2_setup(node, &sun5i_a13_pll2_data);
+	sun4i_pll2_setup(node, &sun5i_a13_pll2_data, 1);
 }
 
 CLK_OF_DECLARE(sun5i_a13_pll2, "allwinner,sun5i-a13-pll2-clk",
-- 
2.6.3
