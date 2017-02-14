From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 11:35:23 +0800
Subject: [PATCH 2/5] clk: sunxi-ng: gate: Support common pre-dividers
In-Reply-To: <20170214033526.16977-1-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
Message-ID: <20170214033526.16977-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clock gates have a pre-divider between the source input and the
gate itself. A notable example is the HSIC 12 MHz clock found on the
A83T, which has the 24 MHz main oscillator as its input, and a /2
pre-divider.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_gate.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index 8a81f9d4a89f..cd069d5da215 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -75,8 +75,55 @@ static int ccu_gate_is_enabled(struct clk_hw *hw)
 	return ccu_gate_helper_is_enabled(&cg->common, cg->enable);
 }
 
+static unsigned long ccu_gate_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+	unsigned long rate = parent_rate;
+
+	if (cg->common.features & CCU_FEATURE_ALL_PREDIV)
+		rate /= cg->common.prediv;
+
+	return rate;
+}
+
+static long ccu_gate_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+	int div = 1;
+
+	if (cg->common.features & CCU_FEATURE_ALL_PREDIV)
+		div = cg->common.prediv;
+
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		unsigned long best_parent = rate;
+
+		if (cg->common.features & CCU_FEATURE_ALL_PREDIV)
+			best_parent *= div;
+		*prate = clk_hw_round_rate(clk_hw_get_parent(hw), best_parent);
+	}
+
+	return *prate / div;
+}
+
+static int ccu_gate_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	/*
+	 * We must report success but we can do so unconditionally because
+	 * clk_factor_round_rate returns values that ensure this call is a
+	 * nop.
+	 */
+
+	return 0;
+}
+
 const struct clk_ops ccu_gate_ops = {
 	.disable	= ccu_gate_disable,
 	.enable		= ccu_gate_enable,
 	.is_enabled	= ccu_gate_is_enabled,
+	.round_rate	= ccu_gate_round_rate,
+	.set_rate	= ccu_gate_set_rate,
+	.recalc_rate	= ccu_gate_recalc_rate,
 };
-- 
2.11.0
