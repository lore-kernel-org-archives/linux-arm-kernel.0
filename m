From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:54 +0200
Subject: [PATCH 58/61] ARM: imx: dynamically register imx-uart devices (imx27)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-59-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                    |    8 +++++++
 arch/arm/mach-imx/devices-imx27.h            |   13 +++++++++++
 arch/arm/mach-imx/devices.c                  |   29 --------------------------
 arch/arm/mach-imx/devices.h                  |    8 -------
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |   14 +++---------
 arch/arm/mach-imx/mach-cpuimx27.c            |   13 +++--------
 arch/arm/mach-imx/mach-imx27lite.c           |    6 ++--
 arch/arm/mach-imx/mach-mx27_3ds.c            |    6 ++--
 arch/arm/mach-imx/mach-mx27ads.c             |   29 +++++++------------------
 arch/arm/mach-imx/mach-mxt_td60.c            |   17 ++++----------
 arch/arm/mach-imx/mach-pca100.c              |    5 +--
 arch/arm/mach-imx/mach-pcm038.c              |   17 ++++----------
 12 files changed, 55 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0fa8acc..3da5355 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -86,6 +86,7 @@ comment "MX27 platforms:"
 config MACH_MX27ADS
 	bool "MX27ADS platform"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX27ADS platform. This includes specific
@@ -94,6 +95,7 @@ config MACH_MX27ADS
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
@@ -118,6 +120,7 @@ endchoice
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
@@ -138,6 +141,7 @@ choice
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	prompt "Eukrea MBIMX27 development board"
 	bool
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  This adds board specific devices that can be found on Eukrea's
@@ -147,12 +151,14 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_IMX27LITE
 	bool "LogicPD MX27 LITEKIT platform"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for MX27 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -160,6 +166,7 @@ config MACH_IMX27LITE
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
@@ -170,6 +177,7 @@ config MACH_PCA100
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for i-MXT (aka td60) platform. This
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 7da1e2b..65e7bb7 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -14,6 +14,19 @@
 #define imx27_add_i2c_imx1(pdata)	\
 	imx_add_imx_i2c(1, MX27_I2C2_BASE_ADDR, SZ_4K, MX27_INT_I2C2, pdata)
 
+#define imx27_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_1irq(0, MX27_UART1_BASE_ADDR, SZ_4K, MX27_INT_UART1, pdata)
+#define imx27_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_1irq(1, MX27_UART2_BASE_ADDR, SZ_4K, MX27_INT_UART2, pdata)
+#define imx27_add_imx_uart2(pdata)	\
+	imx_add_imx_uart_1irq(2, MX27_UART3_BASE_ADDR, SZ_4K, MX27_INT_UART3, pdata)
+#define imx27_add_imx_uart3(pdata)	\
+	imx_add_imx_uart_1irq(3, MX27_UART4_BASE_ADDR, SZ_4K, MX27_INT_UART4, pdata)
+#define imx27_add_imx_uart4(pdata)	\
+	imx_add_imx_uart_1irq(4, MX27_UART5_BASE_ADDR, SZ_4K, MX27_INT_UART5, pdata)
+#define imx27_add_imx_uart5(pdata)	\
+	imx_add_imx_uart_1irq(5, MX27_UART6_BASE_ADDR, SZ_4K, MX27_INT_UART6, pdata)
+
 #define imx27_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
 
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 9ea2ef1..9510687 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -483,35 +483,6 @@ struct platform_device mxc_usbh2 = {
 DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
-#ifdef CONFIG_MACH_MX27
-#define DEFINE_IMX2x_UART_DEVICE(n, baseaddr, irq)			\
-	static struct resource imx2x_uart_resources ## n[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + 0xb5,				\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irq,					\
-			.end = irq,					\
-			.flags = IORESOURCE_IRQ,			\
-		},							\
-	};								\
-									\
-	struct platform_device imx2x_uart_device ## n = {		\
-		.name = "imx-uart",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(imx2x_uart_resources ## n),	\
-		.resource = imx2x_uart_resources ## n,			\
-	}
-
-DEFINE_IMX2x_UART_DEVICE(0, MX2x_UART1_BASE_ADDR, MX2x_INT_UART1);
-DEFINE_IMX2x_UART_DEVICE(1, MX2x_UART2_BASE_ADDR, MX2x_INT_UART2);
-DEFINE_IMX2x_UART_DEVICE(2, MX2x_UART3_BASE_ADDR, MX2x_INT_UART3);
-DEFINE_IMX2x_UART_DEVICE(3, MX2x_UART4_BASE_ADDR, MX2x_INT_UART4);
-DEFINE_IMX2x_UART_DEVICE(4, MX27_UART5_BASE_ADDR, MX27_INT_UART5);
-DEFINE_IMX2x_UART_DEVICE(5, MX27_UART6_BASE_ADDR, MX27_INT_UART6);
-#endif
-
 /* GPIO port description */
 #define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
 	{								\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 13790fb..109f26c 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -14,14 +14,6 @@ extern struct platform_device mxc_gpt4;
 extern struct platform_device mxc_gpt5;
 #endif
 extern struct platform_device mxc_wdt;
-#ifdef CONFIG_MACH_MX27
-extern struct platform_device imx2x_uart_device0;
-extern struct platform_device imx2x_uart_device1;
-extern struct platform_device imx2x_uart_device2;
-extern struct platform_device imx2x_uart_device3;
-extern struct platform_device imx2x_uart_device4;
-extern struct platform_device imx2x_uart_device5;
-#endif
 extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index eed8143..1fb34f3 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -32,7 +32,6 @@
 #include <mach/imxfb.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
-#include <mach/imx-uart.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -154,13 +153,8 @@ static struct imx_fb_platform_data eukrea_mbimx27_fb_data = {
 	.dmacr		= 0x00040060,
 };
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846)
@@ -223,8 +217,8 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
 		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
 
-	mxc_register_device(&imx2x_uart_device1, &uart_pdata[0]);
-	mxc_register_device(&imx2x_uart_device2, &uart_pdata[1]);
+	imx27_add_imx_uart1(&uart_pdata);
+	imx27_add_imx_uart2(&uart_pdata);
 
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, NULL);
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 06dcd23..09cc0c5 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -36,7 +36,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
-#include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 
 #include "devices-imx27.h"
@@ -111,12 +110,8 @@ static struct platform_device eukrea_cpuimx27_nor_mtd_device = {
 	.resource = &eukrea_cpuimx27_flash_resource,
 };
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static const struct mxc_nand_platform_data
@@ -188,7 +183,7 @@ static void __init eukrea_cpuimx27_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
 		ARRAY_SIZE(eukrea_cpuimx27_pins), "CPUIMX27");
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
+	imx27_add_imx_uart0(&uart_pdata);
 
 	imx27_add_mxc_nand(&cpuimx27_nand_board_info);
 
@@ -203,7 +198,7 @@ static void __init eukrea_cpuimx27_init(void)
 	/* SDHC2 can be used for Wifi */
 	mxc_register_device(&mxc_sdhc_device1, NULL);
 	/* in which case UART4 is also used for Bluetooth */
-	mxc_register_device(&imx2x_uart_device3, &uart_pdata[1]);
+	imx27_add_imx_uart3(&uart_pdata);
 #endif
 
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 6df5c7d..22a2b5d 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -22,9 +22,9 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static unsigned int mx27lite_pins[] = {
@@ -54,7 +54,7 @@ static unsigned int mx27lite_pins[] = {
 	PF23_AIN_FEC_TX_EN,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -66,7 +66,7 @@ static void __init mx27lite_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27lite_pins, ARRAY_SIZE(mx27lite_pins),
 		"imx27lite");
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
+	imx27_add_imx_uart0(&uart_pdata);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index da3eeff..e2a82ba 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -27,9 +27,9 @@
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static unsigned int mx27pdk_pins[] = {
@@ -59,7 +59,7 @@ static unsigned int mx27pdk_pins[] = {
 	PF23_AIN_FEC_TX_EN,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -71,7 +71,7 @@ static void __init mx27pdk_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
+	imx27_add_imx_uart0(&uart_pdata);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index f1ee335..9c77da9 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -28,7 +28,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <mach/gpio.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
 #include <mach/imxfb.h>
@@ -289,20 +288,8 @@ static struct platform_device *platform_devices[] __initdata = {
 	&mxc_w1_master_device,
 };
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static void __init mx27ads_board_init(void)
@@ -310,12 +297,12 @@ static void __init mx27ads_board_init(void)
 	mxc_gpio_setup_multiple_pins(mx27ads_pins, ARRAY_SIZE(mx27ads_pins),
 			"mx27ads");
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
-	mxc_register_device(&imx2x_uart_device3, &uart_pdata[3]);
-	mxc_register_device(&imx2x_uart_device4, &uart_pdata[4]);
-	mxc_register_device(&imx2x_uart_device5, &uart_pdata[5]);
+	imx27_add_imx_uart0(&uart_pdata);
+	imx27_add_imx_uart1(&uart_pdata);
+	imx27_add_imx_uart2(&uart_pdata);
+	imx27_add_imx_uart3(&uart_pdata);
+	imx27_add_imx_uart4(&uart_pdata);
+	imx27_add_imx_uart5(&uart_pdata);
 	imx27_add_mxc_nand(&mx27ads_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index b80b41e..a3a1e45 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -28,7 +28,6 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <linux/gpio.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
 #include <linux/i2c/pca953x.h>
@@ -236,14 +235,8 @@ static struct platform_device *platform_devices[] __initdata = {
 	&mxc_fec_device,
 };
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static void __init mxt_td60_board_init(void)
@@ -251,9 +244,9 @@ static void __init mxt_td60_board_init(void)
 	mxc_gpio_setup_multiple_pins(mxt_td60_pins, ARRAY_SIZE(mxt_td60_pins),
 			"MXT_TD60");
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
+	imx27_add_imx_uart0(&uart_pdata);
+	imx27_add_imx_uart1(&uart_pdata);
+	imx27_add_imx_uart2(&uart_pdata);
 	imx27_add_mxc_nand(&mxt_td60_nand_board_info);
 
 	i2c_register_board_info(0, mxt_td60_i2c_devices,
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 953cc74..ff3cf1e 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -37,7 +37,6 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
 #include <asm/mach/time.h>
-#include <mach/imx-uart.h>
 #include <mach/audmux.h>
 #include <mach/ssi.h>
 #include <mach/mxc_nand.h>
@@ -130,7 +129,7 @@ static int pca100_pins[] = {
 	PD26_AF_USBH2_DATA5,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -318,7 +317,7 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&imx_ssi_device0, &pca100_ssi_pdata);
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
+	imx27_add_imx_uart0(&uart_pdata);
 
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index c09f234..9212e8f 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -36,7 +36,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
-#include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
@@ -161,14 +160,8 @@ static struct platform_device pcm038_nor_mtd_device = {
 	.resource = &pcm038_flash_resource,
 };
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static const struct mxc_nand_platform_data
@@ -305,9 +298,9 @@ static void __init pcm038_init(void)
 
 	pcm038_init_sram();
 
-	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
+	imx27_add_imx_uart0(&uart_pdata);
+	imx27_add_imx_uart1(&uart_pdata);
+	imx27_add_imx_uart2(&uart_pdata);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
 	imx27_add_mxc_nand(&pcm038_nand_board_info);
-- 
1.7.1
