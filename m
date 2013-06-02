From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 3 Jun 2013 00:57:56 +0200
Subject: [PATCH 04/10] clk: divider: add flag to limit possible dividers to
 even numbers
In-Reply-To: <201306030055.15413.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de>
Message-ID: <201306030057.57244.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoCs like the Rockchip Cortex-A9 ones contain divider some clocks
that use the regular mechanisms for storage but allow only even
dividers and 1 to be used.

Therefore add a flag that lets _is_valid_div limit the valid dividers
to these values. _get_maxdiv is also adapted to return even values
for the CLK_DIVIDER_ONE_BASED case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk-divider.c    |   14 ++++++++++++--
 include/linux/clk-provider.h |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e37c48a..adfbd0d 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -45,8 +45,16 @@ static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
 
 static unsigned int _get_maxdiv(struct clk_divider *divider)
 {
-	if (divider->flags & CLK_DIVIDER_ONE_BASED)
-		return div_mask(divider);
+	if (divider->flags & CLK_DIVIDER_ONE_BASED) {
+		unsigned int div = div_mask(divider);
+
+		/* decrease to even number */
+		if (divider->flags & CLK_DIVIDER_EVEN)
+			div--;
+
+		return div;
+	}
+
 	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
 		return 1 << div_mask(divider);
 	if (divider->table)
@@ -141,6 +149,8 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
 		return is_power_of_2(div);
 	if (divider->table)
 		return _is_valid_table_div(divider->table, div);
+	if (divider->flags & CLK_DIVIDER_EVEN && div != 1 && (div % 2) != 0)
+		return false;
 	return true;
 }
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 420a187..9fdd60d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -268,6 +268,7 @@ struct clk_div_table {
  *	indicate the bits that get changed during a write. So for a clock with
  *	shift 0 and width 2, setting the divider to 2 would result in a write
  *	of (3 << 16) | (2 << 0).
+ * CLK_DIVIDER_EVEN - only allow even divider values
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -283,6 +284,7 @@ struct clk_divider {
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_MASK_UPPER_HALF	BIT(3)
+#define CLK_DIVIDER_EVEN		BIT(4)
 
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
-- 
1.7.2.3
