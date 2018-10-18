From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 16:54:00 +0000
Subject: [PATCH V5 5/9] clk: imx: scu: add scu clock gate
In-Reply-To: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539881347-20871-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock gate.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v4->v5:
 * add lock for lpcg register write
 * Remove void __iomem * for LPCG physical address, use phys_addr_t instead
 * remove unnecessary debug info
 * remove unnecessary type cast
 * move scu clk files into imx top directory
v3->v4:
 * scu headfile path update
v2->v3:
 * structure names and api usage update
v1->v2:
 * move SCU clock API implementation into driver
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-gate-scu.c | 228 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h      |  23 +++++
 3 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-gate-scu.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 5ffcb71..e311e28 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -16,7 +16,8 @@ obj-$(CONFIG_MXC_CLK) += \
 obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-scu.o \
 	clk-divider-scu.o \
-	clk-divider-gpr-scu.o
+	clk-divider-gpr-scu.o \
+	clk-gate-scu.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-gate-scu.c b/drivers/clk/imx/clk-gate-scu.c
new file mode 100644
index 0000000..759212e
--- /dev/null
+++ b/drivers/clk/imx/clk-gate-scu.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "clk-scu.h"
+
+/*
+ * basic gatable clock which can gate and ungate it's output
+ *
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define CLK_GATE_SCU_LPCG_MASK		0x3
+#define CLK_GATE_SCU_LPCG_HW_SEL	BIT(0)
+#define CLK_GATE_SCU_LPCG_SW_SEL	BIT(1)
+
+struct clk_gate_scu {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 bit_idx;
+	bool hw_gate;
+	u32 rsrc_id;
+	u8 clk_type;
+};
+
+#define to_clk_gate_scu(_hw) container_of(_hw, struct clk_gate_scu, hw)
+
+/* SCU Clock Protocol definitions */
+struct imx_sc_msg_req_clock_enable {
+	struct imx_sc_rpc_msg hdr;
+	u16	resource;
+	u8	clk;
+	u8	enable;
+	u8	autog;
+} __packed;
+
+/* Write to the LPCG bits. */
+static int clk_gate_scu_enable(struct clk_hw *hw)
+{
+	struct clk_gate_scu *gate = to_clk_gate_scu(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&imx_ccm_lock, flags);
+
+	if (gate->reg) {
+		reg = readl(gate->reg);
+		reg &= ~(CLK_GATE_SCU_LPCG_MASK << gate->bit_idx);
+		if (gate->hw_gate)
+			reg |= (CLK_GATE_SCU_LPCG_HW_SEL |
+				CLK_GATE_SCU_LPCG_SW_SEL) << gate->bit_idx;
+		else
+			reg |= (CLK_GATE_SCU_LPCG_SW_SEL << gate->bit_idx);
+		writel(reg, gate->reg);
+	}
+
+	spin_unlock_irqrestore(&imx_ccm_lock, flags);
+
+	return 0;
+}
+
+static void clk_gate_scu_disable(struct clk_hw *hw)
+{
+	struct clk_gate_scu *gate = to_clk_gate_scu(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&imx_ccm_lock, flags);
+
+	if (gate->reg) {
+		reg = readl(gate->reg);
+		reg &= ~(CLK_GATE_SCU_LPCG_MASK << gate->bit_idx);
+		writel(reg, gate->reg);
+	}
+
+	spin_unlock_irqrestore(&imx_ccm_lock, flags);
+}
+
+static int sc_pm_clock_enable(struct imx_sc_ipc *ipc, u32 resource,
+				   u8 clk, bool enable, bool autog)
+{
+	struct imx_sc_msg_req_clock_enable msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_CLOCK_ENABLE;
+	hdr->size = 3;
+
+	msg.resource = resource;
+	msg.clk = clk;
+	msg.enable = enable;
+	msg.autog = autog;
+
+	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+}
+
+static int clk_gate_scu_prepare(struct clk_hw *hw)
+{
+	struct clk_gate_scu *gate = to_clk_gate_scu(hw);
+
+	/* Enable the clock at the DSC slice level */
+	return sc_pm_clock_enable(ccm_ipc_handle, gate->rsrc_id,
+				  gate->clk_type, true, gate->hw_gate);
+}
+
+static void clk_gate_scu_unprepare(struct clk_hw *hw)
+{
+	struct clk_gate_scu *gate = to_clk_gate_scu(hw);
+	int ret;
+
+	ret = sc_pm_clock_enable(ccm_ipc_handle, gate->rsrc_id,
+				     gate->clk_type, false, false);
+	if (ret)
+		pr_warn("%s: clk unprepare failed %d\n", clk_hw_get_name(hw),
+			ret);
+}
+
+static const struct clk_ops clk_gate_scu_ops = {
+	.prepare = clk_gate_scu_prepare,
+	.unprepare = clk_gate_scu_unprepare,
+	.enable = clk_gate_scu_enable,
+	.disable = clk_gate_scu_disable,
+};
+
+struct clk_hw *clk_register_gate_scu(const char *name, const char *parent_name,
+				     unsigned long flags, u32 rsrc_id,
+				     u8 clk_type, phys_addr_t reg,
+				     u8 bit_idx, bool hw_gate)
+{
+	struct clk_gate_scu *gate;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->rsrc_id = rsrc_id;
+	gate->clk_type = clk_type;
+	if (reg) {
+		gate->reg = ioremap(reg, SZ_64K);
+		if (!gate->reg) {
+			kfree(gate);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	gate->bit_idx = bit_idx;
+	gate->hw_gate = hw_gate;
+
+	init.name = name;
+	init.ops = &clk_gate_scu_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		iounmap(gate->reg);
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static const struct clk_ops clk_gate2_scu_ops = {
+	.enable = clk_gate_scu_enable,
+	.disable = clk_gate_scu_disable,
+};
+
+struct clk_hw *clk_register_gate2_scu(const char *name, const char *parent_name,
+				      unsigned long flags, phys_addr_t reg,
+				      u8 bit_idx, bool hw_gate)
+{
+	struct clk_gate_scu *gate;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->reg = ioremap(reg, SZ_64K);
+	if (!gate->reg) {
+		kfree(gate);
+		return ERR_PTR(-ENOMEM);
+	}
+	gate->bit_idx = bit_idx;
+	gate->hw_gate = hw_gate;
+
+	init.name = name;
+	init.ops = &clk_gate2_scu_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		iounmap(gate->reg);
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index f0796f3..3885884 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -36,4 +36,27 @@ static inline struct clk_hw *imx_clk_divider2_scu(const char *name,
 struct clk_hw *imx_clk_divider_gpr_scu(const char *name, const char *parent_name,
 				u32 rsrc_id, u8 gpr_id);
 
+struct clk_hw *clk_register_gate_scu(const char *name, const char *parent_name,
+				unsigned long flags, u32 rsrc_id,
+				u8 clk_type, phys_addr_t reg,
+				u8 bit_idx, bool hw_gate);
+
+struct clk_hw *clk_register_gate2_scu(const char *name, const char *parent_name,
+				unsigned long flags, phys_addr_t reg,
+				u8 bit_idx, bool hw_gate);
+
+static inline struct clk_hw *imx_clk_gate_scu(const char *name, const char *parent,
+				u32 rsrc_id, u8 clk_type,
+				phys_addr_t reg, u8 bit_idx, bool hw_gate)
+{
+	return clk_register_gate_scu(name, parent, CLK_SET_RATE_PARENT,
+				     rsrc_id, clk_type, reg, bit_idx, hw_gate);
+}
+
+static inline struct clk_hw *imx_clk_gate2_scu(const char *name, const char *parent,
+				phys_addr_t reg, u8 bit_idx, bool hw_gate)
+{
+	return clk_register_gate2_scu(name, parent, 0, reg, bit_idx, hw_gate);
+}
+
 #endif
-- 
2.7.4
