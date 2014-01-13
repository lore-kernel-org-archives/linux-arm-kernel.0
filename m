From: damien.riegel.ext@parrot.com (Damien Riegel)
Date: Mon, 13 Jan 2014 10:03:30 +0100
Subject: [PATCH v2] clk: clk-divider: round divider to a valid value when
 a table is used
In-Reply-To: <1389277515-26444-1-git-send-email-damien.riegel.ext@parrot.com>
References: <1389277515-26444-1-git-send-email-damien.riegel.ext@parrot.com>
Message-ID: <52D3ABE2.10701@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_divider_bestdiv computes the bestdiv without taking into account if
it is a valid value when CLK_SET_RATE_PARENT is not set, and it may not
be if a table is used. round_rate then returns a rate that is not
reachable by the clock, leading to a set_rate that does nothing but
reports no error.
This patch makes round_rate return a valid rate.

Signed-off-by: Damien Riegel <damien.riegel.ext@parrot.com>
---
The previous version of this patch luckily worked with the clk_div_table
I had. It might return a divider that was less than the computed div. This
patch should now work in every case.
---
 drivers/clk/clk-divider.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e44fba..658afbc39964 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -144,6 +144,22 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
 	return true;
 }
 
+static int _round_to_valid_div(struct clk_divider *divider, int div, int maxdiv)
+{
+	const struct clk_div_table *clkt = divider->table;
+	int bestdiv = maxdiv;
+
+	if (!clkt)
+		return div;
+
+	for (; clkt->div; clkt++) {
+		if (clkt->div >= div && bestdiv > clkt->div)
+			bestdiv = clkt->div;
+	}
+
+	return bestdiv;
+}
+
 static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 		unsigned long *best_parent_rate)
 {
@@ -161,7 +177,8 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 		parent_rate = *best_parent_rate;
 		bestdiv = DIV_ROUND_UP(parent_rate, rate);
 		bestdiv = bestdiv == 0 ? 1 : bestdiv;
-		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
+		bestdiv = bestdiv > maxdiv ? maxdiv :
+			_round_to_valid_div(divider, bestdiv, maxdiv);
 		return bestdiv;
 	}
 
-- 
1.7.10.4
