From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:40 +0100
Subject: [PATCH 12/51] ARM: imx: dynamically allocate mx1-camera device
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c                     |   25 -------------
 arch/arm/mach-imx/devices.h                     |    4 --
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mx1-camera.c |   42 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +++++
 arch/arm/plat-mxc/include/mach/mx1.h            |    2 +-
 7 files changed, 57 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx1-camera.c

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index fba6285..31c9d6c 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -45,31 +45,6 @@
 #include "devices.h"
 
 #if defined(CONFIG_ARCH_MX1)
-static struct resource imx1_camera_resources[] = {
-	{
-		.start  = 0x00224000,
-		.end    = 0x00224010,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_CSI_INT,
-		.end    = MX1_CSI_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static u64 imx1_camera_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device imx1_camera_device = {
-	.name           = "mx1-camera",
-	.id             = 0, /* This is used to put cameras on this interface */
-	.dev		= {
-		.dma_mask = &imx1_camera_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource       = imx1_camera_resources,
-	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
-};
-
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 91906ce..8f14452 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,7 +1,3 @@
-#ifdef CONFIG_ARCH_MX1
-extern struct platform_device imx1_camera_device;
-#endif
-
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_fb_device;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 2703f5a..61a3e25 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -25,6 +25,9 @@ config IMX_HAVE_PLATFORM_IMX_UART
 config IMX_HAVE_PLATFORM_IMX_UDC
 	bool
 
+config IMX_HAVE_PLATFORM_MX1_CAMERA
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 7c3eaf1..86b47f2 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mx1-camera.c b/arch/arm/plat-mxc/devices/platform-mx1-camera.c
new file mode 100644
index 0000000..edcc581
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mx1-camera.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mx1_camera_data_entry_single(soc, _size)			\
+	{								\
+		.iobase = soc ## _CSI ## _BASE_ADDR,			\
+		.iosize = _size,					\
+		.irq = soc ## _INT_CSI,					\
+	}
+
+#ifdef CONFIG_SOC_IMX1
+const struct imx_mx1_camera_data imx1_mx1_camera_data __initconst =
+	imx_mx1_camera_data_entry_single(MX1, 10);
+#endif /* ifdef CONFIG_SOC_IMX1 */
+
+struct platform_device *__init imx_add_mx1_camera(
+		const struct imx_mx1_camera_data *data,
+		const struct mx1_camera_pdata *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("mx1-camera", 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index a5e97b8..ab0500a 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -108,6 +108,16 @@ struct platform_device *__init imx_add_imx_udc(
 		const struct imx_imx_udc_data *data,
 		const struct imxusb_platform_data *pdata);
 
+#include <mach/mx1_camera.h>
+struct imx_mx1_camera_data {
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_mx1_camera(
+		const struct imx_mx1_camera_data *data,
+		const struct mx1_camera_pdata *pdata);
+
 #include <mach/mxc_nand.h>
 struct imx_mxc_nand_data {
 	/*
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 2cd3fcd..f1e336e 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -77,7 +77,7 @@
 
 /* fixed interrput numbers */
 #define MX1_INT_SOFTINT		0
-#define MX1_CSI_INT		6
+#define MX1_INT_CSI		6
 #define MX1_DSPA_MAC_INT	7
 #define MX1_DSPA_INT		8
 #define MX1_COMP_INT		9
-- 
1.7.2.3
