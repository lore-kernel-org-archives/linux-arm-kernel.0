From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  5 Jan 2018 18:09:57 +0100
Subject: [PATCH 3/5] clk: divider: add divider_ro_round_rate helper
In-Reply-To: <20180105170959.17266-1-jbrunet@baylibre.com>
References: <20180105170959.17266-1-jbrunet@baylibre.com>
Message-ID: <20180105170959.17266-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like divider_round_rate, a couple a of driver are doing more or less
the same operation to round the rate of the divider when it is read-only.

We can factor this code so let's provide an helper function for this

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-divider.c    | 43 ++++++++++++++++++++++++++++---------------
 include/linux/clk-provider.h | 15 +++++++++++++++
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a851d3e04c7f..3eb2b27f3513 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -344,29 +344,42 @@ long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 }
 EXPORT_SYMBOL_GPL(divider_round_rate_parent);
 
+long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+				  unsigned long rate, unsigned long *prate,
+				  const struct clk_div_table *table, u8 width,
+				  unsigned long flags, unsigned int val)
+{
+	int div;
+
+	div = _get_div(table, val, flags, width);
+
+	/* Even a read-only clock can propagate a rate change */
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		if (!parent)
+			return -EINVAL;
+
+		*prate = clk_hw_round_rate(parent, rate * div);
+	}
+
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
+}
+EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
+
+
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
-	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
-	int bestdiv;
+	u32 val;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
-		bestdiv = clk_readl(divider->reg) >> divider->shift;
-		bestdiv &= div_mask(divider->width);
-		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
-			divider->width);
-
-		/* Even a read-only clock can propagate a rate change */
-		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-			if (!hw_parent)
-				return -EINVAL;
-
-			*prate = clk_hw_round_rate(hw_parent, rate * bestdiv);
-		}
+		val = clk_readl(divider->reg) >> divider->shift;
+		val &= div_mask(divider->width);
 
-		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+					     divider->width, divider->flags,
+					     val);
 	}
 
 	return divider_round_rate(hw, rate, prate, divider->table,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 175a62a15619..eb2c3a035e98 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -417,6 +417,10 @@ long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
 			       u8 width, unsigned long flags);
+long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+				  unsigned long rate, unsigned long *prate,
+				  const struct clk_div_table *table, u8 width,
+				  unsigned long flags, unsigned int val);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
@@ -772,6 +776,17 @@ static inline long divider_round_rate(struct clk_hw *hw, unsigned long rate,
 					 rate, prate, table, width, flags);
 }
 
+static inline long divider_ro_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *prate,
+					 const struct clk_div_table *table,
+					 u8 width, unsigned long flags,
+					 unsigned int val)
+{
+	return divider_ro_round_rate_parent(hw, clk_hw_get_parent(hw),
+					    rate, prate, table, width, flags,
+					    val);
+}
+
 /*
  * FIXME clock api without lock protection
  */
-- 
2.14.3
