From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 26 Sep 2018 00:43:49 +0800
Subject: [PATCH V2 03/11] clk: imx: scu: add scu clock divider
In-Reply-To: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
References: <1537893837-31172-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1537893837-31172-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock divider.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * move SCU clock API implementation into driver
---
 drivers/clk/imx/scu/Makefile          |   3 +-
 drivers/clk/imx/scu/clk-divider-scu.c | 190 ++++++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h         |  18 ++++
 3 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/scu/clk-divider-scu.c

diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
index 7dead13..7e360e2 100644
--- a/drivers/clk/imx/scu/Makefile
+++ b/drivers/clk/imx/scu/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o
+	clk-scu.o \
+	clk-divider-scu.o
diff --git a/drivers/clk/imx/scu/clk-divider-scu.c b/drivers/clk/imx/scu/clk-divider-scu.c
new file mode 100644
index 0000000..9da75ae
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-divider-scu.c
@@ -0,0 +1,190 @@
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
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+#include <soc/imx/scu/sci.h>
+
+#include "clk-scu.h"
+
+struct clk_divider_scu {
+	struct clk_hw	hw;
+	sc_rsrc_t	rsrc_id;
+	uint8_t	clk_type;
+};
+
+/* SCU Clock Protocol definitions */
+struct imx_sc_msg_req_set_clock_rate {
+	struct sc_rpc_msg hdr;
+	u32 rate;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_req_get_clock_rate {
+	struct sc_rpc_msg hdr;
+	u16 resource;
+	u8 clk;
+} __packed;
+
+struct imx_sc_msg_resp_get_clock_rate {
+	struct sc_rpc_msg hdr;
+	u32 rate;
+} __packed;
+
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
+						  unsigned long parent_rate)
+{
+	struct clk_divider_scu *div = to_clk_divider_scu(hw);
+	struct imx_sc_msg_req_get_clock_rate msg;
+	struct imx_sc_msg_resp_get_clock_rate *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	sc_err_t sci_err;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_GET_CLOCK_RATE;
+	hdr->size = 2;
+
+	msg.resource = div->rsrc_id;
+	msg.clk = div->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
+	sci_err = (sc_err_t)resp->hdr.func;
+	if (sci_err) {
+		pr_err("%s: failed to get clock rate %d\n",
+			clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return resp->rate;
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
+	struct imx_sc_msg_resp_get_clock_rate *resp;
+	struct sc_rpc_msg *hdr = &msg.hdr;
+	sc_err_t sci_err;
+	int ret;
+
+	hdr->ver = SC_RPC_VERSION;
+	hdr->svc = (uint8_t)SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)PM_FUNC_SET_CLOCK_RATE;
+	hdr->size = 3;
+
+	msg.rate = rate;
+	msg.resource = div->rsrc_id;
+	msg.clk = div->clk_type;
+
+	ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_get_clock_rate *)&msg;
+	sci_err = (sc_err_t)resp->hdr.func;
+	if (sci_err) {
+		pr_err("%s: failed to set clock rate %ld : ret %d\n",
+			clk_hw_get_name(hw), rate, sci_err);
+		return -EINVAL;
+	}
+
+	return 0;
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
+					    sc_rsrc_t rsrc_id,
+					    uint8_t clk_type)
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
diff --git a/drivers/clk/imx/scu/clk-scu.h b/drivers/clk/imx/scu/clk-scu.h
index c503a52..c433cd4 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -7,6 +7,7 @@
 #ifndef __IMX_CLK_SCU_H
 #define __IMX_CLK_SCU_H
 
+#include <linux/clk-provider.h>
 #include <linux/spinlock.h>
 #include <soc/imx/scu/sci.h>
 
@@ -15,4 +16,21 @@ extern struct sc_ipc *ccm_ipc_handle;
 
 int imx_clk_scu_init(void);
 
+struct clk_hw *imx_clk_register_divider_scu(const char *name,
+				const char *parent_name, sc_rsrc_t rsrc_id,
+				uint8_t clk_type);
+
+static inline struct clk_hw *imx_clk_divider_scu(const char *name,
+				sc_rsrc_t rsrc_id, uint8_t clk_type)
+{
+	return imx_clk_register_divider_scu(name, NULL, rsrc_id, clk_type);
+}
+
+static inline struct clk_hw *imx_clk_divider2_scu(const char *name,
+				const char *parent_name,
+				sc_rsrc_t rsrc_id, uint8_t clk_type)
+{
+	return imx_clk_register_divider_scu(name, parent_name, rsrc_id, clk_type);
+}
+
 #endif
-- 
2.7.4
