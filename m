From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:46 -0600
Subject: [PATCH v6 07/41] clk: davinci: Add platform information for TI DM644x
 PLL
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-8-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI
DM644x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- Added dm644x_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm644x.c | 67 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h      |  1 +
 3 files changed, 69 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm644x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 353aa02..59d8ab6 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
+obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
 endif
diff --git a/drivers/clk/davinci/pll-dm644x.c b/drivers/clk/davinci/pll-dm644x.c
new file mode 100644
index 0000000..0c9b80f
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm644x.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM644X
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info dm644x_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 1,
+	.pllm_max = 32,
+	.pllout_min_rate = 400000000,
+	.pllout_max_rate = 600000000, /* 810MHz @ 1.3V, -810 only */
+	.flags = PLL_HAS_OSCIN | PLL_HAS_POSTDIV,
+};
+
+static const struct davinci_pll_sysclk_info dm644x_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	{ }
+};
+
+static const struct davinci_pll_clk_info dm644x_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 1,
+	.pllm_max = 32,
+	.pllout_min_rate = 400000000,
+	.pllout_max_rate = 900000000,
+	.flags = PLL_HAS_POSTDIV | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm644x_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0),
+	SYSCLK(2, pll2_sysclk2, pll2_pllen, 4, 0),
+	{ }
+};
+
+void __init dm644x_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(&dm644x_pll1_info, "ref_clk", pll1);
+
+	for (info = dm644x_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll1);
+
+	davinci_pll_auxclk_register("pll1_auxclk", pll1);
+
+	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
+
+	davinci_pll_clk_register(&dm644x_pll2_info, "oscin", pll2);
+
+	for (info = dm644x_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll2);
+
+	davinci_pll_sysclkbp_clk_register("pll2_sysclkbp", pll2);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 5bf60a7..535990a 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -13,5 +13,6 @@ void da830_pll_clk_init(void __iomem *pll);
 void da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1);
 void dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 void dm365_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
+void dm644x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
