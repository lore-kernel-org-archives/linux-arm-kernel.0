From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:10 +0200
Subject: [PATCH 20/33] ARM i.MX: Add common clock support for pllv1
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-21-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pllv1 is found on i.MX1, i.M25, i.MX27, i.MX31 and i.MX35.
Currently only reading the rate is supported.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile    |    2 ++
 arch/arm/mach-imx/clk-pllv1.c |   57 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h       |    2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-pllv1.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index ab939c5..7e71b39 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o
+
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
 
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
new file mode 100644
index 0000000..a0b2bae
--- /dev/null
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -0,0 +1,57 @@
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
+struct clk *imx_clk_pllv1(const char *name, const char *parent,
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
+
+	clk = clk_register(NULL, name, &clk_pllv1_ops, &pll->hw, &parent,
+			1, 0);
+	if (!clk)
+		kfree(pll);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 00f2590..8a4aee6 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -5,7 +5,7 @@
 #include <linux/clk-provider.h>
 #include <mach/clock.h>
 
-struct clk *imx_clk_pllv1(const char *name, char *parent,
+struct clk *imx_clk_pllv1(const char *name, const char *parent,
 		void __iomem *base);
 
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
-- 
1.7.10
