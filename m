From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 02:56:38 +0800
Subject: [PATCH 07/12] clk: imx: scu: add scu clock mux
In-Reply-To: <1524855403-15301-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855403-15301-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855403-15301-8-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock mux.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/scu/Makefile      |  3 +-
 drivers/clk/imx/scu/clk-mux-scu.c | 89 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h     | 13 ++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/scu/clk-mux-scu.c

diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
index 25d3511..aee56bf 100644
--- a/drivers/clk/imx/scu/Makefile
+++ b/drivers/clk/imx/scu/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-divider-scu.o \
 	clk-divider-gpr-scu.o \
 	clk-gate-scu.o \
-	clk-gate-gpr-scu.o
+	clk-gate-gpr-scu.o \
+	clk-mux-scu.o
diff --git a/drivers/clk/imx/scu/clk-mux-scu.c b/drivers/clk/imx/scu/clk-mux-scu.c
new file mode 100644
index 0000000..52efd99b
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-mux-scu.c
@@ -0,0 +1,89 @@
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
+#include <soc/imx/sc/sci.h>
+
+#include "clk-scu.h"
+
+struct clk_mux_scu {
+	struct clk_hw	hw;
+	sc_rsrc_t	rsrc_id;
+	sc_pm_clk_t	clk_type;
+};
+
+#define to_clk_mux_scu(_hw) container_of(_hw, struct clk_mux_scu, hw)
+
+static u8 clk_mux_scu_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux_scu *mux = to_clk_mux_scu(hw);
+	sc_pm_clk_parent_t parent;
+	sc_err_t ret;
+
+	ret = sc_pm_get_clock_parent(ccm_ipc_handle, mux->rsrc_id,
+				     mux->clk_type, &parent);
+	if (ret != SC_ERR_NONE) {
+		pr_warn("%s: failed to get clock parent %d\n",
+		clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return (u8)parent;
+}
+
+static int clk_mux_scu_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux_scu *mux = to_clk_mux_scu(hw);
+	sc_err_t ret;
+
+	ret = sc_pm_set_clock_parent(ccm_ipc_handle, mux->rsrc_id,
+				     mux->clk_type, index);
+	if (ret != SC_ERR_NONE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct clk_ops clk_mux_scu_ops = {
+	.get_parent = clk_mux_scu_get_parent,
+	.set_parent = clk_mux_scu_set_parent,
+};
+
+struct clk_hw *clk_register_mux_scu(const char *name, const char * const *parents,
+				    int num_parents, unsigned long flags,
+				    sc_rsrc_t rsrc_id, sc_pm_clk_t clk_type)
+{
+	struct clk_init_data init;
+	struct clk_mux_scu *mux;
+	struct clk_hw *hw;
+	int ret;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_mux_scu_ops;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
+	mux->hw.init = &init;
+	mux->rsrc_id = rsrc_id;
+	mux->clk_type = clk_type;
+
+	hw = &mux->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(mux);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/scu/clk-scu.h b/drivers/clk/imx/scu/clk-scu.h
index e419035..672a26c 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -68,4 +68,17 @@ static inline struct clk_hw *imx_clk_gate_gpr_scu(const char *name, const char *
 	return clk_register_gate_gpr_scu(name, parent, rsrc_id, gpr_id, invert_flag);
 }
 
+struct clk_hw *clk_register_mux_scu(const char *name, const char * const *parents,
+			int num_parents, unsigned long flags,
+			sc_rsrc_t rsrc_id, sc_pm_clk_t clk_type);
+
+static inline struct clk_hw *imx_clk_mux_scu(const char *name,
+			const char * const *parents, int num_parents,
+			sc_rsrc_t rsrc_id, sc_pm_clk_t clk_type)
+{
+	return clk_register_mux_scu(name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT, rsrc_id,
+			clk_type);
+}
+
 #endif
-- 
2.7.4
