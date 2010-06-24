From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:50 +0200
Subject: [PATCH 54/61] ARM: imx: dynamically register imx-uart devices
	(generic part)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-55-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx-uart.c   |   60 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 ++++
 4 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-uart.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 166c0c8..09230f8 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,6 +1,9 @@
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
+config IMX_HAVE_PLATFORM_IMX_UART
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index ceb6a42..5ecbb24 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
new file mode 100644
index 0000000..fa3dff1
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_imx_uart_3irq(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irqrx, resource_size_t irqtx,
+		resource_size_t irqrts,
+		const struct imxuart_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = iobase,
+			.end = iobase + iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irqrx,
+			.end = irqrx,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = irqtx,
+			.end = irqtx,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = irqrts,
+			.end = irqrx,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imx-uart", id, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
+
+struct platform_device *__init imx_add_imx_uart_1irq(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct imxuart_platform_data *pdata)
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
+	return imx_add_platform_device("imx-uart", id, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index f67df87..05c8d3f 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -19,6 +19,17 @@ struct platform_device *__init imx_add_imx_i2c(int id,
 		resource_size_t iobase, resource_size_t iosize, int irq,
 		const struct imxi2c_platform_data *pdata);
 
+#include <mach/imx-uart.h>
+struct platform_device *__init imx_add_imx_uart_3irq(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irqrx, resource_size_t irqtx,
+		resource_size_t irqrts,
+		const struct imxuart_platform_data *pdata);
+struct platform_device *__init imx_add_imx_uart_1irq(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct imxuart_platform_data *pdata);
+
 #include <mach/mxc_nand.h>
 struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
 		int irq, const struct mxc_nand_platform_data *pdata);
-- 
1.7.1
