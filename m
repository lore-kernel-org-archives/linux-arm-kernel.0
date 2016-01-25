From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:43 +0800
Subject: [PATCH RFC 07/11] clk: sunxi: factors: Support custom formulas
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks cannot be modelled using the standard factors clk formula,
such as clocks with special pre-dividers on one parent, or clocks
with all power-of-two dividers.

Add support for a custom .recalc callback for factors clk. Also pass
the current parent index to the .get_factor and .recalc callbacks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c | 30 ++++++++++++++++++++++++++++--
 drivers/clk/sunxi/clk-factors.h |  3 +++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 47b7d918b74c..ac259305d5d5 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -63,6 +63,26 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 	if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
 		p = FACTOR_GET(config->pshift, config->pwidth, reg);
 
+	if (factors->recalc) {
+		struct factors_request factors_req = {
+			.parent_rate = parent_rate,
+			.n = n,
+			.k = k,
+			.m = m,
+			.p = p,
+		};
+
+		/* get mux details from mux clk structure */
+		if (factors->mux)
+			factors_req.parent_index =
+				(reg >> factors->mux->shift) &
+				factors->mux->mask;
+
+		factors->recalc(&factors_req);
+
+		return factors_req.rate;
+	}
+
 	/* Calculate the rate */
 	rate = (parent_rate * (n + config->n_start) * (k + 1) >> p) / (m + 1);
 
@@ -87,6 +107,7 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 static int clk_factors_determine_rate(struct clk_hw *hw,
 				      struct clk_rate_request *req)
 {
+	struct clk_factors *factors = to_clk_factors(hw);
 	struct clk_hw *parent, *best_parent = NULL;
 	int i, num_parents;
 	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
@@ -94,6 +115,10 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
 	/* find the parent that can help provide the fastest rate <= rate */
 	num_parents = clk_hw_get_num_parents(hw);
 	for (i = 0; i < num_parents; i++) {
+		struct factors_request factors_req = {
+			.rate = req->rate,
+			.parent_index = i,
+		};
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
@@ -102,8 +127,9 @@ static int clk_factors_determine_rate(struct clk_hw *hw,
 		else
 			parent_rate = clk_hw_get_rate(parent);
 
-		child_rate = clk_factors_round_rate(hw, req->rate,
-						    &parent_rate);
+		factors_req.parent_rate = parent_rate;
+		factors->get_factors(&factors_req);
+		child_rate = factors_req.rate;
 
 		if (child_rate <= req->rate && child_rate > best_child_rate) {
 			best_parent = parent;
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index f09d7c214533..a44a865a6b9e 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -22,6 +22,7 @@ struct clk_factors_config {
 struct factors_request {
 	unsigned long rate;
 	unsigned long parent_rate;
+	u8 parent_index;
 	u8 n;
 	u8 k;
 	u8 m;
@@ -34,6 +35,7 @@ struct factors_data {
 	int muxmask;
 	const struct clk_factors_config *table;
 	void (*getter)(struct factors_request *req);
+	void (*recalc)(struct factors_request *req);
 	const char *name;
 };
 
@@ -42,6 +44,7 @@ struct clk_factors {
 	void __iomem *reg;
 	const struct clk_factors_config *config;
 	void (*get_factors)(struct factors_request *req);
+	void (*recalc)(struct factors_request *req);
 	spinlock_t *lock;
 	/* for cleanup */
 	struct clk_mux *mux;
-- 
2.7.0
