From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:47 +0530
Subject: [PATCH 18/74] ST SPEAr: enhanced spear clock framework
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <a1fd182ecc09aade01875d62ba06be07983a5f26.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Added support for
- recursive enabling of parent clock
- recursive disabling of parent clock
- recalc called only when clk is enabled in h/w

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/clock.c |  199 +++++++++++++++++++++++++++++--------------
 1 files changed, 136 insertions(+), 63 deletions(-)

diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index 89a0434..b4d8110 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -22,7 +23,24 @@
 static DEFINE_SPINLOCK(clocks_lock);
 static LIST_HEAD(root_clks);
 
-static void propagate_rate(struct list_head *);
+static void propagate_rate(struct clk *);
+
+static int clk_is_enabled(struct clk *clk)
+{
+	unsigned int val;
+
+	if (clk->flags & ALWAYS_ENABLED)
+		return 1;
+
+	BUG_ON(!clk->en_reg);
+	val = readl(clk->en_reg);
+	val = val & (1 << clk->en_reg_bit);
+
+	if (unlikely(clk->flags & RESET_TO_ENABLE))
+		return !val;
+	else
+		return !!val;
+}
 
 static int generic_clk_enable(struct clk *clk)
 {
@@ -85,7 +103,7 @@ static struct pclk_info *pclk_info_get(struct clk *clk)
  * Set Update pclk, and pclk_info of clk and add clock sibling node to current
  * parents children list
  */
-static void update_clk_tree(struct clk *clk, struct pclk_info *pclk_info)
+static void clk_reparent(struct clk *clk, struct pclk_info *pclk_info)
 {
 	unsigned long flags;
 
@@ -97,6 +115,64 @@ static void update_clk_tree(struct clk *clk, struct pclk_info *pclk_info)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
+void do_clk_disable(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	if (!clk->usage_count) {
+		WARN_ON(1);
+		return;
+	}
+
+	clk->usage_count--;
+
+	if (clk->usage_count == 0) {
+		/*
+		 * Surely, there are no active childrens or direct users
+		 * of this clock
+		 */
+		if (clk->pclk)
+			do_clk_disable(clk->pclk);
+
+		if (clk->ops && clk->ops->disable)
+			clk->ops->disable(clk);
+	}
+}
+
+int do_clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		return -EFAULT;
+
+	if (clk->usage_count == 0) {
+		if (clk->pclk) {
+			ret = do_clk_enable(clk->pclk);
+			if (ret)
+				goto err;
+		}
+		if (clk->ops && clk->ops->enable) {
+			ret = clk->ops->enable(clk);
+			if (ret) {
+				if (clk->pclk)
+					do_clk_disable(clk->pclk);
+				goto err;
+			}
+		}
+		/*
+		 * Since the clock is going to be used for the first
+		 * time please reclac
+		 */
+		if (clk->recalc)
+			clk->recalc(clk);
+	}
+	clk->usage_count++;
+err:
+	return ret;
+}
+
 /*
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
@@ -110,17 +186,9 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret = 0;
 
-	if (!clk || IS_ERR(clk))
-		return -EFAULT;
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	if (clk->usage_count == 0) {
-		if (clk->ops && clk->ops->enable)
-			ret = clk->ops->enable(clk);
-	}
-	clk->usage_count++;
+	ret = do_clk_enable(clk);
 	spin_unlock_irqrestore(&clocks_lock, flags);
-
 	return ret;
 }
 EXPORT_SYMBOL(clk_enable);
@@ -141,17 +209,8 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk))
-		return;
-
-	WARN_ON(clk->usage_count == 0);
-
 	spin_lock_irqsave(&clocks_lock, flags);
-	clk->usage_count--;
-	if (clk->usage_count == 0) {
-		if (clk->ops && clk->ops->disable)
-			clk->ops->disable(clk);
-	}
+	do_clk_disable(clk);
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
@@ -178,21 +237,22 @@ EXPORT_SYMBOL(clk_get_rate);
  * @clk: clock source
  * @parent: parent clock source
  *
- * Returns success (0) or negative errno.
+ * Returns success (0) or negative errno. clk usage_count must be zero
+ * before calling this function.
  */
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	int i, found = 0, val = 0;
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk) || !parent || IS_ERR(parent))
+	if (!clk || !parent)
 		return -EFAULT;
 	if (clk->usage_count)
-		return -EBUSY;
-	if (!clk->pclk_sel)
 		return -EPERM;
 	if (clk->pclk == parent)
 		return 0;
+	if (!clk->pclk_sel)
+		return -EPERM;
 
 	/* check if requested parent is in clk parent list */
 	for (i = 0; i < clk->pclk_sel->pclk_count; i++) {
@@ -214,10 +274,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	/* reflect parent change in software */
-	update_clk_tree(clk, &clk->pclk_sel->pclk_info[i]);
+	clk_reparent(clk, &clk->pclk_sel->pclk_info[i]);
 
-	clk->recalc(clk);
-	propagate_rate(&clk->children);
 	return 0;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -239,11 +297,12 @@ EXPORT_SYMBOL(clk_set_rate);
 /* registers clock in platform clock framework */
 void clk_register(struct clk_lookup *cl)
 {
-	struct clk *clk = cl->clk;
+	struct clk *clk;
 	unsigned long flags;
 
-	if (!clk || IS_ERR(clk))
+	if (!cl || !cl->clk)
 		return;
+	clk = cl->clk;
 
 	spin_lock_irqsave(&clocks_lock, flags);
 
@@ -265,7 +324,7 @@ void clk_register(struct clk_lookup *cl)
 
 		pclk_info = pclk_info_get(clk);
 		if (!pclk_info) {
-			printk(KERN_ERR "CLKDEV: invalid pclk info of clk with"
+			pr_err("CLKDEV: invalid pclk info of clk with"
 					" %s dev_id and %s con_id\n",
 					cl->dev_id, cl->con_id);
 		} else {
@@ -273,6 +332,7 @@ void clk_register(struct clk_lookup *cl)
 			list_add(&clk->sibling, &pclk_info->pclk->children);
 		}
 	}
+
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	/* add clock to arm clockdev framework */
@@ -280,22 +340,26 @@ void clk_register(struct clk_lookup *cl)
 }
 
 /**
- * propagate_rate - recalculate and propagate all clocks in list head
+ * propagate_rate - recalculate and propagate all clocks to children
  *
- * Recalculates all root clocks in list head, which if the clock's .recalc is
- * set correctly, should also propagate their rates.
+ * Recalculates all children clocks
  */
-static void propagate_rate(struct list_head *lhead)
+void propagate_rate(struct clk *pclk)
 {
-	struct clk *clkp, *_temp;
-
-	list_for_each_entry_safe(clkp, _temp, lhead, sibling) {
-		if (clkp->recalc)
-			clkp->recalc(clkp);
-		propagate_rate(&clkp->children);
+	struct clk *clk, *_temp;
+
+	list_for_each_entry_safe(clk, _temp, &pclk->children, sibling) {
+		/* recalc and propogate only if clk is enabled */
+		if (clk_is_enabled(clk)) {
+			if (clk->recalc)
+				clk->recalc(clk);
+			propagate_rate(clk);
+		}
 	}
 }
 
+/*All recalc functions are called with lock held */
+
 /*
  * calculates current programmed rate of pll1
  *
@@ -309,9 +373,7 @@ void pll_clk_recalc(struct clk *clk)
 {
 	struct pll_clk_config *config = clk->private_data;
 	unsigned int num = 2, den = 0, val, mode = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
 		config->masks->mode_mask;
 
@@ -333,8 +395,9 @@ void pll_clk_recalc(struct clk *clk)
 		den *= 256;
 	}
 
+	BUG_ON(!den);
+
 	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
-	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /* calculates current programmed rate of ahb or apb bus */
@@ -342,13 +405,13 @@ void bus_clk_recalc(struct clk *clk)
 {
 	struct bus_clk_config *config = clk->private_data;
 	unsigned int div;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	div = ((readl(config->reg) >> config->masks->shift) &
 			config->masks->mask) + 1;
+
+	BUG_ON(!div);
+
 	clk->rate = (unsigned long)clk->pclk->rate / div;
-	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /*
@@ -365,9 +428,7 @@ void aux_clk_recalc(struct clk *clk)
 {
 	struct aux_clk_config *config = clk->private_data;
 	unsigned int num = 1, den = 1, val, eqn;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	val = readl(config->synth_reg);
 
 	eqn = (val >> config->masks->eq_sel_shift) &
@@ -382,10 +443,10 @@ void aux_clk_recalc(struct clk *clk)
 	/* calculate denominator */
 	den *= (val >> config->masks->yscale_sel_shift) &
 		config->masks->yscale_sel_mask;
-	val = (((clk->pclk->rate/10000) * num) / den) * 10000;
 
-	clk->rate = val;
-	spin_unlock_irqrestore(&clocks_lock, flags);
+	BUG_ON(!den);
+
+	clk->rate = (((clk->pclk->rate/10000) * num) / den) * 10000;
 }
 
 /*
@@ -397,17 +458,16 @@ void gpt_clk_recalc(struct clk *clk)
 {
 	struct gpt_clk_config *config = clk->private_data;
 	unsigned int div = 1, val;
-	unsigned long flags;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	val = readl(config->synth_reg);
 	div += (val >> config->masks->mscale_sel_shift) &
 		config->masks->mscale_sel_mask;
 	div *= 1 << (((val >> config->masks->nscale_sel_shift) &
 				config->masks->nscale_sel_mask) + 1);
 
+	BUG_ON(!div);
+
 	clk->rate = (unsigned long)clk->pclk->rate / div;
-	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /*
@@ -425,18 +485,19 @@ void clcd_clk_recalc(struct clk *clk)
 {
 	struct clcd_clk_config *config = clk->private_data;
 	unsigned int div = 1;
-	unsigned long flags, prate;
+	unsigned long prate;
 	unsigned int val;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	val = readl(config->synth_reg);
 	div = (val >> config->masks->div_factor_shift) &
 		config->masks->div_factor_mask;
 
 	prate = clk->pclk->rate / 1000; /* first level division, make it KHz */
-	clk->rate = ((unsigned long)prate << 14 / 2 * div) >> 14;
+
+	BUG_ON(!div);
+
+	clk->rate = (((unsigned long)prate << 12) / (2 * div)) >> 12;
 	clk->rate *= 1000;
-	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /*
@@ -445,12 +506,9 @@ void clcd_clk_recalc(struct clk *clk)
  */
 void follow_parent(struct clk *clk)
 {
-	unsigned long flags;
 	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
-	spin_lock_irqsave(&clocks_lock, flags);
 	clk->rate = clk->pclk->rate/div_factor;
-	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 /**
@@ -461,5 +519,20 @@ void follow_parent(struct clk *clk)
  */
 void recalc_root_clocks(void)
 {
-	propagate_rate(&root_clks);
+	struct clk *pclk;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
+	list_for_each_entry(pclk, &root_clks, sibling) {
+		/*
+		 * It doesn't make a sense to recalc and propogate rate
+		 * if clk is not enabled in hw.
+		 */
+		if (clk_is_enabled(pclk)) {
+			if (pclk->recalc)
+				pclk->recalc(pclk);
+			propagate_rate(pclk);
+		}
+	}
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
-- 
1.7.2.2
