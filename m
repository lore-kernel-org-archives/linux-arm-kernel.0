From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:13:51 -0600
Subject: [PATCH v6 12/41] clk: davinci: Add platform information for TI DA850
 PSC
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-13-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds platform-specific declarations for the PSC clocks on TI DA850/
OMAP-L138/AM18XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile    |   1 +
 drivers/clk/davinci/psc-da850.c | 109 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/davinci.h     |   1 +
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-da850.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index fb14c8c..aef0390 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 
 obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 endif
diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
new file mode 100644
index 0000000..df36e1c
--- /dev/null
+++ b/drivers/clk/davinci/psc-da850.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DA850/OMAP-L138/AM18XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+LPSC_CLKDEV2(emifa_clkdev,	NULL,		"ti-aemif",
+				"aemif",	"davinci-nand.0");
+LPSC_CLKDEV1(spi0_clkdev,	NULL,		"spi_davinci.0");
+LPSC_CLKDEV1(mmcsd0_clkdev,	NULL,		"da830-mmc.0");
+LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
+/* REVISIT: used dev_id instead of con_id */
+LPSC_CLKDEV1(arm_clkdev,	"arm",		NULL);
+LPSC_CLKDEV1(dsp_clkdev,	NULL,		"davinci-rproc.0");
+
+static const struct davinci_psc_clk_info da850_psc0_info[] __initconst = {
+	LPSC(0,  0, tpcc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(1,  0, tptc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(2,  0, tptc1,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, emifa,   async1,       emifa_clkdev,  0),
+	LPSC(4,  0, spi0,    pll0_sysclk2, spi0_clkdev,   0),
+	LPSC(5,  0, mmcsd0,  pll0_sysclk2, mmcsd0_clkdev, 0),
+	LPSC(6,  0, aintc,   pll0_sysclk4, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, arm_rom, pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(9,  0, uart0,   pll0_sysclk2, uart0_clkdev,  0),
+	LPSC(13, 0, pruss,   pll0_sysclk2, NULL,          0),
+	LPSC(14, 0, arm,     pll0_sysclk6, arm_clkdev,    LPSC_ALWAYS_ENABLED |
+							  LPSC_ARM_RATE),
+	LPSC(15, 1, dsp,     pll0_sysclk1, dsp_clkdev,    LPSC_FORCE |
+							  LPSC_LOCAL_RESET),
+	{ }
+};
+
+LPSC_CLKDEV2(usb0_clkdev,	NULL,	"musb-da8xx",
+				NULL,	"cppi41-dmaengine");
+LPSC_CLKDEV1(usb1_clkdev,	NULL,	"ohci-da8xx");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,	"gpio",	NULL);
+LPSC_CLKDEV2(emac_clkdev,	NULL,	"davinci_emac.1",
+				"fck",	"davinci_mdio.0");
+LPSC_CLKDEV1(mcasp0_clkdev,	NULL,	"davinci-mcasp.0");
+LPSC_CLKDEV1(sata_clkdev,	"fck",	"ahci_da850");
+LPSC_CLKDEV1(vpif_clkdev,	NULL,	"vpif");
+LPSC_CLKDEV1(spi1_clkdev,	NULL,	"spi_davinci.1");
+LPSC_CLKDEV1(i2c1_clkdev,	NULL,	"i2c_davinci.2");
+LPSC_CLKDEV1(uart1_clkdev,	NULL,	"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,	NULL,	"serial8250.2");
+LPSC_CLKDEV1(mcbsp0_clkdev,	NULL,	"davinci-mcbsp.0");
+LPSC_CLKDEV1(mcbsp1_clkdev,	NULL,	"davinci-mcbsp.1");
+LPSC_CLKDEV1(lcdc_clkdev,	"fck",	"da8xx_lcdc.0");
+LPSC_CLKDEV2(ehrpwm_clkdev,	"fck",	"ehrpwm.0",
+				"fck",	"ehrpwm.1");
+LPSC_CLKDEV1(mmcsd1_clkdev,	NULL,	"da830-mmc.1");
+LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
+				"fck",	"ecap.1",
+				"fck",	"ecap.2");
+
+static const struct davinci_psc_clk_info da850_psc1_info[] __initconst = {
+	LPSC(0,  0, tpcc1,  pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(1,  0, usb0,   pll0_sysclk2, usb0_clkdev,   0),
+	LPSC(2,  0, usb1,   pll0_sysclk4, usb1_clkdev,   0),
+	LPSC(3,  0, gpio,   pll0_sysclk4, gpio_clkdev,   0),
+	LPSC(5,  0, emac,   pll0_sysclk4, emac_clkdev,   0),
+	LPSC(6,  0, ddr,    pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, mcasp0, async3,       mcasp0_clkdev, 0),
+	LPSC(8,  0, sata,   pll0_sysclk2, sata_clkdev,   LPSC_FORCE),
+	LPSC(9,  0, vpif,   pll0_sysclk2, vpif_clkdev,   0),
+	LPSC(10, 0, spi1,   async3,       spi1_clkdev,   0),
+	LPSC(11, 0, i2c1,   pll0_sysclk4, i2c1_clkdev,   0),
+	LPSC(12, 0, uart1,  async3,       uart1_clkdev,  0),
+	LPSC(13, 0, uart2,  async3,       uart2_clkdev,  0),
+	LPSC(14, 0, mcbsp0, async3,       mcbsp0_clkdev, 0),
+	LPSC(15, 0, mcbsp1, async3,       mcbsp1_clkdev, 0),
+	LPSC(16, 0, lcdc,   pll0_sysclk2, lcdc_clkdev,   0),
+	LPSC(17, 0, ehrpwm, async3,       ehrpwm_clkdev, 0),
+	LPSC(18, 0, mmcsd1, pll0_sysclk2, mmcsd1_clkdev, 0),
+	LPSC(20, 0, ecap,   async3,       ecap_clkdev,   0),
+	LPSC(21, 0, tptc2,  pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	{ }
+};
+
+void __init da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1)
+{
+	davinci_psc_register_clocks(da850_psc0_info, psc0);
+	davinci_psc_register_clocks(da850_psc1_info, psc1);
+}
+
+#ifdef CONFIG_OF
+static void __init of_da850_psc0_clk_init(struct device_node *node)
+{
+	of_davinci_psc_clk_init(node, da850_psc0_info, 16);
+}
+CLK_OF_DECLARE(da850_psc0_clk, "ti,da850-psc0", of_da850_psc0_clk_init);
+
+static void __init of_da850_psc1_clk_init(struct device_node *node)
+{
+	of_davinci_psc_clk_init(node, da850_psc1_info, 32);
+}
+CLK_OF_DECLARE(da850_psc1_clk, "ti,da850-psc1", of_da850_psc1_clk_init);
+#endif
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 3ec8100..3d8bdfa 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -17,5 +17,6 @@ void dm644x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 void dm646x_pll_clk_init(void __iomem *pll1, void __iomem *pll2);
 
 void da830_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
+void da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1);
 
 #endif /* __LINUX_CLK_DAVINCI_H__ */
-- 
2.7.4
