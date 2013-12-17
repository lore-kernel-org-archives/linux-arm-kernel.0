From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 17 Dec 2013 17:26:38 +0800
Subject: [PATCH 2/4] clk: tegra: add EMC clock driver
In-Reply-To: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
Message-ID: <1387272400-4689-3-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add External Memory Controller (EMC) clock interface for the Tegra CCF
driver to support EMC scaling.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/tegra/Makefile              |   1 +
 drivers/clk/tegra/clk-emc.c             | 183 ++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h                 |  19 ++++
 include/linux/platform_data/tegra_emc.h |   7 ++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/clk/tegra/clk-emc.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index f7dfb72884a4..c493ba9ad531 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -1,6 +1,7 @@
 obj-y					+= clk.o
 obj-y					+= clk-audio-sync.o
 obj-y					+= clk-divider.o
+obj-y					+= clk-emc.o
 obj-y					+= clk-periph.o
 obj-y					+= clk-periph-gate.o
 obj-y					+= clk-pll.o
diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
new file mode 100644
index 000000000000..4403696a7dc2
--- /dev/null
+++ b/drivers/clk/tegra/clk-emc.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_data/tegra_emc.h>
+
+#include "clk.h"
+
+static u8 clk_emc_get_parent(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	const struct clk_ops *mux_ops = emc->periph->mux_ops;
+	struct clk_hw *mux_hw = &emc->periph->mux.hw;
+
+	mux_hw->clk = hw->clk;
+	return mux_ops->get_parent(mux_hw);
+}
+
+static unsigned long clk_emc_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	struct tegra_clk_periph *periph = emc->periph;
+	const struct clk_ops *div_ops = periph->div_ops;
+	struct clk_hw *div_hw = &periph->divider.hw;
+
+	return div_ops->recalc_rate(div_hw, parent_rate);
+}
+
+static long clk_emc_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	struct clk *parent_clk = __clk_get_parent(hw->clk);
+	unsigned long parent_rate = __clk_get_rate(parent_clk);
+	unsigned long ret;
+
+	if (!emc->emc_ops)
+		return parent_rate;
+
+	ret = emc->emc_ops->emc_round_rate(rate);
+	if (!ret)
+		return parent_rate;
+
+	return ret;
+}
+
+static int clk_emc_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	struct tegra_clk_periph *periph = emc->periph;
+	const struct clk_ops *div_ops = periph->div_ops;
+	struct clk_hw *div_hw = &periph->divider.hw;
+	int ret = -EINVAL;
+
+	if (!emc->emc_ops)
+		goto out;
+
+	ret = emc->emc_ops->emc_set_rate(rate);
+	if (ret)
+		goto out;
+
+	div_ops->set_rate(div_hw, rate, parent_rate);
+
+out:
+	return ret;
+}
+
+static int clk_emc_is_enabled(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	const struct clk_ops *gate_ops = emc->periph->gate_ops;
+	struct clk_hw *gate_hw = &emc->periph->gate.hw;
+
+	gate_hw->clk = hw->clk;
+
+	return gate_ops->is_enabled(gate_hw);
+}
+
+static int clk_emc_enable(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	const struct clk_ops *gate_ops = emc->periph->gate_ops;
+	struct clk_hw *gate_hw = &emc->periph->gate.hw;
+
+	gate_hw->clk = hw->clk;
+
+	return gate_ops->enable(gate_hw);
+}
+
+static void clk_emc_disable(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_clk_emc(hw);
+	const struct clk_ops *gate_ops = emc->periph->gate_ops;
+	struct clk_hw *gate_hw = &emc->periph->gate.hw;
+
+	gate_ops->disable(gate_hw);
+}
+
+void tegra_register_emc_clk_ops(struct clk *emc_clk,
+				const struct emc_clk_ops *emc_ops)
+{
+	struct clk_hw *hw;
+	struct tegra_clk_emc *emc;
+
+	if (IS_ERR_OR_NULL(emc_clk))
+		return;
+	hw = __clk_get_hw(emc_clk);
+
+	emc = to_clk_emc(hw);
+	if (emc)
+		emc->emc_ops = emc_ops;
+}
+
+static const struct clk_ops tegra_clk_emc_ops = {
+	.get_parent = clk_emc_get_parent,
+	.recalc_rate = clk_emc_recalc_rate,
+	.round_rate = clk_emc_round_rate,
+	.set_rate = clk_emc_set_rate,
+	.is_enabled = clk_emc_is_enabled,
+	.enable = clk_emc_enable,
+	.disable = clk_emc_disable,
+};
+
+struct clk *tegra_clk_register_emc(const char *name, const char **parent_names,
+	int num_parents, struct tegra_clk_periph *periph,
+	void __iomem *clk_base, u32 offset, unsigned long flags)
+{
+	struct tegra_clk_emc *emc;
+	struct clk *clk;
+	struct clk_init_data init;
+	struct tegra_clk_periph_regs *bank;
+
+	emc = kzalloc(sizeof(*emc), GFP_KERNEL);
+	if (!emc) {
+		pr_err("%s: could not allocate emc clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &tegra_clk_emc_ops;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	bank = get_reg_bank(periph->gate.clk_num);
+	if (!bank)
+		return ERR_PTR(-EINVAL);
+
+	periph->magic = TEGRA_CLK_PERIPH_MAGIC;
+	periph->mux.reg = clk_base + offset;
+	periph->divider.reg = clk_base + offset;
+	periph->gate.clk_base = clk_base;
+	periph->gate.regs = bank;
+	periph->gate.enable_refcnt = periph_clk_enb_refcnt;
+
+	/* Data in .init is copied by clk_register(), so stack variable OK */
+	emc->hw.init = &init;
+	emc->periph = periph;
+	clk = clk_register(NULL, &emc->hw);
+	if (IS_ERR(clk)) {
+		kfree(emc);
+		return clk;
+	}
+
+	emc->periph->mux.hw.clk = clk;
+	emc->periph->divider.hw.clk = clk;
+	emc->periph->gate.hw.clk = clk;
+
+	return clk;
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 16ec8d6bb87f..381a9b486805 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -511,6 +511,25 @@ struct tegra_periph_init_data {
 			NULL, 0, NULL)
 
 /**
+ * struct clk-emc - emc clock
+ *
+ * @hw:         handle between common and hardware-specific interfaces
+ * @periph:     periph clock
+ * @emc_ops:    emc ops
+ */
+struct tegra_clk_emc {
+	struct clk_hw			hw;
+	struct tegra_clk_periph		*periph;
+	const struct emc_clk_ops	*emc_ops;
+};
+
+#define to_clk_emc(_hw) container_of(_hw, struct tegra_clk_emc, hw)
+
+struct clk *tegra_clk_register_emc(const char *name, const char **parent_names,
+		int num_parents, struct tegra_clk_periph *periph,
+		void __iomem *clk_base, u32 offset, unsigned long flags);
+
+/**
  * struct clk_super_mux - super clock
  *
  * @hw:		handle between common and hardware-specific interfaces
diff --git a/include/linux/platform_data/tegra_emc.h b/include/linux/platform_data/tegra_emc.h
index df67505e98f8..f36cb58932d2 100644
--- a/include/linux/platform_data/tegra_emc.h
+++ b/include/linux/platform_data/tegra_emc.h
@@ -31,4 +31,11 @@ struct tegra_emc_pdata {
 	struct tegra_emc_table *tables;
 };
 
+struct emc_clk_ops {
+	long		(*emc_round_rate)(unsigned long);
+	int		(*emc_set_rate)(unsigned long);
+};
+
+void tegra_register_emc_clk_ops(struct clk *emc_clk,
+				const struct emc_clk_ops *emc_ops);
 #endif
-- 
1.8.5
