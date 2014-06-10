From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 10 Jun 2014 09:27:39 +0800
Subject: [PATCH 03/12] clk: mmp: add init callback for clk-frac
In-Reply-To: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
References: <1402363668-25806-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1402363668-25806-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

For the clk-frac, if it has table, we need to make
sure that the initial clock rate is one item of the
table.
If it is not, we use the first item in the table by default.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index e29d006..1876d2c 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -118,10 +118,50 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long drate,
 	return 0;
 }
 
+void clk_factor_init(struct clk_hw *hw)
+{
+	struct mmp_clk_factor *factor = to_clk_factor(hw);
+	struct mmp_clk_factor_masks *masks = factor->masks;
+	u32 val, num, den;
+	int i;
+	unsigned long flags = 0;
+
+	if (factor->lock)
+		spin_lock_irqsave(factor->lock, flags);
+
+	val = readl(factor->base);
+
+	/* calculate numerator */
+	num = (val >> masks->num_shift) & masks->num_mask;
+
+	/* calculate denominator */
+	den = (val >> masks->den_shift) & masks->den_mask;
+
+	for (i = 0; i < factor->ftbl_cnt; i++)
+		if (den == factor->ftbl[i].den && num == factor->ftbl[i].num)
+			break;
+
+	if (i >= factor->ftbl_cnt) {
+		val &= ~(masks->num_mask << masks->num_shift);
+		val |= (factor->ftbl[0].num & masks->num_mask) <<
+			masks->num_shift;
+
+		val &= ~(masks->den_mask << masks->den_shift);
+		val |= (factor->ftbl[0].den & masks->den_mask) <<
+			masks->den_shift;
+
+		writel(val, factor->base);
+	}
+
+	if (factor->lock)
+		spin_unlock_irqrestore(factor->lock, flags);
+}
+
 static struct clk_ops clk_factor_ops = {
 	.recalc_rate = clk_factor_recalc_rate,
 	.round_rate = clk_factor_round_rate,
 	.set_rate = clk_factor_set_rate,
+	.init = clk_factor_init,
 };
 
 struct clk *mmp_clk_register_factor(const char *name, const char *parent_name,
-- 
1.8.3.2
