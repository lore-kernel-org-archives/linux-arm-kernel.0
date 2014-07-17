From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 11:08:42 +0200
Subject: [PATCH 02/14] clk: sunxi: factors: Implement clock min and max
 frequencies
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1405588134-2396-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the A13, the out of reset frequency for the PLL6 is too high to be actually
working.

Hence, we need to be able to lower down its frequency whenever we need to use
the clock to some acceptable frequency.

This patch adds two new properties in the clock-nodes, clk-min-frequency and
clk-max-frequency, to specify acceptable boundaries for proper clock
operations.

It also adds supports in the sunxi factor clocks driver to use these
boundaries, enforce them at prepare time to make sure that the drivers will
have a decent frequency, even though it never called set_rate, but also make
sure we never cross these boundaries.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-factors.c | 28 ++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-factors.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 2057c8ac648f..f8f45a7ffcd7 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -39,6 +39,25 @@
 #define FACTOR_SET(bit, len, reg, val) \
 	(((reg) & CLRMASK(len, bit)) | (val << (bit)))
 
+static int clk_factors_prepare(struct clk_hw *hw)
+{
+	struct clk_factors *factors = to_clk_factors(hw);
+	unsigned long rate = __clk_get_rate(hw->clk);
+	unsigned long new_rate;
+
+	if (factors->min_rate && (rate < factors->min_rate))
+		new_rate = factors->min_rate;
+	else if (factors->max_rate && (rate > factors->max_rate))
+		new_rate = factors->max_rate;
+	else
+		return 0;
+
+	pr_info("Initial rate of %s out of boundaries.. Changing rate from %lu to %lu\n",
+		__clk_get_name(hw->clk), rate, new_rate);
+
+	return clk_set_rate(hw->clk, rate);
+}
+
 static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
@@ -74,6 +93,11 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 	factors->get_factors((u32 *)&rate, (u32)*parent_rate,
 			     NULL, NULL, NULL, NULL);
 
+	if (factors->max_rate && (rate > factors->max_rate))
+		rate = factors->max_rate;
+	else if (factors->min_rate && (rate < factors->min_rate))
+		rate = factors->min_rate;
+
 	return rate;
 }
 
@@ -123,6 +147,9 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &p);
 
+	if ((rate > factors->max_rate) || (rate < factors->min_rate))
+		return -EINVAL;
+
 	if (factors->lock)
 		spin_lock_irqsave(factors->lock, flags);
 
@@ -149,6 +176,7 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_factors_ops = {
 	.determine_rate = clk_factors_determine_rate,
+	.prepare = clk_factors_prepare,
 	.recalc_rate = clk_factors_recalc_rate,
 	.round_rate = clk_factors_round_rate,
 	.set_rate = clk_factors_set_rate,
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index d2d0efa39379..2b8579a24039 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -24,6 +24,8 @@ struct clk_factors {
 	struct clk_factors_config *config;
 	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
 	spinlock_t *lock;
+	unsigned long max_rate;
+	unsigned long min_rate;
 };
 
 extern const struct clk_ops clk_factors_ops;
-- 
2.0.1
