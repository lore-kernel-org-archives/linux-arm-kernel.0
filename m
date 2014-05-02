From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:15 +0200
Subject: [PATCH v10 01/15] clk: sunxi: factors: automatic reparenting support
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit implements .determine_rate, so that our factor clocks can be
reparented when needed.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-factors.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 9e23264..3806d97 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -77,6 +77,41 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 	return rate;
 }
 
+static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *best_parent_rate,
+				       struct clk **best_parent_p)
+{
+	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
+	int i, num_parents;
+	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
+
+	/* find the parent that can help provide the fastest rate <= rate */
+	num_parents = __clk_get_num_parents(clk);
+	for (i = 0; i < num_parents; i++) {
+		parent = clk_get_parent_by_index(clk, i);
+		if (!parent)
+			continue;
+		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
+			parent_rate = __clk_round_rate(parent, rate);
+		else
+			parent_rate = __clk_get_rate(parent);
+
+		child_rate = clk_factors_round_rate(hw, rate, &parent_rate);
+
+		if (child_rate <= rate && child_rate > best_child_rate) {
+			best_parent = parent;
+			best = parent_rate;
+			best_child_rate = child_rate;
+		}
+	}
+
+	if (best_parent)
+		*best_parent_p = best_parent;
+	*best_parent_rate = best;
+
+	return best_child_rate;
+}
+
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -113,6 +148,7 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_factors_ops = {
+	.determine_rate = clk_factors_determine_rate,
 	.recalc_rate = clk_factors_recalc_rate,
 	.round_rate = clk_factors_round_rate,
 	.set_rate = clk_factors_set_rate,
-- 
1.9.0
