From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 26 Sep 2018 00:43:54 +0800
Subject: [PATCH V2 08/11] clk: imx: scu: add scu clock gpr mux
In-Reply-To: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
References: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1537893837-31172-9-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock gpr mux. Unlike the normal scu mux, such
muxes are controlled by GPR bits through SCU sc_misc_set_control
API.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 v1->v2:
  * no changes except headfile name updated
---
 drivers/clk/imx/scu/Makefile          |  3 +-
 drivers/clk/imx/scu/clk-mux-gpr-scu.c | 90 +++++++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h         | 11 +++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/scu/clk-mux-gpr-scu.c

diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
index aee56bf..a76ed78 100644
--- a/drivers/clk/imx/scu/Makefile
+++ b/drivers/clk/imx/scu/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-divider-gpr-scu.o \
 	clk-gate-scu.o \
 	clk-gate-gpr-scu.o \
-	clk-mux-scu.o
+	clk-mux-scu.o \
+	clk-mux-gpr-scu.o
diff --git a/drivers/clk/imx/scu/clk-mux-gpr-scu.c b/drivers/clk/imx/scu/clk-mux-gpr-scu.c
new file mode 100644
index 0000000..c4b5687
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-mux-gpr-scu.c
@@ -0,0 +1,90 @@
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
+struct clk_mux_gpr_scu {
+	struct clk_hw hw;
+	sc_rsrc_t	rsrc_id;
+	sc_ctrl_t	gpr_id;
+};
+
+#define to_clk_mux_gpr_scu(_hw) container_of(_hw, struct clk_mux_gpr_scu, hw)
+
+static u8 clk_mux_gpr_scu_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux_gpr_scu *gpr_mux = to_clk_mux_gpr_scu(hw);
+	sc_err_t ret;
+	u32 val = 0;
+
+	ret = sc_misc_get_control(ccm_ipc_handle, gpr_mux->rsrc_id,
+				  gpr_mux->gpr_id, &val);
+	if (ret != SC_ERR_NONE) {
+		pr_warn("%s: failed to get clock parent %d\n",
+			clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return (u8)val;
+}
+
+static int clk_mux_gpr_scu_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux_gpr_scu *gpr_mux = to_clk_mux_gpr_scu(hw);
+	sc_err_t ret;
+
+	ret = sc_misc_set_control(ccm_ipc_handle, gpr_mux->rsrc_id,
+				  gpr_mux->gpr_id, index);
+	if (ret != SC_ERR_NONE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct clk_ops clk_mux_gpr_scu_ops = {
+	.get_parent = clk_mux_gpr_scu_get_parent,
+	.set_parent = clk_mux_gpr_scu_set_parent,
+};
+
+struct clk_hw *clk_register_mux_gpr_scu(const char *name, const char * const *parents,
+					int num_parents, unsigned long flags,
+					sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id)
+{
+	struct clk_mux_gpr_scu *mux;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_mux_gpr_scu_ops;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+	init.flags = flags;
+
+	mux->hw.init = &init;
+	mux->rsrc_id = rsrc_id;
+	mux->gpr_id = gpr_id;
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
index 43009c4..828700d 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -81,4 +81,15 @@ static inline struct clk_hw *imx_clk_mux_scu(const char *name,
 			clk_type);
 }
 
+struct clk_hw *clk_register_mux_gpr_scu(const char *name, const char * const *parents,
+			int num_parents, unsigned long flags,
+			sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id);
+
+static inline struct clk_hw *imx_clk_mux_gpr_scu(const char *name, const char * const *parents,
+			int num_parents, sc_rsrc_t rsrc_id, sc_ctrl_t gpr_id)
+{
+	return clk_register_mux_gpr_scu(name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT, rsrc_id, gpr_id);
+}
+
 #endif
-- 
2.7.4
