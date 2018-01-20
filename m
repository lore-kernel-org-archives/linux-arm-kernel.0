From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:54 -0600
Subject: [PATCH v6 15/41] clk: davinci: Add platform information for TI DM644x
 PSC
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-16-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PSC clocks on TI
DM644x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/psc-dm644x.c | 68 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h      |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm644x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 78dc1eb..a20e379 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
+obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= psc-dm644x.o
 endif
diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
new file mode 100644
index 0000000..c3a84e7
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM644x
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
+LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
+LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
+					"fck",		"davinci_mdio.0");
+LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
+LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
+LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
+LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
+LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
+LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
+LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,		NULL,		"serial8250.2");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
+LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
+LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
+
+static const struct davinci_psc_clk_info dm644x_psc_info[] __initconst = {
+	LPSC(0,  0, vpss_master, pll1_sysclk3, vpss_master_clkdev, 0),
+	LPSC(1,  0, vpss_slave,  pll1_sysclk3, vpss_slave_clkdev,  0),
+	LPSC(6,  0, emac,        pll1_sysclk5, emac_clkdev,        0),
+	LPSC(9,  0, usb,         pll1_sysclk5, usb_clkdev,         0),
+	LPSC(10, 0, ide,         pll1_sysclk5, ide_clkdev,         0),
+	LPSC(11, 0, vlynq,       pll1_sysclk5, NULL,               0),
+	LPSC(14, 0, aemif,       pll1_sysclk5, aemif_clkdev,       0),
+	LPSC(15, 0, mmcsd,       pll1_sysclk5, mmcsd_clkdev,       0),
+	LPSC(17, 0, asp0,        pll1_sysclk5, asp0_clkdev,        0),
+	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
+	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
+	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
+	LPSC(21, 0, uart2,       pll1_auxclk,  uart2_clkdev,       0),
+	LPSC(22, 0, spi,         pll1_sysclk5, NULL,               0),
+	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
+	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
+	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
+	LPSC(26, 0, gpio,        pll1_sysclk5, gpio_clkdev,        0),
+	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      0),
+	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
+	/* REVISIT: why can't this be disabled? */
+	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,
+	     LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, arm,         pll1_sysclk2, NULL, LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(39, 1, dsp,         pll1_sysclk1, NULL, LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(40, 1, vicp,        pll1_sysclk2, NULL, LPSC_ALWAYS_ENABLED),
+	{ }
+};
+
+void __init dm644x_psc_clk_init(void __iomem *psc)
+{
+	davinci_psc_register_clocks(dm644x_psc_info, psc);
+}
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index c7d8c5f..6d2896d 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -20,5 +20,6 @@ void da830_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 void da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 void dm355_psc_clk_init(void __iomem *psc);
 void dm365_psc_clk_init(void __iomem *psc);
+void dm644x_psc_clk_init(void __iomem *psc);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
