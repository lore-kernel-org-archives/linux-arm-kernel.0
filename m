From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 24 Aug 2012 13:26:02 +0200
Subject: [PATCH 1/4] clk: ux500: Adapt PRCMU and PRCC clocks for common clk
In-Reply-To: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
References: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1345807565-7729-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

First version of common clock implementation of PRCMU clocks
and PRCC clocks for ux500 platforms.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/Makefile    |    7 ++
 drivers/clk/ux500/clk-prcc.c  |  162 ++++++++++++++++++++++++++++
 drivers/clk/ux500/clk-prcmu.c |  238 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ux500/clk.h       |   43 ++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 drivers/clk/ux500/Makefile
 create mode 100644 drivers/clk/ux500/clk-prcc.c
 create mode 100644 drivers/clk/ux500/clk-prcmu.c
 create mode 100644 drivers/clk/ux500/clk.h

diff --git a/drivers/clk/ux500/Makefile b/drivers/clk/ux500/Makefile
new file mode 100644
index 0000000..a3ccd1b
--- /dev/null
+++ b/drivers/clk/ux500/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for ux500 clocks
+#
+
+# Clock types
+obj-y += clk-prcc.o
+obj-y += clk-prcmu.o
diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
new file mode 100644
index 0000000..12c7a89
--- /dev/null
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -0,0 +1,162 @@
+/*
+ * PRCC clock implementation for ux500 platform.
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <mach/hardware.h>
+
+#include "clk.h"
+
+#define PRCC_PCKEN			0x000
+#define PRCC_PCKDIS			0x004
+#define PRCC_KCKEN			0x008
+#define PRCC_KCKDIS			0x00C
+#define PRCC_PCKSR			0x010
+#define PRCC_KCKSR			0x014
+
+#define to_clk_prcc(_hw) container_of(_hw, struct clk_prcc, hw)
+
+struct clk_prcc {
+	struct clk_hw hw;
+	unsigned int io_base;
+	u32 cg_sel;
+	int is_enabled;
+};
+
+/* PRCC clock operations. */
+
+static int clk_prcc_pclk_enable(struct clk_hw *hw)
+{
+	struct clk_prcc *clk = to_clk_prcc(hw);
+	void __iomem *io_base = __io_address(clk->io_base);
+
+	writel(clk->cg_sel, (io_base + PRCC_PCKEN));
+	while (!(readl(io_base + PRCC_PCKSR) & clk->cg_sel))
+		cpu_relax();
+
+	clk->is_enabled = 1;
+	return 0;
+}
+
+static void clk_prcc_pclk_disable(struct clk_hw *hw)
+{
+	struct clk_prcc *clk = to_clk_prcc(hw);
+	void __iomem *io_base = __io_address(clk->io_base);
+
+	writel(clk->cg_sel, (io_base + PRCC_PCKDIS));
+	clk->is_enabled = 0;
+}
+
+static int clk_prcc_kclk_enable(struct clk_hw *hw)
+{
+	struct clk_prcc *clk = to_clk_prcc(hw);
+	void __iomem *io_base = __io_address(clk->io_base);
+
+	writel(clk->cg_sel, (io_base + PRCC_KCKEN));
+	while (!(readl(io_base + PRCC_KCKSR) & clk->cg_sel))
+		cpu_relax();
+
+	clk->is_enabled = 1;
+	return 0;
+}
+
+static void clk_prcc_kclk_disable(struct clk_hw *hw)
+{
+	struct clk_prcc *clk = to_clk_prcc(hw);
+	void __iomem *io_base = __io_address(clk->io_base);
+
+	writel(clk->cg_sel, (io_base + PRCC_KCKDIS));
+	clk->is_enabled = 0;
+}
+
+static int clk_prcc_is_enabled(struct clk_hw *hw)
+{
+	struct clk_prcc *clk = to_clk_prcc(hw);
+	return clk->is_enabled;
+}
+
+static struct clk_ops clk_prcc_pclk_ops = {
+	.enable = clk_prcc_pclk_enable,
+	.disable = clk_prcc_pclk_disable,
+	.is_enabled = clk_prcc_is_enabled,
+};
+
+static struct clk_ops clk_prcc_kclk_ops = {
+	.enable = clk_prcc_kclk_enable,
+	.disable = clk_prcc_kclk_disable,
+	.is_enabled = clk_prcc_is_enabled,
+};
+
+static struct clk *clk_reg_prcc(const char *name,
+				const char *parent_name,
+				unsigned int io_base,
+				u32 cg_sel,
+				unsigned long flags,
+				struct clk_ops *clk_prcc_ops)
+{
+	struct clk_prcc *clk;
+	struct clk_init_data clk_prcc_init;
+	struct clk *clk_reg;
+
+	if (!name) {
+		pr_err("clk_prcc: %s invalid arguments passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	clk = kzalloc(sizeof(struct clk_prcc), GFP_KERNEL);
+	if (!clk) {
+		pr_err("clk_prcc: %s could not allocate clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk->io_base = io_base;
+	clk->cg_sel = cg_sel;
+	clk->is_enabled = 1;
+
+	clk_prcc_init.name = name;
+	clk_prcc_init.ops = clk_prcc_ops;
+	clk_prcc_init.flags = flags;
+	clk_prcc_init.parent_names = (parent_name ? &parent_name : NULL);
+	clk_prcc_init.num_parents = (parent_name ? 1 : 0);
+	clk->hw.init = &clk_prcc_init;
+
+	clk_reg = clk_register(NULL, &clk->hw);
+	if (IS_ERR_OR_NULL(clk_reg))
+		goto free_clk;
+
+	return clk_reg;
+
+free_clk:
+	kfree(clk);
+	pr_err("clk_prcc: %s failed to register clk\n", __func__);
+	return ERR_PTR(-ENOMEM);
+}
+
+struct clk *clk_reg_prcc_pclk(const char *name,
+			      const char *parent_name,
+			      unsigned int io_base,
+			      u32 cg_sel,
+			      unsigned long flags)
+{
+	return clk_reg_prcc(name, parent_name, io_base, cg_sel, flags,
+			&clk_prcc_pclk_ops);
+}
+
+struct clk *clk_reg_prcc_kclk(const char *name,
+			      const char *parent_name,
+			      unsigned int io_base,
+			      u32 cg_sel,
+			      unsigned long flags)
+{
+	return clk_reg_prcc(name, parent_name, io_base, cg_sel, flags,
+			&clk_prcc_kclk_ops);
+}
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
new file mode 100644
index 0000000..1d779ad
--- /dev/null
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -0,0 +1,238 @@
+/*
+ * PRCMU clock implementation for ux500 platform.
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include "clk.h"
+
+#define to_clk_prcmu(_hw) container_of(_hw, struct clk_prcmu, hw)
+
+struct clk_prcmu {
+	struct clk_hw hw;
+	u8 cg_sel;
+	int is_enabled;
+};
+
+/* PRCMU clock operations. */
+
+static int clk_prcmu_prepare(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return prcmu_request_clock(clk->cg_sel, true);
+}
+
+static void clk_prcmu_unprepare(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	if (prcmu_request_clock(clk->cg_sel, false))
+		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
+			hw->init->name);
+}
+
+static int clk_prcmu_enable(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	clk->is_enabled = 1;
+	return 0;
+}
+
+static void clk_prcmu_disable(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	clk->is_enabled = 0;
+}
+
+static int clk_prcmu_is_enabled(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return clk->is_enabled;
+}
+
+static unsigned long clk_prcmu_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return prcmu_clock_rate(clk->cg_sel);
+}
+
+static long clk_prcmu_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return prcmu_round_clock_rate(clk->cg_sel, rate);
+}
+
+static int clk_prcmu_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return prcmu_set_clock_rate(clk->cg_sel, rate);
+}
+
+static int request_ape_opp100(bool enable)
+{
+	static int reqs;
+	int err = 0;
+
+	if (enable) {
+		if (!reqs)
+			err = prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP,
+							"clock", 100);
+		if (!err)
+			reqs++;
+	} else {
+		reqs--;
+		if (!reqs)
+			prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
+						"clock");
+	}
+	return err;
+}
+
+static int clk_prcmu_opp_prepare(struct clk_hw *hw)
+{
+	int err;
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+
+	err = request_ape_opp100(true);
+	if (err) {
+		pr_err("clk_prcmu: %s failed to request APE OPP100 for %s.\n",
+			__func__, hw->init->name);
+		return err;
+	}
+
+	err = prcmu_request_clock(clk->cg_sel, true);
+	if (err)
+		request_ape_opp100(false);
+
+	return err;
+}
+
+static void clk_prcmu_opp_unprepare(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+
+	if (prcmu_request_clock(clk->cg_sel, false))
+		goto out_error;
+	if (request_ape_opp100(false))
+		goto out_error;
+	return;
+
+out_error:
+	pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
+		hw->init->name);
+}
+
+static struct clk_ops clk_prcmu_scalable_ops = {
+	.prepare = clk_prcmu_prepare,
+	.unprepare = clk_prcmu_unprepare,
+	.enable = clk_prcmu_enable,
+	.disable = clk_prcmu_disable,
+	.is_enabled = clk_prcmu_is_enabled,
+	.recalc_rate = clk_prcmu_recalc_rate,
+	.round_rate = clk_prcmu_round_rate,
+	.set_rate = clk_prcmu_set_rate,
+};
+
+static struct clk_ops clk_prcmu_gate_ops = {
+	.prepare = clk_prcmu_prepare,
+	.unprepare = clk_prcmu_unprepare,
+	.enable = clk_prcmu_enable,
+	.disable = clk_prcmu_disable,
+	.is_enabled = clk_prcmu_is_enabled,
+	.recalc_rate = clk_prcmu_recalc_rate,
+};
+
+static struct clk_ops clk_prcmu_opp_gate_ops = {
+	.prepare = clk_prcmu_opp_prepare,
+	.unprepare = clk_prcmu_opp_unprepare,
+	.enable = clk_prcmu_enable,
+	.disable = clk_prcmu_disable,
+	.is_enabled = clk_prcmu_is_enabled,
+	.recalc_rate = clk_prcmu_recalc_rate,
+};
+
+static struct clk *clk_reg_prcmu(const char *name,
+				 const char *parent_name,
+				 u8 cg_sel,
+				 unsigned long rate,
+				 unsigned long flags,
+				 struct clk_ops *clk_prcmu_ops)
+{
+	struct clk_prcmu *clk;
+	struct clk_init_data clk_prcmu_init;
+	struct clk *clk_reg;
+
+	if (!name) {
+		pr_err("clk_prcmu: %s invalid arguments passed\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	clk = kzalloc(sizeof(struct clk_prcmu), GFP_KERNEL);
+	if (!clk) {
+		pr_err("clk_prcmu: %s could not allocate clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk->cg_sel = cg_sel;
+	clk->is_enabled = 1;
+	/* "rate" can be used for changing the initial frequency */
+	if (rate)
+		prcmu_set_clock_rate(cg_sel, rate);
+
+	clk_prcmu_init.name = name;
+	clk_prcmu_init.ops = clk_prcmu_ops;
+	clk_prcmu_init.flags = flags;
+	clk_prcmu_init.parent_names = (parent_name ? &parent_name : NULL);
+	clk_prcmu_init.num_parents = (parent_name ? 1 : 0);
+	clk->hw.init = &clk_prcmu_init;
+
+	clk_reg = clk_register(NULL, &clk->hw);
+	if (IS_ERR_OR_NULL(clk_reg))
+		goto free_clk;
+
+	return clk_reg;
+
+free_clk:
+	kfree(clk);
+	pr_err("clk_prcmu: %s failed to register clk\n", __func__);
+	return ERR_PTR(-ENOMEM);
+}
+
+struct clk *clk_reg_prcmu_scalable(const char *name,
+				   const char *parent_name,
+				   u8 cg_sel,
+				   unsigned long rate,
+				   unsigned long flags)
+{
+	return clk_reg_prcmu(name, parent_name, cg_sel, rate, flags,
+			&clk_prcmu_scalable_ops);
+}
+
+struct clk *clk_reg_prcmu_gate(const char *name,
+			       const char *parent_name,
+			       u8 cg_sel,
+			       unsigned long flags)
+{
+	return clk_reg_prcmu(name, parent_name, cg_sel, 0, flags,
+			&clk_prcmu_gate_ops);
+}
+
+struct clk *clk_reg_prcmu_opp_gate(const char *name,
+				   const char *parent_name,
+				   u8 cg_sel,
+				   unsigned long flags)
+{
+	return clk_reg_prcmu(name, parent_name, cg_sel, 0, flags,
+			&clk_prcmu_opp_gate_ops);
+}
diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
new file mode 100644
index 0000000..b15382b
--- /dev/null
+++ b/drivers/clk/ux500/clk.h
@@ -0,0 +1,43 @@
+/*
+ * Clocks for ux500 platforms
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __UX500_CLK_H
+#define __UX500_CLK_H
+
+#include <linux/clk.h>
+
+struct clk *clk_reg_prcc_pclk(const char *name,
+			      const char *parent_name,
+			      unsigned int io_base,
+			      u32 cg_sel,
+			      unsigned long flags);
+
+struct clk *clk_reg_prcc_kclk(const char *name,
+			      const char *parent_name,
+			      unsigned int io_base,
+			      u32 cg_sel,
+			      unsigned long flags);
+
+struct clk *clk_reg_prcmu_scalable(const char *name,
+				   const char *parent_name,
+				   u8 cg_sel,
+				   unsigned long rate,
+				   unsigned long flags);
+
+struct clk *clk_reg_prcmu_gate(const char *name,
+			       const char *parent_name,
+			       u8 cg_sel,
+			       unsigned long flags);
+
+struct clk *clk_reg_prcmu_opp_gate(const char *name,
+				   const char *parent_name,
+				   u8 cg_sel,
+				   unsigned long flags);
+
+#endif /* __UX500_CLK_H */
-- 
1.7.10
