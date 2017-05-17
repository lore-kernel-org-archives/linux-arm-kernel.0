From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:36 +0200
Subject: [PATCH v3 07/21] clk: sunxi-ng: mux: Re-adjust parent rate
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d7558de4acfd568ea9f3d185c9530c9b0c311bbc.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the parent rate given back to the clock framework in our
request is the original parent rate we calculated before trying to round
the rate of our clock.

This works fine unless our clock also changes its parent rate, in which
case we will simply ignore that change and still use the previous parent
rate.

Create a new function to re-adjust the parent rate to take the pre-dividers
into account, and give that back to the clock framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index c33210972581..748b172f9193 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -64,6 +64,14 @@ unsigned long ccu_mux_helper_apply_prediv(struct ccu_common *common,
 	return parent_rate / ccu_mux_get_prediv(common, cm, parent_index);
 }
 
+unsigned long ccu_mux_helper_unapply_prediv(struct ccu_common *common,
+					    struct ccu_mux_internal *cm,
+					    int parent_index,
+					    unsigned long parent_rate)
+{
+	return parent_rate * ccu_mux_get_prediv(common, cm, parent_index);
+}
+
 int ccu_mux_helper_determine_rate(struct ccu_common *common,
 				  struct ccu_mux_internal *cm,
 				  struct clk_rate_request *req,
@@ -89,22 +97,37 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 		best_rate = round(cm, best_parent, &adj_parent_rate,
 				  req->rate, data);
 
+		/*
+		 * adj_parent_rate might have been modified by our clock.
+		 * Unapply the pre-divider if there's one, and give
+		 * the actual frequency the parent needs to run at.
+		 */
+		best_parent_rate = ccu_mux_helper_unapply_prediv(common, cm, -1,
+								 adj_parent_rate);
+
 		goto out;
 	}
 
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
-		unsigned long tmp_rate, parent_rate, adj_parent_rate;
+		unsigned long tmp_rate, parent_rate;
 		struct clk_hw *parent;
 
 		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
 
-		parent_rate = clk_hw_get_rate(parent);
-		adj_parent_rate = ccu_mux_helper_apply_prediv(common, cm, i,
-							      parent_rate);
+		parent_rate = ccu_mux_helper_apply_prediv(common, cm, i,
+							  clk_hw_get_rate(parent));
+
+		tmp_rate = round(cm, parent, &parent_rate, req->rate, data);
 
-		tmp_rate = round(cm, parent, &adj_parent_rate, req->rate, data);
+		/*
+		 * parent_rate might have been modified by our clock.
+		 * Unapply the pre-divider if there's one, and give
+		 * the actual frequency the parent needs to run at.
+		 */
+		parent_rate = ccu_mux_helper_unapply_prediv(common, cm, i,
+							    parent_rate);
 		if (tmp_rate == req->rate) {
 			best_parent = parent;
 			best_parent_rate = parent_rate;
-- 
git-series 0.9.1
