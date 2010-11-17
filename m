From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:49 +0100
Subject: [PATCH 21/51] ARM: imx: dynamically register mxc-mmc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-21-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... plus a trivial simplification of mx21ads_sdhc_init()

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    9 +++
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   35 +------------
 arch/arm/mach-imx/devices.h                     |    2 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    5 +-
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    5 +-
 arch/arm/mach-imx/mach-mx21ads.c                |   14 +----
 arch/arm/mach-imx/mach-mx27_3ds.c               |    5 +-
 arch/arm/mach-imx/mach-mx27ads.c                |    9 ++--
 arch/arm/mach-imx/mach-mxt_td60.c               |    5 +-
 arch/arm/mach-imx/mach-pca100.c                 |    5 +-
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +-
 arch/arm/mach-imx/pcm970-baseboard.c            |    5 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c    |   62 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   11 ++++
 19 files changed, 116 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-mmc.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d3e983e..8e9297b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -73,6 +73,7 @@ config MACH_MX21ADS
 	bool "MX21ADS platform"
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX21ADS platform. This includes specific
@@ -89,6 +90,7 @@ config MACH_MX27ADS
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	help
@@ -116,6 +118,7 @@ choice
 config MACH_PCM970_BASEBOARD
 	bool "PHYTEC PCM970 development board"
 	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  This adds board specific devices that can be found on Phytec's
 	  PCM970 evaluation board.
@@ -137,6 +140,7 @@ config MACH_CPUIMX27
 config MACH_EUKREA_CPUIMX27_USESDHC2
 	bool "CPUIMX27 integrates SDHC2 module"
 	depends on MACH_CPUIMX27
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  This adds support for the internal SDHC2 used on CPUIMX27
 	  for wifi or eMMC.
@@ -158,6 +162,7 @@ config MACH_EUKREA_MBIMX27_BASEBOARD
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
@@ -168,6 +173,7 @@ endchoice
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -176,6 +182,7 @@ config MACH_IMX27_VISSTRIM_M10
 	bool "Vista Silicon i.MX27 Visstrim_m10"
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
 	  Include support for Visstrim_m10 platform and its different variants.
 	  This includes specific configurations for the board and its
@@ -195,6 +202,7 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -208,6 +216,7 @@ config MACH_MXT_TD60
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for i-MXT (aka td60) platform. This
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 0f782b6..a97e921 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -33,6 +33,10 @@ extern const struct imx_imx_uart_1irq_data imx21_imx_uart_data[] __initconst;
 #define imx21_add_imx_uart2(pdata)	imx21_add_imx_uart(2, pdata)
 #define imx21_add_imx_uart3(pdata)	imx21_add_imx_uart(3, pdata)
 
+extern const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst;
+#define imx21_add_mxc_mmc(id, pdata)	\
+	imx_add_mxc_mmc(&imx21_mxc_mmc_data[id], pdata)
+
 extern const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst;
 #define imx21_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx21_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 6e11bef..6466744 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -43,6 +43,10 @@ extern const struct imx_mx2_camera_data imx27_mx2_camera_data __initconst;
 #define imx27_add_mx2_camera(pdata)	\
 	imx_add_mx2_camera(&imx27_mx2_camera_data, pdata)
 
+extern const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst;
+#define imx27_add_mxc_mmc(id, pdata)	\
+	imx_add_mxc_mmc(&imx27_mxc_mmc_data[id], pdata)
+
 extern const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst;
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx27_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 9ee0e09..7609e8a 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -76,40 +76,6 @@ int __init imx1_register_gpios(void)
 }
 #endif
 
-#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-#define DEFINE_MXC_MMC_DEVICE(n, baseaddr, irq, dmareq)			\
-	static struct resource mxc_sdhc_resources ## n[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + SZ_4K - 1,			\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irq,					\
-			.end = irq,					\
-			.flags = IORESOURCE_IRQ,			\
-		}, {							\
-			.start = dmareq,				\
-			.end = dmareq,					\
-			.flags = IORESOURCE_DMA,			\
-		},							\
-	};								\
-									\
-	static u64 mxc_sdhc ## n ## _dmamask = DMA_BIT_MASK(32);	\
-									\
-	struct platform_device mxc_sdhc_device ## n = {			\
-		.name = "mxc-mmc",					\
-		.id = n,						\
-		.dev = {						\
-			.dma_mask = &mxc_sdhc ## n ## _dmamask,		\
-			.coherent_dma_mask = DMA_BIT_MASK(32),		\
-		},							\
-		.num_resources = ARRAY_SIZE(mxc_sdhc_resources ## n),	\
-		.resource = mxc_sdhc_resources ## n,		\
-	}
-
-DEFINE_MXC_MMC_DEVICE(0, MX2x_SDHC1_BASE_ADDR, MX2x_INT_SDHC1, MX2x_DMA_REQ_SDHC1);
-DEFINE_MXC_MMC_DEVICE(1, MX2x_SDHC2_BASE_ADDR, MX2x_INT_SDHC2, MX2x_DMA_REQ_SDHC2);
-
 #ifdef CONFIG_MACH_MX27
 static struct resource otg_resources[] = {
 	{
@@ -203,6 +169,7 @@ struct platform_device mxc_usbh2 = {
 };
 #endif
 
+#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 /* GPIO port description */
 #define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 1ba5042..a45d760 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,6 +1,4 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_sdhc_device0;
-extern struct platform_device mxc_sdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index a226e25..fa5aade 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -33,7 +33,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
-#include <mach/mmc.h>
 #include <mach/spi.h>
 #include <mach/audmux.h>
 
@@ -305,7 +304,7 @@ static struct platform_device *platform_devices[] __initdata = {
 	&leds_gpio,
 };
 
-static struct imxmmc_platform_data sdhc_pdata = {
+static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.dat3_card_detect = 1,
 };
 
@@ -351,7 +350,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 #endif
 
 	imx27_add_imx_fb(&eukrea_mbimx27_fb_data);
-	mxc_register_device(&mxc_sdhc_device0, &sdhc_pdata);
+	imx27_add_mxc_mmc(0, &sdhc_pdata);
 
 	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 5771d4e..06ff79a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -265,7 +265,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
 	/* SDHC2 can be used for Wifi */
-	mxc_register_device(&mxc_sdhc_device1, NULL);
+	imx27_add_mxc_mmc(1, NULL);
 #endif
 #if defined(MACH_EUKREA_CPUIMX27_USEUART4)
 	/* in which case UART4 is also used for Bluetooth */
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 59716fa..deef1fa 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -34,7 +34,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
-#include <mach/mmc.h>
 #include <mach/iomux.h>
 #include <mach/mxc_ehci.h>
 
@@ -156,7 +155,7 @@ static void visstrim_m10_sdhc1_exit(struct device *dev, void *data)
 	free_irq(SDHC1_IRQ, data);
 }
 
-static struct imxmmc_platform_data visstrim_m10_sdhc_pdata = {
+static const struct imxmmc_platform_data visstrim_m10_sdhc_pdata __initconst = {
 	.init = visstrim_m10_sdhc1_init,
 	.exit = visstrim_m10_sdhc1_exit,
 };
@@ -237,7 +236,7 @@ static void __init visstrim_m10_board_init(void)
 				ARRAY_SIZE(visstrim_m10_i2c_devices));
 	imx27_add_imx_i2c(0, &visstrim_m10_i2c_data);
 	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
-	mxc_register_device(&mxc_sdhc_device0, &visstrim_m10_sdhc_pdata);
+	imx27_add_mxc_mmc(0, &visstrim_m10_sdhc_pdata);
 	mxc_register_device(&mxc_otg_host, &visstrim_m10_usbotg_pdata);
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 4820a67..83c064a 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 #include <mach/iomux-mx21.h>
 #include <mach/mxc_nand.h>
-#include <mach/mmc.h>
 
 #include "devices-imx21.h"
 #include "devices.h"
@@ -232,15 +231,8 @@ static int mx21ads_sdhc_get_ro(struct device *dev)
 static int mx21ads_sdhc_init(struct device *dev, irq_handler_t detect_irq,
 	void *data)
 {
-	int ret;
-
-	ret = request_irq(IRQ_GPIOD(25), detect_irq,
+	return request_irq(IRQ_GPIOD(25), detect_irq,
 		IRQF_TRIGGER_FALLING, "mmc-detect", data);
-	if (ret)
-		goto out;
-	return 0;
-out:
-	return ret;
 }
 
 static void mx21ads_sdhc_exit(struct device *dev, void *data)
@@ -248,7 +240,7 @@ static void mx21ads_sdhc_exit(struct device *dev, void *data)
 	free_irq(IRQ_GPIOD(25), data);
 }
 
-static struct imxmmc_platform_data mx21ads_sdhc_pdata = {
+static const struct imxmmc_platform_data mx21ads_sdhc_pdata __initconst = {
 	.ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31, /* 3.0V */
 	.get_ro = mx21ads_sdhc_get_ro,
 	.init = mx21ads_sdhc_init,
@@ -296,7 +288,7 @@ static void __init mx21ads_board_init(void)
 	imx21_add_imx_uart2(&uart_pdata_norts);
 	imx21_add_imx_uart3(&uart_pdata_rts);
 	imx21_add_imx_fb(&mx21ads_fb_data);
-	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
+	imx21_add_mxc_mmc(0, &mx21ads_sdhc_pdata);
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 84a5ba0..e6212c3 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -30,7 +30,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
-#include <mach/mmc.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -109,7 +108,7 @@ static void mx27_3ds_sdhc1_exit(struct device *dev, void *data)
 	free_irq(IRQ_GPIOB(26), data);
 }
 
-static struct imxmmc_platform_data sdhc1_pdata = {
+static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
 	.init = mx27_3ds_sdhc1_init,
 	.exit = mx27_3ds_sdhc1_exit,
 };
@@ -129,7 +128,7 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
 	mxc_register_device(&imx_kpp_device, &mx27_3ds_keymap_data);
-	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
+	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 }
 
 static void __init mx27pdk_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index d97b25b..370481b 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -30,7 +30,6 @@
 #include <mach/gpio.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/mmc.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -271,12 +270,12 @@ static void mx27ads_sdhc2_exit(struct device *dev, void *data)
 	free_irq(IRQ_GPIOB(7), data);
 }
 
-static struct imxmmc_platform_data sdhc1_pdata = {
+static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
 	.init = mx27ads_sdhc1_init,
 	.exit = mx27ads_sdhc1_exit,
 };
 
-static struct imxmmc_platform_data sdhc2_pdata = {
+static const struct imxmmc_platform_data sdhc2_pdata __initconst = {
 	.init = mx27ads_sdhc2_init,
 	.exit = mx27ads_sdhc2_exit,
 };
@@ -307,8 +306,8 @@ static void __init mx27ads_board_init(void)
 				ARRAY_SIZE(mx27ads_i2c_devices));
 	imx27_add_imx_i2c(1, &mx27ads_i2c1_data);
 	imx27_add_imx_fb(&mx27ads_fb_data);
-	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
-	mxc_register_device(&mxc_sdhc_device1, &sdhc2_pdata);
+	imx27_add_mxc_mmc(0, &sdhc1_pdata);
+	imx27_add_mxc_mmc(1, &sdhc2_pdata);
 
 	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 0c94485..d1a3158 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -31,7 +31,6 @@
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
 #include <linux/i2c/pca953x.h>
-#include <mach/mmc.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -225,7 +224,7 @@ static void mxt_td60_sdhc1_exit(struct device *dev, void *data)
 	free_irq(IRQ_GPIOF(8), data);
 }
 
-static struct imxmmc_platform_data sdhc1_pdata = {
+static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
 	.init = mxt_td60_sdhc1_init,
 	.exit = mxt_td60_sdhc1_exit,
 };
@@ -253,7 +252,7 @@ static void __init mxt_td60_board_init(void)
 	imx27_add_imx_i2c(0, &mxt_td60_i2c0_data);
 	imx27_add_imx_i2c(1, &mxt_td60_i2c1_data);
 	imx27_add_imx_fb(&mxt_td60_fb_data);
-	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
+	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 	imx27_add_fec(NULL);
 }
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 30490c3..b05f528 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -40,7 +40,6 @@
 #include <mach/audmux.h>
 #include <mach/mxc_nand.h>
 #include <mach/irqs.h>
-#include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
@@ -268,7 +267,7 @@ static void pca100_sdhc2_exit(struct device *dev, void *data)
 	free_irq(IRQ_GPIOC(29), data);
 }
 
-static struct imxmmc_platform_data sdhc_pdata = {
+static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.init = pca100_sdhc2_init,
 	.exit = pca100_sdhc2_exit,
 };
@@ -383,7 +382,7 @@ static void __init pca100_init(void)
 
 	imx27_add_imx_uart0(&uart_pdata);
 
-	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
+	imx27_add_mxc_mmc(1, &sdhc_pdata);
 
 	imx27_add_mxc_nand(&pca100_nand_board_info);
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 3c9f2df..b3340cd 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -212,7 +212,7 @@ static const struct spi_imx_master pcm038_spi0_data __initconst = {
 
 static struct regulator_consumer_supply sdhc1_consumers[] = {
 	{
-		.dev	= &mxc_sdhc_device1.dev,
+		.dev_name = "mxc-mmc.1",
 		.supply	= "sdhc_vcc",
 	},
 };
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 9cf9460..1297f1b 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -26,7 +26,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
 #include <mach/hardware.h>
-#include <mach/mmc.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -119,7 +118,7 @@ static void pcm970_sdhc2_exit(struct device *dev, void *data)
 	gpio_free(GPIO_PORTC + 28);
 }
 
-static struct imxmmc_platform_data sdhc_pdata = {
+static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.get_ro = pcm970_sdhc2_get_ro,
 	.init = pcm970_sdhc2_init,
 	.exit = pcm970_sdhc2_exit,
@@ -228,6 +227,6 @@ void __init pcm970_baseboard_init(void)
 
 	imx27_add_imx_fb(&pcm038_fb_data);
 	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
-	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
+	imx27_add_mxc_mmc(1, &sdhc_pdata);
 	platform_device_register(&pcm970_sja1000);
 }
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 2ded17b..6560cf5 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -37,6 +37,9 @@ config IMX_HAVE_PLATFORM_MX1_CAMERA
 config IMX_HAVE_PLATFORM_MX2_CAMERA
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_MMC
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 8ecd974..d2b7a91 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
new file mode 100644
index 0000000..953319e
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
@@ -0,0 +1,62 @@
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
+#define imx_mxc_mmc_data_entry_single(soc, _id, _hwid)			\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _SDHC ## _hwid ## _BASE_ADDR,		\
+		.irq = soc ## _INT_SDHC ## _hwid,			\
+		.dmareq = soc ## _DMA_REQ_SDHC ## _hwid,		\
+	}
+#define imx_mxc_mmc_data_entry(soc, _id, _hwid)				\
+	[_id] = imx_mxc_mmc_data_entry_single(soc, _id, _hwid)
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
+#define imx21_mxc_mmc_data_entry(_id, _hwid)				\
+	imx_mxc_mmc_data_entry(MX21, _id, _hwid)
+	imx21_mxc_mmc_data_entry(0, 1),
+	imx21_mxc_mmc_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst = {
+#define imx27_mxc_mmc_data_entry(_id, _hwid)				\
+	imx_mxc_mmc_data_entry(MX27, _id, _hwid)
+	imx27_mxc_mmc_data_entry(0, 1),
+	imx27_mxc_mmc_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_mxc_mmc(
+		const struct imx_mxc_mmc_data *data,
+		const struct imxmmc_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->dmareq,
+			.end = data->dmareq,
+			.flags = IORESOURCE_DMA,
+		},
+	};
+	return imx_add_platform_device_dmamask("mxc-mmc", data->id,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index e241e41..bb3b29c 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -151,6 +151,17 @@ struct platform_device *__init imx_add_mx2_camera(
 		const struct imx_mx2_camera_data *data,
 		const struct mx2_camera_platform_data *pdata);
 
+#include <mach/mmc.h>
+struct imx_mxc_mmc_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t irq;
+	resource_size_t dmareq;
+};
+struct platform_device *__init imx_add_mxc_mmc(
+		const struct imx_mxc_mmc_data *data,
+		const struct imxmmc_platform_data *pdata);
+
 #include <mach/mxc_nand.h>
 struct imx_mxc_nand_data {
 	/*
-- 
1.7.2.3
