From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:42 +0530
Subject: [PATCH 10/13] SPEAr: clk: Add Fractional Synthesizer clock
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <ddf067d8f370165ba9cfa483fbdb6790b28e1dd6.1334660432.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SPEAr SoC's contain Fractional Synthesizers. Their Fout is derived from
following equations:

Fout = Fin / (2 * div) (division factor)
div is 17 bits:-
     0-13 (fractional part)
     14-16 (integer part)
     div is (16-14 bits).(13-0 bits) (in binary)

     Fout = Fin/(2 * div)
     Fout = ((Fin / 10000)/(2 * div)) * 10000
     Fout = (2^14 * (Fin / 10000)/(2^14 * (2 * div))) * 10000
     Fout = (((Fin / 10000) << 14)/(2 * (div << 14))) * 10000

div << 14 is simply 17 bit value written at register.

This patch adds in support for this type of clock.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/Makefile           |    2 +-
 arch/arm/plat-spear/clk-frac-synth.c   |  156 ++++++++++++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/clk.h |   16 ++++
 3 files changed, 173 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-spear/clk-frac-synth.c

diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index 7e0f480..3cedb21 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -6,4 +6,4 @@
 obj-y	:= clock.o restart.o time.o pl080.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o
-obj-$(CONFIG_COMMON_CLK)	+= clk-aux-synth.o clk-vco-pll.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-aux-synth.o clk-frac-synth.o clk-vco-pll.o
diff --git a/arch/arm/plat-spear/clk-frac-synth.c b/arch/arm/plat-spear/clk-frac-synth.c
new file mode 100644
index 0000000..7a3cfc0
--- /dev/null
+++ b/arch/arm/plat-spear/clk-frac-synth.c
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Fractional Synthesizer clock implementation
+ */
+
+#define pr_fmt(fmt) "clk-frac-synth: " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <plat/clk.h>
+
+#define DIV_FACTOR_MASK		0x1FFFF
+
+/*
+ * DOC: Fractional Synthesizer clock
+ *
+ * Fout from synthesizer can be given from below equation:
+ *
+ * Fout= Fin/2*div (division factor)
+ * div is 17 bits:-
+ *	0-13 (fractional part)
+ *	14-16 (integer part)
+ *	div is (16-14 bits).(13-0 bits) (in binary)
+ *
+ *	Fout = Fin/(2 * div)
+ *	Fout = ((Fin / 10000)/(2 * div)) * 10000
+ *	Fout = (2^14 * (Fin / 10000)/(2^14 * (2 * div))) * 10000
+ *	Fout = (((Fin / 10000) << 14)/(2 * (div << 14))) * 10000
+ *
+ * div << 14 simply 17 bit value written@register.
+ * Max error due to scaling down by 10000 is 10 KHz
+ */
+
+#define to_clk_frac(_hw) container_of(_hw, struct clk_frac, hw)
+
+static unsigned long frac_calc_rate(struct clk_hw *hw, unsigned long prate,
+		int index)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	struct frac_rate_tbl *rtbl = frac->rtbl;
+
+	prate /= 10000;
+	prate <<= 14;
+	prate /= (2 * rtbl[index].div);
+	prate *= 10000;
+
+	return prate;
+}
+
+static long clk_frac_round_rate(struct clk_hw *hw, unsigned long drate,
+		unsigned long *prate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	int unused;
+
+	return clk_round_rate_index(hw, drate, frac_calc_rate, frac->rtbl_cnt,
+			&unused);
+}
+
+static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	unsigned long flags = 0;
+	unsigned int div = 1, val;
+
+	if (frac->lock)
+		spin_lock_irqsave(frac->lock, flags);
+
+	val = readl_relaxed(frac->reg);
+
+	if (frac->lock)
+		spin_unlock_irqrestore(frac->lock, flags);
+
+	div = val & DIV_FACTOR_MASK;
+
+	if (!div)
+		return 0;
+
+	parent_rate = parent_rate / 10000;
+
+	parent_rate = (parent_rate << 14) / (2 * div);
+	return parent_rate * 10000;
+}
+
+/* Configures new clock rate of frac */
+static int clk_frac_set_rate(struct clk_hw *hw, unsigned long drate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	struct frac_rate_tbl *rtbl = frac->rtbl;
+	unsigned long flags = 0, val;
+	int i;
+
+	clk_round_rate_index(hw, drate, frac_calc_rate, frac->rtbl_cnt, &i);
+
+	if (frac->lock)
+		spin_lock_irqsave(frac->lock, flags);
+
+	val = readl_relaxed(frac->reg) & ~DIV_FACTOR_MASK;
+	val |= rtbl[i].div & DIV_FACTOR_MASK;
+	writel_relaxed(val, frac->reg);
+
+	if (frac->lock)
+		spin_unlock_irqrestore(frac->lock, flags);
+
+	return 0;
+}
+
+struct clk_ops clk_frac_ops = {
+	.recalc_rate = clk_frac_recalc_rate,
+	.round_rate = clk_frac_round_rate,
+	.set_rate = clk_frac_set_rate,
+};
+
+struct clk *clk_register_frac(const char *name, const char *parent_name,
+		unsigned long flags, void __iomem *reg,
+		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock)
+{
+	struct clk_frac *frac;
+	struct clk *clk;
+
+	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
+		pr_err("Invalid arguments passed");
+		return ERR_PTR(-EINVAL);
+	}
+
+	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
+	if (!frac) {
+		pr_err("could not allocate frac clk\n");
+		return NULL;
+	}
+
+	/* struct clk_frac assignments */
+	frac->reg = reg;
+	frac->rtbl = rtbl;
+	frac->rtbl_cnt = rtbl_cnt;
+	frac->lock = lock;
+
+	clk = clk_register(NULL, name, &clk_frac_ops, &frac->hw, &parent_name,
+			1, flags);
+	if (clk)
+		return clk;
+
+	pr_err("clk register failed\n");
+	kfree(frac);
+
+	return NULL;
+}
diff --git a/arch/arm/plat-spear/include/plat/clk.h b/arch/arm/plat-spear/include/plat/clk.h
index d3533e0..7d03e79 100644
--- a/arch/arm/plat-spear/include/plat/clk.h
+++ b/arch/arm/plat-spear/include/plat/clk.h
@@ -46,6 +46,19 @@ struct clk_aux {
 	spinlock_t		*lock;
 };
 
+/* Fractional Synth clk */
+struct frac_rate_tbl {
+	u32 div;
+};
+
+struct clk_frac {
+	struct			clk_hw hw;
+	void __iomem		*reg;
+	struct frac_rate_tbl	*rtbl;
+	u8			rtbl_cnt;
+	spinlock_t		*lock;
+};
+
 /* VCO-PLL clk */
 struct pll_rate_tbl {
 	u8 mode;
@@ -78,6 +91,9 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
 		const char *parent_name, unsigned long flags, void __iomem *reg,
 		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
 		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk);
+struct clk *clk_register_frac(const char *name, const char *parent_name,
+		unsigned long flags, void __iomem *reg,
+		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock);
 struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 		const char *vco_gate_name, const char *parent_name,
 		unsigned long flags, void __iomem *mode_reg, void __iomem
-- 
1.7.9
