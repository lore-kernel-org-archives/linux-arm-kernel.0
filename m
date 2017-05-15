From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 21:59:19 +0800
Subject: [PATCH 5/9] clk: imx: add pfdv2 support
In-Reply-To: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494856763-6543-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pfdv2 is designed for PLL Fractional Divide (PFD) observed in System
Clock Generation (SCG) module in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pfdv2 can only be operated when clk is gated.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/Makefile    |   3 +-
 drivers/clk/imx/clk-pfdv2.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-pfdv2.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 1e308e2..ea4ef27 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -11,7 +11,8 @@ obj-y += \
 	clk-pllv2.o \
 	clk-pllv3.o \
 	clk-pllv4.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-pfdv2.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
new file mode 100644
index 0000000..e5c4ad7
--- /dev/null
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/**
+ * struct clk_pfdv2 - IMX PFD clock
+ * @clk_hw:	clock source
+ * @reg:	PFD register address
+ * @gate_bit:	Gate bit offset
+ * @vld_bit:	Valid bit offset
+ * @frac_off:	PLL Fractional Divider offset
+ */
+
+struct clk_pfdv2 {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		gate_bit;
+	u8		vld_bit;
+	u8		frac_off;
+};
+
+#define to_clk_pfdv2(_hw) container_of(_hw, struct clk_pfdv2, hw)
+
+#define CLK_PFDV2_FRAC_MASK 0x3f
+
+static int clk_pfdv2_wait(struct clk_pfdv2 *pfd)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+
+	while (!(readl_relaxed(pfd->reg) & pfd->vld_bit))
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int clk_pfdv2_enable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u32 val;
+
+	val = readl_relaxed(pfd->reg);
+	val &= ~pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+
+	return clk_pfdv2_wait(pfd);
+}
+
+static void clk_pfdv2_disable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u32 val;
+
+	val = readl_relaxed(pfd->reg);
+	val |= pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+}
+
+static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	frac = (readl_relaxed(pfd->reg) >> pfd->frac_off)
+		& CLK_PFDV2_FRAC_MASK;
+
+	if (!frac) {
+		pr_debug("clk_pfdv2: %s invalid pfd frac value 0\n",
+			 clk_hw_get_name(hw));
+		return 0;
+	}
+
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	u64 tmp = *prate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	tmp = *prate;
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_pfdv2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+
+	if (readl_relaxed(pfd->reg) & pfd->gate_bit)
+		return 0;
+
+	return 1;
+}
+
+static int clk_pfdv2_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u64 tmp = parent_rate;
+	u32 val;
+	u8 frac;
+
+	if (clk_pfdv2_is_enabled(hw)) {
+		WARN(1, "clk_pfdv2: can't change rate when pfd is enabled");
+		return -EINVAL;
+	}
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	val = readl_relaxed(pfd->reg);
+	val &= ~(CLK_PFDV2_FRAC_MASK << pfd->frac_off);
+	val |= frac << pfd->frac_off;
+	writel_relaxed(val, pfd->reg);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pfdv2_ops = {
+	.enable		= clk_pfdv2_enable,
+	.disable	= clk_pfdv2_disable,
+	.recalc_rate	= clk_pfdv2_recalc_rate,
+	.round_rate	= clk_pfdv2_round_rate,
+	.set_rate	= clk_pfdv2_set_rate,
+	.is_enabled     = clk_pfdv2_is_enabled,
+};
+
+struct clk *imx_clk_pfdv2(const char *name, const char *parent_name,
+			void __iomem *reg, u8 idx)
+{
+	struct clk_pfdv2 *pfd;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	WARN_ON(idx > 3);
+
+	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
+	if (!pfd)
+		return ERR_PTR(-ENOMEM);
+
+	pfd->reg = reg;
+	pfd->gate_bit = 1 << ((idx + 1) * 8 - 1);
+	pfd->vld_bit = pfd->gate_bit - 1;
+	pfd->frac_off = idx * 8;
+
+	init.name = name;
+	init.ops = &clk_pfdv2_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pfd->hw.init = &init;
+
+	clk = clk_register(NULL, &pfd->hw);
+	if (IS_ERR(clk))
+		kfree(pfd);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f599732..51b84e4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -58,6 +58,9 @@ struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
+struct clk *imx_clk_pfdv2(const char *name, const char *parent_name,
+			  void __iomem *reg, u8 idx);
+
 struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
-- 
2.7.4
