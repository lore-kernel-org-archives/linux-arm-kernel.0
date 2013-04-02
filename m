From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 2 Apr 2013 15:36:56 -0700
Subject: [PATCH] clk: divider: Introduce CLK_DIVIDER_ALLOW_ZERO flag
Message-ID: <397e02df-e5d1-4211-8a44-2ee15cf4188f@DB3EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dividers which have CLK_DIVIDER_ONE_BASED set have a redundant state,
being a divider value of zero. Some hardware implementations allow a
zero divider which simply doesn't alter the frequency. I.e. it acts like
a divide by one or bypassing the divider.
This flag is used to handle such HW in the clk-divider model.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/clk-divider.c    | 5 +++--
 include/linux/clk-provider.h | 8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 68b4021..6d96741 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -109,8 +109,9 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 
 	div = _get_div(divider, val);
 	if (!div) {
-		WARN(1, "%s: Invalid divisor for clock %s\n", __func__,
-						__clk_get_name(hw->clk));
+		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
+			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+			__clk_get_name(hw->clk));
 		return parent_rate;
 	}
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7f197d7..811426d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -239,9 +239,14 @@ struct clk_div_table {
  * CLK_DIVIDER_ONE_BASED - by default the divisor is the value read from the
  * 	register plus one.  If CLK_DIVIDER_ONE_BASED is set then the divider is
  * 	the raw value read from the register, with the value of zero considered
- * 	invalid
+ *	invalid, unless CLK_DIVIDER_ALLOW_ZERO is set.
  * CLK_DIVIDER_POWER_OF_TWO - clock divisor is 2 raised to the value read from
  * 	the hardware register
+ * CLK_DIVIDER_ALLOW_ZERO - Allow zero divisors.  For dividers which have
+ *	CLK_DIVIDER_ONE_BASED set, it is possible to end up with a zero divisor.
+ *	Some hardware implementations gracefully handle this case and allow a
+ *	zero divisor by not modifying their input clock
+ *	(divide by one / bypass).
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -255,6 +260,7 @@ struct clk_divider {
 
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
+#define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
-- 
1.8.2
