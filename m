From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:15 +0800
Subject: [PATCH RFC 7/7] clk: imx: clk-busy: convert to set_rate_hw and
 set_parent_hw
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-8-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to prepare_hw and set_rate_hw and let the clk core
to handle the polling process automatically.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-busy.c | 52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 5cc99590f9a3..5af622fc726b 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -18,17 +18,6 @@
 #include <linux/err.h>
 #include "clk.h"
 
-static int clk_busy_wait(void __iomem *reg, u8 shift)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
-
-	while (readl_relaxed(reg) & (1 << shift))
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-
-	return 0;
-}
-
 struct clk_busy_divider {
 	struct clk_divider div;
 	const struct clk_ops *div_ops;
@@ -36,6 +25,11 @@ struct clk_busy_divider {
 	u8 shift;
 };
 
+static int clk_is_busy(void __iomem *reg, u8 shift)
+{
+	return readl_relaxed(reg) & (1 << shift);
+}
+
 static inline struct clk_busy_divider *to_clk_busy_divider(struct clk_hw *hw)
 {
 	struct clk_divider *div = to_clk_divider(hw);
@@ -59,23 +53,26 @@ static long clk_busy_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	return busy->div_ops->round_rate(&busy->div.hw, rate, prate);
 }
 
-static int clk_busy_divider_set_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long parent_rate)
+static int clk_busy_divider_set_rate_hw_done(struct clk_hw *hw)
 {
 	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
-	int ret;
 
-	ret = busy->div_ops->set_rate(&busy->div.hw, rate, parent_rate);
-	if (!ret)
-		ret = clk_busy_wait(busy->reg, busy->shift);
+	return !clk_is_busy(busy->reg, busy->shift);
+}
+
+static int clk_busy_divider_set_rate_hw(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
 
-	return ret;
+	return busy->div_ops->set_rate(&busy->div.hw, rate, parent_rate);
 }
 
 static struct clk_ops clk_busy_divider_ops = {
 	.recalc_rate = clk_busy_divider_recalc_rate,
 	.round_rate = clk_busy_divider_round_rate,
-	.set_rate = clk_busy_divider_set_rate,
+	.set_rate_hw = clk_busy_divider_set_rate_hw,
+	.set_rate_done = clk_busy_divider_set_rate_hw_done,
 };
 
 struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
@@ -135,21 +132,24 @@ static u8 clk_busy_mux_get_parent(struct clk_hw *hw)
 	return busy->mux_ops->get_parent(&busy->mux.hw);
 }
 
-static int clk_busy_mux_set_parent(struct clk_hw *hw, u8 index)
+static int clk_busy_mux_set_parent_done(struct clk_hw *hw)
 {
 	struct clk_busy_mux *busy = to_clk_busy_mux(hw);
-	int ret;
 
-	ret = busy->mux_ops->set_parent(&busy->mux.hw, index);
-	if (!ret)
-		ret = clk_busy_wait(busy->reg, busy->shift);
+	return !clk_is_busy(busy->reg, busy->shift);
+}
+
+static int clk_busy_mux_set_parent_hw(struct clk_hw *hw, u8 index)
+{
+	struct clk_busy_mux *busy = to_clk_busy_mux(hw);
 
-	return ret;
+	return busy->mux_ops->set_parent(&busy->mux.hw, index);
 }
 
 static struct clk_ops clk_busy_mux_ops = {
 	.get_parent = clk_busy_mux_get_parent,
-	.set_parent = clk_busy_mux_set_parent,
+	.set_parent_hw = clk_busy_mux_set_parent_hw,
+	.set_parent_done = clk_busy_mux_set_parent_done,
 };
 
 struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
-- 
1.9.1
