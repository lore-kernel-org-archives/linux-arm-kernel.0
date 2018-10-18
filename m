From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 16:53:52 +0000
Subject: [PATCH V5 3/9] clk: imx: scu: add scu clock divider
In-Reply-To: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539881347-20871-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock divider. Note on MX8, the clocks are tightly
coupled with power domain that once the power domain is off, the clock
status will be lost. SO we make it NOCACHE to help user to retrieve the real
clock status from HW instead of using the possible invalid cached rate.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v4->v5:
 * remove unneeded jiffies.h headfile
 * use union for scu protocol structure to avoid cast
 * remove unnecessary cast
 * add more explanation about the NOCACHE flag in commit message
 * move scu clk files into imx top directory
v3->v4:
 * scu headfile path update
v2->v3:
 * structures/enums name update with imx_sc prefix
v1->v2:
 * move SCU clock API implementation into driver
---
 drivers/clk/imx/Makefile          |   3 +-
 drivers/clk/imx/clk-divider-scu.c | 171 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-scu.h         |  18 ++++
 3 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-divider-scu.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index eec6d72..b01f433 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-pfd.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o
+	clk-scu.o \
+	clk-divider-scu.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-divider-scu.c b/drivers/clk/imx/clk-divider-scu.c
new file mode 100644
index 0000000..95d5bd6
--- /dev/null
+++ b/drivers/clk/imx/clk-divider-scu.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk-scu.h"
+
+struct clk_divider_scu {
+	struct clk_hw hw;
+	u32 rsrc_id;
+	u8 clk_type;
+};
+
+/* SCU Clock Protocol definitions */
+struct imx_sc_msg_req_set_clock_rate {
+	struct imx_sc_rpc_msg hdr;
+	u32 rate;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct req_get_clock_rate {
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct resp_get_clock_rate {
+	u32 rate;
+} __packed;
+
+struct imx_sc_msg_get_clock_rate {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_clock_rate req;
+		struct resp_get_clock_rate resp;
+	} data;
+} __packed;
+
+static inline struct clk_divider_scu *to_clk_divider_scu(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_divider_scu, hw);
+}
+
+/*
+ * clk_divider_scu_recalc_rate - Get clock rate for a SCU clock
+ * @hw: clock to get rate for
+ * @parent_rate: parent rate provided by common clock framework, not used
+ *
+ * Gets the current clock rate of a SCU clock. Returns the current
+ * clock rate, or zero in failure.
+ */
+static unsigned long clk_divider_scu_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct clk_divider_scu *div = to_clk_divider_scu(hw);
+	struct imx_sc_msg_get_clock_rate msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_RATE;
+	hdr->size = 2;
+
+	msg.data.req.resource = div->rsrc_id;
+	msg.data.req.clk = div->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("%s: failed to get clock rate %d\n",
+			clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return msg.data.resp.rate;
+}
+
+/*
+ * clk_divider_scu_round_rate - Round clock rate for a SCU clock
+ * @hw: clock to round rate for
+ * @rate: rate to round
+ * @parent_rate: parent rate provided by common clock framework, not used
+ *
+ * Gets the current clock rate of a SCU clock. Returns the current
+ * clock rate, or zero in failure.
+ */
+static long clk_divider_scu_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *parent_rate)
+{
+	/*
+	 * Assume we support all the requested rate and let the SCU firmware
+	 * to handle the left work
+	 */
+	return rate;
+}
+
+/*
+ * clk_divider_scu_set_rate - Set rate for a SCU clock
+ * @hw: clock to change rate for
+ * @rate: target rate for the clock
+ * @parent_rate: rate of the clock parent, not used for SCU clocks
+ *
+ * Sets a clock frequency for a SCU clock. Returns the SCU
+ * protocol status.
+ */
+static int clk_divider_scu_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_divider_scu *div = to_clk_divider_scu(hw);
+	struct imx_sc_msg_req_set_clock_rate msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_SET_CLOCK_RATE;
+	hdr->size = 3;
+
+	msg.rate = rate;
+	msg.resource = div->rsrc_id;
+	msg.clk = div->clk_type;
+
+	return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+}
+
+static const struct clk_ops clk_divider_scu_ops = {
+	.recalc_rate = clk_divider_scu_recalc_rate,
+	.round_rate = clk_divider_scu_round_rate,
+	.set_rate = clk_divider_scu_set_rate,
+};
+
+struct clk_hw *imx_clk_register_divider_scu(const char *name,
+					    const char *parent_name,
+					    u32 rsrc_id,
+					    u8 clk_type)
+{
+	struct clk_divider_scu *div;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->rsrc_id = rsrc_id;
+	div->clk_type = clk_type;
+
+	init.name = name;
+	init.ops = &clk_divider_scu_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+	div->hw.init = &init;
+
+	hw = &div->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index b964f35..e99af63 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -7,6 +7,7 @@
 #ifndef __IMX_CLK_SCU_H
 #define __IMX_CLK_SCU_H
 
+#include <linux/clk-provider.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/spinlock.h>
 
@@ -15,4 +16,21 @@ extern struct imx_sc_ipc *ccm_ipc_handle;
 
 int imx_clk_scu_init(void);
 
+struct clk_hw *imx_clk_register_divider_scu(const char *name,
+				const char *parent_name, u32 rsrc_id,
+				u8 clk_type);
+
+static inline struct clk_hw *imx_clk_divider_scu(const char *name,
+				u32 rsrc_id, u8 clk_type)
+{
+	return imx_clk_register_divider_scu(name, NULL, rsrc_id, clk_type);
+}
+
+static inline struct clk_hw *imx_clk_divider2_scu(const char *name,
+				const char *parent_name,
+				u32 rsrc_id, u8 clk_type)
+{
+	return imx_clk_register_divider_scu(name, parent_name, rsrc_id, clk_type);
+}
+
 #endif
-- 
2.7.4
