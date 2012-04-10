From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:37 +0200
Subject: [PATCH 24/40] ARM: imx: add common clock support for pfd
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-25-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile  |    3 +-
 arch/arm/mach-imx/clk-pfd.c |  138 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h     |    3 +
 3 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-pfd.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 1b3f2ae..4d6be8d 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
+			    clk-pfd.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-pfd.c b/arch/arm/mach-imx/clk-pfd.c
new file mode 100644
index 0000000..3cd2a0c
--- /dev/null
+++ b/arch/arm/mach-imx/clk-pfd.c
@@ -0,0 +1,138 @@
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
+#include "clk.h"
+
+/**
+ * struct clk_pfd - IMX PFD clock
+ * @clk_hw:	clock source
+ * @reg:	PFD register address
+ * @idx:	the index of PFD encoded in the register
+ *
+ * PFD clock found on i.MX6 series.  Each register for PFD has 4 clk_pfd
+ * data encoded, and member idx is used to specify the one.  And each
+ * register has SET, CLR and TOG registers at offset 0x4 0x8 and 0xc.
+ */
+struct clk_pfd {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		idx;
+};
+
+#define to_clk_pfd(_hw) container_of(_hw, struct clk_pfd, hw)
+
+#define SET	0x4
+#define CLR	0x8
+#define OTG	0xc
+
+static int clk_pfd_enable(struct clk_hw *hw)
+{
+	struct clk_pfd *pfd = to_clk_pfd(hw);
+
+	writel_relaxed(1 << ((pfd->idx + 1) * 8 - 1), pfd->reg + CLR);
+
+	return 0;
+}
+
+static void clk_pfd_disable(struct clk_hw *hw)
+{
+	struct clk_pfd *pfd = to_clk_pfd(hw);
+
+	writel_relaxed(1 << ((pfd->idx + 1) * 8 - 1), pfd->reg + SET);
+}
+
+static unsigned long clk_pfd_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_pfd *pfd = to_clk_pfd(hw);
+	u64 tmp = parent_rate;
+	u8 frac = (readl_relaxed(pfd->reg) >> (pfd->idx * 8)) & 0x3f;
+
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_pfd_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+	tmp = parent_rate;
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_pfd_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_pfd *pfd = to_clk_pfd(hw);
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	writel_relaxed(0x3f << (pfd->idx * 8), pfd->reg + CLR);
+	writel_relaxed(frac << (pfd->idx * 8), pfd->reg + SET);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pfd_ops = {
+	.enable		= clk_pfd_enable,
+	.disable	= clk_pfd_disable,
+	.recalc_rate	= clk_pfd_recalc_rate,
+	.round_rate	= clk_pfd_round_rate,
+	.set_rate	= clk_pfd_set_rate,
+};
+
+struct clk *imx_clk_pfd(const char *name, char *parent_name,
+			void __iomem *reg, u8 idx)
+{
+	struct clk_pfd *pfd;
+	struct clk *clk;
+
+	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
+	if (!pfd)
+		return NULL;
+	pfd->reg = reg;
+	pfd->idx = idx;
+
+	clk = clk_register(NULL, name, &clk_pfd_ops, &pfd->hw,
+			   &parent_name, 1, 0);
+	if (!clk)
+		kfree(pfd);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index fb44f03..50f5638 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -29,6 +29,9 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		char *parent_name, void __iomem *base, u32 gate_mask,
 		u32 div_mask);
 
+struct clk *imx_clk_pfd(const char *name, char *parent_name,
+		void __iomem *reg, u8 idx);
+
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
-- 
1.7.9.5
