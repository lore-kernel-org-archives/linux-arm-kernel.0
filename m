From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 12:55:21 +0200
Subject: [PATCH 1/3] arm: imx: add generic esdhc device
In-Reply-To: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
References: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286794523-26607-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-esdhc.c      |   31 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 ++++
 arch/arm/plat-mxc/include/mach/esdhc.h          |   16 ++++++++++++
 5 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-esdhc.c
 create mode 100644 arch/arm/plat-mxc/include/mach/esdhc.h

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 938817e..4047994 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,3 +1,6 @@
+config IMX_HAVE_PLATFORM_ESDHC
+	bool
+
 config IMX_HAVE_PLATFORM_FEC
 	bool
 	default y if ARCH_MX25 || SOC_IMX27 || ARCH_MX35 || ARCH_MX51
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 821fd10..0a3c1f0 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-y += platform-imx-dma.o
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
new file mode 100644
index 0000000..68db2a2
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2010 Pengutronix, Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <mach/devices-common.h>
+#include <mach/esdhc.h>
+
+struct platform_device *__init imx_add_esdhc(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct esdhc_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = iobase,
+			.end = iobase + iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.end = irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("sdhci-esdhc-imx", id, res,
+			ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 85740e9..0498978 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -106,3 +106,9 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+#include <mach/esdhc.h>
+struct platform_device *__init imx_add_esdhc(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct esdhc_platform_data *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
new file mode 100644
index 0000000..a48a9aa
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright 2010 Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#ifndef __ASM_ARCH_IMX_ESDHC_H
+#define __ASM_ARCH_IMX_ESDHC_H
+
+struct esdhc_platform_data {
+	unsigned int wp_gpio;	/* write protect pin */
+};
+#endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.7.1
