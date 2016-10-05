From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:49 +0200
Subject: [PATCH 3/6] clk: oxnas: Rename to clk_oxnas_gate
In-Reply-To: <20161005150752.22618-1-narmstrong@baylibre.com>
References: <20161005150752.22618-1-narmstrong@baylibre.com>
Message-ID: <20161005150752.22618-4-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename clock ops to clk_oxnas_gate in ops and structures.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/clk-oxnas.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk-oxnas.c b/drivers/clk/clk-oxnas.c
index 47649ac..a76c7fb 100644
--- a/drivers/clk/clk-oxnas.c
+++ b/drivers/clk/clk-oxnas.c
@@ -26,7 +26,7 @@
 #include <linux/mfd/syscon.h>
 
 /* Standard regmap gate clocks */
-struct clk_oxnas {
+struct clk_oxnas_gate {
 	struct clk_hw hw;
 	signed char bit;
 	struct regmap *regmap;
@@ -37,14 +37,14 @@ struct clk_oxnas {
 #define CLK_SET_REGOFFSET	0x2c
 #define CLK_CLR_REGOFFSET	0x30
 
-static inline struct clk_oxnas *to_clk_oxnas(struct clk_hw *hw)
+static inline struct clk_oxnas_gate *to_clk_oxnas_gate(struct clk_hw *hw)
 {
-	return container_of(hw, struct clk_oxnas, hw);
+	return container_of(hw, struct clk_oxnas_gate, hw);
 }
 
-static int oxnas_clk_is_enabled(struct clk_hw *hw)
+static int oxnas_clk_gate_is_enabled(struct clk_hw *hw)
 {
-	struct clk_oxnas *std = to_clk_oxnas(hw);
+	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
 	int ret;
 	unsigned int val;
 
@@ -55,26 +55,26 @@ static int oxnas_clk_is_enabled(struct clk_hw *hw)
 	return val & BIT(std->bit);
 }
 
-static int oxnas_clk_enable(struct clk_hw *hw)
+static int oxnas_clk_gate_enable(struct clk_hw *hw)
 {
-	struct clk_oxnas *std = to_clk_oxnas(hw);
+	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
 
 	regmap_write(std->regmap, CLK_SET_REGOFFSET, BIT(std->bit));
 
 	return 0;
 }
 
-static void oxnas_clk_disable(struct clk_hw *hw)
+static void oxnas_clk_gate_disable(struct clk_hw *hw)
 {
-	struct clk_oxnas *std = to_clk_oxnas(hw);
+	struct clk_oxnas_gate *std = to_clk_oxnas_gate(hw);
 
 	regmap_write(std->regmap, CLK_CLR_REGOFFSET, BIT(std->bit));
 }
 
-static const struct clk_ops oxnas_clk_ops = {
-	.enable = oxnas_clk_enable,
-	.disable = oxnas_clk_disable,
-	.is_enabled = oxnas_clk_is_enabled,
+static const struct clk_ops oxnas_clk_gate_ops = {
+	.enable = oxnas_clk_gate_enable,
+	.disable = oxnas_clk_gate_disable,
+	.is_enabled = oxnas_clk_gate_is_enabled,
 };
 
 static const char *const oxnas_clk_parents[] = {
@@ -88,7 +88,7 @@ static const char *const eth_parents[] = {
 #define DECLARE_STD_CLKP(__clk, __parent)			\
 static const struct clk_init_data clk_##__clk##_init = {	\
 	.name = __stringify(__clk),				\
-	.ops = &oxnas_clk_ops,					\
+	.ops = &oxnas_clk_gate_ops,					\
 	.parent_names = __parent,				\
 	.num_parents = ARRAY_SIZE(__parent),			\
 }
@@ -127,7 +127,7 @@ static const struct clk_oxnas_init_data clk_oxnas_init[] = {
 };
 
 struct clk_oxnas_data {
-	struct clk_oxnas clk_oxnas[ARRAY_SIZE(clk_oxnas_init)];
+	struct clk_oxnas_gate clk_oxnas[ARRAY_SIZE(clk_oxnas_init)];
 	struct clk_onecell_data onecell_data[ARRAY_SIZE(clk_oxnas_init)];
 	struct clk *clks[ARRAY_SIZE(clk_oxnas_init)];
 };
@@ -150,7 +150,7 @@ static int oxnas_stdclk_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(clk_oxnas_init); i++) {
-		struct clk_oxnas *_clk;
+		struct clk_oxnas_gate *_clk;
 
 		_clk = &clk_oxnas->clk_oxnas[i];
 		_clk->bit = clk_oxnas_init[i].bit;
-- 
2.7.0
