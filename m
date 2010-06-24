From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:48 +0200
Subject: [PATCH 52/61] ARM: imx: dynamically register spi_imx devices (imx31)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-53-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig            |    4 ++++
 arch/arm/mach-mx3/devices-imx31.h    |    7 +++++++
 arch/arm/mach-mx3/devices.c          |    2 +-
 arch/arm/mach-mx3/devices.h          |    2 ++
 arch/arm/mach-mx3/mach-mx31_3ds.c    |    5 ++---
 arch/arm/mach-mx3/mach-mx31lilly.c   |   10 +++++-----
 arch/arm/mach-mx3/mach-mx31lite.c    |    5 ++---
 arch/arm/mach-mx3/mach-mx31moboard.c |    8 ++++----
 arch/arm/mach-mx3/mx31lite-db.c      |    6 +++---
 9 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index b8a7610..60d58a6 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -55,6 +55,7 @@ config MACH_MX31LITE
 	select ARCH_MX31
 	select MXC_ULPI if USB_ULPI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -63,6 +64,7 @@ config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX31PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -80,6 +82,7 @@ config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31moboard platform. This includes specific
@@ -88,6 +91,7 @@ config MACH_MX31MOBOARD
 config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31 based LILLY1131 modules. This includes
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 56bc1e1..1cf96ca 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -18,3 +18,10 @@
 
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
+
+#define imx31_add_spi_imx0(pdata)	\
+	imx_add_spi_imx(0, MX31_CSPI1_BASE_ADDR, SZ_4K, MX31_INT_CSPI1, pdata)
+#define imx31_add_spi_imx1(pdata)	\
+	imx_add_spi_imx(1, MX31_CSPI2_BASE_ADDR, SZ_4K, MX31_INT_CSPI2, pdata)
+#define imx31_add_spi_imx2(pdata)	\
+	imx_add_spi_imx(2, MX31_CSPI3_BASE_ADDR, SZ_4K, MX31_INT_CSPI3, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index a285b16..02d05ea 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -379,6 +379,7 @@ struct platform_device mxc_usbh2 = {
 	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
 };
 
+#if defined(CONFIG_ARCH_MX35)
 /*
  * SPI master controller
  * 3 channels
@@ -440,7 +441,6 @@ struct platform_device mxc_spi_device2 = {
 	.resource = mxc_spi_2_resources,
 };
 
-#ifdef CONFIG_ARCH_MX35
 static struct resource mxc_fec_resources[] = {
 	{
 		.start	= MXC_FEC_BASE_ADDR,
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index c50596a..d22a327 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -16,9 +16,11 @@ extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_rnga_device;
+#if defined(CONFIG_ARCH_MX35)
 extern struct platform_device mxc_spi_device0;
 extern struct platform_device mxc_spi_device1;
 extern struct platform_device mxc_spi_device2;
+#endif
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_ssi_device1;
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index c730c09..2aa3e58 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -35,7 +35,6 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
-#include <mach/spi.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -170,7 +169,7 @@ static int spi1_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static struct spi_imx_master spi1_pdata = {
+static const struct spi_imx_master spi1_pdata __initconst = {
 	.chipselect	= spi1_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
@@ -419,7 +418,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
-	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	imx31_add_spi_imx0(&spi1_pdata);
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index b4cfbe0..9d6a6cc 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -42,10 +42,10 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lilly.h>
-#include <mach/spi.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 /*
@@ -265,12 +265,12 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static struct spi_imx_master spi0_pdata = {
+static const struct spi_imx_master spi0_pdata __initconst = {
 	.chipselect = spi_internal_chipselect,
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
 
-static struct spi_imx_master spi1_pdata = {
+static const struct spi_imx_master spi1_pdata __initconst = {
 	.chipselect = spi_internal_chipselect,
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
@@ -327,8 +327,8 @@ static void __init mx31lilly_board_init(void)
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS1__SS1, "SPI2_SS1");
 	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS2__SS2, "SPI2_SS2");
 
-	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
-	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	imx31_add_spi_imx0(&spi0_pdata);
+	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(&mc13783_dev, 1);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index f0a68e6..634b855 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -41,7 +41,6 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
-#include <mach/spi.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
@@ -109,7 +108,7 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(0),
 };
 
-static struct spi_imx_master spi1_pdata = {
+static const struct spi_imx_master spi1_pdata __initconst = {
 	.chipselect	= spi_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
@@ -252,7 +251,7 @@ static void __init mxc_board_init(void)
 	platform_device_register(&physmap_flash_device);
 	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
-	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(&mc13783_spi_dev, 1);
 
 #if defined(CONFIG_USB_ULPI)
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index dd51d08..689b068 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -152,7 +152,7 @@ static int moboard_spi1_cs[] = {
 	MXC_SPI_CS(2),
 };
 
-static struct spi_imx_master moboard_spi1_master = {
+static const struct spi_imx_master moboard_spi1_pdata __initconst = {
 	.chipselect	= moboard_spi1_cs,
 	.num_chipselect	= ARRAY_SIZE(moboard_spi1_cs),
 };
@@ -282,7 +282,7 @@ static int moboard_spi2_cs[] = {
 	MXC_SPI_CS(1),
 };
 
-static struct spi_imx_master moboard_spi2_master = {
+static const struct spi_imx_master moboard_spi2_pdata __initconst = {
 	.chipselect	= moboard_spi2_cs,
 	.num_chipselect	= ARRAY_SIZE(moboard_spi2_cs),
 };
@@ -502,8 +502,8 @@ static void __init mxc_board_init(void)
 	imx31_add_imx_i2c0(&moboard_i2c0_data);
 	imx31_add_imx_i2c1(&moboard_i2c1_data);
 
-	mxc_register_device(&mxc_spi_device1, &moboard_spi1_master);
-	mxc_register_device(&mxc_spi_device2, &moboard_spi2_master);
+	imx31_add_spi_imx1(&moboard_spi1_pdata);
+	imx31_add_spi_imx2(&moboard_spi2_pdata);
 
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index e35d2eb..3786e29 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -37,8 +37,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
 #include <mach/mmc.h>
-#include <mach/spi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 /*
@@ -157,7 +157,7 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static struct spi_imx_master spi0_pdata = {
+static const struct spi_imx_master spi0_pdata __initconst = {
 	.chipselect	= spi_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
@@ -199,7 +199,7 @@ void __init mx31lite_db_init(void)
 					"development board pins");
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
-	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
+	imx31_add_spi_imx0(&spi0_pdata);
 	platform_device_register(&litekit_led_device);
 	mxc_register_device(&imx_wdt_device0, NULL);
 	mxc_register_device(&imx_rtc_device0, NULL);
-- 
1.7.1
