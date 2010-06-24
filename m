From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:41 +0200
Subject: [PATCH 45/61] ARM: imx: dynamically register imx-i2c devices (imx27)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-46-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig             |    5 +++++
 arch/arm/mach-imx/devices-imx27.h     |    5 +++++
 arch/arm/mach-imx/devices.c           |   26 --------------------------
 arch/arm/mach-imx/devices.h           |    4 ----
 arch/arm/mach-imx/mach-cpuimx27.c     |    5 ++---
 arch/arm/mach-imx/mach-mx27ads.c      |    5 ++---
 arch/arm/mach-imx/mach-mxt_td60.c     |    9 ++++-----
 arch/arm/mach-imx/mach-pca100.c       |    5 ++---
 arch/arm/mach-imx/mach-pcm038.c       |    5 ++---
 arch/arm/plat-mxc/include/mach/mx27.h |    4 ++--
 10 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 3f88d4a..2bf8078 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -82,6 +82,7 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX27ADS platform. This includes specific
@@ -89,6 +90,7 @@ config MACH_MX27ADS
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -111,6 +113,7 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
@@ -151,6 +154,7 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -159,6 +163,7 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for i-MXT (aka td60) platform. This
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index b2f6a12..5e0c40c 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -9,5 +9,10 @@
 #include <mach/mx27.h>
 #include <mach/devices-common.h>
 
+#define imx27_add_i2c_imx0(pdata)	\
+	imx_add_imx_i2c(0, MX27_I2C1_BASE_ADDR, SZ_4K, MX27_INT_I2C1, pdata)
+#define imx27_add_i2c_imx1(pdata)	\
+	imx_add_imx_i2c(1, MX27_I2C2_BASE_ADDR, SZ_4K, MX27_INT_I2C2, pdata)
+
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index b9f5b69..f8641c2 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -368,32 +368,6 @@ struct platform_device mxc_fec_device = {
 };
 #endif
 
-#ifdef CONFIG_MACH_MX27
-#define DEFINE_IMX_I2C_DEVICE(n, baseaddr, irq)				\
-	static struct resource mxc_i2c_resources ## n[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + SZ_4K - 1,			\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irq,					\
-			.end = irq,					\
-			.flags = IORESOURCE_IRQ,			\
-		}							\
-	};								\
-									\
-	struct platform_device mxc_i2c_device ## n = {			\
-		.name = "imx-i2c",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(mxc_i2c_resources ## n),	\
-		.resource = mxc_i2c_resources ## n,			\
-	}
-
-DEFINE_IMX_I2C_DEVICE(0, MX2x_I2C_BASE_ADDR, MX2x_INT_I2C);
-
-DEFINE_IMX_I2C_DEVICE(1, MX27_I2C2_BASE_ADDR, MX27_INT_I2C2);
-#endif
-
 static struct resource mxc_pwm_resources[] = {
 	{
 		.start = MX2x_PWM_BASE_ADDR,
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index dcaa4f9..4fe9935 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -28,10 +28,6 @@ extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
-#ifdef CONFIG_MACH_MX27
-extern struct platform_device mxc_i2c_device0;
-extern struct platform_device mxc_i2c_device1;
-#endif
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 5d07c2a..06dcd23 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -35,7 +35,6 @@
 #include <mach/board-eukrea_cpuimx27.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/i2c.h>
 #include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
@@ -131,7 +130,7 @@ static struct platform_device *platform_devices[] __initdata = {
 	&mxc_fec_device,
 };
 
-static struct imxi2c_platform_data eukrea_cpuimx27_i2c_1_data = {
+static const struct imxi2c_platform_data cpuimx27_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -196,7 +195,7 @@ static void __init eukrea_cpuimx27_init(void)
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
 
-	mxc_register_device(&mxc_i2c_device0, &eukrea_cpuimx27_i2c_1_data);
+	imx27_add_i2c_imx1(&cpuimx27_i2c1_data);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 1a3ebf5..f1ee335 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -31,7 +31,6 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/i2c.h>
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
 
@@ -195,7 +194,7 @@ static struct platform_device mx27ads_nor_mtd_device = {
 	.resource = &mx27ads_flash_resource,
 };
 
-static struct imxi2c_platform_data mx27ads_i2c_data = {
+static const struct imxi2c_platform_data mx27ads_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -322,7 +321,7 @@ static void __init mx27ads_board_init(void)
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, mx27ads_i2c_devices,
 				ARRAY_SIZE(mx27ads_i2c_devices));
-	mxc_register_device(&mxc_i2c_device1, &mx27ads_i2c_data);
+	imx27_add_i2c_imx1(&mx27ads_i2c1_data);
 	mxc_register_device(&mxc_fb_device, &mx27ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc2_pdata);
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 447c68f..b80b41e 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -31,7 +31,6 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
@@ -131,7 +130,7 @@ mxt_td60_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
-static struct imxi2c_platform_data mxt_td60_i2c_data = {
+static const struct imxi2c_platform_data mxt_td60_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -171,7 +170,7 @@ static struct i2c_board_info mxt_td60_i2c_devices[] = {
 	},
 };
 
-static struct imxi2c_platform_data mxt_td60_i2c2_data = {
+static const struct imxi2c_platform_data mxt_td60_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -263,8 +262,8 @@ static void __init mxt_td60_board_init(void)
 	i2c_register_board_info(1, mxt_td60_i2c2_devices,
 				ARRAY_SIZE(mxt_td60_i2c2_devices));
 
-	mxc_register_device(&mxc_i2c_device0, &mxt_td60_i2c_data);
-	mxc_register_device(&mxc_i2c_device1, &mxt_td60_i2c2_data);
+	imx27_add_i2c_imx0(&mxt_td60_i2c0_data);
+	imx27_add_i2c_imx1(&mxt_td60_i2c1_data);
 	mxc_register_device(&mxc_fb_device, &mxt_td60_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 6efbc6e..6501a7a 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -36,7 +36,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
-#include <mach/i2c.h>
 #include <asm/mach/time.h>
 #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 #include <mach/spi.h>
@@ -150,7 +149,7 @@ static struct platform_device *platform_devices[] __initdata = {
 	&mxc_wdt,
 };
 
-static struct imxi2c_platform_data pca100_i2c_1_data = {
+static const struct imxi2c_platform_data pca100_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -333,7 +332,7 @@ static void __init pca100_init(void)
 	i2c_register_board_info(1, pca100_i2c_devices,
 				ARRAY_SIZE(pca100_i2c_devices));
 
-	mxc_register_device(&mxc_i2c_device1, &pca100_i2c_1_data);
+	imx27_add_i2c_imx1(&pca100_i2c1_data);
 
 	mxc_gpio_mode(GPIO_PORTD | 28 | GPIO_GPIO | GPIO_OUT);
 	mxc_gpio_mode(GPIO_PORTD | 27 | GPIO_GPIO | GPIO_OUT);
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index bc44d6f..7559e0f 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -35,7 +35,6 @@
 #include <mach/board-pcm038.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/i2c.h>
 #include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
@@ -194,7 +193,7 @@ static void __init pcm038_init_sram(void)
 	mx27_setup_weimcs(1, 0x0000d843, 0x22252521, 0x22220a00);
 }
 
-static struct imxi2c_platform_data pcm038_i2c_1_data = {
+static const struct imxi2c_platform_data pcm038_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -318,7 +317,7 @@ static void __init pcm038_init(void)
 	i2c_register_board_info(1, pcm038_i2c_devices,
 				ARRAY_SIZE(pcm038_i2c_devices));
 
-	mxc_register_device(&mxc_i2c_device1, &pcm038_i2c_1_data);
+	imx27_add_i2c_imx1(&pcm038_i2c1_data);
 
 	/* PE18 for user-LED D40 */
 	mxc_gpio_mode(GPIO_PORTE | 18 | GPIO_GPIO | GPIO_OUT);
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index bae9cd7..a8ab2e0 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -48,7 +48,7 @@
 #define MX27_CSPI2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x0f000)
 #define MX27_SSI1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x10000)
 #define MX27_SSI2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x11000)
-#define MX27_I2C_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x12000)
+#define MX27_I2C1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x12000)
 #define MX27_SDHC1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x13000)
 #define MX27_SDHC2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x14000)
 #define MX27_GPIO_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x15000)
@@ -150,7 +150,7 @@ static inline void mx27_setup_weimcs(size_t cs,
 #define MX27_INT_SDHC3		9
 #define MX27_INT_SDHC2		10
 #define MX27_INT_SDHC1		11
-#define MX27_INT_I2C		12
+#define MX27_INT_I2C1		12
 #define MX27_INT_SSI2		13
 #define MX27_INT_SSI1		14
 #define MX27_INT_CSPI2		15
-- 
1.7.1
