From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jun 2014 17:59:38 +0800
Subject: [PATCH v3 4/6] clk: sunxi: Add support for table-based divider clocks
In-Reply-To: <1403603980-31101-1-git-send-email-wens@csie.org>
References: <1403603980-31101-1-git-send-email-wens@csie.org>
Message-ID: <1403603980-31101-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few of the clock modules have odd dividers, such as
the 2 lowest dividers being the same (2), or have the
same divider when the highest bit is set.

This patch adds support for optional divider tables,
so the clock framework will know about the odd values.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index a38c799..6fe9492 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -664,6 +664,7 @@ struct div_data {
 	u8	shift;
 	u8	pow;
 	u8	width;
+	const struct clk_div_table *table;
 };
 
 static const struct div_data sun4i_axi_data __initconst = {
@@ -704,10 +705,10 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
-				   reg, data->shift, data->width,
-				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
-				   &clk_lock);
+	clk = clk_register_divider_table(NULL, clk_name, clk_parent, 0,
+					 reg, data->shift, data->width,
+					 data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
+					 data->table, &clk_lock);
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
-- 
2.0.0
