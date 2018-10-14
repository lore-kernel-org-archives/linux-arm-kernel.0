From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 08:08:02 +0000
Subject: [PATCH V4 07/11] clk: imx: scu: add scu clock mux
In-Reply-To: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539504194-28289-8-git-send-email-aisheng.dong@nxp.com>
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
ChangeLog:
v3->v4:
 * scu headfile path update
v2->v3:
 * structure name and api usage update
v1->v2:
 * move SCU clock API implementation into driver
---
 drivers/clk/imx/scu/Makefile      |   3 +-
 drivers/clk/imx/scu/clk-mux-scu.c | 130 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h     |  13 ++++
 3 files changed, 145 insertions(+), 1 deletion(-)
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
index 0000000..fdef58d
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-mux-scu.c
@@ -0,0 +1,130 @@
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
+struct clk_mux_scu {
+	struct clk_hw hw;
+	u32 rsrc_id;
+	u8 clk_type;
+};
+
+#define to_clk_mux_scu(_hw) container_of(_hw, struct clk_mux_scu, hw)
+
+
+/* SCU Clock Protocol definitions */
+struct imx_sc_msg_req_set_clock_parent {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+	u8 parent;
+} __packed;
+
+struct imx_sc_msg_req_get_clock_parent {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_resp_get_clock_parent {
+	struct imx_sc_rpc_msg hdr;
+	u8 parent;
+} __packed;
+
+static u8 clk_mux_scu_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux_scu *mux = to_clk_mux_scu(hw);
+	struct imx_sc_msg_req_get_clock_parent msg;
+	struct imx_sc_msg_resp_get_clock_parent *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)IMX_SC_PM_FUNC_GET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.resource = mux->rsrc_id;
+	msg.clk = mux->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: failed to get clock parent %d\n",
+			clk_hw_get_name(hw), ret);
+		return ret;
+	}
+
+	resp = (struct imx_sc_msg_resp_get_clock_parent *)&msg;
+
+	return resp->parent;
+}
+
+static int clk_mux_scu_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux_scu *mux = to_clk_mux_scu(hw);
+	struct imx_sc_msg_req_set_clock_parent msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)IMX_SC_PM_FUNC_SET_CLOCK_PARENT;
+	hdr->size = 2;
+
+	msg.resource = mux->rsrc_id;
+	msg.clk = mux->clk_type;
+	msg.parent = index;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret)
+		pr_err("%s: failed to set clock parent %d : ret %d\n",
+			clk_hw_get_name(hw), index, ret);
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
+				    u32 rsrc_id, u8 clk_type)
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
index 56338ca..b2b56d3 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -68,4 +68,17 @@ static inline struct clk_hw *imx_clk_gate_gpr_scu(const char *name, const char *
 	return clk_register_gate_gpr_scu(name, parent, rsrc_id, gpr_id, invert_flag);
 }
 
+struct clk_hw *clk_register_mux_scu(const char *name, const char * const *parents,
+			int num_parents, unsigned long flags,
+			u32 rsrc_id, u8 clk_type);
+
+static inline struct clk_hw *imx_clk_mux_scu(const char *name,
+			const char * const *parents, int num_parents,
+			u32 rsrc_id, u8 clk_type)
+{
+	return clk_register_mux_scu(name, parents, num_parents,
+			CLK_SET_RATE_NO_REPARENT, rsrc_id,
+			clk_type);
+}
+
 #endif
-- 
2.7.4
