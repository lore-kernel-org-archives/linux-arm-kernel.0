From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 29 Jan 2014 17:24:08 +0100
Subject: [PATCH 3/3] clk: divider: Optimize clk_divider_bestdiv loop
In-Reply-To: <1391012648-12481-1-git-send-email-maxime.coquelin@st.com>
References: <1391012648-12481-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1391012648-12481-4-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the for-loop used to try all the different dividers to find the
one that best fit tries all the values from 1 to max_div, incrementing by one.
In case of power-of-two, or table based divider, the loop isn't optimal.

Instead of incrementing by one, this patch provides directly the next divider.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/clk/clk-divider.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 1eaa5d8..4aabf4f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -240,6 +240,18 @@ static bool _is_best_div(struct clk_divider *divider,
 	return now <= rate && now > best;
 }
 
+static int _next_div(struct clk_divider *divider, int div)
+{
+	div++;
+
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return __roundup_pow_of_two(div);
+	if (divider->table)
+		return _round_up_table(divider->table, div);
+
+	return div;
+}
+
 static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 		unsigned long *best_parent_rate)
 {
@@ -267,7 +279,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 	 */
 	maxdiv = min(ULONG_MAX / rate, maxdiv);
 
-	for (i = 1; i <= maxdiv; i++) {
+	for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
 		if (!_is_valid_div(divider, i))
 			continue;
 		if (rate * i == parent_rate_saved) {
-- 
1.7.9.5
