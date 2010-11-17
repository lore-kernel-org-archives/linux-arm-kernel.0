From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:38 +0100
Subject: [PATCH 10/51] ARM: imx: dynamically allocate imx_udc device
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is only available for mx1 machines with no in-tree user.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c                     |   43 -------------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx_udc.c    |   75 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   16 +++++
 arch/arm/plat-mxc/include/mach/mx1.h            |   16 +++---
 7 files changed, 103 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx_udc.c

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index cdc6f32..fba6285 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -70,49 +70,6 @@ struct platform_device imx1_camera_device = {
 	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
 };
 
-static struct resource imx_usb_resources[] = {
-	{
-		.start	= 0x00212000,
-		.end	= 0x00212148,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX1_USBD_INT0,
-		.end	= MX1_USBD_INT0,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT1,
-		.end	= MX1_USBD_INT1,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT2,
-		.end	= MX1_USBD_INT2,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT3,
-		.end	= MX1_USBD_INT3,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT4,
-		.end	= MX1_USBD_INT4,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT5,
-		.end	= MX1_USBD_INT5,
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= MX1_USBD_INT6,
-		.end	= MX1_USBD_INT6,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_usb_device = {
-	.name		= "imx_udc",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(imx_usb_resources),
-	.resource	= imx_usb_resources,
-};
-
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index a7e47f4..91906ce 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,6 +1,5 @@
 #ifdef CONFIG_ARCH_MX1
 extern struct platform_device imx1_camera_device;
-extern struct platform_device imx_usb_device;
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index fb66467..2703f5a 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -22,6 +22,9 @@ config IMX_HAVE_PLATFORM_IMX_SSI
 config IMX_HAVE_PLATFORM_IMX_UART
 	bool
 
+config IMX_HAVE_PLATFORM_IMX_UDC
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 1d7d392..7c3eaf1 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -6,6 +6,7 @@ obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx_udc.c b/arch/arm/plat-mxc/devices/platform-imx_udc.c
new file mode 100644
index 0000000..6fd675d
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx_udc.c
@@ -0,0 +1,75 @@
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
+#define imx_imx_udc_data_entry_single(soc, _size)			\
+	{								\
+		.iobase = soc ## _USBD_BASE_ADDR,			\
+		.iosize = _size,					\
+		.irq0 = soc ## _INT_USBD0,				\
+		.irq1 = soc ## _INT_USBD1,				\
+		.irq2 = soc ## _INT_USBD2,				\
+		.irq3 = soc ## _INT_USBD3,				\
+		.irq4 = soc ## _INT_USBD4,				\
+		.irq5 = soc ## _INT_USBD5,				\
+		.irq6 = soc ## _INT_USBD6,				\
+	}
+
+#define imx_imx_udc_data_entry(soc, _size)				\
+	[_id] = imx_imx_udc_data_entry_single(soc, _size)
+
+#ifdef CONFIG_SOC_IMX1
+const struct imx_imx_udc_data imx1_imx_udc_data __initconst =
+	imx_imx_udc_data_entry_single(MX1, SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX1 */
+
+struct platform_device *__init imx_add_imx_udc(
+		const struct imx_imx_udc_data *data,
+		const struct imxusb_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + data->iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq0,
+			.end = data->irq0,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq1,
+			.end = data->irq1,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq2,
+			.end = data->irq2,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq3,
+			.end = data->irq3,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq4,
+			.end = data->irq4,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq5,
+			.end = data->irq5,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irq6,
+			.end = data->irq6,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imx_udc", 0,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 431e0ef..4eb45fa 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -82,6 +82,22 @@ struct platform_device *__init imx_add_imx_uart_1irq(
 		const struct imx_imx_uart_1irq_data *data,
 		const struct imxuart_platform_data *pdata);
 
+#include <mach/usb.h>
+struct imx_imx_udc_data {
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq0;
+	resource_size_t irq1;
+	resource_size_t irq2;
+	resource_size_t irq3;
+	resource_size_t irq4;
+	resource_size_t irq5;
+	resource_size_t irq6;
+};
+struct platform_device *__init imx_add_imx_udc(
+		const struct imx_imx_udc_data *data,
+		const struct imxusb_platform_data *pdata);
+
 #include <mach/mxc_nand.h>
 struct imx_mxc_nand_data {
 	/*
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index b6771f4..2cd3fcd 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -114,13 +114,13 @@
 #define MX1_SSI_RX_INT		44
 #define MX1_SSI_RX_ERR_INT	45
 #define MX1_TOUCH_INT		46
-#define MX1_USBD_INT0		47
-#define MX1_USBD_INT1		48
-#define MX1_USBD_INT2		49
-#define MX1_USBD_INT3		50
-#define MX1_USBD_INT4		51
-#define MX1_USBD_INT5		52
-#define MX1_USBD_INT6		53
+#define MX1_INT_USBD0		47
+#define MX1_INT_USBD1		48
+#define MX1_INT_USBD2		49
+#define MX1_INT_USBD3		50
+#define MX1_INT_USBD4		51
+#define MX1_INT_USBD5		52
+#define MX1_INT_USBD6		53
 #define MX1_BTSYS_INT		55
 #define MX1_BTTIM_INT		56
 #define MX1_BTWUI_INT		57
@@ -163,6 +163,6 @@
  * to not break drivers/usb/gadget/imx_udc.  Should go
  * away after this driver uses the new name.
  */
-#define USBD_INT0		MX1_USBD_INT0
+#define USBD_INT0		MX1_INT_USBD0
 
 #endif /* ifndef __MACH_MX1_H__ */
-- 
1.7.2.3
