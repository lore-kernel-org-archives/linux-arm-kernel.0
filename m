From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:38 +0200
Subject: [PATCH 25/40] ARM: imx: add common clock support for clk busy
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-26-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile   |    2 +-
 arch/arm/mach-imx/clk-busy.c |  167 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h      |    8 ++
 3 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-busy.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 4d6be8d..ae0a779 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
 obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
-			    clk-pfd.o
+			    clk-pfd.o clk-busy.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
new file mode 100644
index 0000000..9450f0b
--- /dev/null
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include "clk.h"
+
+static int clk_busy_wait(void __iomem *reg, u8 shift)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+
+	while (readl_relaxed(reg) & (1 << shift))
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+
+	return 0;
+}
+
+struct clk_busy_divider {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 shift;
+	struct clk_divider div;
+	const struct clk_ops *div_ops;
+};
+
+#define to_clk_busy_divider(_hw) container_of(_hw, struct clk_busy_divider, hw)
+
+static unsigned long clk_busy_divider_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
+
+	return busy->div_ops->recalc_rate(&busy->div.hw, parent_rate);
+}
+
+static long clk_busy_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *prate)
+{
+	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
+
+	return busy->div_ops->round_rate(&busy->div.hw, rate, prate);
+}
+
+static int clk_busy_divider_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
+	int ret;
+
+	ret = busy->div_ops->set_rate(&busy->div.hw, rate);
+	if (!ret)
+		ret = clk_busy_wait(busy->reg, busy->shift);
+
+	return ret;
+}
+
+static struct clk_ops clk_busy_divider_ops = {
+	.recalc_rate = clk_busy_divider_recalc_rate,
+	.round_rate = clk_busy_divider_round_rate,
+	.set_rate = clk_busy_divider_set_rate,
+};
+
+struct clk *imx_clk_busy_divider(const char *name, char *parent_name,
+				 void __iomem *reg, u8 shift, u8 width,
+				 void __iomem *busy_reg, u8 busy_shift)
+{
+	struct clk_busy_divider *busy;
+	struct clk *clk;
+
+	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
+	if (!busy)
+		return NULL;
+
+	busy->reg = busy_reg;
+	busy->shift = busy_shift;
+
+	busy->div.reg = reg;
+	busy->div.shift = shift;
+	busy->div.width = width;
+	busy->div.lock = &imx_ccm_lock;
+	busy->div_ops = &clk_divider_ops;
+
+	clk = clk_register(NULL, name, &clk_busy_divider_ops, &busy->hw,
+			   &parent_name, 1, CLK_SET_RATE_PARENT);
+	if (!clk)
+		kfree(busy);
+
+	busy->div.hw.clk = clk;
+
+	return clk;
+}
+
+struct clk_busy_mux {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 shift;
+	struct clk_mux mux;
+	const struct clk_ops *mux_ops;
+};
+
+#define to_clk_busy_mux(_hw) container_of(_hw, struct clk_busy_mux, hw)
+
+static u8 clk_busy_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_busy_mux *busy = to_clk_busy_mux(hw);
+
+	return busy->mux_ops->get_parent(&busy->mux.hw);
+}
+
+static int clk_busy_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_busy_mux *busy = to_clk_busy_mux(hw);
+	int ret;
+
+	ret = busy->mux_ops->set_parent(&busy->mux.hw, index);
+	if (!ret)
+		ret = clk_busy_wait(busy->reg, busy->shift);
+
+	return ret;
+}
+
+struct clk_ops clk_busy_mux_ops = {
+	.get_parent = clk_busy_mux_get_parent,
+	.set_parent = clk_busy_mux_set_parent,
+};
+
+struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+			     u8 width, void __iomem *busy_reg, u8 busy_shift,
+			     char **parent_names, int num_parents)
+{
+	struct clk_busy_mux *busy;
+	struct clk *clk;
+
+	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
+	if (!busy)
+		return NULL;
+
+	busy->reg = busy_reg;
+	busy->shift = busy_shift;
+
+	busy->mux.reg = reg;
+	busy->mux.shift = shift;
+	busy->mux.width = width;
+	busy->mux.lock = &imx_ccm_lock;
+	busy->mux_ops = &clk_mux_ops;
+
+	clk = clk_register(NULL, name, &clk_busy_mux_ops, &busy->hw,
+			   parent_names, num_parents, 0);
+	if (!clk)
+		kfree(busy);
+
+	busy->mux.hw.clk = clk;
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 50f5638..53ab2f5 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -44,6 +44,10 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+struct clk *imx_clk_busy_divider(const char *name, char *parent_name,
+				 void __iomem *reg, u8 shift, u8 width,
+				 void __iomem *busy_reg, u8 busy_shift);
+
 static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -65,6 +69,10 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
+struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+			     u8 width, void __iomem *busy_reg, u8 busy_shift,
+			     char **parent_names, int num_parents);
+
 static inline struct clk *imx_clk_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
-- 
1.7.9.5
