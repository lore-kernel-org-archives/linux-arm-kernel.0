From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:42 +0100
Subject: [PATCH 14/51] ARM: imx: dynamically allocate mx2-camera device
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-14-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   32 --------------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mx2-camera.c |   53 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   13 ++++++
 arch/arm/plat-mxc/include/mach/mx27.h           |    4 +-
 8 files changed, 76 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-camera.c

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index b957e78..84b3405 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -31,6 +31,10 @@ extern const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst;
 #define imx27_add_imx_uart4(pdata)	imx27_add_imx_uart(4, pdata)
 #define imx27_add_imx_uart5(pdata)	imx27_add_imx_uart(5, pdata)
 
+extern const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst;
+#define imx27_add_mx2_camera(pdata)	\
+	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
+
 extern const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst;
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 31c9d6c..0c5ade4 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -77,38 +77,6 @@ int __init imx1_register_gpios(void)
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-
-#ifdef CONFIG_MACH_MX27
-static struct resource mx27_camera_resources[] = {
-	{
-	       .start = MX27_CSI_BASE_ADDR,
-	       .end = MX27_CSI_BASE_ADDR + 0x1f,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = MX27_EMMA_PRP_BASE_ADDR,
-	       .end = MX27_EMMA_PRP_BASE_ADDR + 0x1f,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = MX27_INT_CSI,
-	       .end = MX27_INT_CSI,
-	       .flags = IORESOURCE_IRQ,
-	},{
-	       .start = MX27_INT_EMMAPRP,
-	       .end = MX27_INT_EMMAPRP,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-struct platform_device mx27_camera_device = {
-	.name = "mx2-camera",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mx27_camera_resources),
-	.resource = mx27_camera_resources,
-	.dev = {
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
-#endif
-
 /* Watchdog: i.MX1 has seperate driver, i.MX21 and i.MX27 are equal */
 static struct resource mxc_wdt_resources[] = {
 	{
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 8f14452..3d020b9 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -5,7 +5,6 @@ extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
-extern struct platform_device mx27_camera_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 61a3e25..37d7e00 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -28,6 +28,9 @@ config IMX_HAVE_PLATFORM_IMX_UDC
 config IMX_HAVE_PLATFORM_MX1_CAMERA
 	bool
 
+config IMX_HAVE_PLATFORM_MX2_CAMERA
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 86b47f2..88392fc 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
new file mode 100644
index 0000000..a18c803
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
@@ -0,0 +1,53 @@
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
+#define imx_mx2_camera_data_entry_single(soc)				\
+	{								\
+		.iobasecsi = soc ## _CSI_BASE_ADDR,			\
+		.iosizecsi = SZ_32,					\
+		.irqcsi = soc ## _INT_CSI,				\
+		.iobaseemmaprp = soc ## _EMMAPRP_BASE_ADDR,		\
+		.iosizeemmaprp = SZ_32,					\
+		.irqemmaprp = soc ## _INT_EMMAPRP,			\
+	}
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst =
+	imx_mx2_camera_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_mx2_camera(
+		const struct imx_mx2_camera_data *data,
+		const struct mx2_camera_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobasecsi,
+			.end = data->iobasecsi + data->iosizecsi - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->iobaseemmaprp,
+			.end = data->iobaseemmaprp + data->iosizeemmaprp - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irqcsi,
+			.end = data->irqcsi,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->irqemmaprp,
+			.end = data->irqemmaprp,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("mx2-camera", 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index ab0500a..e31fc50 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -118,6 +118,19 @@ struct platform_device *__init imx_add_mx1_camera(
 		const struct imx_mx1_camera_data *data,
 		const struct mx1_camera_pdata *pdata);
 
+#include <mach/mx2_cam.h>
+struct imx_mx2_camera_data {
+	resource_size_t iobasecsi;
+	resource_size_t iosizecsi;
+	resource_size_t irqcsi;
+	resource_size_t iobaseemmaprp;
+	resource_size_t iosizeemmaprp;
+	resource_size_t irqemmaprp;
+};
+struct platform_device *__init imx_add_mx2_camera(
+		const struct imx_mx2_camera_data *data,
+		const struct mx2_camera_platform_data *pdata);
+
 #include <mach/mxc_nand.h>
 struct imx_mxc_nand_data {
 	/*
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 3116b3b..2734d24 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -67,8 +67,8 @@
 #define MX27_USBOTG_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x24000)
 #define MX27_OTG_BASE_ADDR			MX27_USBOTG_BASE_ADDR
 #define MX27_SAHARA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x25000)
-#define MX27_EMMA_PP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26000)
-#define MX27_EMMA_PRP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26400)
+#define MX27_EMMAPP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26000)
+#define MX27_EMMAPRP_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x26400)
 #define MX27_CCM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x27000)
 #define MX27_SYSCTRL_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x27800)
 #define MX27_IIM_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x28000)
-- 
1.7.2.3
