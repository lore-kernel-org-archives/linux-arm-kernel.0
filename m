From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 26 Sep 2018 00:43:52 +0800
Subject: [PATCH V2 06/11] clk: imx: scu: add scu clock gpr gate
In-Reply-To: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
References: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1537893837-31172-7-git-send-email-aisheng.dong@nxp.com>
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
    v1->v2: no changes except update headfile name
---
 drivers/clk/imx/scu/Makefile           |  3 +-
 drivers/clk/imx/scu/clk-gate-gpr-scu.c | 84 ++++++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h          |  9 ++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/scu/clk-gate-gpr-scu.c

diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
index 2abed17..25d3511 100644
--- a/drivers/clk/imx/scu/Makefile
+++ b/drivers/clk/imx/scu/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-scu.o \
 	clk-divider-scu.o \
 	clk-divider-gpr-scu.o \
-	clk-gate-scu.o
+	clk-gate-scu.o \
+	clk-gate-gpr-scu.o
diff --git a/drivers/clk/imx/scu/clk-gate-gpr-scu.c b/drivers/clk/imx/scu/clk-gate-gpr-scu.c
new file mode 100644
index 0000000..ea3d4fb
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-gate-gpr-scu.c
@@ -0,0 +1,84 @@
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
+#include <soc/imx/scu/sci.h>
+
+#include "clk-scu.h"
+
+struct clk_gate_gpr_scu {
+	struct clk_hw hw;
+	sc_rsrc_t	rsrc_id;
+	sc_ctrl_t	gpr_id;
+
+	/* default: enable 1 disable 0 */
+	bool	invert;
+};
+
+#define to_clk_gate_gpr_scu(_hw) container_of(_hw, struct clk_gate_gpr_scu, hw)
+
+static int clk_gate_gpr_scu_enable(struct clk_hw *hw)
+{
+	struct clk_gate_gpr_scu *gate = to_clk_gate_gpr_scu(hw);
+
+	return sc_misc_set_control(ccm_ipc_handle, gate->rsrc_id,
+				   gate->gpr_id, !gate->invert);
+}
+
+static void clk_gate_gpr_scu_disable(struct clk_hw *hw)
+{
+	struct clk_gate_gpr_scu *gate = to_clk_gate_gpr_scu(hw);
+	sc_err_t sci_err;
+
+	sci_err = sc_misc_set_control(ccm_ipc_handle, gate->rsrc_id,
+				      gate->gpr_id, gate->invert);
+	if (sci_err)
+		pr_warn("%s: %s: clk disable failed %d\n",
+			__func__, clk_hw_get_name(hw), sci_err);
+}
+
+static const struct clk_ops clk_gate_gpr_scu_ops = {
+	.enable = clk_gate_gpr_scu_enable,
+	.disable = clk_gate_gpr_scu_disable,
+};
+
+struct clk_hw *clk_register_gate_gpr_scu(const char *name, const char *parent_name,
+					 sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id,
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
diff --git a/drivers/clk/imx/scu/clk-scu.h b/drivers/clk/imx/scu/clk-scu.h
index 99e45ae..13af045 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -59,4 +59,13 @@ static inline struct clk_hw *imx_clk_gate2_scu(const char *name, const char *par
 	return clk_register_gate2_scu(name, parent, 0, reg, bit_idx, hw_gate);
 }
 
+struct clk_hw *clk_register_gate_gpr_scu(const char *name, const char *parent_name,
+				sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id, bool invert_flag);
+
+static inline struct clk_hw *imx_clk_gate_gpr_scu(const char *name, const char *parent,
+				sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id, bool invert_flag)
+{
+	return clk_register_gate_gpr_scu(name, parent, rsrc_id, gpr_id, invert_flag);
+}
+
 #endif
-- 
2.7.4
