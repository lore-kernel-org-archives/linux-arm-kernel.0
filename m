From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:53 +0100
Subject: [PATCH 25/51] ARM: imx: dynamically allocate imx21-hcd devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   26 --------------
 arch/arm/mach-imx/devices.h                     |    3 --
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx21-hcd.c  |   41 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    9 +++++
 7 files changed, 58 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx21-hcd.c

diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 0c0eab1..16744d2 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -9,6 +9,10 @@
 #include <mach/mx21.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_imx21_hcd_data imx21_imx21_hcd_data __initconst;
+#define imx21_add_imx21_hcd(pdata)	\
+	imx_add_imx21_hcd(&imx21_imx21_hcd_data, pdata)
+
 extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst;
 #define imx21_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 4360b9c..8fd2545 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -123,30 +123,4 @@ int __init imx27_register_gpios(void)
 }
 #endif
 
-#ifdef CONFIG_MACH_MX21
-static struct resource mx21_usbhc_resources[] = {
-	{
-		.start	= MX21_USBOTG_BASE_ADDR,
-		.end	= MX21_USBOTG_BASE_ADDR + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start		= MX21_INT_USBHOST,
-		.end		= MX21_INT_USBHOST,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mx21_usbhc_device = {
-	.name		= "imx21-hcd",
-	.id		= 0,
-	.dev		= {
-		.dma_mask = &mx21_usbhc_device.dev.coherent_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(mx21_usbhc_resources),
-	.resource	= mx21_usbhc_resources,
-};
-#endif
-
 #endif
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index d1e7f48..e69de29 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,3 +0,0 @@
-#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mx21_usbhc_device;
-#endif
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 212f380..a0be2df 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -15,6 +15,9 @@ config IMX_HAVE_PLATFORM_FSL_USB2_UDC
 config IMX_HAVE_PLATFORM_GPIO_KEYS
 	bool
 	default y if ARCH_MX51
+
+config IMX_HAVE_PLATFORM_IMX21_HCD
+	bool
 	
 config IMX_HAVE_PLATFORM_IMX2_WDT
 	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index dd23bab..14b228e 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx21-hcd.c b/arch/arm/plat-mxc/devices/platform-imx21-hcd.c
new file mode 100644
index 0000000..5770a42
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx21-hcd.c
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
+#define imx_imx21_hcd_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _USBOTG_BASE_ADDR,			\
+		.irq = soc ## _INT_USBHOST,				\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx21_hcd_data imx21_imx21_hcd_data __initconst =
+	imx_imx21_hcd_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+struct platform_device *__init imx_add_imx21_hcd(
+		const struct imx_imx21_hcd_data *data,
+		const struct mx21_usbh_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("imx21-hcd", 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 1a67299..f5d0000 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -57,6 +57,15 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata);
 
+#include <mach/mx21-usbhost.h>
+struct imx_imx21_hcd_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_imx21_hcd(
+		const struct imx_imx21_hcd_data *data,
+		const struct mx21_usbh_platform_data *pdata);
+
 struct imx_imx2_wdt_data {
 	resource_size_t iobase;
 };
-- 
1.7.2.3
