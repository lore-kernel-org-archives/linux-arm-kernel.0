From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 12 Jan 2013 18:01:46 +0800
Subject: [PATCH v2] clk: max77686: Remove unnecessary NULL checking for
 container_of()
Message-ID: <1357984906.6460.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

container_of() never returns NULL, thus remove the NULL checking for it.
Also rename get_max77686_clk() to to_max77686_clk() for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: remove unrelated change for ~max77686->mask 
 drivers/clk/clk-max77686.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 8944214..90bf59c 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -44,33 +44,23 @@ struct max77686_clk {
 	struct clk_lookup *lookup;
 };
 
-static struct max77686_clk *get_max77686_clk(struct clk_hw *hw)
+static struct max77686_clk *to_max77686_clk(struct clk_hw *hw)
 {
 	return container_of(hw, struct max77686_clk, hw);
 }
 
 static int max77686_clk_prepare(struct clk_hw *hw)
 {
-	struct max77686_clk *max77686;
-	int ret;
-
-	max77686 = get_max77686_clk(hw);
-	if (!max77686)
-		return -ENOMEM;
-
-	ret = regmap_update_bits(max77686->iodev->regmap,
-		MAX77686_REG_32KHZ, max77686->mask, max77686->mask);
+	struct max77686_clk *max77686 = to_max77686_clk(hw);
 
-	return ret;
+	return regmap_update_bits(max77686->iodev->regmap,
+				  MAX77686_REG_32KHZ, max77686->mask,
+				  max77686->mask);
 }
 
 static void max77686_clk_unprepare(struct clk_hw *hw)
 {
-	struct max77686_clk *max77686;
-
-	max77686 = get_max77686_clk(hw);
-	if (!max77686)
-		return;
+	struct max77686_clk *max77686 = to_max77686_clk(hw);
 
 	regmap_update_bits(max77686->iodev->regmap,
 		MAX77686_REG_32KHZ, max77686->mask, ~max77686->mask);
@@ -78,14 +68,10 @@ static void max77686_clk_unprepare(struct clk_hw *hw)
 
 static int max77686_clk_is_enabled(struct clk_hw *hw)
 {
-	struct max77686_clk *max77686;
+	struct max77686_clk *max77686 = to_max77686_clk(hw);
 	int ret;
 	u32 val;
 
-	max77686 = get_max77686_clk(hw);
-	if (!max77686)
-		return -ENOMEM;
-
 	ret = regmap_read(max77686->iodev->regmap,
 				MAX77686_REG_32KHZ, &val);
 
-- 
1.7.9.5
