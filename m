From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun, 30 Sep 2018 08:56:19 +0800
Subject: [PATCH V3 04/11] clk: imx: scu: add scu clock gpr divider
In-Reply-To: <1538268986-24890-1-git-send-email-aisheng.dong@nxp.com>
References: <1538268986-24890-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1538268986-24890-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scu based clock gpr divider. Unlike the normal scu divider, such
dividers are controlled by GPR bits through SCU sc_misc_set_control
API.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v2->v3:
 * structures name and api use update
v1->v2:
 * no changes except update headfile name
---
 drivers/clk/imx/scu/Makefile              |   3 +-
 drivers/clk/imx/scu/clk-divider-gpr-scu.c | 130 ++++++++++++++++++++++++++++++
 drivers/clk/imx/scu/clk-scu.h             |   3 +
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/scu/clk-divider-gpr-scu.c

diff --git a/drivers/clk/imx/scu/Makefile b/drivers/clk/imx/scu/Makefile
index 7e360e2..9e7f4aa 100644
--- a/drivers/clk/imx/scu/Makefile
+++ b/drivers/clk/imx/scu/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-scu.o \
-	clk-divider-scu.o
+	clk-divider-scu.o \
+	clk-divider-gpr-scu.o
diff --git a/drivers/clk/imx/scu/clk-divider-gpr-scu.c b/drivers/clk/imx/scu/clk-divider-gpr-scu.c
new file mode 100644
index 0000000..2843bf9
--- /dev/null
+++ b/drivers/clk/imx/scu/clk-divider-gpr-scu.c
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
+#include <soc/imx/scu/sci.h>
+
+#include "clk-scu.h"
+
+struct clk_divider_gpr_scu {
+	struct clk_hw	hw;
+	u32	rsrc_id;
+	u8	gpr_id;
+};
+
+static inline struct clk_divider_gpr_scu *to_clk_divider_gpr_scu(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_divider_gpr_scu, hw);
+}
+
+/*
+ * clk_divider_scu_recalc_rate - Get clock rate for a SCU clock
+ * @hw: clock to get rate for
+ * @parent_rate: parent rate provided by common clock framework
+ *
+ * Gets the current clock rate of a SCU clock. Returns the current
+ * clock rate, or zero in failure.
+ */
+static unsigned long clk_divider_gpr_scu_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_divider_gpr_scu *clk = to_clk_divider_gpr_scu(hw);
+	u32 val;
+	int ret;
+
+	ret = imx_sc_misc_get_control(ccm_ipc_handle, clk->rsrc_id,
+				      clk->gpr_id, &val);
+	if (ret) {
+		pr_err("%s: failed to get clock rate %d\n",
+			clk_hw_get_name(hw), ret);
+		return 0;
+	}
+
+	return val ? parent_rate / 2 : parent_rate;
+}
+
+/*
+ * clk_divider_scu_round_rate - Round clock rate for a SCU clock
+ * @hw: clock to round rate for
+ * @rate: rate to round
+ * @parent_rate: parent rate provided by common clock framework
+ *
+ * Round clock rate for a SCU clock according to parent rate
+ */
+static long clk_divider_gpr_scu_round_rate(struct clk_hw *hw, unsigned long rate,
+					   unsigned long *prate)
+{
+	if (rate < *prate)
+		rate = *prate / 2;
+	else
+		rate = *prate;
+
+	return rate;
+}
+
+/*
+ * clk_divider_scu_set_rate - Set rate for a SCU clock
+ * @hw: clock to change rate for
+ * @rate: target rate for the clock
+ * @parent_rate: rate of the clock parent
+ *
+ * Sets a clock frequency for a SCU clock. Returns the SCU
+ * protocol status.
+ */
+static int clk_divider_gpr_scu_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider_gpr_scu *clk = to_clk_divider_gpr_scu(hw);
+	uint32_t val;
+
+	val = (rate < parent_rate) ? 1 : 0;
+
+	return imx_sc_misc_set_control(ccm_ipc_handle, clk->rsrc_id,
+				       clk->gpr_id, val);
+}
+
+static const struct clk_ops clk_divider_gpr_scu_ops = {
+	.recalc_rate = clk_divider_gpr_scu_recalc_rate,
+	.round_rate = clk_divider_gpr_scu_round_rate,
+	.set_rate = clk_divider_gpr_scu_set_rate,
+};
+
+struct clk_hw *imx_clk_divider_gpr_scu(const char *name, const char *parent_name,
+				       u32 rsrc_id, u8 gpr_id)
+{
+	struct clk_divider_gpr_scu *div;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->rsrc_id = rsrc_id;
+	div->gpr_id = gpr_id;
+
+	init.name = name;
+	init.ops = &clk_divider_gpr_scu_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
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
index 38f9cb2..10aa687 100644
--- a/drivers/clk/imx/scu/clk-scu.h
+++ b/drivers/clk/imx/scu/clk-scu.h
@@ -33,4 +33,7 @@ static inline struct clk_hw *imx_clk_divider2_scu(const char *name,
 	return imx_clk_register_divider_scu(name, parent_name, rsrc_id, clk_type);
 }
 
+struct clk_hw *imx_clk_divider_gpr_scu(const char *name, const char *parent_name,
+				u32 rsrc_id, u8 gpr_id);
+
 #endif
-- 
2.7.4
