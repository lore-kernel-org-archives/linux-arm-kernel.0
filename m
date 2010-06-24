From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:55 +0200
Subject: [PATCH 59/61] ARM: imx: dynamically register imx-uart devices (imx31)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-60-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                |    9 ++++++
 arch/arm/mach-mx3/devices-imx31.h        |   11 +++++++
 arch/arm/mach-mx3/devices.c              |   43 +----------------------------
 arch/arm/mach-mx3/devices.h              |    5 +--
 arch/arm/mach-mx3/mach-armadillo5x0.c    |    7 ++---
 arch/arm/mach-mx3/mach-kzm_arm11_01.c    |    9 +++---
 arch/arm/mach-mx3/mach-mx31_3ds.c        |    5 +--
 arch/arm/mach-mx3/mach-mx31ads.c         |    5 +--
 arch/arm/mach-mx3/mach-mx31lite.c        |    1 -
 arch/arm/mach-mx3/mach-mx31moboard.c     |   10 +++----
 arch/arm/mach-mx3/mach-pcm037.c          |   10 +++---
 arch/arm/mach-mx3/mach-qong.c            |    9 +++---
 arch/arm/mach-mx3/mx31lilly-db.c         |   10 +++---
 arch/arm/mach-mx3/mx31lite-db.c          |    5 +--
 arch/arm/mach-mx3/mx31moboard-devboard.c |    6 ++--
 arch/arm/mach-mx3/mx31moboard-smartbot.c |    7 ++---
 16 files changed, 62 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index a8018e8..7f2d5a6 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -16,6 +16,7 @@ config MACH_MX31ADS
 	bool "Support MX31ADS platforms"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	default y
 	help
 	  Include support for MX31ADS platform. This includes specific
@@ -36,6 +37,7 @@ config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -55,6 +57,7 @@ config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
 	select ARCH_MX31
 	select MXC_ULPI if USB_ULPI
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -64,6 +67,7 @@ config MACH_MX31LITE
 config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -83,6 +87,7 @@ config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
@@ -92,6 +97,7 @@ config MACH_MX31MOBOARD
 config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
 	help
@@ -101,6 +107,7 @@ config MACH_MX31LILLY
 config MACH_QONG
 	bool "Support Dave/DENX QongEVB-LITE platform"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for Dave/DENX QongEVB-LITE platform. This includes
 	  specific configurations for the board and its peripherals.
@@ -119,6 +126,7 @@ config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
 	select ARCH_MX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -136,6 +144,7 @@ config MACH_MX35_3DS
 config MACH_KZM_ARM11_01
 	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for KZM-ARM11-01. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 1cf96ca..3b1a44a 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -16,6 +16,17 @@
 #define imx31_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX31_I2C3_BASE_ADDR, SZ_4K, MX31_INT_I2C3, pdata)
 
+#define imx31_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_1irq(0, MX31_UART1_BASE_ADDR, SZ_16K, MX31_INT_UART1, pdata)
+#define imx31_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_1irq(1, MX31_UART2_BASE_ADDR, SZ_16K, MX31_INT_UART2, pdata)
+#define imx31_add_imx_uart2(pdata)	\
+	imx_add_imx_uart_1irq(2, MX31_UART3_BASE_ADDR, SZ_16K, MX31_INT_UART3, pdata)
+#define imx31_add_imx_uart3(pdata)	\
+	imx_add_imx_uart_1irq(3, MX31_UART4_BASE_ADDR, SZ_16K, MX31_INT_UART4, pdata)
+#define imx31_add_imx_uart4(pdata)	\
+	imx_add_imx_uart_1irq(4, MX31_UART5_BASE_ADDR, SZ_16K, MX31_INT_UART5, pdata)
+
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
 
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index dd90ee9..5b42862 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -25,11 +25,11 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/mx3_camera.h>
 
 #include "devices.h"
 
+#if defined(CONFIG_ARCH_MX35)
 static struct resource uart0[] = {
 	{
 		.start = UART1_BASE_ADDR,
@@ -86,46 +86,7 @@ struct platform_device mxc_uart_device2 = {
 	.resource = uart2,
 	.num_resources = ARRAY_SIZE(uart2),
 };
-
-#ifdef CONFIG_ARCH_MX31
-static struct resource uart3[] = {
-	{
-		.start = UART4_BASE_ADDR,
-		.end = UART4_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_UART4,
-		.end = MXC_INT_UART4,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device3 = {
-	.name = "imx-uart",
-	.id = 3,
-	.resource = uart3,
-	.num_resources = ARRAY_SIZE(uart3),
-};
-
-static struct resource uart4[] = {
-	{
-		.start = UART5_BASE_ADDR,
-		.end = UART5_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_UART5,
-		.end = MXC_INT_UART5,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device4 = {
-	.name = "imx-uart",
-	.id = 4,
-	.resource = uart4,
-	.num_resources = ARRAY_SIZE(uart4),
-};
-#endif /* CONFIG_ARCH_MX31 */
+#endif
 
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 9380cd9..5a156f1 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,9 +1,8 @@
-
+#if defined(CONFIG_ARCH_MX35)
 extern struct platform_device mxc_uart_device0;
 extern struct platform_device mxc_uart_device1;
 extern struct platform_device mxc_uart_device2;
-extern struct platform_device mxc_uart_device3;
-extern struct platform_device mxc_uart_device4;
+#endif
 extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 423ffe7..96aadca 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -48,7 +48,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/mmc.h>
 #include <mach/ipu.h>
@@ -493,7 +492,7 @@ static struct platform_device armadillo5x0_smc911x_device = {
 };
 
 /* UART device data */
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -514,8 +513,8 @@ static void __init armadillo5x0_init(void)
 	imx31_add_imx_i2c1(NULL);
 
 	/* Register UART */
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
+	imx31_add_imx_uart1(&uart_pdata);
 
 	/* SMSC9118 IRQ pin */
 	gpio_direction_input(MX31_PIN_GPIO1_0);
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 1129140..5b23e41 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -35,10 +35,10 @@
 
 #include <mach/clock.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/memory.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 #define KZM_ARM11_IO_ADDRESS(x) (					\
@@ -185,15 +185,14 @@ static inline int kzm_init_smsc9118(void)
 #endif
 
 #if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 static void __init kzm_init_imx_uart(void)
 {
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
+	imx31_add_imx_uart1(&uart_pdata);
 }
 #else
 static inline void kzm_init_imx_uart(void)
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 2aa3e58..4c021c5 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -33,7 +33,6 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 
 #include "devices-imx31.h"
@@ -233,7 +232,7 @@ static struct fsl_usb2_platform_data usbotg_pdata = {
 	.phy_mode	= FSL_USB2_PHY_ULPI,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -415,7 +414,7 @@ static void __init mxc_board_init(void)
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
 	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
 	imx31_add_spi_imx0(&spi1_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index b6dc6c8..94b3e7c 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -29,7 +29,6 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
@@ -124,7 +123,7 @@ static inline int mxc_init_extuart(void)
 #endif
 
 #if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -138,7 +137,7 @@ static unsigned int uart_pins[] = {
 static inline void mxc_init_imx_uart(void)
 {
 	mxc_iomux_setup_multiple_pins(uart_pins, ARRAY_SIZE(uart_pins), "uart-0");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
 }
 #else /* !SERIAL_IMX */
 static inline void mxc_init_imx_uart(void)
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 634b855..da236c4 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/board-mx31lite.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
 #include <mach/mxc_ehci.h>
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 689b068..95633bb 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -38,7 +38,6 @@
 #include <mach/board-mx31moboard.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
 #include <mach/mmc.h>
@@ -131,11 +130,11 @@ static int moboard_uart0_init(struct platform_device *pdev)
 	return 0;
 }
 
-static struct imxuart_platform_data uart0_pdata = {
+static const struct imxuart_platform_data uart0_pdata __initconst = {
 	.init = moboard_uart0_init,
 };
 
-static struct imxuart_platform_data uart4_pdata = {
+static const struct imxuart_platform_data uart4_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -495,9 +494,8 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_uart_device0, &uart0_pdata);
-
-	mxc_register_device(&mxc_uart_device4, &uart4_pdata);
+	imx31_add_imx_uart0(&uart0_pdata);
+	imx31_add_imx_uart4(&uart4_pdata);
 
 	imx31_add_imx_i2c0(&moboard_i2c0_data);
 	imx31_add_imx_i2c1(&moboard_i2c1_data);
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 7e3fc47..e71e390 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -41,7 +41,6 @@
 #include <asm/mach/map.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ipu.h>
 #include <mach/mmc.h>
@@ -219,7 +218,7 @@ static struct platform_device pcm037_flash = {
 	.num_resources = 1,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -609,9 +608,10 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
+	/* XXX: should't this have .flags = 0 (i.e. no RTSCTS) on PCM037_EET? */
+	imx31_add_imx_uart1(&uart_pdata);
+	imx31_add_imx_uart2(&uart_pdata);
 
 	mxc_register_device(&mxc_w1_master_device, NULL);
 
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index 335b0bf..d44ac70 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -30,8 +30,9 @@
 #include <mach/common.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
+
+#include "devices-imx31.h"
 #include "devices.h"
 
 /* FPGA defines */
@@ -57,7 +58,7 @@
  * This file contains the board-specific initialization routines.
  */
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -68,11 +69,11 @@ static int uart_pins[] = {
 	MX31_PIN_RXD1__RXD1
 };
 
-static inline void mxc_init_imx_uart(void)
+static inline void __init mxc_init_imx_uart(void)
 {
 	mxc_iomux_setup_multiple_pins(uart_pins, ARRAY_SIZE(uart_pins),
 			"uart-0");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
 }
 
 static struct resource dnet_resources[] = {
diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index 2e50951..827fd3c 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -32,13 +32,13 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lilly.h>
 #include <mach/mmc.h>
 #include <mach/mx3fb.h>
 #include <mach/ipu.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 /*
@@ -92,7 +92,7 @@ static unsigned int lilly_db_board_pins[] __initdata = {
 };
 
 /* UART */
-static struct imxuart_platform_data uart_pdata __initdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -213,9 +213,9 @@ void __init mx31lilly_db_init(void)
 	mxc_iomux_setup_multiple_pins(lilly_db_board_pins,
 					ARRAY_SIZE(lilly_db_board_pins),
 					"development board pins");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
+	imx31_add_imx_uart1(&uart_pdata);
+	imx31_add_imx_uart2(&uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	mx31lilly_init_fb();
 }
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 3786e29..7b0e74e 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -33,7 +33,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lite.h>
 #include <mach/mmc.h>
@@ -72,7 +71,7 @@ static unsigned int litekit_db_board_pins[] __initdata = {
 };
 
 /* UART */
-static struct imxuart_platform_data uart_pdata __initdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -197,7 +196,7 @@ void __init mx31lite_db_init(void)
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
 					ARRAY_SIZE(litekit_db_board_pins),
 					"development board pins");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx31_add_imx_uart0(&uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	imx31_add_spi_imx0(&spi0_pdata);
 	platform_device_register(&litekit_led_device);
diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
index 44473b1..fc395a7 100644
--- a/arch/arm/mach-mx3/mx31moboard-devboard.c
+++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
@@ -23,13 +23,13 @@
 #include <linux/usb/otg.h>
 
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 static unsigned int devboard_pins[] = {
@@ -52,7 +52,7 @@ static unsigned int devboard_pins[] = {
 	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -226,7 +226,7 @@ void __init mx31moboard_devboard_init(void)
 	mxc_iomux_setup_multiple_pins(devboard_pins, ARRAY_SIZE(devboard_pins),
 		"devboard");
 
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	imx31_add_imx_uart1(&uart_pdata);
 
 	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
 
diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index f45a500..40c3e75 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -26,7 +26,6 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31moboard.h>
 #include <mach/mxc_ehci.h>
@@ -34,6 +33,7 @@
 
 #include <media/soc_camera.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 static unsigned int smartbot_pins[] = {
@@ -55,7 +55,7 @@ static unsigned int smartbot_pins[] = {
 	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -179,8 +179,7 @@ void __init mx31moboard_smartbot_init(int board)
 	mxc_iomux_setup_multiple_pins(smartbot_pins, ARRAY_SIZE(smartbot_pins),
 		"smartbot");
 
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-
+	imx31_add_imx_uart1(&uart_pdata);
 
 	switch (board) {
 	case MX31SMARTBOT:
-- 
1.7.1
