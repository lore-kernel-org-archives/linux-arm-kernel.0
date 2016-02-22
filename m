From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 22 Feb 2016 01:39:58 +0000
Subject: [PATCH] clk: sunxi: allow PLL6 clock to be reused
Message-ID: <1456105198-25295-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we hard-code the base name for the PLL6 clock for both the
sun4i and sun6i variants in the driver (pll6 and pll6x2, respectively).
This unfortunately denies reusing this clock for the H3 and A64 PLL8
clock, which is the same otherwise.
Remove the hard-coded name in the source code and replace it with an
appropriate index into the clock-output-names array in the DT.
This is compatible with all current device trees, since they all carry
the hard-coded base name in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Salut Maxime,

does that patch make sense?
It fixes the re-usability problem while still keeping compatibility
with existing DTs and also is pretty small.
If you agree with this, I'll send out a v3 of the A64 series including
this patch and the H3 PLL8 enablement later.
I tested this on my BananaPi, the clk_summary output was identical
with and without this patch.

Cheers,
Andre.

 drivers/clk/sunxi/clk-factors.c | 3 ++-
 drivers/clk/sunxi/clk-factors.h | 1 +
 drivers/clk/sunxi/clk-sunxi.c   | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index ddefe96..7daf01d 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -202,7 +202,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	if (data->name)
 		clk_name = data->name;
 	else
-		of_property_read_string(node, "clock-output-names", &clk_name);
+		of_property_read_string_index(node, "clock-output-names",
+					      data->name_idx, &clk_name);
 
 	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
 	if (!factors)
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 1e63c5b..3a7da86 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -36,6 +36,7 @@ struct factors_data {
 	void (*getter)(struct factors_request *req);
 	void (*recalc)(struct factors_request *req);
 	const char *name;
+	int name_idx;
 };
 
 struct clk_factors {
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 99f60ef..53f5927 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -530,14 +530,14 @@ static const struct factors_data sun4i_pll6_data __initconst = {
 	.enable = 31,
 	.table = &sun4i_pll5_config,
 	.getter = sun4i_get_pll5_factors,
-	.name = "pll6",
+	.name_idx = 2,
 };
 
 static const struct factors_data sun6i_a31_pll6_data __initconst = {
 	.enable = 31,
 	.table = &sun6i_a31_pll6_config,
 	.getter = sun6i_a31_get_pll6_factors,
-	.name = "pll6x2",
+	.name_idx = 1,
 };
 
 static const struct factors_data sun5i_a13_ahb_data __initconst = {
-- 
1.8.4
