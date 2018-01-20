From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:53 -0600
Subject: [PATCH v6 14/41] clk: davinci: Add platform information for TI DM365
 PSC
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-15-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PSC clocks on TI
DM365 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/psc-dm365.c | 79 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     |  1 +
 3 files changed, 81 insertions(+)
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
index 0000000..dd6eb1d
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM365
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
+LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
+LPSC_CLKDEV1(spi1_clkdev,		NULL,		"spi_davinci.1");
+LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"da830-mmc.1");
+LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
+LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
+LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
+LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"da830-mmc.0");
+LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
+LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
+LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
+LPSC_CLKDEV1(spi0_clkdev,		NULL,		"spi_davinci.0");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
+LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
+LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
+LPSC_CLKDEV1(spi3_clkdev,		NULL,		"spi_davinci.3");
+LPSC_CLKDEV1(spi4_clkdev,		NULL,		"spi_davinci.4");
+LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
+					"fck",		"davinci_mdio.0");
+LPSC_CLKDEV1(voice_codec_clkdev,	NULL,		"davinci_voicecodec");
+LPSC_CLKDEV1(vpss_dac_clkdev,		"vpss_dac",	NULL);
+LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
+
+static const struct davinci_psc_clk_info dm365_psc_info[] __initconst = {
+	LPSC(1,  0, vpss_slave,  pll1_sysclk5, vpss_slave_clkdev,  0),
+	LPSC(5,  0, timer3,      pll1_auxclk,  NULL,               0),
+	LPSC(6,  0, spi1,        pll1_sysclk4, spi1_clkdev,        0),
+	LPSC(7,  0, mmcsd1,      pll1_sysclk4, mmcsd1_clkdev,      0),
+	LPSC(8,  0, asp0,        pll1_sysclk4, asp0_clkdev,        0),
+	LPSC(9,  0, usb,         pll1_auxclk,  usb_clkdev,         0),
+	LPSC(10, 0, pwm3,        pll1_auxclk,  NULL,               0),
+	LPSC(11, 0, spi2,        pll1_sysclk4, spi2_clkdev,        0),
+	LPSC(12, 0, rto,         pll1_sysclk4, NULL,               0),
+	LPSC(14, 0, aemif,       pll1_sysclk4, aemif_clkdev,       0),
+	LPSC(15, 0, mmcsd0,      pll1_sysclk8, mmcsd0_clkdev,      0),
+	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
+	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
+	LPSC(20, 0, uart1,       pll1_sysclk4, uart1_clkdev,       0),
+	LPSC(22, 0, spi0,        pll1_sysclk4, spi0_clkdev,        0),
+	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
+	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
+	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
+	LPSC(26, 0, gpio,        pll1_sysclk4, gpio_clkdev,        0),
+	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      0),
+	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
+	/* REVISIT: why can't this be disabled? */
+	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,
+	     LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, arm,         pll2_sysclk2, NULL,
+	     LPSC_ALWAYS_ENABLED),
+	LPSC(38, 0, spi3,        pll1_sysclk4, spi3_clkdev,        0),
+	LPSC(39, 0, spi4,        pll1_auxclk,  spi4_clkdev,        0),
+	LPSC(40, 0, emac,        pll2_sysclk4, emac_clkdev,        0),
+	LPSC(44, 1, voice_codec, pll1_sysclk3, voice_codec_clkdev, 0),
+	LPSC(46, 1, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
+	LPSC(47, 0, vpss_master, pll1_sysclk5, vpss_master_clkdev, 0),
+	LPSC(50, 0, mjcp,        pll1_sysclk3, NULL,               0),
+	{ }
+};
+
+void __init dm365_psc_clk_init(void __iomem *psc)
+{
+	davinci_psc_register_clocks(dm365_psc_info, psc);
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
