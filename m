From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:47 -0600
Subject: [PATCH v6 08/41] clk: davinci: Add platform information for TI DM646x
 PLL
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-9-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI
DM646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- Added dm646x_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm646x.c | 63 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h      |  1 +
 3 files changed, 65 insertions(+)
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
index 0000000..2d58d11
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM646X
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
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
+	.flags = PLL_HAS_OSCIN,
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
+void __init dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(&dm646x_pll1_info, "ref_clk", pll1);
+
+	for (info = dm646x_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll1);
+
+	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
+
+	davinci_pll_auxclk_register("pll1_auxclk", pll1);
+
+	davinci_pll_clk_register(&dm646x_pll2_info, "oscin", pll2);
+
+	for (info = dm646x_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll2);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 535990a..d495de7 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -14,5 +14,6 @@ void da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1);
 void dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 void dm365_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 void dm644x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
+void dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
