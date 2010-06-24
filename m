From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:44 +0200
Subject: [PATCH 48/61] ARM: imx: dynamically register spi_imx devices (generic
	part)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-49-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |   30 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    5 ++++
 4 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-spi_imx.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index c50a7d6..166c0c8 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -3,3 +3,6 @@ config IMX_HAVE_PLATFORM_IMX_I2C
 
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
+
+config IMX_HAVE_PLATFORM_SPI_IMX
+	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 4a2b2de..ceb6a42 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
new file mode 100644
index 0000000..2831a6d
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_spi_imx(int id,
+		resource_size_t iobase, resource_size_t iosize, int irq,
+		const struct spi_imx_master *pdata)
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
+	return imx_add_platform_device("spi_imx", id, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8388f90..f67df87 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -24,3 +24,8 @@ struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
 		int irq, const struct mxc_nand_platform_data *pdata);
 struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
 		int irq, const struct mxc_nand_platform_data *pdata);
+
+#include <mach/spi.h>
+struct platform_device *__init imx_add_spi_imx(int id,
+		resource_size_t iobase, resource_size_t iosize, int irq,
+		const struct spi_imx_master *pdata);
-- 
1.7.1
