From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 23 Jun 2017 11:00:54 +0200
Subject: [PATCH 1/6] clk: at91: clk-generated: remove useless divisor loop
In-Reply-To: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
Message-ID: <20170623090059.8371-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver requests the current clk rate of each of its parent clocks to
decide whether a clock rate is suitable or not. It does not request
determine_rate from a parent clock which could request a rate change in
parent clock (i.e. there is no parent rate propagation).

We know the rate we want (passed along req argument of the function) and
the parent clock rate, thus we know the closest rounded divisor, we
don't need to iterate over the available divisors to find the best one
for a given clock.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 07c8f701e51c..dab7002937e6 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -124,19 +124,18 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 		    (gck->range.max && min_rate > gck->range.max))
 			continue;
 
-		for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
-			tmp_rate = DIV_ROUND_CLOSEST(parent_rate, div);
-			tmp_diff = abs(req->rate - tmp_rate);
-
-			if (best_diff < 0 || best_diff > tmp_diff) {
-				best_rate = tmp_rate;
-				best_diff = tmp_diff;
-				req->best_parent_rate = parent_rate;
-				req->best_parent_hw = parent;
-			}
-
-			if (!best_diff || tmp_rate < req->rate)
-				break;
+		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
+		if (!div)
+			tmp_rate = parent_rate;
+		else
+			tmp_rate = parent_rate / div;
+		tmp_diff = abs(req->rate - tmp_rate);
+
+		if (best_diff < 0 || best_diff > tmp_diff) {
+			best_rate = tmp_rate;
+			best_diff = tmp_diff;
+			req->best_parent_rate = parent_rate;
+			req->best_parent_hw = parent;
 		}
 
 		if (!best_diff)
-- 
2.11.0
