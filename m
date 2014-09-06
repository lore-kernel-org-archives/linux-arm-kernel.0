From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  6 Sep 2014 14:45:10 +0800
Subject: [PATCH] clk: sunxi: add correct divider table for sun4i-apb0 clock
Message-ID: <1409985910-30737-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i-apb0 clock, as found on all platforms using it, is a
power-of-two-based divider clock, with a special divider of 2
for value 0.

This was causing the clock framework to incorrectly calculate
the clock rate for apb1 and related modules on sun6i and sun8i.
On sun[4/5/7]i, u-boot SPL configures the divider with value 1
for /2 divider, so no suprises there.

This patch adds a proper divider table for it, so the correct
clock rate can be calculated.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b654b7b..2cf6581 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -762,10 +762,19 @@ static const struct div_data sun4i_ahb_data __initconst = {
 	.width	= 2,
 };
 
+static const struct clk_div_table sun4i_apb0_table[] __initconst = {
+	{ .val = 0, .div = 2 },
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 8 },
+	{ } /* sentinel */
+};
+
 static const struct div_data sun4i_apb0_data __initconst = {
 	.shift	= 8,
 	.pow	= 1,
 	.width	= 2,
+	.table	= sun4i_apb0_table,
 };
 
 static const struct div_data sun6i_a31_apb2_div_data __initconst = {
-- 
2.1.0
