From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:35 +0000
Subject: [RFC 4/9] clk: bcm2835: reorganize bcm2835_clock_determine_rate
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Reorganize bcm2835_clock_determine_rate so that the per
clock frequency calculation is separated from the
selection logic.

This allows for different clock selection policies
to be use while keeping code common.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   98 +++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 48c1ad0..f1ab525 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1668,44 +1668,86 @@ unlock_exit:
 	return 0;
 }
 
-static int bcm2835_clock_determine_rate(struct clk_hw *hw,
-		struct clk_rate_request *req)
+struct bcm2835_rates {
+	struct clk_hw *parent;
+	unsigned long rate;
+	unsigned long prate;
+	u32 div;
+	divmash dmash;
+};
+
+static int bcm2835_clock_determine_rate_set(struct clk_rate_request *req,
+					    struct bcm2835_rates *best)
 {
-	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
-	struct clk_hw *parent, *best_parent = NULL;
-	unsigned long rate, best_rate = 0;
-	unsigned long prate, best_prate = 0;
+	req->best_parent_hw = best->parent;
+	req->best_parent_rate = best->prate;
+	req->rate = best->rate;
+
+	return 0;
+}
+
+static int bcm2835_clock_determine_closest_rate(struct clk_hw *hw,
+						struct clk_rate_request *req,
+						struct bcm2835_rates *rates,
+						size_t rate_cnt)
+{
+	struct bcm2835_rates *best = NULL;
 	size_t i;
-	divmash dm;
-	u32 div;
 
-	/*
-	 * Select parent clock that results in the closest but lower rate
-	 */
-	for (i = 0; i < clk_hw_get_num_parents(hw); ++i) {
-		parent = clk_hw_get_parent_by_index(hw, i);
-		if (!parent)
+	/* find best matching */
+	for (i = 0; i < rate_cnt; i++) {
+		if (rates[i].rate > req->rate)
+			continue;
+		if (!best) {
+			best = &rates[i];
+			continue;
+		}
+		/* find the closest */
+		if (rates[i].rate > best->rate) {
+			best = &rates[i];
+			continue;
+		}
+		/* if identical then use highest divider */
+		if ((rates[i].rate == best->rate) &&
+		    (rates[i].div > best->div)) {
+			best = &rates[i];
 			continue;
-		prate = clk_hw_get_rate(parent);
-		dm = bcm2835_clock_choose_div(hw, req->rate, prate, true);
-		div = divmash_get_div(dm);
-		rate = bcm2835_clock_rate_from_divisor(clock, prate, div);
-		if (rate > best_rate && rate <= req->rate) {
-			best_parent = parent;
-			best_prate = prate;
-			best_rate = rate;
 		}
 	}
 
-	if (!best_parent)
-		return -EINVAL;
+	if (best)
+		return bcm2835_clock_determine_rate_set(req, best);
+
+	/* nothing found */
+	return -EINVAL;
+}
 
-	req->best_parent_hw = best_parent;
-	req->best_parent_rate = best_prate;
+static int bcm2835_clock_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_rates rates[BIT(CM_SRC_BITS)];
+	size_t i, rate_cnt = 0;
+	divmash dm;
 
-	req->rate = best_rate;
+	/* fill in rates */
+	for (i = 0; i < clk_hw_get_num_parents(hw); ++i) {
+		rates[rate_cnt].parent = clk_hw_get_parent_by_index(hw, i);
+		if (!rates[rate_cnt].parent)
+			continue;
+		rates[rate_cnt].prate = clk_hw_get_rate(
+			rates[rate_cnt].parent);
+		dm = bcm2835_clock_choose_div(
+			hw, req->rate, rates[rate_cnt].prate, true);
+		rates[rate_cnt].div =  divmash_get_div(dm);
+		rates[rate_cnt].rate = bcm2835_clock_rate_from_divisor(
+			clock, rates[rate_cnt].prate, rates[rate_cnt].div);
+		rate_cnt++;
+	}
 
-	return 0;
+	/* choose the "closest" one */
+	return bcm2835_clock_determine_closest_rate(hw, req, rates,
+						    rate_cnt);
 }
 
 static int _bcm2835_clk_set_parent(struct bcm2835_cprman *cprman,
-- 
1.7.10.4
