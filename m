From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:24 +0530
Subject: [PATCH V2 04/69] ST SPEAr: Making clock functions more generic
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <4e91d7264bcbedf8132178aa601a2f95c38339e7.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modifications include:
 - Adding dummy clk_set_rate function. Required for compilation of few drivers
 - Making function present in plat-spear/clock.c more generic over all platforms
 - Added div_factor filed in struct clk for clks with .recalc = follow_parent

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c           |   66 ++++++++++++++++++++++++++----
 arch/arm/mach-spear6xx/clock.c           |   67 ++++++++++++++++++++++++++----
 arch/arm/plat-spear/clock.c              |   59 ++++++++++++++++++--------
 arch/arm/plat-spear/include/plat/clock.h |   64 ++++++++++++++++++++++++----
 4 files changed, 212 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 18febf9..7ea8749 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -39,10 +39,25 @@ static struct clk rtc_clk = {
 };
 
 /* clock derived from 24 MHz osc clk */
+/* pll masks structure */
+static struct pll_clk_masks pll1_masks = {
+	.mode_mask = PLL_MODE_MASK,
+	.mode_shift = PLL_MODE_SHIFT,
+	.norm_fdbk_m_mask = PLL_NORM_FDBK_M_MASK,
+	.norm_fdbk_m_shift = PLL_NORM_FDBK_M_SHIFT,
+	.dith_fdbk_m_mask = PLL_DITH_FDBK_M_MASK,
+	.dith_fdbk_m_shift = PLL_DITH_FDBK_M_SHIFT,
+	.div_p_mask = PLL_DIV_P_MASK,
+	.div_p_shift = PLL_DIV_P_SHIFT,
+	.div_n_mask = PLL_DIV_N_MASK,
+	.div_n_shift = PLL_DIV_N_SHIFT,
+};
+
 /* pll1 configuration structure */
 static struct pll_clk_config pll1_config = {
 	.mode_reg = PLL1_CTR,
 	.cfg_reg = PLL1_FRQ,
+	.masks = &pll1_masks,
 };
 
 /* PLL1 clock */
@@ -50,7 +65,7 @@ static struct clk pll1_clk = {
 	.pclk = &osc_24m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
-	.recalc = &pll1_clk_recalc,
+	.recalc = &pll_clk_recalc,
 	.private_data = &pll1_config,
 };
 
@@ -76,11 +91,16 @@ static struct clk cpu_clk = {
 	.recalc = &follow_parent,
 };
 
+/* ahb masks structure */
+static struct bus_clk_masks ahb_masks = {
+	.mask = PLL_HCLK_RATIO_MASK,
+	.shift = PLL_HCLK_RATIO_SHIFT,
+};
+
 /* ahb configuration structure */
 static struct bus_clk_config ahb_config = {
 	.reg = CORE_CLK_CFG,
-	.mask = PLL_HCLK_RATIO_MASK,
-	.shift = PLL_HCLK_RATIO_SHIFT,
+	.masks = &ahb_masks,
 };
 
 /* ahb clock */
@@ -91,9 +111,22 @@ static struct clk ahb_clk = {
 	.private_data = &ahb_config,
 };
 
+/* auxiliary synthesizers masks */
+static struct aux_clk_masks aux_masks = {
+	.eq_sel_mask = AUX_EQ_SEL_MASK,
+	.eq_sel_shift = AUX_EQ_SEL_SHIFT,
+	.eq1_mask = AUX_EQ1_SEL,
+	.eq2_mask = AUX_EQ2_SEL,
+	.xscale_sel_mask = AUX_XSCALE_MASK,
+	.xscale_sel_shift = AUX_XSCALE_SHIFT,
+	.yscale_sel_mask = AUX_YSCALE_MASK,
+	.yscale_sel_shift = AUX_YSCALE_SHIFT,
+};
+
 /* uart configurations */
 static struct aux_clk_config uart_config = {
 	.synth_reg = UART_CLK_SYNT,
+	.masks = &aux_masks,
 };
 
 /* uart parents */
@@ -130,6 +163,7 @@ static struct clk uart_clk = {
 /* firda configurations */
 static struct aux_clk_config firda_config = {
 	.synth_reg = FIRDA_CLK_SYNT,
+	.masks = &aux_masks,
 };
 
 /* firda parents */
@@ -184,9 +218,18 @@ static struct pclk_sel gpt_pclk_sel = {
 	.pclk_sel_mask = GPT_CLK_MASK,
 };
 
+/* gpt synthesizer masks */
+static struct gpt_clk_masks gpt_masks = {
+	.mscale_sel_mask = GPT_MSCALE_MASK,
+	.mscale_sel_shift = GPT_MSCALE_SHIFT,
+	.nscale_sel_mask = GPT_NSCALE_MASK,
+	.nscale_sel_shift = GPT_NSCALE_SHIFT,
+};
+
 /* gpt0 configurations */
-static struct aux_clk_config gpt0_config = {
+static struct gpt_clk_config gpt0_config = {
 	.synth_reg = PRSC1_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt0 timer clock */
@@ -199,8 +242,9 @@ static struct clk gpt0_clk = {
 };
 
 /* gpt1 configurations */
-static struct aux_clk_config gpt1_config = {
+static struct gpt_clk_config gpt1_config = {
 	.synth_reg = PRSC2_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt1 timer clock */
@@ -214,8 +258,9 @@ static struct clk gpt1_clk = {
 };
 
 /* gpt2 configurations */
-static struct aux_clk_config gpt2_config = {
+static struct gpt_clk_config gpt2_config = {
 	.synth_reg = PRSC3_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt2 timer clock */
@@ -253,11 +298,16 @@ static struct clk clcd_clk = {
 };
 
 /* clock derived from ahb clk */
+/* apb masks structure */
+static struct bus_clk_masks apb_masks = {
+	.mask = HCLK_PCLK_RATIO_MASK,
+	.shift = HCLK_PCLK_RATIO_SHIFT,
+};
+
 /* apb configuration structure */
 static struct bus_clk_config apb_config = {
 	.reg = CORE_CLK_CFG,
-	.mask = HCLK_PCLK_RATIO_MASK,
-	.shift = HCLK_PCLK_RATIO_SHIFT,
+	.masks = &apb_masks,
 };
 
 /* apb clock */
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index 36ff056..ef88922 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -39,10 +39,25 @@ static struct clk rtc_clk = {
 };
 
 /* clock derived from 30 MHz osc clk */
+/* pll masks structure */
+static struct pll_clk_masks pll1_masks = {
+	.mode_mask = PLL_MODE_MASK,
+	.mode_shift = PLL_MODE_SHIFT,
+	.norm_fdbk_m_mask = PLL_NORM_FDBK_M_MASK,
+	.norm_fdbk_m_shift = PLL_NORM_FDBK_M_SHIFT,
+	.dith_fdbk_m_mask = PLL_DITH_FDBK_M_MASK,
+	.dith_fdbk_m_shift = PLL_DITH_FDBK_M_SHIFT,
+	.div_p_mask = PLL_DIV_P_MASK,
+	.div_p_shift = PLL_DIV_P_SHIFT,
+	.div_n_mask = PLL_DIV_N_MASK,
+	.div_n_shift = PLL_DIV_N_SHIFT,
+};
+
 /* pll1 configuration structure */
 static struct pll_clk_config pll1_config = {
 	.mode_reg = PLL1_CTR,
 	.cfg_reg = PLL1_FRQ,
+	.masks = &pll1_masks,
 };
 
 /* PLL1 clock */
@@ -50,7 +65,7 @@ static struct clk pll1_clk = {
 	.pclk = &osc_30m_clk,
 	.en_reg = PLL1_CTR,
 	.en_reg_bit = PLL_ENABLE,
-	.recalc = &pll1_clk_recalc,
+	.recalc = &pll_clk_recalc,
 	.private_data = &pll1_config,
 };
 
@@ -76,11 +91,16 @@ static struct clk cpu_clk = {
 	.recalc = &follow_parent,
 };
 
+/* ahb masks structure */
+static struct bus_clk_masks ahb_masks = {
+	.mask = PLL_HCLK_RATIO_MASK,
+	.shift = PLL_HCLK_RATIO_SHIFT,
+};
+
 /* ahb configuration structure */
 static struct bus_clk_config ahb_config = {
 	.reg = CORE_CLK_CFG,
-	.mask = PLL_HCLK_RATIO_MASK,
-	.shift = PLL_HCLK_RATIO_SHIFT,
+	.masks = &ahb_masks,
 };
 
 /* ahb clock */
@@ -112,9 +132,22 @@ static struct pclk_sel uart_pclk_sel = {
 	.pclk_sel_mask = UART_CLK_MASK,
 };
 
+/* auxiliary synthesizers masks */
+static struct aux_clk_masks aux_masks = {
+	.eq_sel_mask = AUX_EQ_SEL_MASK,
+	.eq_sel_shift = AUX_EQ_SEL_SHIFT,
+	.eq1_mask = AUX_EQ1_SEL,
+	.eq2_mask = AUX_EQ2_SEL,
+	.xscale_sel_mask = AUX_XSCALE_MASK,
+	.xscale_sel_shift = AUX_XSCALE_SHIFT,
+	.yscale_sel_mask = AUX_YSCALE_MASK,
+	.yscale_sel_shift = AUX_YSCALE_SHIFT,
+};
+
 /* uart configurations */
 static struct aux_clk_config uart_config = {
 	.synth_reg = UART_CLK_SYNT,
+	.masks = &aux_masks,
 };
 
 /* uart0 clock */
@@ -140,6 +173,7 @@ static struct clk uart1_clk = {
 /* firda configurations */
 static struct aux_clk_config firda_config = {
 	.synth_reg = FIRDA_CLK_SYNT,
+	.masks = &aux_masks,
 };
 
 /* firda parents */
@@ -176,6 +210,7 @@ static struct clk firda_clk = {
 /* clcd configurations */
 static struct aux_clk_config clcd_config = {
 	.synth_reg = CLCD_CLK_SYNT,
+	.masks = &aux_masks,
 };
 
 /* clcd parents */
@@ -230,9 +265,18 @@ static struct pclk_sel gpt_pclk_sel = {
 	.pclk_sel_mask = GPT_CLK_MASK,
 };
 
+/* gpt synthesizer masks */
+static struct gpt_clk_masks gpt_masks = {
+	.mscale_sel_mask = GPT_MSCALE_MASK,
+	.mscale_sel_shift = GPT_MSCALE_SHIFT,
+	.nscale_sel_mask = GPT_NSCALE_MASK,
+	.nscale_sel_shift = GPT_NSCALE_SHIFT,
+};
+
 /* gpt0_1 configurations */
-static struct aux_clk_config gpt0_1_config = {
+static struct gpt_clk_config gpt0_1_config = {
 	.synth_reg = PRSC1_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt0 ARM1 subsystem timer clock */
@@ -254,8 +298,9 @@ static struct clk gpt1_clk = {
 };
 
 /* gpt2 configurations */
-static struct aux_clk_config gpt2_config = {
+static struct gpt_clk_config gpt2_config = {
 	.synth_reg = PRSC2_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt2 timer clock */
@@ -269,8 +314,9 @@ static struct clk gpt2_clk = {
 };
 
 /* gpt3 configurations */
-static struct aux_clk_config gpt3_config = {
+static struct gpt_clk_config gpt3_config = {
 	.synth_reg = PRSC3_CLK_CFG,
+	.masks = &gpt_masks,
 };
 
 /* gpt3 timer clock */
@@ -309,11 +355,16 @@ static struct clk usbd_clk = {
 };
 
 /* clock derived from ahb clk */
+/* apb masks structure */
+static struct bus_clk_masks apb_masks = {
+	.mask = HCLK_PCLK_RATIO_MASK,
+	.shift = HCLK_PCLK_RATIO_SHIFT,
+};
+
 /* apb configuration structure */
 static struct bus_clk_config apb_config = {
 	.reg = CORE_CLK_CFG,
-	.mask = HCLK_PCLK_RATIO_MASK,
-	.shift = HCLK_PCLK_RATIO_SHIFT,
+	.masks = &apb_masks,
 };
 
 /* apb clock */
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index ee4f90e..f1cf832 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -17,7 +17,6 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
-#include <mach/misc_regs.h>
 #include <plat/clock.h>
 
 static DEFINE_SPINLOCK(clocks_lock);
@@ -187,6 +186,20 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 }
 EXPORT_SYMBOL(clk_set_parent);
 
+/**
+ * clk_set_rate - set the clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired clock rate in Hz
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	/* TODO */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
 /* registers clock in platform clock framework */
 void clk_register(struct clk_lookup *cl)
 {
@@ -212,6 +225,7 @@ void clk_register(struct clk_lookup *cl)
 		list_add(&clk->sibling, &clk->pclk->children);
 	} else {
 		/* add clocks with > 1 parent to 1st parent's children list */
+		clk->pclk = clk->pclk_sel->pclk_info[0].pclk;
 		list_add(&clk->sibling,
 			 &clk->pclk_sel->pclk_info[0].pclk->children);
 	}
@@ -283,29 +297,31 @@ static void change_parent(struct clk *cclk, struct clk *pclk)
  * In Dithered mode
  * rate = (2 * M[15:0] * Fin)/(256 * N * 2^P)
  */
-void pll1_clk_recalc(struct clk *clk)
+void pll_clk_recalc(struct clk *clk)
 {
 	struct pll_clk_config *config = clk->private_data;
 	unsigned int num = 2, den = 0, val, mode = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	mode = (readl(config->mode_reg) >> PLL_MODE_SHIFT) &
-		PLL_MODE_MASK;
+	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
+		config->masks->mode_mask;
 
 	val = readl(config->cfg_reg);
 	/* calculate denominator */
-	den = (val >> PLL_DIV_P_SHIFT) & PLL_DIV_P_MASK;
+	den = (val >> config->masks->div_p_shift) & config->masks->div_p_mask;
 	den = 1 << den;
-	den *= (val >> PLL_DIV_N_SHIFT) & PLL_DIV_N_MASK;
+	den *= (val >> config->masks->div_n_shift) & config->masks->div_n_mask;
 
 	/* calculate numerator & denominator */
 	if (!mode) {
 		/* Normal mode */
-		num *= (val >> PLL_NORM_FDBK_M_SHIFT) & PLL_NORM_FDBK_M_MASK;
+		num *= (val >> config->masks->norm_fdbk_m_shift) &
+			config->masks->norm_fdbk_m_mask;
 	} else {
 		/* Dithered mode */
-		num *= (val >> PLL_DITH_FDBK_M_SHIFT) & PLL_DITH_FDBK_M_MASK;
+		num *= (val >> config->masks->dith_fdbk_m_shift) &
+			config->masks->dith_fdbk_m_mask;
 		den *= 256;
 	}
 
@@ -321,7 +337,8 @@ void bus_clk_recalc(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	div = ((readl(config->reg) >> config->shift) & config->mask) + 1;
+	div = ((readl(config->reg) >> config->masks->shift) &
+			config->masks->mask) + 1;
 	clk->rate = (unsigned long)clk->pclk->rate / div;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
@@ -359,15 +376,18 @@ void aux_clk_recalc(struct clk *clk)
 	if (pclk_info->scalable) {
 		val = readl(config->synth_reg);
 
-		eqn = (val >> AUX_EQ_SEL_SHIFT) & AUX_EQ_SEL_MASK;
-		if (eqn == AUX_EQ1_SEL)
+		eqn = (val >> config->masks->eq_sel_shift) &
+			config->masks->eq_sel_mask;
+		if (eqn == config->masks->eq1_mask)
 			den *= 2;
 
 		/* calculate numerator */
-		num = (val >> AUX_XSCALE_SHIFT) & AUX_XSCALE_MASK;
+		num = (val >> config->masks->xscale_sel_shift) &
+			config->masks->xscale_sel_mask;
 
 		/* calculate denominator */
-		den *= (val >> AUX_YSCALE_SHIFT) & AUX_YSCALE_MASK;
+		den *= (val >> config->masks->yscale_sel_shift) &
+			config->masks->yscale_sel_mask;
 		val = (((clk->pclk->rate/10000) * num) / den) * 10000;
 	} else
 		val = clk->pclk->rate;
@@ -383,7 +403,7 @@ void aux_clk_recalc(struct clk *clk)
  */
 void gpt_clk_recalc(struct clk *clk)
 {
-	struct aux_clk_config *config = clk->private_data;
+	struct gpt_clk_config *config = clk->private_data;
 	struct pclk_info *pclk_info = NULL;
 	unsigned int div = 1, val;
 	unsigned long flags;
@@ -402,8 +422,10 @@ void gpt_clk_recalc(struct clk *clk)
 	spin_lock_irqsave(&clocks_lock, flags);
 	if (pclk_info->scalable) {
 		val = readl(config->synth_reg);
-		div += (val >> GPT_MSCALE_SHIFT) & GPT_MSCALE_MASK;
-		div *= 1 << (((val >> GPT_NSCALE_SHIFT) & GPT_NSCALE_MASK) + 1);
+		div += (val >> config->masks->mscale_sel_shift) &
+			config->masks->mscale_sel_mask;
+		div *= 1 << (((val >> config->masks->nscale_sel_shift) &
+					config->masks->nscale_sel_mask) + 1);
 	}
 
 	clk->rate = (unsigned long)clk->pclk->rate / div;
@@ -411,15 +433,16 @@ void gpt_clk_recalc(struct clk *clk)
 }
 
 /*
- * Used for clocks that always have same value as the parent clock divided by a
+ * Used for clocks that always have value as the parent clock divided by a
  * fixed divisor
  */
 void follow_parent(struct clk *clk)
 {
 	unsigned long flags;
+	unsigned int div_factor = (clk->div_factor < 1) ? 1 : clk->div_factor;
 
 	spin_lock_irqsave(&clocks_lock, flags);
-	clk->rate = clk->pclk->rate;
+	clk->rate = clk->pclk->rate/div_factor;
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 298bafc..e08b58c 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -67,6 +67,7 @@ struct pclk_sel {
  * @en_reg_bit: clk enable/disable bit
  * @ops: clk enable/disable ops - generic_clkops selected if NULL
  * @recalc: pointer to clock rate recalculate function
+ * @div_factor: division factor to parent clock. Only for recalc = follow_parent
  * @pclk: current parent clk
  * @pclk_sel: pointer to parent selection structure
  * @pclk_sel_shift: register shift for selecting parent of this clock
@@ -82,6 +83,7 @@ struct clk {
 	u8 en_reg_bit;
 	const struct clkops *ops;
 	void (*recalc) (struct clk *);
+	unsigned int div_factor;
 
 	struct clk *pclk;
 	struct pclk_sel *pclk_sel;
@@ -93,23 +95,65 @@ struct clk {
 };
 
 /* pll configuration structure */
+struct pll_clk_masks {
+	u32 mode_mask;
+	u32 mode_shift;
+
+	u32 norm_fdbk_m_mask;
+	u32 norm_fdbk_m_shift;
+	u32 dith_fdbk_m_mask;
+	u32 dith_fdbk_m_shift;
+	u32 div_p_mask;
+	u32 div_p_shift;
+	u32 div_n_mask;
+	u32 div_n_shift;
+};
+
 struct pll_clk_config {
-	unsigned int *mode_reg;
-	unsigned int *cfg_reg;
+	u32 *mode_reg;
+	u32 *cfg_reg;
+	struct pll_clk_masks *masks;
 };
 
 /* ahb and apb bus configuration structure */
+struct bus_clk_masks {
+	u32 mask;
+	u32 shift;
+};
+
 struct bus_clk_config {
-	unsigned int *reg;
-	unsigned int mask;
-	unsigned int shift;
+	u32 *reg;
+	struct bus_clk_masks *masks;
+};
+
+/* Aux clk configuration structure: applicable to UART and FIRDA */
+struct aux_clk_masks {
+	u32 eq_sel_mask;
+	u32 eq_sel_shift;
+	u32 eq1_mask;
+	u32 eq2_mask;
+	u32 xscale_sel_mask;
+	u32 xscale_sel_shift;
+	u32 yscale_sel_mask;
+	u32 yscale_sel_shift;
 };
 
-/*
- * Aux clk configuration structure: applicable to GPT, UART and FIRDA
- */
 struct aux_clk_config {
-	unsigned int *synth_reg;
+	u32 *synth_reg;
+	struct aux_clk_masks *masks;
+};
+
+/* GPT clk configuration structure */
+struct gpt_clk_masks {
+	u32 mscale_sel_mask;
+	u32 mscale_sel_shift;
+	u32 nscale_sel_mask;
+	u32 nscale_sel_shift;
+};
+
+struct gpt_clk_config {
+	u32 *synth_reg;
+	struct gpt_clk_masks *masks;
 };
 
 /* platform specific clock functions */
@@ -118,7 +162,7 @@ void recalc_root_clocks(void);
 
 /* clock recalc functions */
 void follow_parent(struct clk *clk);
-void pll1_clk_recalc(struct clk *clk);
+void pll_clk_recalc(struct clk *clk);
 void bus_clk_recalc(struct clk *clk);
 void gpt_clk_recalc(struct clk *clk);
 void aux_clk_recalc(struct clk *clk);
-- 
1.7.2.2
