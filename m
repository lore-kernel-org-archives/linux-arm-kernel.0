From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:36 +0100
Subject: [PATCH 08/51] ARM: imx: dynamically allocate mxc_w1 devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no platform data used in the driver.  In case this
changes NULL is passed unused to the soc specific functions.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    4 ++
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   15 -------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c                |    2 +-
 arch/arm/mach-imx/mach-pca100.c                 |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +-
 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/devices-imx31.h               |    4 ++
 arch/arm/mach-mx3/devices-imx35.h               |    4 ++
 arch/arm/mach-mx3/devices.c                     |   15 -------
 arch/arm/mach-mx3/devices.h                     |    1 -
 arch/arm/mach-mx3/mach-pcm037.c                 |    2 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_w1.c     |   50 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +++
 19 files changed, 86 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_w1.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 197f9e2..edf0182 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -88,6 +88,7 @@ config MACH_MX27ADS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
 	help
 	  Include support for MX27ADS platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -97,6 +98,7 @@ config MACH_PCM038
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
@@ -122,6 +124,7 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
@@ -186,6 +189,7 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index d189039..61b0aa7 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -29,6 +29,10 @@ extern const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst;
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_w1_data imx21_mxc_w1_data __initconst;
+#define imx21_add_mxc_w1(pdata)	\
+	imx_add_mxc_w1(&imx21_mxc_w1_data)
+
 extern const struct imx_spi_imx_data imx21_cspi_data[] __initconst;
 #define imx21_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx21_cspi_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 7011690..b957e78 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -35,6 +35,10 @@ extern const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst;
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_w1_data imx27_mxc_w1_data __initconst;
+#define imx27_add_mxc_w1(pdata)	\
+	imx_add_mxc_w1(&imx27_mxc_w1_data)
+
 extern const struct imx_spi_imx_data imx27_cspi_data[] __initconst;
 #define imx27_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx27_cspi_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index e69e46e..6fbd624 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -270,21 +270,6 @@ struct platform_device mxc_wdt = {
 	.resource = mxc_wdt_resources,
 };
 
-static struct resource mxc_w1_master_resources[] = {
-	{
-		.start = MX2x_OWIRE_BASE_ADDR,
-		.end = MX2x_OWIRE_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_w1_master_device = {
-	.name = "mxc_w1",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_w1_master_resources),
-	.resource = mxc_w1_master_resources,
-};
-
 /*
  * lcdc:
  * - i.MX1: the basic controller
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 807f02a..48d2c5b 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -14,7 +14,6 @@ extern struct platform_device mxc_gpt4;
 extern struct platform_device mxc_gpt5;
 #endif
 extern struct platform_device mxc_wdt;
-extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 745ee60..9baaf3d 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -158,7 +158,6 @@ cpuimx27_nand_board_info __initconst = {
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_cpuimx27_nor_mtd_device,
 	&mxc_wdt,
-	&mxc_w1_master_device,
 };
 
 static const struct imxi2c_platform_data cpuimx27_i2c1_data __initconst = {
@@ -262,6 +261,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_mxc_w1(NULL);
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
 	/* SDHC2 can be used for Wifi */
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index a1e4bc5..219899a 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -284,7 +284,6 @@ static struct imxmmc_platform_data sdhc2_pdata = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&mx27ads_nor_mtd_device,
-	&mxc_w1_master_device,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -314,6 +313,7 @@ static void __init mx27ads_board_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_mxc_w1(NULL);
 }
 
 static void __init mx27ads_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 8c720d4..39c580b 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -172,7 +172,6 @@ pca100_nand_board_info __initconst = {
 };
 
 static struct platform_device *platform_devices[] __initdata = {
-	&mxc_w1_master_device,
 	&mxc_wdt,
 };
 
@@ -434,6 +433,7 @@ static void __init pca100_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_mxc_w1(NULL);
 }
 
 static void __init pca100_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 49a97ce..2cfc4b9 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -172,7 +172,6 @@ pcm038_nand_board_info __initconst = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&pcm038_nor_mtd_device,
-	&mxc_w1_master_device,
 	&pcm038_sram_mtd_device,
 	&mxc_wdt,
 };
@@ -326,6 +325,7 @@ static void __init pcm038_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_mxc_w1(NULL);
 
 #ifdef CONFIG_MACH_PCM970_BASEBOARD
 	pcm970_baseboard_init();
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 5000ac1..3f83fd5 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -41,6 +41,7 @@ config MACH_PCM037
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm037 platform. This includes
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index de95985..a88f243 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -33,6 +33,10 @@ extern const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst;
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_w1_data imx31_mxc_w1_data __initconst;
+#define imx31_add_mxc_w1(pdata)	\
+	imx_add_mxc_w1(&imx31_mxc_w1_data)
+
 extern const struct imx_spi_imx_data imx31_cspi_data[] __initconst;
 #define imx31_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx31_cspi_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 5eb917b..7602cb4 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -40,6 +40,10 @@ extern const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst;
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx35_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_w1_data imx35_mxc_w1_data __initconst;
+#define imx35_add_mxc_w1(pdata)	\
+	imx_add_mxc_w1(&imx35_mxc_w1_data)
+
 extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 #define imx35_add_cspi(id, pdata)	\
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 74f74f4..5808ce1 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -54,21 +54,6 @@ int __init imx3x_register_gpios(void)
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
 
-static struct resource mxc_w1_master_resources[] = {
-	{
-		.start = MX3x_OWIRE_BASE_ADDR,
-		.end = MX3x_OWIRE_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_w1_master_device = {
-	.name = "mxc_w1",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_w1_master_resources),
-	.resource = mxc_w1_master_resources,
-};
-
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
 	{
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 585f814..a649772 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,4 +1,3 @@
-extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 86e86c1..bc5d3a1 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -614,7 +614,7 @@ static void __init mxc_board_init(void)
 	imx31_add_imx_uart1(&uart_pdata);
 	imx31_add_imx_uart2(&uart_pdata);
 
-	mxc_register_device(&mxc_w1_master_device, NULL);
+	imx31_add_mxc_w1(NULL);
 
 	/* LAN9217 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 9aa6f3e..fb66467 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -25,5 +25,8 @@ config IMX_HAVE_PLATFORM_IMX_UART
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_W1
+	bool
+
 config IMX_HAVE_PLATFORM_SPI_IMX
 	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 45aefeb..1d7d392 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_w1.c b/arch/arm/plat-mxc/devices/platform-mxc_w1.c
new file mode 100644
index 0000000..1355237
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_w1.c
@@ -0,0 +1,50 @@
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
+#define imx_mxc_w1_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _OWIRE_BASE_ADDR,			\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_mxc_w1_data imx21_mxc_w1_data __initconst =
+	imx_mxc_w1_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_w1_data imx27_mxc_w1_data __initconst =
+	imx_mxc_w1_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX31
+const struct imx_mxc_w1_data imx31_mxc_w1_data __initconst =
+	imx_mxc_w1_data_entry_single(MX31);
+#endif /* ifdef CONFIG_ARCH_MX31 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_mxc_w1_data imx35_mxc_w1_data __initconst =
+	imx_mxc_w1_data_entry_single(MX35);
+#endif /* ifdef CONFIG_ARCH_MX35 */
+
+struct platform_device *__init imx_add_mxc_w1(
+		const struct imx_mxc_w1_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	return imx_add_platform_device("mxc_w1", 0,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8c6896f..431e0ef 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -99,6 +99,12 @@ struct platform_device *__init imx_add_mxc_nand(
 		const struct imx_mxc_nand_data *data,
 		const struct mxc_nand_platform_data *pdata);
 
+struct imx_mxc_w1_data {
+	resource_size_t iobase;
+};
+struct platform_device *__init imx_add_mxc_w1(
+		const struct imx_mxc_w1_data *data);
+
 #include <mach/spi.h>
 struct imx_spi_imx_data {
 	const char *devid;
-- 
1.7.2.3
