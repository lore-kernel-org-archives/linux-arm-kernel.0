From: david@lechnology.com (David Lechner)
Date: Mon, 19 Feb 2018 14:21:29 -0600
Subject: [PATCH v7 08/42] clk: davinci: Add platform information for TI DM646x
 PLL
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
Message-ID: <1519071723-31790-9-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI
DM646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

Note: I meant to drop the fixed factor clock for timer2 and use pll1_sysclk3
directly in the lookup but noticed it too late. Will fix in the next rev.

v6 changes:
- Added dm646x_pll{1,2}_info with controller-specific information
- Add empty lines between function calls


 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm646x.c | 78 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c        |  2 ++
 drivers/clk/davinci/pll.h        |  3 ++
 4 files changed, 84 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm646x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 59d8ab6..d471386 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
 obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
+obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 endif
diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
new file mode 100644
index 0000000..9d3e0c2
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM646X
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info dm646x_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 14,
+	.pllm_max = 32,
+	.flags = PLL_HAS_CLKMODE,
+};
+
+static const struct davinci_pll_sysclk_info dm646x_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(4, pll1_sysclk4, pll1_pllen, 4, 0),
+	SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, 0),
+	SYSCLK(6, pll1_sysclk6, pll1_pllen, 4, 0),
+	SYSCLK(8, pll1_sysclk8, pll1_pllen, 4, 0),
+	SYSCLK(9, pll1_sysclk9, pll1_pllen, 4, 0),
+	{ }
+};
+
+static const struct davinci_pll_clk_info dm646x_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 14,
+	.pllm_max = 32,
+	.flags = 0,
+};
+
+static const struct davinci_pll_sysclk_info dm646x_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0),
+	{ }
+};
+
+int __init dm646x_pll1_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm646x_pll1_info, "ref_clk", base);
+
+	for (info = dm646x_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+
+	return 0;
+}
+
+int __init dm646x_pll2_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base);
+
+	for (info = dm646x_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	clk = clk_register_fixed_factor(dev, "timer2", "pll1_sysclk3", 0, 1, 1);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 613ec24..8fad491 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -762,6 +762,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
 	{ .name = "dm644x-pll1", .driver_data = (kernel_ulong_t)dm644x_pll1_init },
 	{ .name = "dm644x-pll2", .driver_data = (kernel_ulong_t)dm644x_pll2_init },
+	{ .name = "dm646x-pll1", .driver_data = (kernel_ulong_t)dm646x_pll1_init },
+	{ .name = "dm646x-pll2", .driver_data = (kernel_ulong_t)dm646x_pll2_init },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index df977a6..5977be0 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -135,4 +135,7 @@ int dm365_pll2_init(struct device *dev, void __iomem *base);
 int dm644x_pll1_init(struct device *dev, void __iomem *base);
 int dm644x_pll2_init(struct device *dev, void __iomem *base);
 
+int dm646x_pll1_init(struct device *dev, void __iomem *base);
+int dm646x_pll2_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
