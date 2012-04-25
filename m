From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:15 +0200
Subject: [PATCH 25/33] ARM: imx: add common clock support for clk busy
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-26-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile   |    2 +-
 arch/arm/mach-imx/clk-busy.c |  173 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h      |    8 ++
 3 files changed, 182 insertions(+), 1 deletion(-)
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
index 0000000..5abe1f3
--- /dev/null
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -0,0 +1,173 @@
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
+#include <linux/err.h>
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
+	struct clk_divider div;
+	const struct clk_ops *div_ops;
+	void __iomem *reg;
+	u8 shift;
+};
+
+static inline struct clk_busy_divider *to_clk_busy_divider(struct clk_hw *hw)
+{
+	struct clk_divider *div = container_of(hw, struct clk_divider, hw);
+
+	return container_of(div, struct clk_busy_divider, div);
+}
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
+static int clk_busy_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_busy_divider *busy = to_clk_busy_divider(hw);
+	int ret;
+
+	ret = busy->div_ops->set_rate(&busy->div.hw, rate, parent_rate);
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
+struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
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
+	clk = clk_register(NULL, name, &clk_busy_divider_ops, &busy->div.hw,
+			   &parent_name, 1, CLK_SET_RATE_PARENT);
+	if (!clk)
+		kfree(busy);
+
+	return clk;
+}
+
+struct clk_busy_mux {
+	struct clk_mux mux;
+	const struct clk_ops *mux_ops;
+	void __iomem *reg;
+	u8 shift;
+};
+
+static inline struct clk_busy_mux *to_clk_busy_mux(struct clk_hw *hw)
+{
+	struct clk_mux *mux = container_of(hw, struct clk_mux, hw);
+
+	return container_of(mux, struct clk_busy_mux, mux);
+}
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
+			     const char **parent_names, int num_parents)
+{
+	struct clk_busy_mux *busy;
+	struct clk *clk;
+
+	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
+	if (!busy)
+		return ERR_PTR(-ENOMEM);
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
+	clk = clk_register(NULL, name, &clk_busy_mux_ops, &busy->mux.hw,
+			   parent_names, num_parents, 0);
+	if (IS_ERR(clk))
+		kfree(busy);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 5297099..1bf64fe 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -39,6 +39,14 @@ static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
+struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
+				 void __iomem *reg, u8 shift, u8 width,
+				 void __iomem *busy_reg, u8 busy_shift);
+
+struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+			     u8 width, void __iomem *busy_reg, u8 busy_shift,
+			     const char **parent_names, int num_parents);
+
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
-- 
1.7.10
