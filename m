From: pi-cheng.chen@linaro.org (pi-cheng.chen)
Date: Wed,  4 Mar 2015 18:49:11 +0800
Subject: [PATCH] clk: mediatek: Export CPU mux clocks for CPU frequency control
Message-ID: <1425466152-7867-1-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CPU mux clocks which are used by Mediatek cpufreq driver
for intermediate clock source switching. This patch is based on Mediatek
clock driver patches[1].

[1] http://thread.gmane.org/gmane.linux.kernel/1892436

Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-cpumux.c      | 119 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-cpumux.h      |  32 +++++++++
 drivers/clk/mediatek/clk-mt8173.c      |  23 +++++++
 drivers/clk/mediatek/clk-mtk.c         |  39 +++++++++++
 drivers/clk/mediatek/clk-mtk.h         |   4 ++
 include/dt-bindings/clock/mt8173-clk.h |   4 +-
 7 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-cpumux.c
 create mode 100644 drivers/clk/mediatek/clk-cpumux.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 8e4b2a4..299917a 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,4 +1,4 @@
-obj-y += clk-mtk.o clk-pll.o clk-gate.o
+obj-y += clk-mtk.o clk-pll.o clk-gate.o clk-cpumux.o
 obj-$(CONFIG_RESET_CONTROLLER) += reset.o
 obj-y += clk-mt8135.o
 obj-y += clk-mt8173.o
diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
new file mode 100644
index 0000000..2026d56
--- /dev/null
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright (c) 2015 Linaro Ltd.
+ * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "clk-cpumux.h"
+
+#define ARMPLL_INDEX	1
+#define MAINPLL_INDEX	2
+
+static inline struct mtk_clk_cpumux *to_clk_mux(struct clk_hw *_hw)
+{
+	return container_of(_hw, struct mtk_clk_cpumux, hw);
+}
+
+static long clk_cpumux_determine_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long min_rate,
+				      unsigned long max_rate,
+				      unsigned long *best_parent_rate,
+				      struct clk_hw **best_parent_p)
+{
+	struct clk *clk = hw->clk, *parent;
+	unsigned long parent_rate;
+	int i;
+
+	for (i = MAINPLL_INDEX; i >= ARMPLL_INDEX; i--) {
+		parent = clk_get_parent_by_index(clk, i);
+		if (!parent)
+			return 0;
+
+		if (i == MAINPLL_INDEX) {
+			parent_rate = __clk_get_rate(parent);
+			if (parent_rate == rate)
+				break;
+		}
+
+		parent_rate = __clk_round_rate(parent, rate);
+	}
+
+	*best_parent_rate = parent_rate;
+	*best_parent_p = __clk_get_hw(parent);
+	return parent_rate;
+}
+
+static u8 clk_cpumux_get_parent(struct clk_hw *hw)
+{
+	struct mtk_clk_cpumux *mux = to_clk_mux(hw);
+	int num_parents = __clk_get_num_parents(hw->clk);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->reg, &val);
+	val = (val & mux->mask) >> mux->shift;
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static int clk_cpumux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct mtk_clk_cpumux *mux = to_clk_mux(hw);
+
+	return regmap_update_bits(mux->regmap, mux->reg, mux->mask,
+				  index << mux->shift);
+}
+
+static struct clk_ops clk_cpumux_ops = {
+	.get_parent = clk_cpumux_get_parent,
+	.set_parent = clk_cpumux_set_parent,
+	.determine_rate = clk_cpumux_determine_rate,
+};
+
+struct clk *mtk_clk_register_cpumux(const char *name, const char **parent_names,
+				    u8 num_parents, struct regmap *regmap,
+				    u32 reg, u8 shift, u8 width)
+{
+	struct mtk_clk_cpumux *mux;
+	struct clk *clk;
+	struct clk_init_data init;
+	u32 mask = (BIT(width) - 1) << shift;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_cpumux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = CLK_SET_RATE_PARENT;
+
+	mux->regmap = regmap;
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->mask = mask;
+	mux->hw.init = &init;
+
+	clk = clk_register(NULL, &mux->hw);
+	if (IS_ERR(clk))
+		kfree(mux);
+
+	return clk;
+}
+
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
new file mode 100644
index 0000000..e1c8369
--- /dev/null
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2015 Linaro Ltd.
+ * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_CPUMUX_H
+#define __DRV_CLK_CPUMUX_H
+
+#include <linux/regmap.h>
+
+struct mtk_clk_cpumux {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	u32		reg;
+	u32		mask;
+	u8		shift;
+};
+
+struct clk *mtk_clk_register_cpumux(const char *name, const char **parent_names,
+				    u8 num_parents, struct regmap *regmap,
+				    u32 reg, u8 shift, u8 width);
+
+#endif /* __DRV_CLK_CPUMUX_H */
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 014e552..124c7da 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -19,6 +19,7 @@
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-cpumux.h"
 
 #include <dt-bindings/clock/mt8173-clk.h>
 
@@ -517,6 +518,25 @@ static const char *i2s3_b_ck_parents[] __initconst = {
 	"apll2_div5"
 };
 
+static const char *ca53_parents[] __initconst = {
+	"clk26m",
+	"armca7pll",
+	"mainpll",
+	"univpll"
+};
+
+static const char *ca57_parents[] __initconst = {
+	"clk26m",
+	"armca15pll",
+	"mainpll",
+	"univpll"
+};
+
+static struct mtk_composite cpu_muxes[] __initdata = {
+	MUX(INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
+	MUX(INFRA_CA57SEL, "infra_ca57_sel", ca57_parents, 0x0000, 2, 2),
+};
+
 static struct mtk_composite top_muxes[] __initdata = {
 	/* CLK_CFG_0 */
 	MUX(TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
@@ -745,6 +765,9 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
 
+	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+				  clk_data);
+
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2bcade0..5c65cc4 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -23,6 +23,7 @@
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-cpumux.h"
 
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
@@ -193,3 +194,41 @@ err_out:
 
 	return ERR_PTR(ret);
 }
+
+int mtk_clk_register_cpumuxes(struct device_node *node,
+			      struct mtk_composite *clks, int num,
+			      struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+	struct regmap *regmap;
+
+	if (!clk_data)
+		return -ENOMEM;
+
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
+		       PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	for (i = 0; i < num; i++) {
+		struct mtk_composite *mux = &clks[i];
+
+		clk = mtk_clk_register_cpumux(mux->name, mux->parent_names,
+					      mux->num_parents, regmap,
+					      mux->mux_reg, mux->mux_shift,
+					      mux->mux_width);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+			       mux->name, PTR_ERR(clk));
+			continue;
+		}
+
+		clk_data->clks[mux->id] = clk;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 8f5190c..f3b1840 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -126,6 +126,10 @@ struct mtk_gate {
 int mtk_clk_register_gates(struct device_node *node, struct mtk_gate *clks, int num,
 		struct clk_onecell_data *clk_data);
 
+int mtk_clk_register_cpumuxes(struct device_node *node,
+			      struct mtk_composite *clks, int num,
+			      struct clk_onecell_data *clk_data);
+
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 
 #define HAVE_RST_BAR	BIT(0)
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index e648b28..2503b03 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -187,7 +187,9 @@
 #define INFRA_CEC		9
 #define INFRA_PMICSPI		10
 #define INFRA_PMICWRAP		11
-#define INFRA_NR_CLK		12
+#define INFRA_CA53SEL		12
+#define INFRA_CA57SEL		13
+#define INFRA_NR_CLK		14
 
 /* PERI_SYS */
 
-- 
1.9.1
