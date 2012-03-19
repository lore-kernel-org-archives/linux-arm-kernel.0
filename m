From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 14:36:02 +0100
Subject: [PATCH 4/8] ARM i.MX: Add common clock support for pllv1
In-Reply-To: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
References: <1332164166-6055-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1332164166-6055-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile    |    2 +
 arch/arm/mach-imx/clk-pllv1.c |   59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-pllv1.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 55db9c4..1f138ae 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o
+
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
new file mode 100644
index 0000000..afbd95f
--- /dev/null
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -0,0 +1,59 @@
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/clock.h>
+#include "clk.h"
+
+/**
+ * pll v1
+ *
+ * @clk_hw	clock source
+ * @parent	the parent clock name
+ * @base	base address of pll registers
+ *
+ * PLL clock version 1, found on i.MX1/21/25/27/31/35
+ */
+struct clk_pllv1 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+	char		*parent;
+};
+
+#define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
+
+static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_pllv1 *pll = to_clk_pllv1(hw);
+
+	return mxc_decode_pll(readl(pll->base), parent_rate);
+}
+
+struct clk_ops clk_pllv1_ops = {
+	.recalc_rate = clk_pllv1_recalc_rate,
+};
+
+struct clk *imx_clk_pllv1(const char *name, char *parent,
+		void __iomem *base)
+{
+	struct clk_pllv1 *pll;
+	struct clk *clk;
+
+	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return NULL;
+
+	pll->base = base;
+	pll->parent = parent;
+
+	clk = clk_register(NULL, name, &clk_pllv1_ops, &pll->hw, &pll->parent,
+			1, 0);
+	if (!clk)
+		kfree(pll);
+
+	return clk;
+}
-- 
1.7.9.1
