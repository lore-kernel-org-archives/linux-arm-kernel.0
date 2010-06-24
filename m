From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:47 +0200
Subject: [PATCH 51/61] ARM: imx: dynamically register spi_imx devices (imx27)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-52-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                    |    3 ++
 arch/arm/mach-imx/devices-imx27.h            |    7 +++++
 arch/arm/mach-imx/devices.c                  |   33 --------------------------
 arch/arm/mach-imx/devices.h                  |    5 ----
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    5 ++-
 arch/arm/mach-imx/mach-pca100.c              |    7 +----
 arch/arm/mach-imx/mach-pcm038.c              |    5 +--
 7 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2bf8078..c185ec3 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -92,6 +92,7 @@ config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
@@ -134,6 +135,7 @@ choice
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	prompt "Eukrea MBIMX27 development board"
 	bool
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMX27 evaluation board.
@@ -156,6 +158,7 @@ config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 5e0c40c..7da1e2b 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -16,3 +16,10 @@
 
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
+
+#define imx27_add_spi_imx0(pdata)	\
+	imx_add_spi_imx(0, MX27_CSPI1_BASE_ADDR, SZ_4K, MX27_INT_CSPI1, pdata)
+#define imx27_add_spi_imx1(pdata)	\
+	imx_add_spi_imx(1, MX27_CSPI2_BASE_ADDR, SZ_4K, MX27_INT_CSPI2, pdata)
+#define imx27_add_spi_imx2(pdata)	\
+	imx_add_spi_imx(2, MX27_CSPI3_BASE_ADDR, SZ_4K, MX27_INT_CSPI3, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index e42eead..84e6da6 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -219,39 +219,6 @@ int __init imx1_register_gpios(void)
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 /*
- * SPI master controller
- *
- * - i.MX1: 2 channel (slighly different register setting)
- * - i.MX21: 2 channel
- * - i.MX27: 3 channel
- */
-#ifdef CONFIG_MACH_MX27
-#define DEFINE_IMX_SPI_DEVICE(n, baseaddr, irq)					\
-	static struct resource mxc_spi_resources ## n[] = {			\
-		{								\
-			.start = baseaddr,					\
-			.end = baseaddr + SZ_4K - 1,				\
-			.flags = IORESOURCE_MEM,				\
-		}, {								\
-			.start = irq,						\
-			.end = irq,						\
-			.flags = IORESOURCE_IRQ,				\
-		},								\
-	};									\
-										\
-	struct platform_device mxc_spi_device ## n = {				\
-		.name = "spi_imx",						\
-		.id = n,							\
-		.num_resources = ARRAY_SIZE(mxc_spi_resources ## n),		\
-		.resource = mxc_spi_resources ## n,				\
-	}
-
-DEFINE_IMX_SPI_DEVICE(0, MX2x_CSPI1_BASE_ADDR, MX2x_INT_CSPI1);
-DEFINE_IMX_SPI_DEVICE(1, MX2x_CSPI2_BASE_ADDR, MX2x_INT_CSPI2);
-DEFINE_IMX_SPI_DEVICE(2, MX27_CSPI3_BASE_ADDR, MX27_INT_CSPI3);
-#endif
-
-/*
  * General Purpose Timer
  * - i.MX21: 3 timers
  * - i.MX27: 6 timers
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index c15b0de..db995b1 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -34,11 +34,6 @@ extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
-#ifdef CONFIG_MACH_MX27
-extern struct platform_device mxc_spi_device0;
-extern struct platform_device mxc_spi_device1;
-extern struct platform_device mxc_spi_device2;
-#endif
 extern struct platform_device mx21_usbhc_device;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 463e80d..eed8143 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -34,6 +34,7 @@
 #include <mach/mmc.h>
 #include <mach/imx-uart.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static int eukrea_mbimx27_pins[] = {
@@ -201,7 +202,7 @@ static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
 
 static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
 
-static struct spi_imx_master eukrea_mbimx27_spi_0_data = {
+static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
 	.chipselect	= eukrea_mbimx27_spi_cs,
 	.num_chipselect = ARRAY_SIZE(eukrea_mbimx27_spi_cs),
 };
@@ -233,7 +234,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	/* SPI and ADS7846 Touchscreen controler init */
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
 	mxc_gpio_mode(GPIO_PORTD | 25 | GPIO_GPIO | GPIO_IN);
-	mxc_register_device(&mxc_spi_device0, &eukrea_mbimx27_spi_0_data);
+	imx27_add_spi_imx0(&eukrea_mbimx27_spi0_data);
 	spi_register_board_info(eukrea_mbimx27_spi_board_info,
 			ARRAY_SIZE(eukrea_mbimx27_spi_board_info));
 	ads7846_dev_init();
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 6501a7a..953cc74 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -37,9 +37,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
-#include <mach/spi.h>
-#endif
 #include <mach/imx-uart.h>
 #include <mach/audmux.h>
 #include <mach/ssi.h>
@@ -192,7 +189,7 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 
 static int pca100_spi_cs[] = {GPIO_PORTD + 28, GPIO_PORTD + 27};
 
-static struct spi_imx_master pca100_spi_0_data = {
+static const struct spi_imx_master pca100_spi0_data __initconst = {
 	.chipselect	= pca100_spi_cs,
 	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
 };
@@ -347,7 +344,7 @@ static void __init pca100_init(void)
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 	spi_register_board_info(pca100_spi_board_info,
 				ARRAY_SIZE(pca100_spi_board_info));
-	mxc_register_device(&mxc_spi_device0, &pca100_spi_0_data);
+	imx27_add_spi_imx0(&pca100_spi_0_data);
 #endif
 
 	gpio_request(OTG_PHY_CS_GPIO, "usb-otg-cs");
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 7559e0f..c09f234 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -38,7 +38,6 @@
 #include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
-#include <mach/spi.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
@@ -216,7 +215,7 @@ static struct i2c_board_info pcm038_i2c_devices[] = {
 
 static int pcm038_spi_cs[] = {GPIO_PORTD + 28};
 
-static struct spi_imx_master pcm038_spi_0_data = {
+static const struct spi_imx_master pcm038_spi0_data __initconst = {
 	.chipselect = pcm038_spi_cs,
 	.num_chipselect = ARRAY_SIZE(pcm038_spi_cs),
 };
@@ -327,7 +326,7 @@ static void __init pcm038_init(void)
 	/* MC13783 IRQ */
 	mxc_gpio_mode(GPIO_PORTB | 23 | GPIO_GPIO | GPIO_IN);
 
-	mxc_register_device(&mxc_spi_device0, &pcm038_spi_0_data);
+	imx27_add_spi_imx0(&pcm038_spi0_data);
 	spi_register_board_info(pcm038_spi_board_info,
 				ARRAY_SIZE(pcm038_spi_board_info));
 
-- 
1.7.1
