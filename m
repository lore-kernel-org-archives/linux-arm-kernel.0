From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:41 +0530
Subject: [PATCH 09/13] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <e5ea0b5c1511fe29d1b452fb3095f4380db58455.1334660432.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SPEAr SoC's contain Auxiliary Synthesizers. Their Fout is derived based on
values of eq, x and y.

Fout from synthesizer can be given from two equations:
Fout1 = (Fin * X/Y)/2		EQ1
Fout2 = Fin * X/Y		EQ2

This patch adds in support for this type of clock.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/Makefile           |    2 +-
 arch/arm/plat-spear/clk-aux-synth.c    |  195 ++++++++++++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/clk.h |   32 +++++
 3 files changed, 228 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-spear/clk-aux-synth.c

diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 4e6d65d..7e0f480 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -6,4 +6,4 @@
 obj-y	:= clock.o restart.o time.o pl080.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o
-obj-$(CONFIG_COMMON_CLK)	+= clk-vco-pll.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-aux-synth.o clk-vco-pll.o
diff --git a/arch/arm/plat-spear/clk-aux-synth.c b/arch/arm/plat-spear/clk-aux-synth.c
new file mode 100644
index 0000000..69045a6
--- /dev/null
+++ b/arch/arm/plat-spear/clk-aux-synth.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Auxiliary Synthesizer clock implementation
+ */
+
+#define pr_fmt(fmt) "clk-aux-synth: " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/clk.h>
+
+/*
+ * DOC: Auxiliary Synthesizer clock
+ *
+ * Aux synth gives rate for different values of eq, x and y
+ *
+ * Fout from synthesizer can be given from two equations:
+ * Fout1 = (Fin * X/Y)/2		EQ1
+ * Fout2 = Fin * X/Y			EQ2
+ */
+
+#define AUX_EQ_SEL_SHIFT	30
+#define AUX_EQ_SEL_MASK		1
+#define AUX_EQ1_SEL		0
+#define AUX_EQ2_SEL		1
+#define AUX_XSCALE_SHIFT	16
+#define AUX_XSCALE_MASK		0xFFF
+#define AUX_YSCALE_SHIFT	0
+#define AUX_YSCALE_MASK		0xFFF
+
+#define AUX_SYNT_ENB		31
+
+#define to_clk_aux(_hw) container_of(_hw, struct clk_aux, hw)
+
+static struct aux_clk_masks default_aux_masks = {
+	.eq_sel_mask = AUX_EQ_SEL_MASK,
+	.eq_sel_shift = AUX_EQ_SEL_SHIFT,
+	.eq1_mask = AUX_EQ1_SEL,
+	.eq2_mask = AUX_EQ2_SEL,
+	.xscale_sel_mask = AUX_XSCALE_MASK,
+	.xscale_sel_shift = AUX_XSCALE_SHIFT,
+	.yscale_sel_mask = AUX_YSCALE_MASK,
+	.yscale_sel_shift = AUX_YSCALE_SHIFT,
+	.enable_bit = AUX_SYNT_ENB,
+};
+
+static unsigned long aux_calc_rate(struct clk_hw *hw, unsigned long prate,
+		int index)
+{
+	struct clk_aux *aux = to_clk_aux(hw);
+	struct aux_rate_tbl *rtbl = aux->rtbl;
+	u8 eq = rtbl[index].eq ? 1 : 2;
+
+	return (((prate / 10000) * rtbl[index].xscale) /
+			(rtbl[index].yscale * eq)) * 10000;
+}
+
+static long clk_aux_round_rate(struct clk_hw *hw, unsigned long drate,
+		unsigned long *prate)
+{
+	struct clk_aux *aux = to_clk_aux(hw);
+	int unused;
+
+	return clk_round_rate_index(hw, drate, aux_calc_rate, aux->rtbl_cnt,
+			&unused);
+}
+
+static unsigned long clk_aux_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_aux *aux = to_clk_aux(hw);
+	unsigned int num = 1, den = 1, val, eqn;
+	unsigned long flags = 0;
+
+	if (aux->lock)
+		spin_lock_irqsave(aux->lock, flags);
+
+	val = readl_relaxed(aux->reg);
+
+	if (aux->lock)
+		spin_unlock_irqrestore(aux->lock, flags);
+
+	eqn = (val >> aux->masks->eq_sel_shift) & aux->masks->eq_sel_mask;
+	if (eqn == aux->masks->eq1_mask)
+		den = 2;
+
+	/* calculate numerator */
+	num = (val >> aux->masks->xscale_sel_shift) &
+		aux->masks->xscale_sel_mask;
+
+	/* calculate denominator */
+	den *= (val >> aux->masks->yscale_sel_shift) &
+		aux->masks->yscale_sel_mask;
+
+	if (!den)
+		return 0;
+
+	return (((parent_rate / 10000) * num) / den) * 10000;
+}
+
+/* Configures new clock rate of aux */
+static int clk_aux_set_rate(struct clk_hw *hw, unsigned long drate)
+{
+	struct clk_aux *aux = to_clk_aux(hw);
+	struct aux_rate_tbl *rtbl = aux->rtbl;
+	unsigned long val, flags = 0;
+	int i;
+
+	clk_round_rate_index(hw, drate, aux_calc_rate, aux->rtbl_cnt, &i);
+
+	if (aux->lock)
+		spin_lock_irqsave(aux->lock, flags);
+
+	val = readl_relaxed(aux->reg) &
+		~(aux->masks->eq_sel_mask << aux->masks->eq_sel_shift);
+	val |= (rtbl[i].eq & aux->masks->eq_sel_mask) <<
+		aux->masks->eq_sel_shift;
+	val &= ~(aux->masks->xscale_sel_mask << aux->masks->xscale_sel_shift);
+	val |= (rtbl[i].xscale & aux->masks->xscale_sel_mask) <<
+		aux->masks->xscale_sel_shift;
+	val &= ~(aux->masks->yscale_sel_mask << aux->masks->yscale_sel_shift);
+	val |= (rtbl[i].yscale & aux->masks->yscale_sel_mask) <<
+		aux->masks->yscale_sel_shift;
+	writel_relaxed(val, aux->reg);
+
+	if (aux->lock)
+		spin_unlock_irqrestore(aux->lock, flags);
+
+	return 0;
+}
+
+static struct clk_ops clk_aux_ops = {
+	.recalc_rate = clk_aux_recalc_rate,
+	.round_rate = clk_aux_round_rate,
+	.set_rate = clk_aux_set_rate,
+};
+
+struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
+		const char *parent_name, unsigned long flags, void __iomem *reg,
+		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
+		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk)
+{
+	struct clk_aux *aux;
+	struct clk *clk, *tgate_clk;
+
+	if (!aux_name || !gate_name || !parent_name || !reg || !rtbl ||
+			!rtbl_cnt) {
+		pr_err("Invalid arguments passed");
+		return ERR_PTR(-EINVAL);
+	}
+
+	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	if (!aux) {
+		pr_err("could not allocate aux clk\n");
+		return NULL;
+	}
+
+	/* struct clk_aux assignments */
+	if (!masks)
+		aux->masks = &default_aux_masks;
+
+	aux->reg = reg;
+	aux->rtbl = rtbl;
+	aux->rtbl_cnt = rtbl_cnt;
+	aux->lock = lock;
+
+	clk = clk_register(NULL, aux_name, &clk_aux_ops, &aux->hw, &parent_name,
+			1, flags);
+	if (!clk)
+		goto free_aux;
+
+	tgate_clk = clk_register_gate(NULL, gate_name, aux_name, 0, reg,
+			aux->masks->enable_bit, 0, lock);
+	if (!tgate_clk)
+		goto free_aux;
+
+	if (gate_clk)
+		*gate_clk = tgate_clk;
+
+	return clk;
+
+free_aux:
+	kfree(aux);
+	pr_err("clk register failed\n");
+
+	return NULL;
+}
diff --git a/arch/arm/plat-spear/include/plat/clk.h b/arch/arm/plat-spear/include/plat/clk.h
index 3c93d9f..d3533e0 100644
--- a/arch/arm/plat-spear/include/plat/clk.h
+++ b/arch/arm/plat-spear/include/plat/clk.h
@@ -18,6 +18,34 @@
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 
+/* Auxiliary Synth clk */
+struct aux_clk_masks {
+	u32 eq_sel_mask;
+	u32 eq_sel_shift;
+	u32 eq1_mask;
+	u32 eq2_mask;
+	u32 xscale_sel_mask;
+	u32 xscale_sel_shift;
+	u32 yscale_sel_mask;
+	u32 yscale_sel_shift;
+	u32 enable_bit;
+};
+
+struct aux_rate_tbl {
+	u16 xscale;
+	u16 yscale;
+	u8 eq;
+};
+
+struct clk_aux {
+	struct			clk_hw hw;
+	void __iomem		*reg;
+	struct aux_clk_masks	*masks;
+	struct aux_rate_tbl	*rtbl;
+	u8			rtbl_cnt;
+	spinlock_t		*lock;
+};
+
 /* VCO-PLL clk */
 struct pll_rate_tbl {
 	u8 mode;
@@ -46,6 +74,10 @@ typedef unsigned long (*clk_calc_rate)(struct clk_hw *hw, unsigned long prate,
 		int index);
 
 /* clk register routines */
+struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
+		const char *parent_name, unsigned long flags, void __iomem *reg,
+		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
+		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk);
 struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 		const char *vco_gate_name, const char *parent_name,
 		unsigned long flags, void __iomem *mode_reg, void __iomem
-- 
1.7.9
