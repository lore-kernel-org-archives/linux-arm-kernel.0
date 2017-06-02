From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:10 +0800
Subject: [PATCH 05/19] drm/sun4i: hdmi: Allow using second PLL as TMDS clk
 parent
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SoCs with two display pipelines, it is possible that the two
pipelines are active at the same time, with potentially incompatible
dot clocks.

Let the HDMI encoder's TMDS clock go through all of its parents when
calculating possible clock rates. This allows usage of the second video
PLL as its parent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 51 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 5cf2527bffc8..5692e41833ae 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -71,7 +71,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 	unsigned long best_parent = 0;
 	unsigned long rate = req->rate;
 	int best_div = 1, best_half = 1;
-	int i, j;
+	int i, j, p;
 
 	/*
 	 * We only consider PLL3, since the TCON is very likely to be
@@ -79,32 +79,37 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 	 * clock, so we should not need to do anything.
 	 */
 
-	parent = clk_hw_get_parent_by_index(hw, 0);
-	if (!parent)
-		return -EINVAL;
-
-	for (i = 1; i < 3; i++) {
-		for (j = 1; j < 16; j++) {
-			unsigned long ideal = rate * i * j;
-			unsigned long rounded;
-
-			rounded = clk_hw_round_rate(parent, ideal);
-
-			if (rounded == ideal) {
-				best_parent = rounded;
-				best_half = i;
-				best_div = j;
-				goto out;
-			}
-
-			if (abs(rate - rounded / i) <
-			    abs(rate - best_parent / best_div)) {
-				best_parent = rounded;
-				best_div = i;
+	for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
+		parent = clk_hw_get_parent_by_index(hw, p);
+		if (!parent)
+			continue;
+
+		for (i = 1; i < 3; i++) {
+			for (j = 1; j < 16; j++) {
+				unsigned long ideal = rate * i * j;
+				unsigned long rounded;
+
+				rounded = clk_hw_round_rate(parent, ideal);
+
+				if (rounded == ideal) {
+					best_parent = rounded;
+					best_half = i;
+					best_div = j;
+					goto out;
+				}
+
+				if (abs(rate - rounded / i) <
+				    abs(rate - best_parent / best_div)) {
+					best_parent = rounded;
+					best_div = i;
+				}
 			}
 		}
 	}
 
+	if (!parent)
+		return -EINVAL;
+
 out:
 	req->rate = best_parent / best_half / best_div;
 	req->best_parent_rate = best_parent;
-- 
2.11.0
