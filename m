From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:02 -0600
Subject: [PATCH v5 03/44] clk: davinci: Add platform information for TI DA830
 PLL
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI DA830/
OMAP-L137/AM17XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-da830.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     | 14 ++++++++++++++
 3 files changed, 53 insertions(+)
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
index 0000000..369db59
--- /dev/null
+++ b/drivers/clk/davinci/pll-da830.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA830/OMAP-L137/AM17XX
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+/*
+ * NB: Technically, the clocks flagged as DIVCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+static const struct davinci_pll_divclk_info da830_pll_divclk_info[] __initconst = {
+	DIVCLK(2, pll0_sysclk2, pll0, DIVCLK_FIXED_DIV),
+	DIVCLK(3, pll0_sysclk3, pll0, 0),
+	DIVCLK(4, pll0_sysclk4, pll0, DIVCLK_FIXED_DIV),
+	DIVCLK(5, pll0_sysclk5, pll0, 0),
+	DIVCLK(6, pll0_sysclk6, pll0, DIVCLK_FIXED_DIV),
+	DIVCLK(7, pll0_sysclk7, pll0, 0),
+	{ }
+};
+
+void __init da830_pll_clk_init(void __iomem *pll)
+{
+	const struct davinci_pll_divclk_info *info;
+
+	davinci_pll_clk_register("pll0", "ref_clk", pll);
+	davinci_pll_aux_clk_register("pll0_aux_clk", "ref_clk", pll);
+	for (info = da830_pll_divclk_info; info->name; info++)
+		davinci_pll_divclk_register(info, pll);
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
