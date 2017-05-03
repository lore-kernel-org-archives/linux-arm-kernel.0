From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:38 +0200
Subject: [PATCH v2 1/20] clk: divider: Make divider_round_rate take the parent
 clock
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9c2f3ed66ae32e55721bfced41dfd70e49cb746c.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, divider_round_rate only considers the parent clock returned by
clk_hw_get_parent.

This works fine on clocks that have a single parents, this doesn't work on
muxes, since we will only consider the first parent, while other parents
may totally be able to provide a better combination.

Clocks in that case cannot use divider_round_rate, so would have to come up
with a very similar logic to work around it. Instead of having to do
something like this, and duplicate that logic everywhere, create a
divider_round_rate parent to allow caller to give an additional parameter
for the parent clock to consider.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk-divider.c    | 26 ++++++++++++++++++--------
 include/linux/clk-provider.h |  4 ++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 96386ffc8483..48750439b1cd 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -275,7 +275,8 @@ static int _next_div(const struct clk_div_table *table, int div,
 	return div;
 }
 
-static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
+			       unsigned long rate,
 			       unsigned long *best_parent_rate,
 			       const struct clk_div_table *table, u8 width,
 			       unsigned long flags)
@@ -314,8 +315,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 			*best_parent_rate = parent_rate_saved;
 			return i;
 		}
-		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
-					       rate * i);
+		parent_rate = clk_hw_round_rate(parent, rate * i);
 		now = DIV_ROUND_UP_ULL((u64)parent_rate, i);
 		if (_is_best_div(rate, now, best, flags)) {
 			bestdiv = i;
@@ -326,22 +326,32 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 
 	if (!bestdiv) {
 		bestdiv = _get_maxdiv(table, width, flags);
-		*best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
+		*best_parent_rate = clk_hw_round_rate(parent, 1);
 	}
 
 	return bestdiv;
 }
 
-long divider_round_rate(struct clk_hw *hw, unsigned long rate,
-			unsigned long *prate, const struct clk_div_table *table,
-			u8 width, unsigned long flags)
+long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+			       unsigned long rate, unsigned long *prate,
+			       const struct clk_div_table *table,
+			       u8 width, unsigned long flags)
 {
 	int div;
 
-	div = clk_divider_bestdiv(hw, rate, prate, table, width, flags);
+	div = clk_divider_bestdiv(hw, parent, rate, prate, table, width, flags);
 
 	return DIV_ROUND_UP_ULL((u64)*prate, div);
 }
+EXPORT_SYMBOL_GPL(divider_round_rate_parent);
+
+long divider_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *prate, const struct clk_div_table *table,
+			u8 width, unsigned long flags)
+{
+	return divider_round_rate_parent(hw, clk_hw_get_parent(hw), rate, prate,
+					 table, width, flags);
+}
 EXPORT_SYMBOL_GPL(divider_round_rate);
 
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a428aec36ace..14102f783f64 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -412,6 +412,10 @@ extern const struct clk_ops clk_divider_ro_ops;
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
 		unsigned int val, const struct clk_div_table *table,
 		unsigned long flags);
+long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+			       unsigned long rate, unsigned long *prate,
+			       const struct clk_div_table *table,
+			       u8 width, unsigned long flags);
 long divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long *prate, const struct clk_div_table *table,
 		u8 width, unsigned long flags);
-- 
git-series 0.8.11
