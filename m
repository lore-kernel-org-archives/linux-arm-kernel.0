From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Mon, 11 Apr 2016 09:54:12 +0800
Subject: [PATCH v1] clk: Add clk_composite_set_rate_and_parent
Message-ID: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Some of Rockchip's clocks should consider the priority of .set_parent
and .set_rate to prevent a too large temporary clock rate.

For example, the gpu clock can be parented to cpll(750MHz) and
usbphy_480m(480MHz), 375MHz comes from cpll and the div is set
to 2, 480MHz comes from usbphy_480m and the div is set to 1.

>From the code, when change rate from 480MHz to 375MHz, it changes
the gpu's parent from USBPHY_480M to cpll first(.set_parent), but the
div value is still 1 and the gpu's rate will be 750MHz at the moment,
then it changes the div value from 1 to 2(.set_rate) and the gpu's
rate will be changed to 375MHz(480MHZ->750MHz->375MHz), here temporary
rate is 750MHz, the voltage which supply for 480MHz certainly can not
supply for 750MHz, so the gpu will crash.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
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
