From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:13 +0100
Subject: [PATCH 45/51] ARM: mx3: dynamically register mxc-mmc devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-45-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compared to the static devices the dynamic have a DMA resource.
This should be save as it seems unused in the driver.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                       |    5 +++
 arch/arm/mach-mx3/devices-imx31.h               |    4 ++
 arch/arm/mach-mx3/devices.c                     |   38 -----------------------
 arch/arm/mach-mx3/devices.h                     |    2 -
 arch/arm/mach-mx3/mach-armadillo5x0.c           |    5 +--
 arch/arm/mach-mx3/mach-mx31moboard.c            |    9 ++---
 arch/arm/mach-mx3/mach-pcm037.c                 |    5 +--
 arch/arm/mach-mx3/mx31lilly-db.c                |    5 +--
 arch/arm/mach-mx3/mx31lite-db.c                 |    6 +--
 arch/arm/mach-mx3/mx31moboard-devboard.c        |    5 +--
 arch/arm/mach-mx3/mx31moboard-marxbot.c         |    6 ++--
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c    |   20 +++++++++---
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 arch/arm/plat-mxc/include/mach/mx31.h           |   10 +++--
 14 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 29ec5ad..46fffa5 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -52,6 +52,7 @@ config MACH_PCM037
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select MXC_ULPI if USB_ULPI
@@ -73,6 +74,7 @@ config MACH_MX31LITE
 	select SOC_IMX31
 	select MXC_ULPI if USB_ULPI
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -104,6 +106,7 @@ config MACH_MX31MOBOARD
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
@@ -114,6 +117,7 @@ config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
@@ -147,6 +151,7 @@ config MACH_ARMADILLO5X0
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index a88f243..875e26f 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -29,6 +29,10 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst;
 #define imx31_add_imx_uart3(pdata)	imx31_add_imx_uart(3, pdata)
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
+extern const struct imx_mxc_mmc_data imx31_mxc_mmc_data[] __initconst;
+#define imx31_add_mxc_mmc(id, pdata)	\
+	imx_add_mxc_mmc(&imx31_mxc_mmc_data[id], pdata)
+
 extern const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst;
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index b179f70..079b98e 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -30,44 +30,6 @@
 #include "devices.h"
 
 #ifdef CONFIG_ARCH_MX31
-static struct resource mxcsdhc0_resources[] = {
-	{
-		.start = MX31_MMC_SDHC1_BASE_ADDR,
-		.end = MX31_MMC_SDHC1_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX31_INT_MMC_SDHC1,
-		.end = MX31_INT_MMC_SDHC1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-static struct resource mxcsdhc1_resources[] = {
-	{
-		.start = MX31_MMC_SDHC2_BASE_ADDR,
-		.end = MX31_MMC_SDHC2_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX31_INT_MMC_SDHC2,
-		.end = MX31_INT_MMC_SDHC2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxcsdhc_device0 = {
-	.name = "mxc-mmc",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxcsdhc0_resources),
-	.resource = mxcsdhc0_resources,
-};
-
-struct platform_device mxcsdhc_device1 = {
-	.name = "mxc-mmc",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxcsdhc1_resources),
-	.resource = mxcsdhc1_resources,
-};
-
 static struct resource rnga_resources[] = {
 	{
 		.start = MX3x_RNGA_BASE_ADDR,
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index a649772..2020474 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,8 +1,6 @@
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device mxcsdhc_device0;
-extern struct platform_device mxcsdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index aaa30fe..e48072c 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -49,7 +49,6 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
-#include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_ehci.h>
@@ -453,7 +452,7 @@ static void armadillo5x0_sdhc1_exit(struct device *dev, void *data)
 	gpio_free(IOMUX_TO_GPIO(MX31_PIN_ATA_RESET_B));
 }
 
-static struct imxmmc_platform_data sdhc_pdata = {
+static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.get_ro = armadillo5x0_sdhc1_get_ro,
 	.init = armadillo5x0_sdhc1_init,
 	.exit = armadillo5x0_sdhc1_exit,
@@ -520,7 +519,7 @@ static void __init armadillo5x0_init(void)
 	gpio_direction_input(MX31_PIN_GPIO1_0);
 
 	/* Register SDHC */
-	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
+	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
 	/* Register FB */
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index eb5f426..5e2ee85 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -40,7 +40,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
-#include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/mx3_camera.h>
 #include <mach/spi.h>
@@ -170,11 +169,11 @@ static const struct spi_imx_master moboard_spi1_pdata __initconst = {
 
 static struct regulator_consumer_supply sdhc_consumers[] = {
 	{
-		.dev	= &mxcsdhc_device0.dev,
+		.dev_name = "mxc-mmc.0",
 		.supply	= "sdhc0_vcc",
 	},
 	{
-		.dev	= &mxcsdhc_device1.dev,
+		.dev_name = "mxc-mmc.1",
 		.supply	= "sdhc1_vcc",
 	},
 };
@@ -345,7 +344,7 @@ static void moboard_sdhc1_exit(struct device *dev, void *data)
 	gpio_free(SDHC1_CD);
 }
 
-static struct imxmmc_platform_data sdhc1_pdata = {
+static const struct imxmmc_platform_data sdhc1_pdata __initconst = {
 	.get_ro	= moboard_sdhc1_get_ro,
 	.init	= moboard_sdhc1_init,
 	.exit	= moboard_sdhc1_exit,
@@ -520,7 +519,7 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(moboard_spi_board_info,
 		ARRAY_SIZE(moboard_spi_board_info));
 
-	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
+	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	if (!mx31moboard_cam_alloc_dma(CAMERA_BUF_SIZE))
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index bc5d3a1..2ba4f2b 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -43,7 +43,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
-#include <mach/mmc.h>
 #include <mach/mx3_camera.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_ehci.h>
@@ -401,7 +400,7 @@ static void pcm970_sdhc1_exit(struct device *dev, void *data)
 	gpio_free(SDHC1_GPIO_WP);
 }
 
-static struct imxmmc_platform_data sdhc_pdata = {
+static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 #ifdef PCM970_SDHC_RW_SWITCH
 	.get_ro = pcm970_sdhc1_get_ro,
 #endif
@@ -634,7 +633,7 @@ static void __init mxc_board_init(void)
 	imx31_add_imx_i2c2(&pcm037_i2c2_data);
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
-	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
+	imx31_add_mxc_mmc(0, &sdhc_pdata);
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 
diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index 827fd3c..8f1a38e 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -34,7 +34,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lilly.h>
-#include <mach/mmc.h>
 #include <mach/mx3fb.h>
 #include <mach/ipu.h>
 
@@ -158,7 +157,7 @@ static void mxc_mmc1_exit(struct device *dev, void *data)
 	free_irq(IOMUX_TO_IRQ(MX31_PIN_GPIO1_1), data);
 }
 
-static struct imxmmc_platform_data mmc_pdata = {
+static const struct imxmmc_platform_data mmc_pdata __initconst = {
 	.get_ro	= mxc_mmc1_get_ro,
 	.init	= mxc_mmc1_init,
 	.exit	= mxc_mmc1_exit,
@@ -216,7 +215,7 @@ void __init mx31lilly_db_init(void)
 	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_imx_uart1(&uart_pdata);
 	imx31_add_imx_uart2(&uart_pdata);
-	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
+	imx31_add_mxc_mmc(0, &mmc_pdata);
 	mx31lilly_init_fb();
 }
 
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 7b0e74e..a06161e 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -35,7 +35,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
-#include <mach/mmc.h>
 
 #include "devices-imx31.h"
 #include "devices.h"
@@ -142,7 +141,7 @@ static void mxc_mmc1_exit(struct device *dev, void *data)
 	free_irq(IOMUX_TO_IRQ(MX31_PIN_DCD_DCE1), data);
 }
 
-static struct imxmmc_platform_data mmc_pdata = {
+static const struct imxmmc_platform_data mmc_pdata __initconst = {
 	.get_ro	 = mxc_mmc1_get_ro,
 	.init	   = mxc_mmc1_init,
 	.exit	   = mxc_mmc1_exit,
@@ -197,10 +196,9 @@ void __init mx31lite_db_init(void)
 					ARRAY_SIZE(litekit_db_board_pins),
 					"development board pins");
 	imx31_add_imx_uart0(&uart_pdata);
-	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
+	imx31_add_mxc_mmc(0, &mmc_pdata);
 	imx31_add_spi_imx0(&spi0_pdata);
 	platform_device_register(&litekit_led_device);
 	mxc_register_device(&imx_wdt_device0, NULL);
 	mxc_register_device(&imx_rtc_device0, NULL);
 }
-
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index fc395a7..3b75929 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -25,7 +25,6 @@
 #include <mach/common.h>
 #include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
-#include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
@@ -103,7 +102,7 @@ static void devboard_sdhc2_exit(struct device *dev, void *data)
 	gpio_free(SDHC2_CD);
 }
 
-static struct imxmmc_platform_data sdhc2_pdata = {
+static const struct imxmmc_platform_data sdhc2_pdata __initconst = {
 	.get_ro	= devboard_sdhc2_get_ro,
 	.init	= devboard_sdhc2_init,
 	.exit	= devboard_sdhc2_exit,
@@ -228,7 +227,7 @@ void __init mx31moboard_devboard_init(void)
 
 	imx31_add_imx_uart1(&uart_pdata);
 
-	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
+	imx31_add_mxc_mmc(1, &sdhc2_pdata);
 
 	devboard_init_sel_gpios();
 
diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 0551eb3..075c4fb 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -29,12 +29,12 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
-#include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
 #include <media/soc_camera.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 static unsigned int marxbot_pins[] = {
@@ -116,7 +116,7 @@ static void marxbot_sdhc2_exit(struct device *dev, void *data)
 	gpio_free(SDHC2_CD);
 }
 
-static struct imxmmc_platform_data sdhc2_pdata = {
+static const struct imxmmc_platform_data sdhc2_pdata __initconst = {
 	.get_ro	= marxbot_sdhc2_get_ro,
 	.init	= marxbot_sdhc2_init,
 	.exit	= marxbot_sdhc2_exit,
@@ -345,7 +345,7 @@ void __init mx31moboard_marxbot_init(void)
 
 	dspics_resets_init();
 
-	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
+	imx31_add_mxc_mmc(1, &sdhc2_pdata);
 
 	spi_register_board_info(marxbot_spi_board_info,
 		ARRAY_SIZE(marxbot_spi_board_info));
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
index 953319e..90d762f 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
@@ -9,20 +9,21 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_mxc_mmc_data_entry_single(soc, _id, _hwid)			\
+#define imx_mxc_mmc_data_entry_single(soc, _id, _hwid, _size)		\
 	{								\
 		.id = _id,						\
 		.iobase = soc ## _SDHC ## _hwid ## _BASE_ADDR,		\
+		.iosize = _size,					\
 		.irq = soc ## _INT_SDHC ## _hwid,			\
 		.dmareq = soc ## _DMA_REQ_SDHC ## _hwid,		\
 	}
-#define imx_mxc_mmc_data_entry(soc, _id, _hwid)				\
-	[_id] = imx_mxc_mmc_data_entry_single(soc, _id, _hwid)
+#define imx_mxc_mmc_data_entry(soc, _id, _hwid, _size)			\
+	[_id] = imx_mxc_mmc_data_entry_single(soc, _id, _hwid, _size)
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
 #define imx21_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX21, _id, _hwid)
+	imx_mxc_mmc_data_entry(MX21, _id, _hwid, SZ_4K)
 	imx21_mxc_mmc_data_entry(0, 1),
 	imx21_mxc_mmc_data_entry(1, 2),
 };
@@ -31,12 +32,21 @@ const struct imx_mxc_mmc_data imx21_mxc_mmc_data[] __initconst = {
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_mmc_data imx27_mxc_mmc_data[] __initconst = {
 #define imx27_mxc_mmc_data_entry(_id, _hwid)				\
-	imx_mxc_mmc_data_entry(MX27, _id, _hwid)
+	imx_mxc_mmc_data_entry(MX27, _id, _hwid, SZ_4K)
 	imx27_mxc_mmc_data_entry(0, 1),
 	imx27_mxc_mmc_data_entry(1, 2),
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX31
+const struct imx_mxc_mmc_data imx31_mxc_mmc_data[] __initconst = {
+#define imx31_mxc_mmc_data_entry(_id, _hwid)				\
+	imx_mxc_mmc_data_entry(MX31, _id, _hwid, SZ_16K)
+	imx31_mxc_mmc_data_entry(0, 1),
+	imx31_mxc_mmc_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
 struct platform_device *__init imx_add_mxc_mmc(
 		const struct imx_mxc_mmc_data *data,
 		const struct imxmmc_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 95331ae..5a62dc4 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -202,6 +202,7 @@ struct platform_device *__init imx_add_mxc_ehci(
 struct imx_mxc_mmc_data {
 	int id;
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq;
 	resource_size_t dmareq;
 };
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 6d4b98f..d024c9c 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -41,8 +41,8 @@
 
 #define MX31_SPBA0_BASE_ADDR		0x50000000
 #define MX31_SPBA0_SIZE			SZ_1M
-#define MX31_MMC_SDHC1_BASE_ADDR		(MX31_SPBA0_BASE_ADDR + 0x04000)
-#define MX31_MMC_SDHC2_BASE_ADDR		(MX31_SPBA0_BASE_ADDR + 0x08000)
+#define MX31_SDHC1_BASE_ADDR			(MX31_SPBA0_BASE_ADDR + 0x04000)
+#define MX31_SDHC2_BASE_ADDR			(MX31_SPBA0_BASE_ADDR + 0x08000)
 #define MX31_UART3_BASE_ADDR			(MX31_SPBA0_BASE_ADDR + 0x0c000)
 #define MX31_CSPI2_BASE_ADDR			(MX31_SPBA0_BASE_ADDR + 0x10000)
 #define MX31_SSI2_BASE_ADDR			(MX31_SPBA0_BASE_ADDR + 0x14000)
@@ -134,8 +134,8 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_MPEG4_ENCODER	5
 #define MX31_INT_RTIC		6
 #define MX31_INT_FIRI		7
-#define MX31_INT_MMC_SDHC2	8
-#define MX31_INT_MMC_SDHC1	9
+#define MX31_INT_SDHC2		8
+#define MX31_INT_SDHC1		9
 #define MX31_INT_I2C1		10
 #define MX31_INT_SSI2		11
 #define MX31_INT_SSI1		12
@@ -188,6 +188,8 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_EXT_WDOG	62
 #define MX31_INT_EXT_TV		63
 
+#define MX31_DMA_REQ_SDHC1	20
+#define MX31_DMA_REQ_SDHC2	21
 #define MX31_DMA_REQ_SSI2_RX1	22
 #define MX31_DMA_REQ_SSI2_TX1	23
 #define MX31_DMA_REQ_SSI2_RX0	24
-- 
1.7.2.3
