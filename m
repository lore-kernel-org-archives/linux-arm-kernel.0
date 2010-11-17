From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:01 +0100
Subject: [PATCH 33/51] ARM: mx25: dynamically allocate imxdi_rtc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-33-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig                      |    2 +
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++
 arch/arm/mach-mx25/devices.c                    |   19 ----------
 arch/arm/mach-mx25/devices.h                    |    1 -
 arch/arm/mach-mx25/mach-cpuimx25.c              |    2 +-
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    2 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c  |   41 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    7 ++++
 10 files changed, 60 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index e9d4456..baa75fe 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -5,6 +5,7 @@ comment "MX25 platforms:"
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -15,6 +16,7 @@ config MACH_EUKREA_CPUIMX25
 	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index a35123f..a4980ec 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -23,6 +23,10 @@ extern const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst;
 #define imx25_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx25_fsl_usb2_udc_data, pdata)
 
+extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
+#define imx25_add_imxdi_rtc(pdata)	\
+	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
+
 extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
 #define imx25_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx25_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 052adbb..1274396 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,25 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource mx25_rtc_resources[] = {
-	{
-		.start	= MX25_DRYICE_BASE_ADDR,
-		.end	= MX25_DRYICE_BASE_ADDR + 0x40,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_DRYICE,
-		.flags	= IORESOURCE_IRQ
-	},
-};
-
-struct platform_device mx25_rtc_device = {
-	.name	= "imxdi_rtc",
-	.id	= 0,
-	.num_resources	= ARRAY_SIZE(mx25_rtc_resources),
-	.resource	= mx25_rtc_resources,
-};
-
 static struct resource mx25_fb_resources[] = {
 	{
 		.start	= MX25_LCDC_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index dd1fded..f37f9a2 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,4 +1,3 @@
-extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
 extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 2094bdd..d1a04ba 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -124,7 +124,7 @@ static void __init eukrea_cpuimx25_init(void)
 
 	imx25_add_imx_uart0(&uart_pdata);
 	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
-	mxc_register_device(&mx25_rtc_device, NULL);
+	imx25_add_imxdi_rtc(NULL);
 	imx25_add_fec(&mx25_fec_pdata);
 
 	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 1d07cfb..0566d3c 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -194,7 +194,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_imx_uart0(&uart_pdata);
 	imx25_add_mxc_ehci_hs(NULL);
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
-	mxc_register_device(&mx25_rtc_device, NULL);
+	imx25_add_imxdi_rtc(NULL);
 	mxc_register_device(&mx25_fb_device, &mx25pdk_fb_pdata);
 	mxc_register_device(&mxc_wdt, NULL);
 
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index a0be2df..81d7a54 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -22,6 +22,9 @@ config IMX_HAVE_PLATFORM_IMX21_HCD
 config IMX_HAVE_PLATFORM_IMX2_WDT
 	bool
 
+config IMX_HAVE_PLATFORM_IMXDI_RTC
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_FB
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 14b228e..f1c3767 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
diff --git a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
new file mode 100644
index 0000000..387f650
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_imxdi_rtc_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _DRYICE_BASE_ADDR,			\
+		.irq = soc ## _INT_DRYICE,				\
+	}
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst =
+	imx_imxdi_rtc_data_entry_single(MX25);
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+struct platform_device *__init imx_add_imxdi_rtc(
+		const struct imx_imxdi_rtc_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_16K,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imxdi_rtc", 0,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8482613..4d4b28b 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -72,6 +72,13 @@ struct imx_imx2_wdt_data {
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data);
 
+struct imx_imxdi_rtc_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_imxdi_rtc(
+		const struct imx_imxdi_rtc_data *data);
+
 #include <mach/imxfb.h>
 struct imx_imx_fb_data {
 	resource_size_t iobase;
-- 
1.7.2.3
