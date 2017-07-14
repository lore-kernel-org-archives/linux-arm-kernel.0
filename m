From: plaes@plaes.org (Priit Laes)
Date: Fri, 14 Jul 2017 17:49:23 +0300
Subject: [PATCH v6 1/6] clk: sunxi-ng: div: Add support for fixed post-divider
In-Reply-To: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
References: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
Message-ID: <946794e97ae2c36cd67c272099e8236a589efc28.1500043741.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SATA clock on sun4i/sun7i is of type (parent) / M / 6 where
6 is fixed post-divider.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu_div.c | 15 +++++++++++++--
 drivers/clk/sunxi-ng/ccu_div.h |  3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index c0e5c10..744502a 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -21,6 +21,9 @@ static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
 {
 	struct ccu_div *cd = data;
 
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate *= cd->fixed_post_div;
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
@@ -86,6 +94,9 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	parent_rate = ccu_mux_helper_apply_prediv(&cd->common, &cd->mux, -1,
 						  parent_rate);
 
+	if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate *= cd->fixed_post_div;
+
 	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
 			      cd->div.flags);
 
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
