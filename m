From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 21:59:15 +0800
Subject: [PATCH 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk support
In-Reply-To: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494856763-6543-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For dividers with zero indicating clock is disabled, instead of giving a
warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
set" in exist code, we'd consider it as a normal case and just return 0 in
divider_recalc_rate function. For such clocks users should be aware of
setting a correct rate before using.

e.g.
000b - Clock disabled
001b - Divide by 1
010b - Divide by 2
...

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk-divider.c    | 2 ++
 include/linux/clk-provider.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 96386ff..f78ba7a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -125,6 +125,8 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 
 	div = _get_div(table, val, flags, divider->width);
 	if (!div) {
+		if (flags & CLK_DIVIDER_ZERO_GATE)
+			return 0;
 		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
 			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
 			clk_hw_get_name(hw));
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a428aec..a6efbb9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -385,6 +385,9 @@ struct clk_div_table {
  * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
  *	except when the value read from the register is zero, the divisor is
  *	2^width of the field.
+ * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BASED
+ *	when the value read from the register is zero, it means the divisor
+ *	output is disabled and the rate calculated will be 0.
  */
 struct clk_divider {
 	struct clk_hw	hw;
@@ -405,6 +408,7 @@ struct clk_divider {
 #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
+#define CLK_DIVIDER_ZERO_GATE		BIT(7)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
-- 
2.7.4
