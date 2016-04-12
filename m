From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Tue, 12 Apr 2016 16:43:39 +0800
Subject: [PATCH v2] clk: Add clk_composite_set_rate_and_parent
In-Reply-To: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
References: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1460450619-1118-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

When changing the clock-rate, currently a new parent is set first and a
divider adapted thereafter. This may result in the clock-rate overflowing
its target rate for a short time if the new parent has a higher rate than
the old parent.

While this often doesn't produce negative effects, it can affect components
in a voltage-scaling environment, like the GPU on the rk3399 socs, where
the voltage than simply is to low for the temporarily to high clock rate.

For general clock hirarchies this may need more extensive adaptions to
the common clock-framework, but at least for composite clocks having
both parent and rate settings it is easy to create a short-term solution to
make sure the clock-rate does not overflow the target.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
v1->v2:
- change the commit message

 drivers/clk/clk-composite.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 1f903e1f8..4d4b5ab 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -151,6 +151,33 @@ static int clk_composite_set_rate(struct clk_hw *hw, unsigned long rate,
 	return rate_ops->set_rate(rate_hw, rate, parent_rate);
 }
 
+static int clk_composite_set_rate_and_parent(struct clk_hw *hw,
+					     unsigned long rate,
+					     unsigned long parent_rate,
+					     u8 index)
+{
+	struct clk_composite *composite = to_clk_composite(hw);
+	const struct clk_ops *rate_ops = composite->rate_ops;
+	const struct clk_ops *mux_ops = composite->mux_ops;
+	struct clk_hw *rate_hw = composite->rate_hw;
+	struct clk_hw *mux_hw = composite->mux_hw;
+	unsigned long temp_rate;
+
+	__clk_hw_set_clk(rate_hw, hw);
+	__clk_hw_set_clk(mux_hw, hw);
+
+	temp_rate = rate_ops->recalc_rate(rate_hw, parent_rate);
+	if (temp_rate > rate) {
+		rate_ops->set_rate(rate_hw, rate, parent_rate);
+		mux_ops->set_parent(mux_hw, index);
+	} else {
+		mux_ops->set_parent(mux_hw, index);
+		rate_ops->set_rate(rate_hw, rate, parent_rate);
+	}
+
+	return 0;
+}
+
 static int clk_composite_is_enabled(struct clk_hw *hw)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
@@ -250,6 +277,12 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		composite->rate_ops = rate_ops;
 	}
 
+	if (mux_hw && mux_ops && rate_hw && rate_ops) {
+		if (mux_ops->set_parent && rate_ops->set_rate)
+			clk_composite_ops->set_rate_and_parent =
+			clk_composite_set_rate_and_parent;
+	}
+
 	if (gate_hw && gate_ops) {
 		if (!gate_ops->is_enabled || !gate_ops->enable ||
 		    !gate_ops->disable) {
-- 
1.9.1
