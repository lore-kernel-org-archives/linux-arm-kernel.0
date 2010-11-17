From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:43 +0100
Subject: [PATCH 15/51] ARM: imx: dynamically allocate imx2-wdt devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-15-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no platform data used in the driver.  In case this
changes and for consistency NULL is passed unused to the soc specific
functions.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    3 ++
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   16 ---------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +-
 arch/arm/mach-imx/mach-pca100.c                 |    6 +---
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c   |   40 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +++
 12 files changed, 64 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx2-wdt.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index edf0182..6b1662c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -95,6 +95,7 @@ config MACH_MX27ADS
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -121,6 +122,7 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -185,6 +187,7 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 61b0aa7..738dbba 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -9,6 +9,10 @@
 #include <mach/mx21.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst;
+#define imx21_add_imx2_wdt(pdata)	\
+	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
+
 extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
 #define imx21_add_imx_i2c(pdata)	\
 	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 84b3405..b2d4c51 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -13,6 +13,10 @@ extern const struct imx_fec_data imx27_fec_data __initconst;
 #define imx27_add_fec(pdata)	\
 	imx_add_fec(&imx27_fec_data, pdata)
 
+extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst;
+#define imx27_add_imx2_wdt(pdata)	\
+	imx_add_imx2_wdt(&imx27_imx2_wdt_data)
+
 extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 0c5ade4..20655fb 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -77,22 +77,6 @@ int __init imx1_register_gpios(void)
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-/* Watchdog: i.MX1 has seperate driver, i.MX21 and i.MX27 are equal */
-static struct resource mxc_wdt_resources[] = {
-	{
-		.start = MX2x_WDOG_BASE_ADDR,
-		.end = MX2x_WDOG_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_wdt = {
-	.name = "imx2-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
-	.resource = mxc_wdt_resources,
-};
-
 /*
  * lcdc:
  * - i.MX1: the basic controller
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 3d020b9..f441b02 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,5 +1,4 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 9baaf3d..5771d4e 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -157,7 +157,6 @@ cpuimx27_nand_board_info __initconst = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_cpuimx27_nor_mtd_device,
-	&mxc_wdt,
 };
 
 static const struct imxi2c_platform_data cpuimx27_i2c1_data __initconst = {
@@ -261,6 +260,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_imx2_wdt(NULL);
 	imx27_add_mxc_w1(NULL);
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 39c580b..11da9c2 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -171,10 +171,6 @@ pca100_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&mxc_wdt,
-};
-
 static const struct imxi2c_platform_data pca100_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
@@ -432,7 +428,7 @@ static void __init pca100_init(void)
 	mxc_register_device(&mxc_fb_device, &pca100_fb_data);
 
 	imx27_add_fec(NULL);
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_imx2_wdt(NULL);
 	imx27_add_mxc_w1(NULL);
 }
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 2cfc4b9..3c9f2df 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -173,7 +173,6 @@ pcm038_nand_board_info __initconst = {
 static struct platform_device *platform_devices[] __initdata = {
 	&pcm038_nor_mtd_device,
 	&pcm038_sram_mtd_device,
-	&mxc_wdt,
 };
 
 /* On pcm038 there's a sram attached to CS1, we enable the chipselect here and
@@ -325,6 +324,7 @@ static void __init pcm038_init(void)
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_imx2_wdt(NULL);
 	imx27_add_mxc_w1(NULL);
 
 #ifdef CONFIG_MACH_PCM970_BASEBOARD
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 37d7e00..01b0d0c 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -13,6 +13,9 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
 	bool
 	default y if ARCH_MX51
 	
+config IMX_HAVE_PLATFORM_IMX2_WDT
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 88392fc..224f665 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_ESDHC) += platform-esdhc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
new file mode 100644
index 0000000..86eb7f1
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -0,0 +1,40 @@
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
+#define imx_imx2_wdt_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _WDOG_BASE_ADDR,			\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
+	imx_imx2_wdt_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
+	imx_imx2_wdt_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_imx2_wdt(
+		const struct imx_imx2_wdt_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+	return imx_add_platform_device("imx2-wdt", 0,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index e31fc50..a0ac8454 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -43,6 +43,12 @@ struct platform_device *__init imx_add_flexcan(int id,
 struct platform_device *__init imx_add_gpio_keys(
 		const struct gpio_keys_platform_data *pdata);
 
+struct imx_imx2_wdt_data {
+	resource_size_t iobase;
+};
+struct platform_device *__init imx_add_imx2_wdt(
+		const struct imx_imx2_wdt_data *data);
+
 #include <mach/i2c.h>
 struct imx_imx_i2c_data {
 	int id;
-- 
1.7.2.3
