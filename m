From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 12:00:41 -0700
Subject: [PATCH v1 4/4] clk: iproc: Minor tidy up of iproc pll data structures
In-Reply-To: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502737241-2040-5-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lori Hikichi <lhikichi@broadcom.com>

There were a few fields in the iproc pll data structures that were
holding information that was not true state information.
Using stack variables is sufficient and simplifies the structure.
There are not any functional changes in this commit.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 drivers/clk/bcm/clk-iproc-pll.c | 83 ++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index ab10819..43a58ae 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -69,16 +69,6 @@ enum vco_freq_range {
 	VCO_MAX       = 4000000000U,
 };
 
-struct iproc_pll;
-
-struct iproc_clk {
-	struct clk_hw hw;
-	const char *name;
-	struct iproc_pll *pll;
-	unsigned long rate;
-	const struct iproc_clk_ctrl *ctrl;
-};
-
 struct iproc_pll {
 	void __iomem *status_base;
 	void __iomem *control_base;
@@ -88,9 +78,12 @@ struct iproc_pll {
 	const struct iproc_pll_ctrl *ctrl;
 	const struct iproc_pll_vco_param *vco_param;
 	unsigned int num_vco_entries;
+};
 
-	struct clk_hw_onecell_data *clk_data;
-	struct iproc_clk *clks;
+struct iproc_clk {
+	struct clk_hw hw;
+	struct iproc_pll *pll;
+	const struct iproc_clk_ctrl *ctrl;
 };
 
 #define to_iproc_clk(hw) container_of(hw, struct iproc_clk, hw)
@@ -329,6 +322,7 @@ static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 	u32 val;
 	enum kp_band kp_index;
 	unsigned long ref_freq;
+	const char *clk_name = clk_hw_get_name(&clk->hw);
 
 	/*
 	 * reference frequency = parent frequency / PDIV
@@ -351,19 +345,19 @@ static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 		kp_index = KP_BAND_HIGH_HIGH;
 	} else {
 		pr_err("%s: pll: %s has invalid rate: %lu\n", __func__,
-				clk->name, rate);
+				clk_name, rate);
 		return -EINVAL;
 	}
 
 	kp = get_kp(ref_freq, kp_index);
 	if (kp < 0) {
-		pr_err("%s: pll: %s has invalid kp\n", __func__, clk->name);
+		pr_err("%s: pll: %s has invalid kp\n", __func__, clk_name);
 		return kp;
 	}
 
 	ret = __pll_enable(pll);
 	if (ret) {
-		pr_err("%s: pll: %s fails to enable\n", __func__, clk->name);
+		pr_err("%s: pll: %s fails to enable\n", __func__, clk_name);
 		return ret;
 	}
 
@@ -433,7 +427,7 @@ static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 
 	ret = pll_wait_for_lock(pll);
 	if (ret < 0) {
-		pr_err("%s: pll: %s failed to lock\n", __func__, clk->name);
+		pr_err("%s: pll: %s failed to lock\n", __func__, clk_name);
 		return ret;
 	}
 
@@ -469,16 +463,15 @@ static unsigned long iproc_pll_recalc_rate(struct clk_hw *hw,
 	u32 val;
 	u64 ndiv, ndiv_int, ndiv_frac;
 	unsigned int pdiv;
+	unsigned long rate;
 
 	if (parent_rate == 0)
 		return 0;
 
 	/* PLL needs to be locked */
 	val = readl(pll->status_base + ctrl->status.offset);
-	if ((val & (1 << ctrl->status.shift)) == 0) {
-		clk->rate = 0;
+	if ((val & (1 << ctrl->status.shift)) == 0)
 		return 0;
-	}
 
 	/*
 	 * PLL output frequency =
@@ -500,14 +493,14 @@ static unsigned long iproc_pll_recalc_rate(struct clk_hw *hw,
 	val = readl(pll->control_base + ctrl->pdiv.offset);
 	pdiv = (val >> ctrl->pdiv.shift) & bit_mask(ctrl->pdiv.width);
 
-	clk->rate = (ndiv * parent_rate) >> 20;
+	rate = (ndiv * parent_rate) >> 20;
 
 	if (pdiv == 0)
-		clk->rate *= 2;
+		rate *= 2;
 	else
-		clk->rate /= pdiv;
+		rate /= pdiv;
 
-	return clk->rate;
+	return rate;
 }
 
 static int iproc_pll_determine_rate(struct clk_hw *hw,
@@ -632,6 +625,7 @@ static unsigned long iproc_clk_recalc_rate(struct clk_hw *hw,
 	struct iproc_pll *pll = clk->pll;
 	u32 val;
 	unsigned int mdiv;
+	unsigned long rate;
 
 	if (parent_rate == 0)
 		return 0;
@@ -642,11 +636,11 @@ static unsigned long iproc_clk_recalc_rate(struct clk_hw *hw,
 		mdiv = 256;
 
 	if (ctrl->flags & IPROC_CLK_MCLK_DIV_BY_2)
-		clk->rate = parent_rate / (mdiv * 2);
+		rate = parent_rate / (mdiv * 2);
 	else
-		clk->rate = parent_rate / mdiv;
+		rate = parent_rate / mdiv;
 
-	return clk->rate;
+	return rate;
 }
 
 static int iproc_clk_determine_rate(struct clk_hw *hw,
@@ -698,10 +692,6 @@ static int iproc_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		val |= div << ctrl->mdiv.shift;
 	}
 	iproc_pll_write(pll, pll->control_base, ctrl->mdiv.offset, val);
-	if (ctrl->flags & IPROC_CLK_MCLK_DIV_BY_2)
-		clk->rate = parent_rate / (div * 2);
-	else
-		clk->rate = parent_rate / div;
 
 	return 0;
 }
@@ -744,6 +734,8 @@ void iproc_pll_clk_setup(struct device_node *node,
 	struct iproc_clk *iclk;
 	struct clk_init_data init;
 	const char *parent_name;
+	struct iproc_clk *iclk_array;
+	struct clk_hw_onecell_data *clk_data;
 
 	if (WARN_ON(!pll_ctrl) || WARN_ON(!clk_ctrl))
 		return;
@@ -752,14 +744,14 @@ void iproc_pll_clk_setup(struct device_node *node,
 	if (WARN_ON(!pll))
 		return;
 
-	pll->clk_data = kzalloc(sizeof(*pll->clk_data->hws) * num_clks +
-				sizeof(*pll->clk_data), GFP_KERNEL);
-	if (WARN_ON(!pll->clk_data))
+	clk_data = kzalloc(sizeof(*clk_data->hws) * num_clks +
+				sizeof(*clk_data), GFP_KERNEL);
+	if (WARN_ON(!clk_data))
 		goto err_clk_data;
-	pll->clk_data->num = num_clks;
+	clk_data->num = num_clks;
 
-	pll->clks = kcalloc(num_clks, sizeof(*pll->clks), GFP_KERNEL);
-	if (WARN_ON(!pll->clks))
+	iclk_array = kcalloc(num_clks, sizeof(struct iproc_clk), GFP_KERNEL);
+	if (WARN_ON(!iclk_array))
 		goto err_clks;
 
 	pll->control_base = of_iomap(node, 0);
@@ -789,9 +781,8 @@ void iproc_pll_clk_setup(struct device_node *node,
 	/* initialize and register the PLL itself */
 	pll->ctrl = pll_ctrl;
 
-	iclk = &pll->clks[0];
+	iclk = &iclk_array[0];
 	iclk->pll = pll;
-	iclk->name = node->name;
 
 	init.name = node->name;
 	init.ops = &iproc_pll_ops;
@@ -812,7 +803,7 @@ void iproc_pll_clk_setup(struct device_node *node,
 	if (WARN_ON(ret))
 		goto err_pll_register;
 
-	pll->clk_data->hws[0] = &iclk->hw;
+	clk_data->hws[0] = &iclk->hw;
 
 	/* now initialize and register all leaf clocks */
 	for (i = 1; i < num_clks; i++) {
@@ -826,8 +817,7 @@ void iproc_pll_clk_setup(struct device_node *node,
 		if (WARN_ON(ret))
 			goto err_clk_register;
 
-		iclk = &pll->clks[i];
-		iclk->name = clk_name;
+		iclk = &iclk_array[i];
 		iclk->pll = pll;
 		iclk->ctrl = &clk_ctrl[i];
 
@@ -842,11 +832,10 @@ void iproc_pll_clk_setup(struct device_node *node,
 		if (WARN_ON(ret))
 			goto err_clk_register;
 
-		pll->clk_data->hws[i] = &iclk->hw;
+		clk_data->hws[i] = &iclk->hw;
 	}
 
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
-				     pll->clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (WARN_ON(ret))
 		goto err_clk_register;
 
@@ -854,7 +843,7 @@ void iproc_pll_clk_setup(struct device_node *node,
 
 err_clk_register:
 	while (--i >= 0)
-		clk_hw_unregister(pll->clk_data->hws[i]);
+		clk_hw_unregister(clk_data->hws[i]);
 
 err_pll_register:
 	if (pll->status_base != pll->control_base)
@@ -871,10 +860,10 @@ void iproc_pll_clk_setup(struct device_node *node,
 	iounmap(pll->control_base);
 
 err_pll_iomap:
-	kfree(pll->clks);
+	kfree(iclk_array);
 
 err_clks:
-	kfree(pll->clk_data);
+	kfree(clk_data);
 
 err_clk_data:
 	kfree(pll);
-- 
1.9.1
