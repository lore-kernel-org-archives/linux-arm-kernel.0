From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 21:52:19 -0500
Subject: [PATCH v8 03/42] clk: davinci: Add platform information for TI DA830
 PLL
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
Message-ID: <1521168778-27236-4-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PLL clocks on TI DA830/
OMAP-L137/AM17XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v8 changes:
- drop __init and __initconst attributes
- add a clkdev lookup for each SYSCLK

v7 changes:
- include clkdev lookup registration here instead of in mach-davinci
- Add platform_device_id lookup

v6 changes:
- Added da830_pll_info with controller-specific information
- Add empty lines between function calls


 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-da830.c | 70 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |  1 +
 drivers/clk/davinci/pll.h       |  4 +++
 4 files changed, 76 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-da830.c

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
index 0000000..929a3d3
--- /dev/null
+++ b/drivers/clk/davinci/pll-da830.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA830/OMAP-L137/AM17XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clkdev.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info da830_pll_info = {
+	.name = "pll0",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
+};
+
+/*
+ * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV);
+SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0);
+SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV);
+SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0);
+SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_FIXED_DIV);
+SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0);
+
+int da830_pll_init(struct device *dev, void __iomem *base)
+{
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &da830_pll_info, "ref_clk", base);
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk2, base);
+	clk_register_clkdev(clk, "pll0_sysclk2", "da830-psc0");
+	clk_register_clkdev(clk, "pll0_sysclk2", "da830-psc1");
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk3, base);
+	clk_register_clkdev(clk, "pll0_sysclk3", "da830-psc0");
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk4, base);
+	clk_register_clkdev(clk, "pll0_sysclk4", "da830-psc0");
+	clk_register_clkdev(clk, "pll0_sysclk4", "da830-psc1");
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk5, base);
+	clk_register_clkdev(clk, "pll0_sysclk5", "da830-psc1");
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk6, base);
+	clk_register_clkdev(clk, "pll0_sysclk6", "da830-psc0");
+
+	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk7, base);
+
+	clk = davinci_pll_auxclk_register(dev, "pll0_auxclk", base);
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 22ee95c..eaf8049 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -775,6 +775,7 @@ static const struct of_device_id davinci_pll_of_match[] = {
 };
 
 static const struct platform_device_id davinci_pll_id_table[] = {
+	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 52103ae..0de2c61 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -117,4 +117,8 @@ int of_davinci_pll_init(struct device *dev,
 			u8 max_sysclk_id,
 			void __iomem *base);
 
+/* Platform-specific callbacks */
+
+int da830_pll_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
