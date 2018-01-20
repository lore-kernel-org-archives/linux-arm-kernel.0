From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:42 -0600
Subject: [PATCH v6 03/41] clk: davinci: Add platform information for TI DA830
 PLL
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI DA830/
OMAP-L137/AM17XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- Added da830_pll_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-da830.c | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     | 14 +++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-da830.c
 create mode 100644 include/linux/clk/davinci.h

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index d9673bd..9061e19 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -2,4 +2,5 @@
 
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
+obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 endif
diff --git a/drivers/clk/davinci/pll-da830.c b/drivers/clk/davinci/pll-da830.c
new file mode 100644
index 0000000..548eb73
--- /dev/null
+++ b/drivers/clk/davinci/pll-da830.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA830/OMAP-L137/AM17XX
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
+static const struct davinci_pll_clk_info da830_pll_info __initconst = {
+	.name = "pll0",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_OSCIN | PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
+};
+
+/*
+ * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+static const struct davinci_pll_sysclk_info da830_pll_sysclk_info[] __initconst = {
+	SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0),
+	SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0),
+	SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0),
+	{ }
+};
+
+void __init da830_pll_clk_init(void __iomem *pll)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(&da830_pll_info, "ref_clk", pll);
+
+	davinci_pll_auxclk_register("pll0_auxclk", pll);
+
+	for (info = da830_pll_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
new file mode 100644
index 0000000..4f4d60d
--- /dev/null
+++ b/include/linux/clk/davinci.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI Davinci clocks
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ */
+#ifndef __LINUX_CLK_DAVINCI_H__
+#define __LINUX_CLK_DAVINCI_H__
+
+#include <linux/types.h>
+
+void da830_pll_clk_init(void __iomem *pll);
+
+#endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
