From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:51 +0200
Subject: [PATCH 55/61] ARM: imx: dynamically register imx-uart devices (imx1)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-56-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig            |    2 ++
 arch/arm/mach-imx/devices-imx1.h     |    5 +++++
 arch/arm/mach-imx/devices.c          |   31 -------------------------------
 arch/arm/mach-imx/devices.h          |    2 --
 arch/arm/mach-imx/mach-mx1ads.c      |   17 ++++++++---------
 arch/arm/mach-imx/mach-scb9328.c     |    6 +++---
 arch/arm/plat-mxc/include/mach/mx1.h |   24 ++++++++++++------------
 7 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c185ec3..445ce10 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -17,11 +17,13 @@ config ARCH_MX1ADS
 	bool "MX1ADS platform"
 	select MACH_MXLADS
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
 
 config MACH_SCB9328
 	bool "Synertronixx scb9328"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Say Y here if you are using a Synertronixx scb9328 board
 
diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
index a5cfe04..a8d94f0 100644
--- a/arch/arm/mach-imx/devices-imx1.h
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -11,3 +11,8 @@
 
 #define imx1_add_i2c_imx(pdata)		\
 	imx_add_imx_i2c(0, MX1_I2C_BASE_ADDR, SZ_4K, MX1_INT_I2C, pdata)
+
+#define imx1_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_3irq(0, MX1_UART1_BASE_ADDR, 0xd0, MX1_INT_UART1RX, MX1_INT_UART1TX, MX1_INT_UART1RTS, pdata)
+#define imx1_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_3irq(0, MX1_UART2_BASE_ADDR, 0xd0, MX1_INT_UART2RX, MX1_INT_UART2TX, MX1_INT_UART2RTS, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 84e6da6..b4bf8fc 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -70,37 +70,6 @@ struct platform_device imx1_camera_device = {
 	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
 };
 
-#define DEFINE_IMX1_UART_DEVICE(n, baseaddr, irqrx, irqtx, irqrts)	\
-	static struct resource imx1_uart_resources ## n[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + 0xd0,				\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irqrx,					\
-			.end = irqrx,					\
-			.flags = IORESOURCE_IRQ,			\
-		}, {							\
-			.start = irqtx,					\
-			.end = irqtx,					\
-			.flags = IORESOURCE_IRQ,			\
-		}, {							\
-			.start = irqrts,				\
-			.end = irqrts,					\
-			.flags = IORESOURCE_IRQ,			\
-		},							\
-	};								\
-									\
-	struct platform_device imx1_uart_device ## n = {		\
-		.name = "imx-uart",					\
-		.id = n,						\
-		.num_resources = ARRAY_SIZE(imx1_uart_resources ## n),	\
-		.resource = imx1_uart_resources ## n,			\
-	}
-
-DEFINE_IMX1_UART_DEVICE(0, MX1_UART1_BASE_ADDR, MX1_UART1_MINT_RX, MX1_UART1_MINT_TX, MX1_UART1_MINT_RTS);
-DEFINE_IMX1_UART_DEVICE(1, MX1_UART2_BASE_ADDR, MX1_UART2_MINT_RX, MX1_UART2_MINT_TX, MX1_UART2_MINT_RTS);
-
 static struct resource imx_rtc_resources[] = {
 	{
 		.start  = 0x00204000,
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index db995b1..e56efbc 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,7 +1,5 @@
 #ifdef CONFIG_ARCH_MX1
 extern struct platform_device imx1_camera_device;
-extern struct platform_device imx1_uart_device0;
-extern struct platform_device imx1_uart_device1;
 extern struct platform_device imx_rtc_device;
 extern struct platform_device imx_wdt_device;
 extern struct platform_device imx_usb_device;
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 339d41a..77a760c 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -26,7 +26,6 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/i2c.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx1.h>
 #include <mach/irqs.h>
 
@@ -59,12 +58,12 @@ static int mx1ads_pins[] = {
  * UARTs platform data
  */
 
-static struct imxuart_platform_data uart_pdata[] = {
-	{
-		.flags = IMXUART_HAVE_RTSCTS,
-	}, {
-		.flags = IMXUART_HAVE_RTSCTS,
-	},
+static const struct imxuart_platform_data uart0_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+       
+static const struct imxuart_platform_data uart1_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
 };
 
 /*
@@ -122,8 +121,8 @@ static void __init mx1ads_init(void)
 		ARRAY_SIZE(mx1ads_pins), "mx1ads");
 
 	/* UART */
-	mxc_register_device(&imx1_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&imx1_uart_device1, &uart_pdata[1]);
+	imx1_add_imx_uart0(&uart0_pdata);
+	imx1_add_imx_uart1(&uart1_pdata);
 
 	/* Physmap flash */
 	mxc_register_device(&flash_device, &mx1ads_flash_data);
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index 482b24d..88bf0d1 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -22,9 +22,9 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/imx-uart.h>
 #include <mach/iomux-mx1.h>
 
+#include "devices-imx1.h"
 #include "devices.h"
 
 /*
@@ -114,7 +114,7 @@ static void uart1_mxc_exit(struct platform_device *pdev)
 			ARRAY_SIZE(mxc_uart1_pins));
 }
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.init = uart1_mxc_init,
 	.exit = uart1_mxc_exit,
 	.flags = IMXUART_HAVE_RTSCTS,
@@ -130,7 +130,7 @@ static struct platform_device *devices[] __initdata = {
  */
 static void __init scb9328_init(void)
 {
-	mxc_register_device(&imx1_uart_device0, &uart_pdata);
+	imx1_add_imx_uart0(&uart_pdata);
 
 	printk(KERN_INFO"Scb9328: Adding devices\n");
 	platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index e99c0b2..641b246 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -91,18 +91,18 @@
 #define MX1_SIM_DATA_INT	16
 #define MX1_RTC_INT		17
 #define MX1_RTC_SAMINT		18
-#define MX1_UART2_MINT_PFERR	19
-#define MX1_UART2_MINT_RTS	20
-#define MX1_UART2_MINT_DTR	21
-#define MX1_UART2_MINT_UARTC	22
-#define MX1_UART2_MINT_TX	23
-#define MX1_UART2_MINT_RX	24
-#define MX1_UART1_MINT_PFERR	25
-#define MX1_UART1_MINT_RTS	26
-#define MX1_UART1_MINT_DTR	27
-#define MX1_UART1_MINT_UARTC	28
-#define MX1_UART1_MINT_TX	29
-#define MX1_UART1_MINT_RX	30
+#define MX1_INT_UART2PFERR	19
+#define MX1_INT_UART2RTS	20
+#define MX1_INT_UART2DTR	21
+#define MX1_INT_UART2UARTC	22
+#define MX1_INT_UART2TX		23
+#define MX1_INT_UART2RX		24
+#define MX1_INT_UART1PFERR	25
+#define MX1_INT_UART1RTS	26
+#define MX1_INT_UART1DTR	27
+#define MX1_INT_UART1UARTC	28
+#define MX1_INT_UART1TX		29
+#define MX1_INT_UART1RX		30
 #define MX1_VOICE_DAC_INT	31
 #define MX1_VOICE_ADC_INT	32
 #define MX1_PEN_DATA_INT	33
-- 
1.7.1
