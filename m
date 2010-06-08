From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 21:01:59 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for SDHCI controllers
In-Reply-To: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
References: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
Message-ID: <20100608170159.GC22516@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3xxx chips have SDHCI-compatible SDIO/SD/MMC controller. This patch
adds the support using sdhci-cns3xxx driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/mach-cns3xxx/Makefile    |    2 +-
 arch/arm/mach-cns3xxx/cns3420vb.c |    3 ++
 arch/arm/mach-cns3xxx/devices.c   |   59 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/devices.h   |   19 ++++++++++++
 4 files changed, 82 insertions(+), 1 deletions(-)
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
index 2e30c82..04ae1ce 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -32,6 +32,7 @@
 #include <mach/cns3xxx.h>
 #include <mach/irqs.h>
 #include "core.h"
+#include "devices.h"
 
 /*
  * NOR Flash
@@ -117,6 +118,8 @@ static void __init cns3420_init(void)
 {
 	platform_add_devices(cns3420_pdevs, ARRAY_SIZE(cns3420_pdevs));
 
+	cns3xxx_sdhci_init();
+
 	pm_power_off = cns3xxx_power_off;
 }
 
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
new file mode 100644
index 0000000..b01a301
--- /dev/null
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -0,0 +1,59 @@
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
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/platform_device.h>
+#include <mach/cns3xxx.h>
+#include <mach/irqs.h>
+#include "core.h"
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
+static struct platform_device cns3xxx_sdhci_pdev = {
+	.name		= "sdhci-cns3xxx",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(cns3xxx_sdhci_resources),
+	.resource	= cns3xxx_sdhci_resources,
+};
+
+void __init cns3xxx_sdhci_init(void)
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
+	platform_device_register(&cns3xxx_sdhci_pdev);
+}
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
new file mode 100644
index 0000000..0735a45
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
+void __init cns3xxx_sdhci_init(void);
+
+#endif /* __CNS3XXX_DEVICES_H_ */
-- 
1.7.0.5
