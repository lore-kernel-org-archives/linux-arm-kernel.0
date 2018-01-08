From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:17:13 -0600
Subject: [PATCH v5 14/44] clk: davinci: Add platform information for TI DM365
 PSC
In-Reply-To: <1515377863-20358-1-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
Message-ID: <1515377863-20358-15-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PSC clocks on TI
DaVinci 365 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/psc-dm365.c | 83 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm365.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index e0da5c3..78dc1eb 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -13,4 +13,5 @@ obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
+obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
 endif
diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
new file mode 100644
index 0000000..0232832
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM365
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
+static const struct davinci_psc_clk_info dm365_psc_info[] __initconst = {
+	LPSC(1, 0, vpss_slave, pll1_sysclk5, 0),
+	LPSC(5, 0, timer3, pll1_aux_clk, 0),
+	LPSC(6, 0, spi1, pll1_sysclk4, 0),
+	LPSC(7, 0, mmcsd1, pll1_sysclk4, 0),
+	LPSC(8, 0, asp0, pll1_sysclk4, 0),
+	LPSC(9, 0, usb, pll1_aux_clk, 0),
+	LPSC(10, 0, pwm3, ref_clk, 0),
+	LPSC(11, 0, spi2, pll1_sysclk4, 0),
+	LPSC(12, 0, rto, pll1_sysclk4, 0),
+	LPSC(14, 0, aemif, pll1_sysclk4, 0),
+	LPSC(15, 0, mmcsd0, pll1_sysclk8, 0),
+	LPSC(18, 0, i2c, pll1_aux_clk, 0),
+	LPSC(19, 0, uart0, pll1_aux_clk, 0),
+	LPSC(20, 0, uart1, pll1_sysclk4, 0),
+	LPSC(22, 0, spi0, pll1_sysclk4, 0),
+	LPSC(23, 0, pwm0, pll1_aux_clk, 0),
+	LPSC(24, 0, pwm1, pll1_aux_clk, 0),
+	LPSC(25, 0, pwm2, pll1_aux_clk, 0),
+	LPSC(26, 0, gpio, pll1_sysclk4, 0),
+	LPSC(27, 0, timer0, pll1_aux_clk, 0),
+	LPSC(28, 0, timer1, pll1_aux_clk, 0),
+	/* REVISIT: why can't this be disabled? */
+	LPSC(29, 0, timer2, pll1_aux_clk, LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, arm, pll2_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(38, 0, spi3, pll1_sysclk4, 0),
+	LPSC(39, 0, spi4, pll1_aux_clk, 0),
+	LPSC(40, 0, emac, pll2_sysclk4, 0),
+	LPSC(44, 1, voice_codec, pll1_sysclk3, 0),
+	LPSC(46, 1, vpss_dac, pll1_sysclk3, 0),
+	LPSC(47, 0, vpss_master, pll1_sysclk5, 0),
+	LPSC(50, 0, mjcp, pll1_sysclk3, 0),
+	{ }
+};
+
+void __init dm365_psc_clk_init(void __iomem *psc)
+{
+	struct clk_onecell_data *clk_data;
+
+	clk_data = davinci_psc_register_clocks(psc, dm365_psc_info, 52);
+	if (!clk_data)
+		return;
+
+	clk_register_clkdev(clk_data->clks[1], "slave", "vpss");
+	clk_register_clkdev(clk_data->clks[6], NULL, "spi_davinci.1");
+	clk_register_clkdev(clk_data->clks[7], NULL, "da830-mmc.1");
+	clk_register_clkdev(clk_data->clks[8], NULL, "davinci-mcbsp");
+	clk_register_clkdev(clk_data->clks[9], "usb", NULL);
+	clk_register_clkdev(clk_data->clks[11], NULL, "spi_davinci.2");
+	clk_register_clkdev(clk_data->clks[14], "aemif", NULL);
+	clk_register_clkdev(clk_data->clks[15], NULL, "da830-mmc.0");
+	clk_register_clkdev(clk_data->clks[18], NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk_data->clks[19], NULL, "serial8250.0");
+	clk_register_clkdev(clk_data->clks[20], NULL, "serial8250.1");
+	clk_register_clkdev(clk_data->clks[22], NULL, "spi_davinci.0");
+	clk_register_clkdev(clk_data->clks[26], "gpio", NULL);
+	clk_register_clkdev(clk_data->clks[27], "timer0", NULL);
+	clk_register_clkdev(clk_data->clks[29], NULL, "davinci-wdt");
+	clk_register_clkdev(clk_data->clks[31], "arm", NULL);
+	clk_register_clkdev(clk_data->clks[38], NULL, "spi_davinci.3");
+	clk_register_clkdev(clk_data->clks[39], NULL, "spi_davinci.4");
+	clk_register_clkdev(clk_data->clks[40], NULL, "davinci_emac.1");
+	clk_register_clkdev(clk_data->clks[40], "fck", "davinci_mdio.0");
+	clk_register_clkdev(clk_data->clks[44], NULL, "davinci_voicecodec");
+	clk_register_clkdev(clk_data->clks[46], "vpss_dac", NULL);
+	clk_register_clkdev(clk_data->clks[47], "master", "vpss");
+
+	clk_free_onecell_data(clk_data);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index dc09177..c7d8c5f 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -19,5 +19,6 @@ void dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 void da830_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 void da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 void dm355_psc_clk_init(void __iomem *psc);
+void dm365_psc_clk_init(void __iomem *psc);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
