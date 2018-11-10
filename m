From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:20:04 +0000
Subject: [PATCH V6 5/6] clk: imx: add lpcg clock support
In-Reply-To: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
References: <1541862894-8209-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541862894-8209-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Low-Power Clock Gate (LPCG) modules contain a local programming
model to control the clock gates for the peripherals. An LPCG module
is used to locally gate the clocks for the associated peripheral.
And they're bedind the SCU clock.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v6: separate from [PATCH V5 5/9] clk: imx: scu: add scu clock gate
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-lpcg-scu.c | 108 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h      |   3 ++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-lpcg-scu.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8369a34..cd2b6f0 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-pfd.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o
+	clk-scu.o \
+	clk-lpcg-scu.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
new file mode 100644
index 0000000..54a1cb3
--- /dev/null
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static DEFINE_SPINLOCK(imx_lpcg_scu_lock);
+
+#define CLK_GATE_SCU_LPCG_MASK		0x3
+#define CLK_GATE_SCU_LPCG_HW_SEL	BIT(0)
+#define CLK_GATE_SCU_LPCG_SW_SEL	BIT(1)
+
+struct clk_lpcg_scu {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 bit_idx;
+	bool hw_gate;
+};
+
+#define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
+
+/* Write to the LPCG bits. */
+static int clk_lpcg_scu_enable(struct clk_hw *hw)
+{
+	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
+
+	if (clk->reg) {
+		reg = readl(clk->reg);
+		reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
+		if (clk->hw_gate)
+			reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
+				CLK_GATE_SCU_LPCG_SW_SEL) << clk->bit_idx;
+		else
+			reg |= (CLK_GATE_SCU_LPCG_SW_SEL << clk->bit_idx);
+		writel(reg, clk->reg);
+	}
+
+	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
+
+	return 0;
+}
+
+static void clk_lpcg_scu_disable(struct clk_hw *hw)
+{
+	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&imx_lpcg_scu_lock, flags);
+
+	if (clk->reg) {
+		reg = readl(clk->reg);
+		reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
+		writel(reg, clk->reg);
+	}
+
+	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
+}
+
+static const struct clk_ops clk_lpcg_scu_ops = {
+	.enable = clk_lpcg_scu_enable,
+	.disable = clk_lpcg_scu_disable,
+};
+
+struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
+				unsigned long flags, void __iomem *reg,
+				u8 bit_idx, bool hw_gate)
+{
+	struct clk_lpcg_scu *clk;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->reg = reg;
+	clk->bit_idx = bit_idx;
+	clk->hw_gate = hw_gate;
+
+	init.name = name;
+	init.ops = &clk_lpcg_scu_ops;
+	init.flags = CLK_SET_RATE_PARENT | flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	clk->hw.init = &init;
+
+	hw = &clk->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(clk);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index 09f381b..b8e91b1 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -18,4 +18,7 @@ static inline int imx_clk_scu_init(void)
 
 struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type);
 
+struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
+				unsigned long flags, void __iomem *reg,
+				u8 bit_idx, bool hw_gate);
 #endif
-- 
2.7.4
