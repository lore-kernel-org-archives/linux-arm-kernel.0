From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 1 Jun 2010 20:55:18 +0400
Subject: [PATCH 2/4] ARM: cns3xxx: Add support for SDHCI controllers
In-Reply-To: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
Message-ID: <20100601165518.GB7123@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3xxx chips have SDHCI-compatible SDIO/SD/MMC controller. This patch
adds the support using generic sdhci-pltfm driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/mach-cns3xxx/Makefile    |    2 +-
 arch/arm/mach-cns3xxx/cns3420vb.c |    2 +
 arch/arm/mach-cns3xxx/devices.c   |  145 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/devices.h   |   19 +++++
 4 files changed, 167 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-cns3xxx/devices.c
 create mode 100644 arch/arm/mach-cns3xxx/devices.h

diff --git a/arch/arm/mach-cns3xxx/Makefile b/arch/arm/mach-cns3xxx/Makefile
index 683f117..11033f1 100644
--- a/arch/arm/mach-cns3xxx/Makefile
+++ b/arch/arm/mach-cns3xxx/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_ARCH_CNS3XXX)		+= core.o pm.o
+obj-$(CONFIG_ARCH_CNS3XXX)		+= core.o pm.o devices.o
 obj-$(CONFIG_PCI)			+= pcie.o
 obj-$(CONFIG_MACH_CNS3420VB)		+= cns3420vb.o
diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 2e30c82..df9ca5b 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -32,6 +32,7 @@
 #include <mach/cns3xxx.h>
 #include <mach/irqs.h>
 #include "core.h"
+#include "devices.h"
 
 /*
  * NOR Flash
@@ -111,6 +112,7 @@ static void __init cns3420_early_serial_setup(void)
  */
 static struct platform_device *cns3420_pdevs[] __initdata = {
 	&cns3420_nor_pdev,
+	&cns3xxx_sdhci_pdev,
 };
 
 static void __init cns3420_init(void)
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
new file mode 100644
index 0000000..549ad0c
--- /dev/null
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -0,0 +1,145 @@
+/*
+ * CNS3xxx common devices
+ *
+ * Copyright 2008 Cavium Networks
+ *		  Scott Shu
+ * Copyright 2010 MontaVista Software, LLC.
+ *		  Anton Vorontsov <avorontsov@mvista.com>
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/mmc/host.h>
+#include <linux/sdhci-pltfm.h>
+#include "../../../drivers/mmc/host/sdhci.h"
+#include "devices.h"
+
+/*
+ * SDHCI
+ */
+static struct resource cns3xxx_sdhci_resources[] = {
+	[0] = {
+		.start = CNS3XXX_SDIO_BASE,
+		.end   = CNS3XXX_SDIO_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_CNS3XXX_SDIO,
+		.end   = IRQ_CNS3XXX_SDIO,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static int cns3xxx_sdhci_init(struct sdhci_host *host)
+{
+	u32 __iomem *gpioa = __io(CNS3XXX_MISC_BASE_VIRT + 0x0014);
+	u32 gpioa_pins = __raw_readl(gpioa);
+
+	/* MMC/SD pins share with GPIOA */
+	gpioa_pins |= 0x1fff0004;
+	__raw_writel(gpioa_pins, gpioa);
+
+	cns3xxx_pwr_clk_en(CNS3XXX_PWR_CLK_EN(SDIO));
+	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SDIO));
+
+	return 0;
+}
+
+static unsigned int cns3xxx_sdhci_get_max_clk(struct sdhci_host *host)
+{
+	return 150000000;
+}
+
+static unsigned int cns3xxx_sdhci_get_timeout_clk(struct sdhci_host *host)
+{
+	return cns3xxx_sdhci_get_max_clk(host) / 100000;
+}
+
+static void cns3xxx_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	int div = 1;
+	u16 clk;
+	unsigned long timeout;
+
+	if (clock == host->clock)
+		return;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		goto out;
+
+	while (host->max_clk / div > clock) {
+		/*
+		 * On CNS3xxx divider grows linearly up to 4, and then
+		 * exponentially up to 256.
+		 */
+		if (div < 4)
+			div += 1;
+		else if (div < 256)
+			div *= 2;
+		else
+			break;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host->max_clk / div);
+
+	/* Divide by 3 is special. */
+	if (div != 3)
+		div >>= 1;
+
+	clk = div << SDHCI_DIVIDER_SHIFT;
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	timeout = 10;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+			& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0)
+			return;
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	host->timeout_clk = cns3xxx_sdhci_get_timeout_clk(host);
+out:
+	host->clock = clock;
+}
+
+static struct sdhci_ops cns3xxx_sdhci_ops = {
+	.get_max_clock		= cns3xxx_sdhci_get_max_clk,
+	.get_timeout_clock	= cns3xxx_sdhci_get_timeout_clk,
+	.set_clock		= cns3xxx_sdhci_set_clock,
+};
+
+static struct sdhci_pltfm_data cns3xxx_sdhci_pdata = {
+	.ops = &cns3xxx_sdhci_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_DMA |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
+	.init = cns3xxx_sdhci_init,
+};
+
+struct platform_device cns3xxx_sdhci_pdev = {
+	.name		= "sdhci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(cns3xxx_sdhci_resources),
+	.resource	= cns3xxx_sdhci_resources,
+	.dev		= {
+		.platform_data	= &cns3xxx_sdhci_pdata,
+	},
+};
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
new file mode 100644
index 0000000..c5bf5cf
--- /dev/null
+++ b/arch/arm/mach-cns3xxx/devices.h
@@ -0,0 +1,19 @@
+/*
+ * CNS3xxx common devices
+ *
+ * Copyright 2008 Cavium Networks
+ *		  Scott Shu
+ * Copyright 2010 MontaVista Software, LLC.
+ *		  Anton Vorontsov <avorontsov@mvista.com>
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CNS3XXX_DEVICES_H_
+#define __CNS3XXX_DEVICES_H_
+
+extern struct platform_device cns3xxx_sdhci_pdev;
+
+#endif /* __CNS3XXX_DEVICES_H_ */
-- 
1.7.0.5
