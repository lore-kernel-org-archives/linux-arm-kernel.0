From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:15 -0600
Subject: [PATCH v5 16/44] clk: davinci: Add platform information for TI DM646x
 PSC
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-17-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PSC clocks on TI
DaVinci 646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/psc-dm646x.c | 68 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h      |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm646x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index a20e379..6c388d4 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
 obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= psc-dm644x.o
+obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= psc-dm646x.o
 endif
diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
new file mode 100644
index 0000000..cbc3976
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM646x
+ *
+ * Copyright (C) 2017 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+static const struct davinci_psc_clk_info dm646x_psc_info[] __initconst = {
+	LPSC(0, 0, arm, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(1, 0, dsp, pll1_sysclk1, LPSC_ALWAYS_ENABLED),
+	LPSC(4, 0, edma_cc, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(5, 0, edma_tc0, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(6, 0, edma_tc1, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(7, 0, edma_tc2, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(8, 0, edma_tc3, pll1_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(10, 0, ide, pll1_sysclk4, 0),
+	LPSC(14, 0, emac, pll1_sysclk3, 0),
+	LPSC(16, 0, vpif0, ref_clk, LPSC_ALWAYS_ENABLED),
+	LPSC(17, 0, vpif1, ref_clk, LPSC_ALWAYS_ENABLED),
+	LPSC(21, 0, aemif, pll1_sysclk3, LPSC_ALWAYS_ENABLED),
+	LPSC(22, 0, mcasp0, pll1_sysclk3, 0),
+	LPSC(23, 0, mcasp1, pll1_sysclk3, 0),
+	LPSC(26, 0, uart0, aux_clkin, 0),
+	LPSC(27, 0, uart1, aux_clkin, 0),
+	LPSC(28, 0, uart2, aux_clkin, 0),
+	/* REVIST: disabling hangs system */
+	LPSC(29, 0, pwm0, pll1_sysclk3, LPSC_ALWAYS_ENABLED),
+	/* REVIST: disabling hangs system */
+	LPSC(30, 0, pwm1, pll1_sysclk3, LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, i2c, pll1_sysclk3, 0),
+	LPSC(33, 0, gpio, pll1_sysclk3, 0),
+	LPSC(34, 0, timer0, pll1_sysclk3, 0),
+	LPSC(35, 0, timer1, pll1_sysclk3, 0),
+	{ }
+};
+
+void __init dm646x_psc_clk_init(void __iomem *psc)
+{
+	struct clk_onecell_data *clk_data;
+
+	clk_data = davinci_psc_register_clocks(psc, dm646x_psc_info, 41);
+	if (!clk_data)
+		return;
+
+	clk_register_clkdev(clk_data->clks[0], "arm", NULL);
+	clk_register_clkdev(clk_data->clks[10], NULL, "palm_bk3710");
+	clk_register_clkdev(clk_data->clks[14], NULL, "davinci_emac.1");
+	clk_register_clkdev(clk_data->clks[14], "fck", "davinci_mdio.0");
+	clk_register_clkdev(clk_data->clks[21], "aemif", NULL);
+	clk_register_clkdev(clk_data->clks[22], NULL, "davinci-mcasp.0");
+	clk_register_clkdev(clk_data->clks[23], NULL, "davinci-mcasp.1");
+	clk_register_clkdev(clk_data->clks[26], NULL, "serial8250.0");
+	clk_register_clkdev(clk_data->clks[27], NULL, "serial8250.1");
+	clk_register_clkdev(clk_data->clks[28], NULL, "serial8250.2");
+	clk_register_clkdev(clk_data->clks[31], NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk_data->clks[33], "gpio", NULL);
+	clk_register_clkdev(clk_data->clks[34], "timer0", NULL);
+
+	clk_free_onecell_data(clk_data);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 6d2896d..3810ea3 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -21,5 +21,6 @@ void da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 void dm355_psc_clk_init(void __iomem *psc);
 void dm365_psc_clk_init(void __iomem *psc);
 void dm644x_psc_clk_init(void __iomem *psc);
+void dm646x_psc_clk_init(void __iomem *psc);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
