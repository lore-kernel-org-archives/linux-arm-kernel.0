From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:07 -0600
Subject: [PATCH v5 08/44] clk: davinci: Add platform information for TI DM646x
 PLL
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-9-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI
DaVinci 646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm646x.c | 44 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h      |  1 +
 3 files changed, 46 insertions(+)
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
index 0000000..9d5bdaf
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM646X
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_divclk_info dm646x_pll1_divclk_info[] __initconst = {
+	DIVCLK(1, pll1_sysclk1, pll1, DIVCLK_FIXED_DIV),
+	DIVCLK(2, pll1_sysclk2, pll1, DIVCLK_FIXED_DIV),
+	DIVCLK(3, pll1_sysclk3, pll1, DIVCLK_FIXED_DIV),
+	DIVCLK(4, pll1_sysclk4, pll1, 0),
+	DIVCLK(5, pll1_sysclk5, pll1, 0),
+	DIVCLK(6, pll1_sysclk6, pll1, 0),
+	DIVCLK(7, pll1_sysclk7, pll1, 0),
+	DIVCLK(8, pll1_sysclk8, pll1, 0),
+	DIVCLK(9, pll1_sysclk9, pll1, 0),
+	{ }
+};
+
+static const struct davinci_pll_divclk_info dm646x_pll2_divclk_info[] __initconst = {
+	DIVCLK(1, pll2_sysclk1, pll2, 0),
+	{ }
+};
+
+void __init dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2)
+{
+	const struct davinci_pll_divclk_info *info;
+
+	davinci_pll_clk_register("pll1", "ref_clk", pll1);
+	for (info = dm646x_pll1_divclk_info; info->name; info++)
+		davinci_pll_divclk_register(info, pll1);
+	davinci_pll_bpdiv_clk_register("pll1_sysclkbp", "ref_clk", pll1);
+	davinci_pll_aux_clk_register("pll1_aux_clk", "ref_clk", pll1);
+
+	davinci_pll_clk_register("pll2_clk", "ref_clk", pll2);
+	for (info = dm646x_pll2_divclk_info; info->name; info++)
+		davinci_pll_divclk_register(info, pll2);
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
