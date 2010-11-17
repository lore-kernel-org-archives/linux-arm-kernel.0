From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:51 +0100
Subject: [PATCH 23/51] ARM: imx: dynamically allocate fsl-usb2-udc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                         |    2 +
 arch/arm/mach-imx/devices-imx27.h                 |    4 ++
 arch/arm/mach-imx/devices.c                       |   28 --------------
 arch/arm/mach-imx/devices.h                       |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c                 |    5 +--
 arch/arm/mach-imx/mach-pca100.c                   |    5 +--
 arch/arm/plat-mxc/devices/Kconfig                 |    3 ++
 arch/arm/plat-mxc/devices/Makefile                |    1 +
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |   41 +++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h   |    9 +++++
 10 files changed, 64 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 025e969..e50a164 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -128,6 +128,7 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -200,6 +201,7 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 51b9155..51bb42d 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -13,6 +13,10 @@ extern const struct imx_fec_data imx27_fec_data __initconst;
 #define imx27_add_fec(pdata)	\
 	imx_add_fec(&imx27_fec_data, pdata)
 
+extern const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst;
+#define imx27_add_fsl_usb2_udc(pdata)	\
+	imx_add_fsl_usb2_udc(&imx27_fsl_usb2_udc_data, pdata)
+
 extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst;
 #define imx27_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx27_imx2_wdt_data)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 2a6d707..d026cfb 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -76,34 +76,6 @@ int __init imx1_register_gpios(void)
 }
 #endif
 
-#ifdef CONFIG_MACH_MX27
-static struct resource otg_resources[] = {
-	{
-		.start = MX27_USB_OTG_BASE_ADDR,
-		.end = MX27_USB_OTG_BASE_ADDR + 0x1ff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_USB_OTG,
-		.end = MX27_INT_USB_OTG,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static u64 otg_dmamask = DMA_BIT_MASK(32);
-
-/* OTG gadget device */
-struct platform_device mxc_otg_udc_device = {
-	.name		= "fsl-usb2-udc",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &otg_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= otg_resources,
-	.num_resources	= ARRAY_SIZE(otg_resources),
-};
-#endif
-
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 /* GPIO port description */
 #define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 7a00bba..a788566 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,5 +1,4 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mx21_usbhc_device;
 extern struct platform_device imx_kpp_device;
 #endif
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index c70b038..9ae5bed 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -28,7 +28,6 @@
 #include <linux/serial_8250.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -223,7 +222,7 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 };
 #endif
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_ULPI,
 };
@@ -289,7 +288,7 @@ static void __init eukrea_cpuimx27_init(void)
 	imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
 #endif
 	if (!otg_mode_host)
-		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 
 #ifdef CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD
 	eukrea_mbimx27_baseboard_init();
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 683374d..d9e2dda 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -29,7 +29,6 @@
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
-#include <linux/fsl_devices.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -297,7 +296,7 @@ static struct mxc_usbh_platform_data usbh2_pdata __initdata = {
 };
 #endif
 
-static struct fsl_usb2_platform_data otg_device_pdata = {
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.operating_mode = FSL_USB2_DR_DEVICE,
 	.phy_mode       = FSL_USB2_PHY_ULPI,
 };
@@ -419,7 +418,7 @@ static void __init pca100_init(void)
 #endif
 	if (!otg_mode_host) {
 		gpio_set_value(OTG_PHY_CS_GPIO, 0);
-		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 	}
 
 	imx27_add_imx_fb(&pca100_fb_data);
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index d2d096c..26196d9 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -9,6 +9,9 @@ config IMX_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
 
+config IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	bool
+
 config IMX_HAVE_PLATFORM_GPIO_KEYS
 	bool
 	default y if ARCH_MX51
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index c8734bd..e40897e 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
diff --git a/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
new file mode 100644
index 0000000..3116f9a
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
@@ -0,0 +1,41 @@
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
+#define imx_fsl_usb2_udc_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _USB_OTG_BASE_ADDR,			\
+		.irq = soc ## _INT_USB_OTG,				\
+	}
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
+	imx_fsl_usb2_udc_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_fsl_usb2_udc(
+		const struct imx_fsl_usb2_udc_data *data,
+		const struct fsl_usb2_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_512 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("fsl-usb2-udc", -1,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 7df7a9f..f01fd28 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -44,6 +44,15 @@ struct platform_device *__init imx_add_flexcan(
 		const struct imx_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
 
+#include <linux/fsl_devices.h>
+struct imx_fsl_usb2_udc_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_fsl_usb2_udc(
+		const struct imx_fsl_usb2_udc_data *data,
+		const struct fsl_usb2_platform_data *pdata);
+
 #include <linux/gpio_keys.h>
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata);
-- 
1.7.2.3
