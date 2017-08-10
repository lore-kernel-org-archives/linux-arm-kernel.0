From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu, 10 Aug 2017 08:34:01 +0200
Subject: [PATCH v5 1/7] clk: at91: clk-generated: remove useless divisor loop
In-Reply-To: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <fe26a470c87e39b5e07fbada6ce7020a6b65429b.1502346448.git-series.quentin.schulz@free-electrons.com>
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
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/clk/at91/clk-generated.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index f0b7ae9..ef4b4e0 100644
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
git-series 0.9.1
