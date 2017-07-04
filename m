From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:23 +0200
Subject: [PATCH v2 5/9] clk: at91: clk-generated: create function to find
 best_diff
In-Reply-To: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704115927.32662-6-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way to find the best_diff and do the appropriate process afterwards
can be re-used.

This patch prepares the driver for an upcoming patch that will allow
clk_generated to determine the rate of the audio_pll.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/at91/clk-generated.c | 41 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index dab7002937e6..6530a2e7e84d 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -99,15 +99,36 @@ clk_generated_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, gck->gckdiv + 1);
 }
 
+static void clk_generated_best_diff(struct clk_rate_request *req,
+				    struct clk_hw *parent,
+				    unsigned long parent_rate, u32 div,
+				    int *best_diff, long *best_rate)
+{
+	unsigned long tmp_rate;
+	int tmp_diff;
+
+	if (!div)
+		tmp_rate = parent_rate;
+	else
+		tmp_rate = parent_rate / div;
+	tmp_diff = abs(req->rate - tmp_rate);
+
+	if (*best_diff < 0 || *best_diff > tmp_diff) {
+		*best_rate = tmp_rate;
+		*best_diff = tmp_diff;
+		req->best_parent_rate = parent_rate;
+		req->best_parent_hw = parent;
+	}
+}
+
 static int clk_generated_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
 	struct clk_hw *parent = NULL;
 	long best_rate = -EINVAL;
-	unsigned long tmp_rate, min_rate;
+	unsigned long min_rate;
 	int best_diff = -1;
-	int tmp_diff;
 	int i;
 
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
@@ -125,18 +146,10 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 			continue;
 
 		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
-		if (!div)
-			tmp_rate = parent_rate;
-		else
-			tmp_rate = parent_rate / div;
-		tmp_diff = abs(req->rate - tmp_rate);
-
-		if (best_diff < 0 || best_diff > tmp_diff) {
-			best_rate = tmp_rate;
-			best_diff = tmp_diff;
-			req->best_parent_rate = parent_rate;
-			req->best_parent_hw = parent;
-		}
+
+		clk_generated_best_diff(req, parent, parent_rate, div,
+					&best_diff, &best_rate);
+
 
 		if (!best_diff)
 			break;
-- 
2.11.0
