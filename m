From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:42 +0530
Subject: [PATCH 11/74] ST SPEAr: Adding support for divisor per parent clock
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <f48a03e98396acfa0baf06105eb66c41fbb70e4d.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch was intended to provide support for clocks with multiple parents,
where clock derived from any parent can be divided by a fixed number or can be
passed to synthesizer. For this clock framework is reorganized to make behaviour
of functions more closer to their name.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/clock.c              |  249 +++++++++++++++++++-----------
 arch/arm/plat-spear/include/plat/clock.h |    6 +-
 2 files changed, 162 insertions(+), 93 deletions(-)

diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index f1cf832..ab29353 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -64,6 +64,40 @@ static struct clkops generic_clkops = {
 	.disable = generic_clk_disable,
 };
 
+/* returns current programmed clocks clock info structure */
+static struct pclk_info *pclk_info_get(struct clk *clk)
+{
+	unsigned int mask, i;
+	struct pclk_info *info = NULL;
+
+	mask = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
+		& clk->pclk_sel->pclk_sel_mask;
+
+	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
+		if (clk->pclk_sel->pclk_info[i].pclk_mask == mask)
+			info = &clk->pclk_sel->pclk_info[i];
+	}
+
+	return info;
+}
+
+/*
+ * Set Update pclk, and pclk_info of clk and add clock sibling node to current
+ * parents children list
+ */
+static void update_clk_tree(struct clk *clk, struct pclk_info *pclk_info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	list_del(&clk->sibling);
+	list_add(&clk->sibling, &pclk_info->pclk->children);
+
+	clk->pclk = pclk_info->pclk;
+	clk->pclk_info = pclk_info;
+	spin_unlock_irqrestore(&clocks_lock, flags);
+}
+
 /*
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
@@ -161,6 +195,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (clk->pclk == parent)
 		return 0;
 
+	/* check if requested parent is in clk parent list */
 	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
 		if (clk->pclk_sel->pclk_info[i].pclk == parent) {
 			found = 1;
@@ -180,8 +215,11 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	/* reflect parent change in software */
+	update_clk_tree(clk, &clk->pclk_sel->pclk_info[i]);
+
 	clk->recalc(clk);
 	propagate_rate(&clk->children);
+
 	return 0;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -220,14 +258,23 @@ void clk_register(struct clk_lookup *cl)
 	/* root clock don't have any parents */
 	if (!clk->pclk && !clk->pclk_sel) {
 		list_add(&clk->sibling, &root_clks);
-		/* add clocks with only one parent to parent's children list */
 	} else if (clk->pclk && !clk->pclk_sel) {
+		/* add clocks with only one parent to parent's children list */
 		list_add(&clk->sibling, &clk->pclk->children);
 	} else {
-		/* add clocks with > 1 parent to 1st parent's children list */
-		clk->pclk = clk->pclk_sel->pclk_info[0].pclk;
-		list_add(&clk->sibling,
-			 &clk->pclk_sel->pclk_info[0].pclk->children);
+		/* clocks with more than one parent */
+		struct pclk_info *pclk_info;
+
+		pclk_info = pclk_info_get(clk);
+		if (!pclk_info) {
+			printk(KERN_ERR "CLKDEV: invalid pclk info of clk with"
+					" %s dev_id and %s con_id\n",
+					cl->dev_id, cl->con_id);
+		} else {
+			clk->pclk = pclk_info->pclk;
+			clk->pclk_info = pclk_info;
+			list_add(&clk->sibling, &pclk_info->pclk->children);
+		}
 	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
@@ -252,42 +299,6 @@ static void propagate_rate(struct list_head *lhead)
 	}
 }
 
-/* returns current programmed clocks clock info structure */
-static struct pclk_info *pclk_info_get(struct clk *clk)
-{
-	unsigned int mask, i;
-	unsigned long flags;
-	struct pclk_info *info = NULL;
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	mask = (readl(clk->pclk_sel->pclk_sel_reg) >> clk->pclk_sel_shift)
-			& clk->pclk_sel->pclk_sel_mask;
-
-	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
-		if (clk->pclk_sel->pclk_info[i].pclk_mask == mask)
-			info = &clk->pclk_sel->pclk_info[i];
-	}
-	spin_unlock_irqrestore(&clocks_lock, flags);
-
-	return info;
-}
-
-/*
- * Set pclk as cclk's parent and add clock sibling node to current parents
- * children list
- */
-static void change_parent(struct clk *cclk, struct clk *pclk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	list_del(&cclk->sibling);
-	list_add(&cclk->sibling, &pclk->children);
-
-	cclk->pclk = pclk;
-	spin_unlock_irqrestore(&clocks_lock, flags);
-}
-
 /*
  * calculates current programmed rate of pll1
  *
@@ -304,28 +315,53 @@ void pll_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
-		config->masks->mode_mask;
-
-	val = readl(config->cfg_reg);
-	/* calculate denominator */
-	den = (val >> config->masks->div_p_shift) & config->masks->div_p_mask;
-	den = 1 << den;
-	den *= (val >> config->masks->div_n_shift) & config->masks->div_n_mask;
-
-	/* calculate numerator & denominator */
-	if (!mode) {
-		/* Normal mode */
-		num *= (val >> config->masks->norm_fdbk_m_shift) &
-			config->masks->norm_fdbk_m_mask;
+
+	/*
+	 * read divisor from hardware, only in two cases:
+	 * - There is only parent to clk and it requires *_clk_recalc
+	 * - There are two parents of a clock and current pclk requires
+	 *   *_clk_recalc
+	 */
+	if (!clk->pclk_info || clk->pclk_info->scalable) {
+		mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
+			config->masks->mode_mask;
+
+		val = readl(config->cfg_reg);
+		spin_unlock_irqrestore(&clocks_lock, flags);
+
+		/* calculate denominator */
+		den = (val >> config->masks->div_p_shift) &
+			config->masks->div_p_mask;
+		den = 1 << den;
+		den *= (val >> config->masks->div_n_shift) &
+			config->masks->div_n_mask;
+
+		/* calculate numerator & denominator */
+		if (!mode) {
+			/* Normal mode */
+			num *= (val >> config->masks->norm_fdbk_m_shift) &
+				config->masks->norm_fdbk_m_mask;
+		} else {
+			/* Dithered mode */
+			num *= (val >> config->masks->dith_fdbk_m_shift) &
+				config->masks->dith_fdbk_m_mask;
+			den *= 256;
+		}
+
+		spin_lock_irqsave(&clocks_lock, flags);
+		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
 	} else {
-		/* Dithered mode */
-		num *= (val >> config->masks->dith_fdbk_m_shift) &
-			config->masks->dith_fdbk_m_mask;
-		den *= 256;
+		int div = 0;
+		/*
+		 * only if there are two parents and current parent requires
+		 * simple division
+		 */
+		div = (clk->pclk_info->div_factor < 1) ? 1 :
+			clk->pclk_info->div_factor;
+		val = clk->pclk->rate/div;
 	}
 
-	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
+	clk->rate = val;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
@@ -337,8 +373,23 @@ void bus_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	div = ((readl(config->reg) >> config->masks->shift) &
-			config->masks->mask) + 1;
+	/*
+	 * read divisor from hardware, only in two cases:
+	 * - There is only parent to clk and it requires *_clk_recalc
+	 * - There are two parents of a clock and current pclk requires
+	 *   *_clk_recalc
+	 */
+	if (!clk->pclk_info || clk->pclk_info->scalable) {
+		div = ((readl(config->reg) >> config->masks->shift) &
+				config->masks->mask) + 1;
+	} else {
+		/*
+		 * only if there are two parents and current parent requires
+		 * simple division
+		 */
+		div = (clk->pclk_info->div_factor < 1) ? 1 :
+			clk->pclk_info->div_factor;
+	}
 	clk->rate = (unsigned long)clk->pclk->rate / div;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
@@ -356,25 +407,19 @@ void bus_clk_recalc(struct clk *clk)
 void aux_clk_recalc(struct clk *clk)
 {
 	struct aux_clk_config *config = clk->private_data;
-	struct pclk_info *pclk_info = NULL;
 	unsigned int num = 1, den = 1, val, eqn;
 	unsigned long flags;
 
-	/* get current programmed parent */
-	pclk_info = pclk_info_get(clk);
-	if (!pclk_info) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		clk->pclk = NULL;
-		clk->rate = 0;
-		spin_unlock_irqrestore(&clocks_lock, flags);
-		return;
-	}
-
-	change_parent(clk, pclk_info->pclk);
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	if (pclk_info->scalable) {
+	/*
+	 * read divisor from hardware, only in two cases:
+	 * - There is only parent to clk and it requires *_clk_recalc
+	 * - There are two parents of a clock and current pclk requires
+	 *   *_clk_recalc
+	 */
+	if (!clk->pclk_info || clk->pclk_info->scalable) {
 		val = readl(config->synth_reg);
+		spin_unlock_irqrestore(&clocks_lock, flags);
 
 		eqn = (val >> config->masks->eq_sel_shift) &
 			config->masks->eq_sel_mask;
@@ -388,9 +433,19 @@ void aux_clk_recalc(struct clk *clk)
 		/* calculate denominator */
 		den *= (val >> config->masks->yscale_sel_shift) &
 			config->masks->yscale_sel_mask;
+
+		spin_lock_irqsave(&clocks_lock, flags);
 		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
-	} else
-		val = clk->pclk->rate;
+	} else {
+		/*
+		 * only if there are two parents and current parent requires
+		 * simple division
+		 */
+		int div_factor = (clk->pclk_info->div_factor < 1) ? 1 :
+			clk->pclk_info->div_factor;
+
+		val = clk->pclk->rate/div_factor;
+	}
 
 	clk->rate = val;
 	spin_unlock_irqrestore(&clocks_lock, flags);
@@ -404,28 +459,32 @@ void aux_clk_recalc(struct clk *clk)
 void gpt_clk_recalc(struct clk *clk)
 {
 	struct gpt_clk_config *config = clk->private_data;
-	struct pclk_info *pclk_info = NULL;
 	unsigned int div = 1, val;
 	unsigned long flags;
 
-	pclk_info = pclk_info_get(clk);
-	if (!pclk_info) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		clk->pclk = NULL;
-		clk->rate = 0;
-		spin_unlock_irqrestore(&clocks_lock, flags);
-		return;
-	}
-
-	change_parent(clk, pclk_info->pclk);
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	if (pclk_info->scalable) {
+	/*
+	 * read divisor from hardware, only in two cases:
+	 * - There is only parent to clk and it requires *_clk_recalc
+	 * - There are two parents of a clock and current pclk requires
+	 *   *_clk_recalc
+	 */
+	if (!clk->pclk_info || clk->pclk_info->scalable) {
 		val = readl(config->synth_reg);
+		spin_unlock_irqrestore(&clocks_lock, flags);
+
 		div += (val >> config->masks->mscale_sel_shift) &
 			config->masks->mscale_sel_mask;
 		div *= 1 << (((val >> config->masks->nscale_sel_shift) &
 					config->masks->nscale_sel_mask) + 1);
+		spin_lock_irqsave(&clocks_lock, flags);
+	} else {
+		/*
+		 * only if there are two parents and current parent requires
+		 * simple division
+		 */
+		div = (clk->pclk_info->div_factor < 1) ? 1 :
+			clk->pclk_info->div_factor;
 	}
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
@@ -439,9 +498,15 @@ void gpt_clk_recalc(struct clk *clk)
 void follow_parent(struct clk *clk)
 {
 	unsigned long flags;
-	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
+	unsigned int div_factor;
 
 	spin_lock_irqsave(&clocks_lock, flags);
+	if (clk->pclk_info)
+		div_factor = clk->pclk_info->div_factor;
+	else
+		div_factor = clk->div_factor;
+	div_factor = (div_factor < 1) ? 1 : div_factor;
+
 	clk->rate = clk->pclk->rate/div_factor;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index e08b58c..d8d0856 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -37,11 +37,13 @@ struct clkops {
  * @pclk: pointer to parent clk
  * @pclk_mask: value to be written for selecting this parent
  * @scalable: Is parent scalable (1 - YES, 0 - NO)
+ * @div_factor: div factor for pclk
  */
 struct pclk_info {
 	struct clk *pclk;
 	u8 pclk_mask;
 	u8 scalable;
+	u8 div_factor;
 };
 
 /**
@@ -67,8 +69,9 @@ struct pclk_sel {
  * @en_reg_bit: clk enable/disable bit
  * @ops: clk enable/disable ops - generic_clkops selected if NULL
  * @recalc: pointer to clock rate recalculate function
- * @div_factor: division factor to parent clock. Only for recalc = follow_parent
+ * @div_factor: division factor to parent clock. Only for clks with one parent
  * @pclk: current parent clk
+ * @pclk_info: current parent clk's pclk_info
  * @pclk_sel: pointer to parent selection structure
  * @pclk_sel_shift: register shift for selecting parent of this clock
  * @children: list for childrens or this clock
@@ -86,6 +89,7 @@ struct clk {
 	unsigned int div_factor;
 
 	struct clk *pclk;
+	struct pclk_info *pclk_info;
 	struct pclk_sel *pclk_sel;
 	unsigned int pclk_sel_shift;
 
-- 
1.7.2.2
