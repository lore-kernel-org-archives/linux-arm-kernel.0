From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:24 +0200
Subject: [PATCH V2 5/6] imx: dynamically register flexcan devices for mx25 and
	mx35
In-Reply-To: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
References: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279816165-6542-6-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make this patch compile, even if the flexcan driver with
it's header defining the platform data isn't merged yet, two ifdefs have
been added. They effect that the "imx_add_flexcan" function results in a
no-op function if the driver hasn't been activated.

These ifdefs can be removed after the flexcan driver has been merged.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx25/devices-imx25.h              |    5 ++++
 arch/arm/mach-mx3/devices-imx35.h               |    5 ++++
 arch/arm/plat-mxc/devices/Kconfig               |    4 +++
 arch/arm/plat-mxc/devices/Makefile              |    4 +++
 arch/arm/plat-mxc/devices/platform-flexcan.c    |   30 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   18 +++++++++++++
 6 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-flexcan.c

diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 2025cb9..d86a7c3 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -9,6 +9,11 @@
 #include <mach/mx25.h>
 #include <mach/devices-common.h>
 
+#define imx25_add_flexcan0(pdata)	\
+	imx_add_flexcan(0, MX25_CAN1_BASE_ADDR, SZ_16K, MX25_INT_CAN1, pdata)
+#define imx25_add_flexcan1(pdata)	\
+	imx_add_flexcan(1, MX25_CAN2_BASE_ADDR, SZ_16K, MX25_INT_CAN2, pdata)
+
 #define imx25_add_imx_i2c0(pdata)	\
 	imx_add_imx_i2c(0, MX25_I2C1_BASE_ADDR, SZ_16K, MX25_INT_I2C1, pdata)
 #define imx25_add_imx_i2c1(pdata)	\
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 536d9b9..f6a431a 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -9,6 +9,11 @@
 #include <mach/mx35.h>
 #include <mach/devices-common.h>
 
+#define imx35_add_flexcan0(pdata)	\
+	imx_add_flexcan(0, MX35_CAN1_BASE_ADDR, SZ_16K, MX35_INT_CAN1, pdata)
+#define imx35_add_flexcan1(pdata)	\
+	imx_add_flexcan(1, MX35_CAN2_BASE_ADDR, SZ_16K, MX35_INT_CAN2, pdata)
+
 #define imx35_add_imx_i2c0(pdata)	\
 	imx_add_imx_i2c(0, MX35_I2C1_BASE_ADDR, SZ_4K, MX35_INT_I2C1, pdata)
 #define imx35_add_imx_i2c1(pdata)	\
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 09230f8..9ab784b 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,3 +1,7 @@
+config IMX_HAVE_PLATFORM_FLEXCAN
+	select HAVE_CAN_FLEXCAN
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 5ecbb24..347da51 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,3 +1,7 @@
+ifdef CONFIG_CAN_FLEXCAN
+# the ifdef can be removed once the flexcan driver has been merged
+obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) +=  platform-flexcan.o
+endif
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
new file mode 100644
index 0000000..5e97a01
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-flexcan.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2010 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_flexcan(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct flexcan_platform_data *pdata)
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
+	return imx_add_platform_device("flexcan", id, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 05c8d3f..c5f68c5 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -14,6 +14,24 @@ struct platform_device *imx_add_platform_device(const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data);
 
+#if defined (CONFIG_CAN_FLEXCAN) || defined (CONFIG_CAN_FLEXCAN_MODULE)
+#include <linux/can/platform/flexcan.h>
+struct platform_device *__init imx_add_flexcan(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct flexcan_platform_data *pdata);
+#else
+/* the ifdef can be removed once the flexcan driver has been merged */
+struct flexcan_platform_data;
+static inline struct platform_device *__init imx_add_flexcan(int id,
+		resource_size_t iobase, resource_size_t iosize,
+		resource_size_t irq,
+		const struct flexcan_platform_data *pdata)
+{
+	return NULL;
+}
+#endif
+
 #include <mach/i2c.h>
 struct platform_device *__init imx_add_imx_i2c(int id,
 		resource_size_t iobase, resource_size_t iosize, int irq,
-- 
1.7.1
