From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 14:59:12 +0800
Subject: [PATCH v2 06/13] drm/sun4i: hdmi: Allow using second PLL as TMDS clk
 parent
In-Reply-To: <20170926065919.24446-1-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
Message-ID: <20170926065919.24446-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs typically have two PLLs reserved for video related usage.
At the moment we only support using the first one to feed the HDMI
transmitter block's TMDS clock.

Let the HDMI encoder's TMDS clock go through all of its parents when
calculating possible clock rates. This allows usage of the second video
PLL as its parent.

Note that this does not handle conflicting pixel clocks. It is entirely
possible to have an LCD panel use one pixel clock rate, only to be
overridden by the HDMI transmitter's clock rate request when the second
display pipeline is enabled.

This should be handled by having all the clock drivers honor clock rate
ranges, and have the consumers use clk_set_rate_min/clk_set_rate_max.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 53 ++++++++++++++++-------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 5cf2527bffc8..e8d4c311b80d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -67,11 +67,11 @@ static unsigned long sun4i_tmds_calc_divider(unsigned long rate,
 static int sun4i_tmds_determine_rate(struct clk_hw *hw,
 				     struct clk_rate_request *req)
 {
-	struct clk_hw *parent;
+	struct clk_hw *parent = NULL;
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
2.14.1
