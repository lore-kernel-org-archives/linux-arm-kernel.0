From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:35 +0200
Subject: [PATCH v3 06/21] clk: sunxi-ng: mux: Change pre-divider application
 function prototype
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2e0b7726cd92e0123c0ffdc6d8f8266ebcb7e160.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current function name is a bit confusing, and doesn't really allow to
create an explicit function to reverse the operation.

We also for now change the parent rate through a pointer, while we don't
return anything.

In order to be less confusing, and easier to use for downstream users,
change the function name to something hopefully clearer, and return the
adjusted rate instead of changing the pointer.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_div.c  |  8 ++++----
 drivers/clk/sunxi-ng/ccu_mp.c   |  8 ++++----
 drivers/clk/sunxi-ng/ccu_mult.c |  8 ++++----
 drivers/clk/sunxi-ng/ccu_mux.c  | 29 ++++++++++++-----------------
 drivers/clk/sunxi-ng/ccu_mux.h  |  8 ++++----
 5 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 419463375bc1..c0e5c10d0091 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -59,8 +59,8 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	val = reg >> cd->div.shift;
 	val &= (1 << cd->div.width) - 1;
 
-	ccu_mux_helper_adjust_parent_for_prediv(&cd->common, &cd->mux, -1,
-						&parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
+						  parent_rate);
 
 	return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
 				   cd->div.flags);
@@ -83,8 +83,8 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long val;
 	u32 reg;
 
-	ccu_mux_helper_adjust_parent_for_prediv(&cd->common, &cd->mux, -1,
-						&parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
+						  parent_rate);
 
 	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
 			      cd->div.flags);
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index de02e6c386d8..b917ad7a386c 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -87,8 +87,8 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
 	u32 reg;
 
 	/* Adjust parent_rate according to pre-dividers */
-	ccu_mux_helper_adjust_parent_for_prediv(&cmp->common, &cmp->mux,
-						-1, &parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cmp->common, &cmp->mux, -1,
+						  parent_rate);
 
 	reg = readl(cmp->common.base + cmp->common.reg);
 
@@ -123,8 +123,8 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 reg;
 
 	/* Adjust parent_rate according to pre-dividers */
-	ccu_mux_helper_adjust_parent_for_prediv(&cmp->common, &cmp->mux,
-						-1, &parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cmp->common, &cmp->mux, -1,
+						  parent_rate);
 
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 6ee7ba0738fb..20d0300867f2 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -88,8 +88,8 @@ static unsigned long ccu_mult_recalc_rate(struct clk_hw *hw,
 	val = reg >> cm->mult.shift;
 	val &= (1 << cm->mult.width) - 1;
 
-	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
-						&parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cm->common, &cm->mux, -1,
+						  parent_rate);
 
 	return parent_rate * (val + cm->mult.offset);
 }
@@ -116,8 +116,8 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		ccu_frac_helper_disable(&cm->common, &cm->frac);
 
-	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
-						&parent_rate);
+	parent_rate = ccu_mux_helper_apply_prediv(&cm->common, &cm->mux, -1,
+						  parent_rate);
 
 	_cm.min = cm->mult.min;
 
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 3eb23d4e6534..c33210972581 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -56,13 +56,12 @@ static u16 ccu_mux_get_prediv(struct ccu_common *common,
 	return prediv;
 }
 
-void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
-					     struct ccu_mux_internal *cm,
-					     int parent_index,
-					     unsigned long *parent_rate)
+unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
+					  struct ccu_mux_internal *cm,
+					  int parent_index,
+					  unsigned long parent_rate)
 {
-	*parent_rate = *parent_rate / ccu_mux_get_prediv(common, cm,
-							 parent_index);
+	return parent_rate / ccu_mux_get_prediv(common, cm, parent_index);
 }
 
 int ccu_mux_helper_determine_rate(struct ccu_common *common,
@@ -84,10 +83,8 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 
 		best_parent = clk_hw_get_parent(hw);
 		best_parent_rate = clk_hw_get_rate(best_parent);
-
-		adj_parent_rate = best_parent_rate;
-		ccu_mux_helper_adjust_parent_for_prediv(common, cm, -1,
-							&adj_parent_rate);
+		adj_parent_rate = ccu_mux_helper_apply_prediv(common, cm, -1,
+							      best_parent_rate);
 
 		best_rate = round(cm, best_parent, &adj_parent_rate,
 				  req->rate, data);
@@ -103,9 +100,9 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		if (!parent)
 			continue;
 
-		adj_parent_rate = parent_rate = clk_hw_get_rate(parent);
-		ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
-							&adj_parent_rate);
+		parent_rate = clk_hw_get_rate(parent);
+		adj_parent_rate = ccu_mux_helper_apply_prediv(common, cm, i,
+							      parent_rate);
 
 		tmp_rate = round(cm, parent, &adj_parent_rate, req->rate, data);
 		if (tmp_rate == req->rate) {
@@ -215,10 +212,8 @@ static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
 {
 	struct ccu_mux *cm = hw_to_ccu_mux(hw);
 
-	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
-						&parent_rate);
-
-	return parent_rate;
+	return ccu_mux_helper_apply_prediv(&cm->common, &cm->mux, -1,
+					   parent_rate);
 }
 
 const struct clk_ops ccu_mux_ops = {
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 4be56eee2bfd..dba12c76cf54 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -78,10 +78,10 @@ static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
 
 extern const struct clk_ops ccu_mux_ops;
 
-void ccu_mux_helper_adjust_parent_for_prediv(struct ccu_common *common,
-					     struct ccu_mux_internal *cm,
-					     int parent_index,
-					     unsigned long *parent_rate);
+unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
+					  struct ccu_mux_internal *cm,
+					  int parent_index,
+					  unsigned long parent_rate);
 int ccu_mux_helper_determine_rate(struct ccu_common *common,
 				  struct ccu_mux_internal *cm,
 				  struct clk_rate_request *req,
-- 
git-series 0.9.1
