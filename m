From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:42 +0200
Subject: [PATCH 46/61] ARM: imx: dynamically register imx-i2c devices (imx31)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-47-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig             |    4 ++++
 arch/arm/mach-mx3/devices-imx31.h     |    7 +++++++
 arch/arm/mach-mx3/devices.c           |    2 ++
 arch/arm/mach-mx3/devices.h           |    2 ++
 arch/arm/mach-mx3/mach-armadillo5x0.c |    2 +-
 arch/arm/mach-mx3/mach-mx31ads.c      |    3 ++-
 arch/arm/mach-mx3/mach-mx31moboard.c  |   10 +++++-----
 arch/arm/mach-mx3/mach-pcm037.c       |    9 ++++-----
 arch/arm/plat-mxc/include/mach/mx31.h |    4 ++--
 9 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 5611b23..557a20b 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -15,6 +15,7 @@ comment "MX3 platforms:"
 config MACH_MX31ADS
 	bool "Support MX31ADS platforms"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	default y
 	help
 	  Include support for MX31ADS platform. This includes specific
@@ -34,6 +35,7 @@ config MACH_MX31ADS_WM1133_EV1
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -77,6 +79,7 @@ config MACH_MX31_3DS_MXC_NAND_USE_BBT
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31moboard platform. This includes specific
@@ -109,6 +112,7 @@ config MACH_PCM043
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 8bd8b38..56bc1e1 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -9,5 +9,12 @@
 #include <mach/mx31.h>
 #include <mach/devices-common.h>
 
+#define imx31_add_imx_i2c0(pdata)	\
+	imx_add_imx_i2c(0, MX31_I2C1_BASE_ADDR, SZ_4K, MX31_INT_I2C1, pdata)
+#define imx31_add_imx_i2c1(pdata)	\
+	imx_add_imx_i2c(1, MX31_I2C2_BASE_ADDR, SZ_4K, MX31_INT_I2C2, pdata)
+#define imx31_add_imx_i2c2(pdata)	\
+	imx_add_imx_i2c(2, MX31_I2C3_BASE_ADDR, SZ_4K, MX31_INT_I2C3, pdata)
+
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index c8db849..0743214 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -167,6 +167,7 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
+#if defined(CONFIG_ARCH_MX35)
 static struct resource mxc_i2c0_resources[] = {
 	{
 		.start = I2C_BASE_ADDR,
@@ -223,6 +224,7 @@ struct platform_device mxc_i2c_device2 = {
 	.num_resources = ARRAY_SIZE(mxc_i2c2_resources),
 	.resource = mxc_i2c2_resources,
 };
+#endif
 
 #ifdef CONFIG_ARCH_MX31
 static struct resource mxcsdhc0_resources[] = {
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 4a224e6..e108fa3 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -5,9 +5,11 @@ extern struct platform_device mxc_uart_device2;
 extern struct platform_device mxc_uart_device3;
 extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_w1_master_device;
+#if defined(CONFIG_ARCH_MX35)
 extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
+#endif
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 633107a..423ffe7 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -499,7 +499,6 @@ static struct imxuart_platform_data uart_pdata = {
 
 static struct platform_device *devices[] __initdata = {
 	&armadillo5x0_smc911x_device,
-	&mxc_i2c_device1,
 	&armadillo5x0_button_device,
 };
 
@@ -512,6 +511,7 @@ static void __init armadillo5x0_init(void)
 			ARRAY_SIZE(armadillo5x0_pins), "armadillo5x0");
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx31_add_imx_i2c1(NULL);
 
 	/* Register UART */
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index a68b868..b6dc6c8 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -38,6 +38,7 @@
 #include <linux/mfd/wm8350/pmic.h>
 #endif
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 /* Base address of PBC controller */
@@ -500,7 +501,7 @@ static void mxc_init_i2c(void)
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MOSI, IOMUX_CONFIG_ALT1));
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MISO, IOMUX_CONFIG_ALT1));
 
-	mxc_register_device(&mxc_i2c_device1, NULL);
+	imx31_add_imx_i2c1(NULL);
 }
 #else
 static void mxc_init_i2c(void)
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 545cfdd..dd51d08 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -41,13 +41,13 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
-#include <mach/i2c.h>
 #include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/mx3_camera.h>
 #include <mach/spi.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 static unsigned int moboard_pins[] = {
@@ -139,11 +139,11 @@ static struct imxuart_platform_data uart4_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct imxi2c_platform_data moboard_i2c0_pdata = {
+static const struct imxi2c_platform_data moboard_i2c0_data __initconst = {
 	.bitrate = 400000,
 };
 
-static struct imxi2c_platform_data moboard_i2c1_pdata = {
+static const struct imxi2c_platform_data moboard_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -499,8 +499,8 @@ static void __init mxc_board_init(void)
 
 	mxc_register_device(&mxc_uart_device4, &uart4_pdata);
 
-	mxc_register_device(&mxc_i2c_device0, &moboard_i2c0_pdata);
-	mxc_register_device(&mxc_i2c_device1, &moboard_i2c1_pdata);
+	imx31_add_imx_i2c0(&moboard_i2c0_data);
+	imx31_add_imx_i2c1(&moboard_i2c1_data);
 
 	mxc_register_device(&mxc_spi_device1, &moboard_spi1_master);
 	mxc_register_device(&mxc_spi_device2, &moboard_spi2_master);
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index d7fef46..7e3fc47 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -41,7 +41,6 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/i2c.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
@@ -280,11 +279,11 @@ pcm037_nand_board_info __initconst = {
 	.hw_ecc = 1,
 };
 
-static struct imxi2c_platform_data pcm037_i2c_1_data = {
+static const struct imxi2c_platform_data pcm037_i2c1_data __initconst = {
 	.bitrate = 100000,
 };
 
-static struct imxi2c_platform_data pcm037_i2c_2_data = {
+static const struct imxi2c_platform_data pcm037_i2c2_data __initconst = {
 	.bitrate = 20000,
 };
 
@@ -630,8 +629,8 @@ static void __init mxc_board_init(void)
 	i2c_register_board_info(1, pcm037_i2c_devices,
 			ARRAY_SIZE(pcm037_i2c_devices));
 
-	mxc_register_device(&mxc_i2c_device1, &pcm037_i2c_1_data);
-	mxc_register_device(&mxc_i2c_device2, &pcm037_i2c_2_data);
+	imx31_add_imx_i2c1(&pcm037_i2c1_data);
+	imx31_add_imx_i2c2(&pcm037_i2c2_data);
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
 	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index fb90e11..afee3ab 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -23,7 +23,7 @@
 #define MX31_ETB_SLOT4_BASE_ADDR		(MX31_AIPS1_BASE_ADDR + 0x10000)
 #define MX31_ETB_SLOT5_BASE_ADDR		(MX31_AIPS1_BASE_ADDR + 0x14000)
 #define MX31_ECT_CTIO_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x18000)
-#define MX31_I2C_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x80000)
+#define MX31_I2C1_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x80000)
 #define MX31_I2C3_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x84000)
 #define MX31_OTG_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x88000)
 #define MX31_ATA_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x8c000)
@@ -145,7 +145,7 @@ static inline void mx31_setup_weimcs(size_t cs,
 #define MX31_INT_FIRI		7
 #define MX31_INT_MMC_SDHC2	8
 #define MX31_INT_MMC_SDHC1	9
-#define MX31_INT_I2C		10
+#define MX31_INT_I2C1		10
 #define MX31_INT_SSI2		11
 #define MX31_INT_SSI1		12
 #define MX31_INT_CSPI2		13
-- 
1.7.1
