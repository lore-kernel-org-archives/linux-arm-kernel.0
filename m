From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 12:20:34 +0530
Subject: [PATCH V3 6/8] SPEAr: clk: Add General Purpose Timer Synthesizer clock
In-Reply-To: <cover.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
Message-ID: <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All SPEAr SoC's contain GPT Synthesizers. Their Fout is derived from
following equations:

Fout= Fin/((2 ^ (N+1)) * (M+1))

This patch adds in support for this type of clock.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/spear/Makefile        |    2 +-
 drivers/clk/spear/clk-gpt-synth.c |  145 +++++++++++++++++++++++++++++++++++++
 drivers/clk/spear/clk.h           |   17 +++++
 3 files changed, 163 insertions(+), 1 deletions(-)
 create mode 100644 drivers/clk/spear/clk-gpt-synth.c

diff --git a/drivers/clk/spear/Makefile b/drivers/clk/spear/Makefile
index 1827036..9e64824 100644
--- a/drivers/clk/spear/Makefile
+++ b/drivers/clk/spear/Makefile
@@ -2,4 +2,4 @@
 # SPEAr Clock specific Makefile
 #
 
-obj-y	+= clk.o clk-aux-synth.o clk-frac-synth.o clk-vco-pll.o
+obj-y	+= clk.o clk-aux-synth.o clk-frac-synth.o clk-gpt-synth.o clk-vco-pll.o
diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
new file mode 100644
index 0000000..514539c
--- /dev/null
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * General Purpose Timer Synthesizer clock implementation
+ */
+
+#define pr_fmt(fmt) "clk-gpt-synth: " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include "clk.h"
+
+#define GPT_MSCALE_MASK		0xFFF
+#define GPT_NSCALE_SHIFT	12
+#define GPT_NSCALE_MASK		0xF
+
+/*
+ * DOC: General Purpose Timer Synthesizer clock
+ *
+ * Calculates gpt synth clk rate for different values of mscale and nscale
+ *
+ * Fout= Fin/((2 ^ (N+1)) * (M+1))
+ */
+
+#define to_clk_gpt(_hw) container_of(_hw, struct clk_gpt, hw)
+
+static unsigned long gpt_calc_rate(struct clk_hw *hw, unsigned long prate,
+		int index)
+{
+	struct clk_gpt *gpt = to_clk_gpt(hw);
+	struct gpt_rate_tbl *rtbl = gpt->rtbl;
+
+	prate /= ((1 << (rtbl[index].nscale + 1)) * (rtbl[index].mscale + 1));
+
+	return prate;
+}
+
+static long clk_gpt_round_rate(struct clk_hw *hw, unsigned long drate,
+		unsigned long *prate)
+{
+	struct clk_gpt *gpt = to_clk_gpt(hw);
+	int unused;
+
+	return clk_round_rate_index(hw, drate, gpt_calc_rate, gpt->rtbl_cnt,
+			&unused);
+}
+
+static unsigned long clk_gpt_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_gpt *gpt = to_clk_gpt(hw);
+	unsigned long flags = 0;
+	unsigned int div = 1, val;
+
+	if (gpt->lock)
+		spin_lock_irqsave(gpt->lock, flags);
+
+	val = readl_relaxed(gpt->reg);
+
+	if (gpt->lock)
+		spin_unlock_irqrestore(gpt->lock, flags);
+
+	div += val & GPT_MSCALE_MASK;
+	div *= 1 << (((val >> GPT_NSCALE_SHIFT) & GPT_NSCALE_MASK) + 1);
+
+	if (!div)
+		return 0;
+
+	return parent_rate / div;
+}
+
+/* Configures new clock rate of gpt */
+static int clk_gpt_set_rate(struct clk_hw *hw, unsigned long drate)
+{
+	struct clk_gpt *gpt = to_clk_gpt(hw);
+	struct gpt_rate_tbl *rtbl = gpt->rtbl;
+	unsigned long flags = 0, val;
+	int i;
+
+	clk_round_rate_index(hw, drate, gpt_calc_rate, gpt->rtbl_cnt, &i);
+
+	if (gpt->lock)
+		spin_lock_irqsave(gpt->lock, flags);
+
+	val = readl(gpt->reg) & ~GPT_MSCALE_MASK;
+	val &= ~(GPT_NSCALE_MASK << GPT_NSCALE_SHIFT);
+
+	val |= rtbl[i].mscale & GPT_MSCALE_MASK;
+	val |= (rtbl[i].nscale & GPT_NSCALE_MASK) << GPT_NSCALE_SHIFT;
+
+	writel_relaxed(val, gpt->reg);
+
+	if (gpt->lock)
+		spin_unlock_irqrestore(gpt->lock, flags);
+
+	return 0;
+}
+
+static struct clk_ops clk_gpt_ops = {
+	.recalc_rate = clk_gpt_recalc_rate,
+	.round_rate = clk_gpt_round_rate,
+	.set_rate = clk_gpt_set_rate,
+};
+
+struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
+		long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
+		rtbl_cnt, spinlock_t *lock)
+{
+	struct clk_gpt *gpt;
+	struct clk *clk;
+
+	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
+		pr_err("Invalid arguments passed");
+		return ERR_PTR(-EINVAL);
+	}
+
+	gpt = kzalloc(sizeof(*gpt), GFP_KERNEL);
+	if (!gpt) {
+		pr_err("could not allocate gpt clk\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* struct clk_gpt assignments */
+	gpt->reg = reg;
+	gpt->rtbl = rtbl;
+	gpt->rtbl_cnt = rtbl_cnt;
+	gpt->lock = lock;
+
+	clk = clk_register(NULL, name, &clk_gpt_ops, &gpt->hw, &parent_name, 1,
+			flags);
+	if (!IS_ERR_OR_NULL(clk))
+		return clk;
+
+	pr_err("clk register failed\n");
+	kfree(gpt);
+
+	return NULL;
+}
diff --git a/drivers/clk/spear/clk.h b/drivers/clk/spear/clk.h
index c7dbc84..ee17994 100644
--- a/drivers/clk/spear/clk.h
+++ b/drivers/clk/spear/clk.h
@@ -68,6 +68,20 @@ struct clk_frac {
 	spinlock_t		*lock;
 };
 
+/* GPT clk */
+struct gpt_rate_tbl {
+	u16 mscale;
+	u16 nscale;
+};
+
+struct clk_gpt {
+	struct			clk_hw hw;
+	void __iomem		*reg;
+	struct gpt_rate_tbl	*rtbl;
+	u8			rtbl_cnt;
+	spinlock_t		*lock;
+};
+
 /* VCO-PLL clk */
 struct pll_rate_tbl {
 	u8 mode;
@@ -103,6 +117,9 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
 struct clk *clk_register_frac(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg,
 		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock);
+struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
+		long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
+		rtbl_cnt, spinlock_t *lock);
 struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 		const char *vco_gate_name, const char *parent_name,
 		unsigned long flags, void __iomem *mode_reg, void __iomem
-- 
1.7.9
