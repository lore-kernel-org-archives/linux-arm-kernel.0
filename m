From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:20 +0800
Subject: [PATCH 01/11] clk: sunxi-ng: mux: Fix determine_rate for mux clocks
 with pre-dividers
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The determine_rate helper used ccu_mux_helper_adjust_parent_for_prediv()
to adjust the parent_rate to account for pre-dividers, but then passed
the pristine parent clock rate from clk_hw_get_rate() to the round()
callback, thereby ignoring the pre-divider adjustment. In addition,
it was saving the adjusted parent rate back into struct
clk_rate_request.

This patch fixes this by saving the pristine parent clock rate, and
adding a copy that is adjusted and passed to the round() callback.
The pristine copy, if it is the best solution, would be saved back
to struct clk_rate_request.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 858a48621631..3445041894e7 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -71,7 +71,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 	unsigned int i;
 
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
-		unsigned long tmp_rate, parent_rate;
+		unsigned long tmp_rate, parent_rate, adj_parent_rate;
 		struct clk_hw *parent;
 
 		parent = clk_hw_get_parent_by_index(hw, i);
@@ -79,10 +79,11 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 			continue;
 
 		parent_rate = clk_hw_get_rate(parent);
+		adj_parent_rate = parent_rate;
 		ccu_mux_helper_adjust_parent_for_prediv(common, cm, i,
-							&parent_rate);
+							&adj_parent_rate);
 
-		tmp_rate = round(cm, clk_hw_get_rate(parent), req->rate, data);
+		tmp_rate = round(cm, parent_rate, req->rate, data);
 		if (tmp_rate == req->rate) {
 			best_parent = parent;
 			best_parent_rate = parent_rate;
-- 
2.11.0
