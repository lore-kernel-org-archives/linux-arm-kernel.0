From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 22 Mar 2013 15:43:51 +0000
Subject: [RFC PATCH v1 3/3] clk: clk-mux: implement remuxing
In-Reply-To: <1363967031-22781-1-git-send-email-james.hogan@imgtec.com>
References: <1363967031-22781-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <1363967031-22781-4-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement clk-mux remuxing if the CLK_SET_RATE_REMUX flag is set. This
implements round_rate for clk-mux to propagate the round_rate to each
parent and to choose the best one.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/clk/clk-mux.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 508c032..20b3f0b 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -82,9 +82,56 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+/* Return index of parent that provides best clock rate */
+static int clk_mux_bestparent(struct clk *clk, unsigned long rate,
+			      unsigned long *best_parent_rate)
+{
+	int i, num_parents, bestparent = -1;
+	unsigned long parent_rate, best = 0;
+	struct clk *parent;
+
+	num_parents = __clk_get_num_parents(clk);
+	for (i = 0; i < num_parents; i++) {
+		parent = __clk_get_parent_by_index(clk, i);
+		if (!parent)
+			continue;
+		parent_rate = __clk_round_rate(parent, rate);
+		if (parent_rate <= rate && parent_rate > best) {
+			bestparent = i;
+			best = parent_rate;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	return bestparent;
+}
+
+static long clk_mux_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate, u8 *best_parent)
+{
+	struct clk *clk = hw->clk;
+	unsigned long flags = __clk_get_flags(clk);
+	int parent;
+
+	/* never remux unless the flag is set */
+	if (!(flags & CLK_SET_RATE_REMUX)) {
+		if (flags & CLK_SET_RATE_PARENT)
+			return __clk_round_rate(__clk_get_parent(clk), rate);
+		else
+			return __clk_get_rate(clk);
+	}
+
+	parent = clk_mux_bestparent(clk, rate, prate);
+	if (best_parent && parent >= 0)
+		*best_parent = parent;
+
+	return *prate;
+}
+
 const struct clk_ops clk_mux_ops = {
 	.get_parent = clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
+	.round_rate = clk_mux_round_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
-- 
1.8.1.2
