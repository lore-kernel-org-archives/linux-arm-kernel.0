From: plaes@plaes.org (Priit Laes)
Date: Tue,  4 Jul 2017 23:04:56 +0300
Subject: [PATCH v5 1/6] clk: sunxi-ng: div: Add support for fixed post-divider
In-Reply-To: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
References: <cover.23e9103a2becf2261d7e145bb1516221a5cfb8a4.1499197129.git-series.plaes@plaes.org>
Message-ID: <805048a548031cafc890e6ea06ee773bdfb199d0.1499197129.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
6 is fixed post-divider.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu_div.c | 18 ++++++++++++++++--
 drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index c0e5c10..054b12a 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -21,6 +21,9 @@ static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
 {
 	struct ccu_div *cd = data;
 
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate /= cd->fixed_post_div;
+
 	return divider_round_rate_parent(&cd->common.hw, parent,
 					 rate, parent_rate,
 					 cd->div.table, cd->div.width,
@@ -62,8 +65,13 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
 						  parent_rate);
 
-	return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
-				   cd->div.flags);
+	val = divider_recalc_rate(hw, parent_rate, val, cd->div.table,
+				  cd->div.flags);
+
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		val /= cd->fixed_post_div;
+
+	return val;
 }
 
 static int ccu_div_determine_rate(struct clk_hw *hw,
@@ -71,6 +79,9 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
 {
 	struct ccu_div *cd = hw_to_ccu_div(hw);
 
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		req->rate *= cd->fixed_post_div;
+
 	return ccu_mux_helper_determine_rate(&cd->common, &cd->mux,
 					     req, ccu_div_round_rate, cd);
 }
@@ -89,6 +100,9 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
 			      cd->div.flags);
 
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		val /= cd->fixed_post_div;
+
 	spin_lock_irqsave(cd->common.lock, flags);
 
 	reg = readl(cd->common.base + cd->common.reg);
diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 08d0744..f3a5028 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -86,9 +86,10 @@ struct ccu_div_internal {
 struct ccu_div {
 	u32			enable;
 
-	struct ccu_div_internal		div;
+	struct ccu_div_internal	div;
 	struct ccu_mux_internal	mux;
 	struct ccu_common	common;
+	unsigned int		fixed_post_div;
 };
 
 #define SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,	\
-- 
git-series 0.9.1
