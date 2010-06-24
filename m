From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:56 +0200
Subject: [PATCH 60/61] ARM: imx: dynamically register imx-uart devices (imx35)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-61-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig         |    2 +
 arch/arm/mach-mx3/devices-imx35.h |    7 ++++
 arch/arm/mach-mx3/devices.c       |   59 -------------------------------------
 arch/arm/mach-mx3/devices.h       |    5 ---
 arch/arm/mach-mx3/mach-mx35_3ds.c |    6 ++--
 arch/arm/mach-mx3/mach-pcm043.c   |    7 ++--
 6 files changed, 15 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 7f2d5a6..594502a 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -116,6 +116,7 @@ config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select ARCH_MX35
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
@@ -136,6 +137,7 @@ config MACH_ARMADILLO5X0
 config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
 	select ARCH_MX35
+	select IMX_HAVE_PLATFORM_IMX_UART
 	default n
 	help
 	  Include support for MX35PDK platform. This includes specific
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index b595fa6..536d9b9 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -16,6 +16,13 @@
 #define imx35_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX35_I2C3_BASE_ADDR, SZ_4K, MX35_INT_I2C3, pdata)
 
+#define imx35_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_1irq(0, MX35_UART1_BASE_ADDR, SZ_16K, MX35_INT_UART1, pdata)
+#define imx35_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_1irq(1, MX35_UART2_BASE_ADDR, SZ_16K, MX35_INT_UART2, pdata)
+#define imx35_add_imx_uart2(pdata)	\
+	imx_add_imx_uart_1irq(2, MX35_UART3_BASE_ADDR, SZ_16K, MX35_INT_UART3, pdata)
+
 #define imx35_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
 
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 5b42862..a4fd1a2 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -29,65 +29,6 @@
 
 #include "devices.h"
 
-#if defined(CONFIG_ARCH_MX35)
-static struct resource uart0[] = {
-	{
-		.start = UART1_BASE_ADDR,
-		.end = UART1_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_UART1,
-		.end = MXC_INT_UART1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device0 = {
-	.name = "imx-uart",
-	.id = 0,
-	.resource = uart0,
-	.num_resources = ARRAY_SIZE(uart0),
-};
-
-static struct resource uart1[] = {
-	{
-		.start = UART2_BASE_ADDR,
-		.end = UART2_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_UART2,
-		.end = MXC_INT_UART2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device1 = {
-	.name = "imx-uart",
-	.id = 1,
-	.resource = uart1,
-	.num_resources = ARRAY_SIZE(uart1),
-};
-
-static struct resource uart2[] = {
-	{
-		.start = UART3_BASE_ADDR,
-		.end = UART3_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MXC_INT_UART3,
-		.end = MXC_INT_UART3,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device2 = {
-	.name = "imx-uart",
-	.id = 2,
-	.resource = uart2,
-	.num_resources = ARRAY_SIZE(uart2),
-};
-#endif
-
 /* GPIO port description */
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 5a156f1..e553523 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,8 +1,3 @@
-#if defined(CONFIG_ARCH_MX35)
-extern struct platform_device mxc_uart_device0;
-extern struct platform_device mxc_uart_device1;
-extern struct platform_device mxc_uart_device2;
-#endif
 extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index cfac778..1c30d72 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -34,12 +34,12 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx35.h>
 
+#include "devices-imx35.h"
 #include "devices.h"
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -92,7 +92,7 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx35_add_imx_uart0(&uart_pdata);
 
 	mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
 }
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 21305c6..97cc364 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -36,7 +36,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
@@ -115,7 +114,7 @@ static struct platform_device pcm043_flash = {
 	.num_resources = 1,
 };
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -355,11 +354,11 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
 	mxc_register_device(&imx_ssi_device0, &pcm043_ssi_pdata);
 
-	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	imx35_add_imx_uart1(&uart_pdata);
 
 #if defined CONFIG_I2C_IMX || defined CONFIG_I2C_IMX_MODULE
 	i2c_register_board_info(0, pcm043_i2c_devices,
-- 
1.7.1
