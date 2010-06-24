From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:49 +0200
Subject: [PATCH 53/61] ARM: imx: dynamically register spi_imx devices (imx35)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-54-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig           |    1 +
 arch/arm/mach-mx3/devices-imx35.h   |    5 +++
 arch/arm/mach-mx3/devices.c         |   61 -----------------------------------
 arch/arm/mach-mx3/devices.h         |    5 ---
 arch/arm/mach-mx3/mach-pcm037_eet.c |    7 +---
 5 files changed, 8 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 60d58a6..a8018e8 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -45,6 +45,7 @@ config MACH_PCM037
 config MACH_PCM037_EET
 	bool "Support pcm037 EET board extensions"
 	depends on MACH_PCM037
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Add support for PCM037 EET baseboard extensions. If you are using the
 	  OLED display with EET, use "video=mx3fb:CMEL-OLED" kernel
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 6d993ae..b595fa6 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -18,3 +18,8 @@
 
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
+
+#define imx35_add_spi_imx0(pdata)	\
+	imx_add_spi_imx(0, MX35_CSPI1_BASE_ADDR, SZ_4K, MX35_INT_CSPI1, pdata)
+#define imx35_add_spi_imx1(pdata)	\
+	imx_add_spi_imx(1, MX35_CSPI2_BASE_ADDR, SZ_4K, MX35_INT_CSPI2, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 02d05ea..dd90ee9 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -380,67 +380,6 @@ struct platform_device mxc_usbh2 = {
 };
 
 #if defined(CONFIG_ARCH_MX35)
-/*
- * SPI master controller
- * 3 channels
- */
-static struct resource mxc_spi_0_resources[] = {
-	{
-	       .start = CSPI1_BASE_ADDR,
-	       .end = CSPI1_BASE_ADDR + SZ_4K - 1,
-	       .flags = IORESOURCE_MEM,
-	}, {
-	       .start = MXC_INT_CSPI1,
-	       .end = MXC_INT_CSPI1,
-	       .flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource mxc_spi_1_resources[] = {
-	{
-		.start = CSPI2_BASE_ADDR,
-		.end = CSPI2_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_CSPI2,
-		.end = MXC_INT_CSPI2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource mxc_spi_2_resources[] = {
-	{
-		.start = CSPI3_BASE_ADDR,
-		.end = CSPI3_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_CSPI3,
-		.end = MXC_INT_CSPI3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_spi_device0 = {
-	.name = "spi_imx",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_spi_0_resources),
-	.resource = mxc_spi_0_resources,
-};
-
-struct platform_device mxc_spi_device1 = {
-	.name = "spi_imx",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_spi_1_resources),
-	.resource = mxc_spi_1_resources,
-};
-
-struct platform_device mxc_spi_device2 = {
-	.name = "spi_imx",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_spi_2_resources),
-	.resource = mxc_spi_2_resources,
-};
-
 static struct resource mxc_fec_resources[] = {
 	{
 		.start	= MXC_FEC_BASE_ADDR,
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index d22a327..9380cd9 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -16,11 +16,6 @@ extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
 extern struct platform_device mxc_rnga_device;
-#if defined(CONFIG_ARCH_MX35)
-extern struct platform_device mxc_spi_device0;
-extern struct platform_device mxc_spi_device1;
-extern struct platform_device mxc_spi_device2;
-#endif
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
 extern struct platform_device imx_ssi_device1;
diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index 8d38600..c8b9821 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -13,9 +13,6 @@
 #include <linux/spi/spi.h>
 
 #include <mach/common.h>
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
-#include <mach/spi.h>
-#endif
 #include <mach/iomux-mx3.h>
 
 #include <asm/mach-types.h>
@@ -64,7 +61,7 @@ static struct spi_board_info pcm037_spi_dev[] = {
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 static int pcm037_spi1_cs[] = {MXC_SPI_CS(1), IOMUX_TO_GPIO(MX31_PIN_KEY_COL7)};
 
-struct spi_imx_master pcm037_spi1_master = {
+static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
 	.chipselect = pcm037_spi1_cs,
 	.num_chipselect = ARRAY_SIZE(pcm037_spi1_cs),
 };
@@ -184,7 +181,7 @@ static int eet_init_devices(void)
 	/* SPI */
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
-	mxc_register_device(&mxc_spi_device0, &pcm037_spi1_master);
+	imx35_add_spi_imx0(&pcm037_spi1_pdata);
 #endif
 
 	platform_device_register(&pcm037_gpio_keys_device);
-- 
1.7.1
