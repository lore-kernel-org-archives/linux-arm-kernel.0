From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 16:54:04 +0000
Subject: [PATCH V5 6/9] clk: imx: scu: add scu clock gpr gate
In-Reply-To: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539881347-20871-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock gpr gate. Unlike the normal scu gate, such
gates are controlled by GPR bits through SCU sc_misc_set_control
API.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v4->v5:
 * move scu clk files into imx top directory
v3->v4:
 * scu headfile path update
v2->v3:
 * structure name and api usage update
v1->v2:
 * no changes except update headfile name
---
 drivers/clk/imx/Makefile           |  3 +-
 drivers/clk/imx/clk-gate-gpr-scu.c | 87 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h          |  9 ++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-gate-gpr-scu.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e311e28..4564175 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-scu.o \
 	clk-divider-scu.o \
 	clk-divider-gpr-scu.o \
-	clk-gate-scu.o
+	clk-gate-scu.o \
+	clk-gate-gpr-scu.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-gate-gpr-scu.c b/drivers/clk/imx/clk-gate-gpr-scu.c
new file mode 100644
index 0000000..4a8f6d3
--- /dev/null
+++ b/drivers/clk/imx/clk-gate-gpr-scu.c
@@ -0,0 +1,87 @@
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
+
+#include "clk-scu.h"
+
+struct clk_gate_gpr_scu {
+	struct clk_hw hw;
+	u32 rsrc_id;
+	u8 gpr_id;
+
+	/* default: enable 1 disable 0 */
+	bool invert;
+};
+
+#define to_clk_gate_gpr_scu(_hw) container_of(_hw, struct clk_gate_gpr_scu, hw)
+
+static int clk_gate_gpr_scu_enable(struct clk_hw *hw)
+{
+	struct clk_gate_gpr_scu *gate = to_clk_gate_gpr_scu(hw);
+	int ret;
+
+	ret = imx_sc_misc_set_control(ccm_ipc_handle, gate->rsrc_id,
+				      gate->gpr_id, !gate->invert);
+	if (ret)
+		pr_err("%s: clk enable failed %d\n", clk_hw_get_name(hw), ret);
+
+	return ret;
+}
+
+static void clk_gate_gpr_scu_disable(struct clk_hw *hw)
+{
+	struct clk_gate_gpr_scu *gate = to_clk_gate_gpr_scu(hw);
+	int ret;
+
+	ret  = imx_sc_misc_set_control(ccm_ipc_handle, gate->rsrc_id,
+				       gate->gpr_id, gate->invert);
+	if (ret)
+		pr_err("%s: clk disable failed %d\n", clk_hw_get_name(hw), ret);
+}
+
+static const struct clk_ops clk_gate_gpr_scu_ops = {
+	.enable = clk_gate_gpr_scu_enable,
+	.disable = clk_gate_gpr_scu_disable,
+};
+
+struct clk_hw *clk_register_gate_gpr_scu(const char *name, const char *parent_name,
+					 u32 rsrc_id, u8 gpr_id,
+					 bool invert_flag)
+{
+	struct clk_gate_gpr_scu *gate;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	gate->rsrc_id = rsrc_id;
+	gate->gpr_id = gpr_id;
+	gate->invert = invert_flag;
+
+	init.name = name;
+	init.ops = &clk_gate_gpr_scu_ops;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(gate);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index 3885884..673b280 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -59,4 +59,13 @@ static inline struct clk_hw *imx_clk_gate2_scu(const char *name, const char *par
 	return clk_register_gate2_scu(name, parent, 0, reg, bit_idx, hw_gate);
 }
 
+struct clk_hw *clk_register_gate_gpr_scu(const char *name, const char *parent_name,
+				u32 rsrc_id, u8 gpr_id, bool invert_flag);
+
+static inline struct clk_hw *imx_clk_gate_gpr_scu(const char *name, const char *parent,
+				u32 rsrc_id, u8 gpr_id, bool invert_flag)
+{
+	return clk_register_gate_gpr_scu(name, parent, rsrc_id, gpr_id, invert_flag);
+}
+
 #endif
-- 
2.7.4
