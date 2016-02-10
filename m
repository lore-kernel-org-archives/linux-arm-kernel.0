From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:51 +0100
Subject: [PATCH 2/8] clk: add artpec-6 pll1 clock driver
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <30bfa3b9a237699a7a2078c51903238aa330b992.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLL1 clock is a fixed-factor clock with factors derived from boot
mode pins. This driver is a simple wrapper to register the fixed
factor clock according to the pin settings.

Signed-off-by: Lars Persson <larper@axis.com>
---
 drivers/clk/Makefile      |  1 +
 drivers/clk/clk-artpec6.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 drivers/clk/clk-artpec6.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b038e36..388f0cf 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -17,6 +17,7 @@ endif
 
 # hardware specific clock types
 # please keep this section sorted lexicographically by file/directory path name
+obj-$(CONFIG_MACH_ARTPEC6)		+= clk-artpec6.o
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
diff --git a/drivers/clk/clk-artpec6.c b/drivers/clk/clk-artpec6.c
new file mode 100644
index 0000000..3664c44
--- /dev/null
+++ b/drivers/clk/clk-artpec6.c
@@ -0,0 +1,70 @@
+/*
+ * ARTPEC-6 clock initialization
+ *
+ * Copyright 2015 Axis Comunications AB.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+static void __init of_artpec6_pll1_setup(struct device_node *np)
+{
+	void __iomem *devstat;
+	struct clk *clk;
+	const char *clk_name = np->name;
+	const char *parent_name;
+	u32 pll_mode, pll_m, pll_n;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	devstat = of_iomap(np, 0);
+	if (devstat == NULL) {
+		pr_err("error to ioremap DEVSTAT\n");
+		return;
+	}
+
+	/* DEVSTAT register contains PLL settings */
+	pll_mode = (readl(devstat) >> 6) & 3;
+	iounmap(devstat);
+
+	/*
+	 * pll1 settings are designed for different DDR speeds using a fixed
+	 * 50MHz external clock. However, a different external clock could be
+	 * used on different boards.
+	 * CPU clock is half the DDR clock.
+	 */
+	switch (pll_mode) {
+	case 0: /* DDR3-2133 mode */
+		pll_m = 4;
+		pll_n = 85;
+		break;
+	case 1: /* DDR3-1866 mode */
+		pll_m = 6;
+		pll_n = 112;
+		break;
+	case 2: /* DDR3-1600 mode */
+		pll_m = 4;
+		pll_n = 64;
+		break;
+	case 3: /* DDR3-1333 mode */
+		pll_m = 8;
+		pll_n = 106;
+		break;
+	}
+	/* ext_clk is defined in device tree */
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
+			pll_n, pll_m);
+	if (IS_ERR(clk)) {
+		pr_err("%s not registered\n", clk_name);
+		return;
+	}
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(artpec6_pll1, "axis,artpec6-pll1-clock", of_artpec6_pll1_setup);
-- 
2.1.4
