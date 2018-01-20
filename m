From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:44 -0600
Subject: [PATCH v6 05/41] clk: davinci: Add platform information for TI DM355
 PLL
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI
DM355 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- Added dm355_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-dm355.c | 66 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     |  1 +
 3 files changed, 68 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm355.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 13049d4..6720bd0 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -4,4 +4,5 @@ ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
+obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 endif
diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
new file mode 100644
index 0000000..ac93c52
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM355
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
+static const struct davinci_pll_clk_info dm355_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_OSCIN | PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED |
+		 PLL_PREDIV_FIXED8 | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm355_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+static const struct davinci_pll_clk_info dm355_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm355_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+void __init dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(&dm355_pll1_info, "ref_clk", pll1);
+
+	for (info = dm355_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll1);
+
+	davinci_pll_auxclk_register("pll1_auxclk", pll1);
+
+	davinci_pll_sysclkbp_clk_register("pll1_sysclkbp", pll1);
+
+	davinci_pll_clk_register(&dm355_pll2_info, "oscin", pll2);
+
+	for (info = dm355_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll2);
+
+	davinci_pll_sysclkbp_clk_register("pll2_sysclkbp", pll2);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 7b08fe0..95333fe 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -11,5 +11,6 @@
 
 void da830_pll_clk_init(void __iomem *pll);
 void da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1);
+void dm355_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
