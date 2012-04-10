From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:36 +0200
Subject: [PATCH 23/40] ARM i.MX: Add common clock support for 2bit gate
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-24-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gate consists of two bits:

0b00: clk disabled
0b01: clk enabled in run mode and disabled in sleep mode
0b11: clk enabled

Currently only disabled and enabled are supported. As it's unlikely
that we find something like this in another SoC create a i.MX specific
clk helper for this.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile    |    2 +-
 arch/arm/mach-imx/clk-gate2.c |  125 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h       |   12 ++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-gate2.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 66bc6be..1b3f2ae 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
new file mode 100644
index 0000000..1ce9f44
--- /dev/null
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
+ * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Gated clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+/**
+ * DOC: basic gatable clock which can gate and ungate it's ouput
+ *
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
+
+static int clk_gate2_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	u32 reg;
+	unsigned long flags = 0;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	reg = readl(gate->reg);
+	reg |= 3 << gate->bit_idx;
+	writel(reg, gate->reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void clk_gate2_disable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	u32 reg;
+	unsigned long flags = 0;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+
+	reg = readl(gate->reg);
+	reg &= ~(3 << gate->bit_idx);
+	writel(reg, gate->reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+}
+
+static int clk_gate2_is_enabled(struct clk_hw *hw)
+{
+	u32 reg;
+	struct clk_gate *gate = to_clk_gate(hw);
+
+	reg = readl(gate->reg);
+
+	if (((reg >> gate->bit_idx) & 3) == 3)
+		return 1;
+
+	return 0;
+}
+
+static struct clk_ops clk_gate2_ops = {
+	.enable = clk_gate2_enable,
+	.disable = clk_gate2_disable,
+	.is_enabled = clk_gate2_is_enabled,
+};
+
+struct clk *clk_register_gate2(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate2_flags, spinlock_t *lock)
+{
+	struct clk_gate *gate;
+	struct clk *clk;
+
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+
+	if (!gate) {
+		pr_err("%s: could not allocate gated clk\n", __func__);
+		return NULL;
+	}
+
+	/* struct clk_gate assignments */
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->flags = clk_gate2_flags;
+	gate->lock = lock;
+
+	if (parent_name) {
+		gate->parent[0] = kstrdup(parent_name, GFP_KERNEL);
+		if (!gate->parent[0])
+			goto out;
+	}
+
+	clk = clk_register(dev, name,
+			&clk_gate2_ops, &gate->hw,
+			gate->parent,
+			(parent_name ? 1 : 0),
+			flags);
+	if (clk)
+		return clk;
+out:
+	kfree(gate->parent[0]);
+	kfree(gate);
+
+	return NULL;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 96ac3b1..fb44f03 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -5,6 +5,11 @@
 #include <linux/clk-provider.h>
 #include <mach/clock.h>
 
+struct clk *clk_register_gate2(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 bit_idx,
+		u8 clk_gate_flags, spinlock_t *lock);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
@@ -43,6 +48,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 			shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
+		void __iomem *reg, u8 shift)
+{
+	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+			shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, char **parents, int num_parents)
 {
-- 
1.7.9.5
