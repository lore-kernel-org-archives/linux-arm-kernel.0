From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:43 -0600
Subject: [PATCH v6 04/41] clk: davinci: Add platform information for TI DA850
 PLL
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI DA850/
OMAP-L138/AM18XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- Added da850_pll{0,1}_info with controller-specific information
- Added OBSCLK data
- Add empty lines between function calls

 drivers/clk/davinci/Makefile    |   1 +
 drivers/clk/davinci/pll-da850.c | 163 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     |   1 +
 3 files changed, 165 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-da850.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 9061e19..13049d4 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -3,4 +3,5 @@
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 endif
diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
new file mode 100644
index 0000000..a94e1a6
--- /dev/null
+++ b/drivers/clk/davinci/pll-da850.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA850/OMAP-L138/AM18XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/of.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+#define OCSEL_OCSRC_OSCIN		0x14
+#define OCSEL_OCSRC_PLL0_SYSCLK(n)	(0x16 + (n))
+#define OCSEL_OCSRC_PLL1_OBSCLK		0x1e
+#define OCSEL_OCSRC_PLL1_SYSCLK(n)	(0x16 + (n))
+
+static const struct davinci_pll_clk_info da850_pll0_info __initconst = {
+	.name = "pll0",
+	.unlock_reg = CFGCHIP(0),
+	.unlock_mask = CFGCHIP0_PLL_MASTER_LOCK,
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_OSCIN | PLL_HAS_PREDIV | PLL_HAS_POSTDIV |
+		 PLL_HAS_EXTCLKSRC,
+};
+
+/*
+ * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+static const struct davinci_pll_sysclk_info da850_pll0_sysclk_info[] __initconst = {
+	SYSCLK(1, pll0_sysclk1, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0),
+	SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0),
+	SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_ARM_RATE | SYSCLK_FIXED_DIV),
+	SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0),
+	{ }
+};
+
+static const char * const da850_pll0_obsclk_parent_names[] __initconst = {
+	"oscin",
+	"pll0_sysclk1",
+	"pll0_sysclk2",
+	"pll0_sysclk3",
+	"pll0_sysclk4",
+	"pll0_sysclk5",
+	"pll0_sysclk6",
+	"pll0_sysclk7",
+	"pll1_obsclk",
+};
+
+static u32 da850_pll0_obsclk_table[] = {
+	OCSEL_OCSRC_OSCIN,
+	OCSEL_OCSRC_PLL0_SYSCLK(1),
+	OCSEL_OCSRC_PLL0_SYSCLK(2),
+	OCSEL_OCSRC_PLL0_SYSCLK(3),
+	OCSEL_OCSRC_PLL0_SYSCLK(4),
+	OCSEL_OCSRC_PLL0_SYSCLK(5),
+	OCSEL_OCSRC_PLL0_SYSCLK(6),
+	OCSEL_OCSRC_PLL0_SYSCLK(7),
+	OCSEL_OCSRC_PLL1_OBSCLK,
+};
+
+static const struct davinci_pll_obsclk_info da850_pll0_obsclk_info __initconst = {
+	.name = "pll0_obsclk",
+	.parent_names = da850_pll0_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(da850_pll0_obsclk_parent_names),
+	.table = da850_pll0_obsclk_table,
+	.ocsrc_mask = GENMASK(4, 0),
+};
+
+static const struct davinci_pll_clk_info da850_pll1_info __initconst = {
+	.name = "pll1",
+	.unlock_reg = CFGCHIP(3),
+	.unlock_mask = CFGCHIP3_PLL1_MASTER_LOCK,
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_POSTDIV,
+};
+
+static const struct davinci_pll_sysclk_info da850_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, 0),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, 0),
+	{ }
+};
+
+static const char * const da850_pll1_obsclk_parent_names[] __initconst = {
+	"oscin",
+	"pll1_sysclk1",
+	"pll1_sysclk2",
+	"pll1_sysclk3",
+};
+
+static u32 da850_pll1_obsclk_table[] = {
+	OCSEL_OCSRC_OSCIN,
+	OCSEL_OCSRC_PLL1_SYSCLK(1),
+	OCSEL_OCSRC_PLL1_SYSCLK(2),
+	OCSEL_OCSRC_PLL1_SYSCLK(3),
+};
+
+static const struct davinci_pll_obsclk_info da850_pll1_obsclk_info __initconst = {
+	.name = "pll1_obsclk",
+	.parent_names = da850_pll1_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(da850_pll1_obsclk_parent_names),
+	.table = da850_pll1_obsclk_table,
+	.ocsrc_mask = GENMASK(4, 0),
+};
+
+void __init da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(&da850_pll0_info, "ref_clk", pll0);
+
+	davinci_pll_auxclk_register("pll0_auxclk", pll0);
+
+	for (info = da850_pll0_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll0);
+
+	davinci_pll_obsclk_register(&da850_pll0_obsclk_info, pll0);
+
+	davinci_pll_clk_register(&da850_pll1_info, "oscin", pll1);
+
+	for (info = da850_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(info, pll1);
+
+	davinci_pll_obsclk_register(&da850_pll1_obsclk_info, pll1);
+}
+
+#ifdef CONFIG_OF
+static void __init of_da850_pll0_auxclk_init(struct device_node *node)
+{
+	of_davinci_pll_init(node, &da850_pll0_info, &da850_pll0_obsclk_info,
+			    da850_pll0_sysclk_info, 7);
+}
+CLK_OF_DECLARE(da850_pll0_auxclk, "ti,da850-pll0", of_da850_pll0_auxclk_init);
+
+static void __init of_da850_pll1_auxclk_init(struct device_node *node)
+{
+	of_davinci_pll_init(node, &da850_pll1_info, &da850_pll1_obsclk_info,
+			    da850_pll1_sysclk_info, 3);
+}
+CLK_OF_DECLARE(da850_pll1_auxclk, "ti,da850-pll1", of_da850_pll1_auxclk_init);
+#endif
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 4f4d60d..7b08fe0 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -10,5 +10,6 @@
 #include <linux/types.h>
 
 void da830_pll_clk_init(void __iomem *pll);
+void da850_pll_clk_init(void __iomem *pll0, void __iomem *pll1);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
