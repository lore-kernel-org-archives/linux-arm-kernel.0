From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:16 +0200
Subject: [PATCH 20/61] ARM: imx1: rename imx_uart[12]_device to follow a
	common naming scheme
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-21-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that these devices are specific for imx1 as only here three irqs are
used.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx1/devices.c      |   81 +++++++++++++------------------------
 arch/arm/mach-mx1/devices.h      |    4 +-
 arch/arm/mach-mx1/mach-mx1ads.c  |    4 +-
 arch/arm/mach-mx1/mach-scb9328.c |    2 +-
 4 files changed, 34 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-mx1/devices.c b/arch/arm/mach-mx1/devices.c
index c770aa0..a79e613 100644
--- a/arch/arm/mach-mx1/devices.c
+++ b/arch/arm/mach-mx1/devices.c
@@ -73,59 +73,36 @@ struct platform_device imx_i2c_device0 = {
 	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
 };
 
-static struct resource imx_uart1_resources[] = {
-	{
-		.start = MX1_UART1_BASE_ADDR,
-		.end = MX1_UART1_BASE_ADDR + 0xD0,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX1_UART1_MINT_RX,
-		.end = MX1_UART1_MINT_RX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MX1_UART1_MINT_TX,
-		.end = MX1_UART1_MINT_TX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MX1_UART1_MINT_RTS,
-		.end = MX1_UART1_MINT_RTS,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_uart1_device = {
-	.name		= "imx-uart",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(imx_uart1_resources),
-	.resource	= imx_uart1_resources,
-};
-
-static struct resource imx_uart2_resources[] = {
-	{
-		.start = MX1_UART2_BASE_ADDR,
-		.end = MX1_UART2_BASE_ADDR + 0xD0,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX1_UART2_MINT_RX,
-		.end = MX1_UART2_MINT_RX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MX1_UART2_MINT_TX,
-		.end = MX1_UART2_MINT_TX,
-		.flags = IORESOURCE_IRQ,
-	}, {
-		.start = MX1_UART2_MINT_RTS,
-		.end = MX1_UART2_MINT_RTS,
-		.flags = IORESOURCE_IRQ,
-	},
-};
+#define DEFINE_IMX1_UART_DEVICE(n, baseaddr, irqrx, irqtx, irqrts)	\
+	static struct resource imx1_uart_resources ## n[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + 0xd0,				\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irqrx,					\
+			.end = irqrx,					\
+			.flags = IORESOURCE_IRQ,			\
+		}, {							\
+			.start = irqtx,					\
+			.end = irqtx,					\
+			.flags = IORESOURCE_IRQ,			\
+		}, {							\
+			.start = irqrts,				\
+			.end = irqrts,					\
+			.flags = IORESOURCE_IRQ,			\
+		},							\
+	};								\
+									\
+	struct platform_device imx1_uart_device ## n = {		\
+		.name = "imx-uart",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(imx1_uart_resources ## n),	\
+		.resource = imx1_uart_resources ## n,			\
+	}
 
-struct platform_device imx_uart2_device = {
-	.name		= "imx-uart",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(imx_uart2_resources),
-	.resource	= imx_uart2_resources,
-};
+DEFINE_IMX1_UART_DEVICE(0, MX1_UART1_BASE_ADDR, MX1_UART1_MINT_RX, MX1_UART1_MINT_TX, MX1_UART1_MINT_RTS);
+DEFINE_IMX1_UART_DEVICE(1, MX1_UART2_BASE_ADDR, MX1_UART2_MINT_RX, MX1_UART2_MINT_TX, MX1_UART2_MINT_RTS);
 
 static struct resource imx_rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-mx1/devices.h b/arch/arm/mach-mx1/devices.h
index 851d6df..1332516 100644
--- a/arch/arm/mach-mx1/devices.h
+++ b/arch/arm/mach-mx1/devices.h
@@ -1,7 +1,7 @@
 extern struct platform_device imx1_camera_device;
 extern struct platform_device imx_i2c_device0;
-extern struct platform_device imx_uart1_device;
-extern struct platform_device imx_uart2_device;
+extern struct platform_device imx1_uart_device0;
+extern struct platform_device imx1_uart_device1;
 extern struct platform_device imx_rtc_device;
 extern struct platform_device imx_wdt_device;
 extern struct platform_device imx_usb_device;
diff --git a/arch/arm/mach-mx1/mach-mx1ads.c b/arch/arm/mach-mx1/mach-mx1ads.c
index 16adc61..5d7c85f 100644
--- a/arch/arm/mach-mx1/mach-mx1ads.c
+++ b/arch/arm/mach-mx1/mach-mx1ads.c
@@ -121,8 +121,8 @@ static void __init mx1ads_init(void)
 		ARRAY_SIZE(mx1ads_pins), "mx1ads");
 
 	/* UART */
-	mxc_register_device(&imx_uart1_device, &uart_pdata[0]);
-	mxc_register_device(&imx_uart2_device, &uart_pdata[1]);
+	mxc_register_device(&imx1_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx1_uart_device1, &uart_pdata[1]);
 
 	/* Physmap flash */
 	mxc_register_device(&flash_device, &mx1ads_flash_data);
diff --git a/arch/arm/mach-mx1/mach-scb9328.c b/arch/arm/mach-mx1/mach-scb9328.c
index ed2ff16..482b24d 100644
--- a/arch/arm/mach-mx1/mach-scb9328.c
+++ b/arch/arm/mach-mx1/mach-scb9328.c
@@ -130,7 +130,7 @@ static struct platform_device *devices[] __initdata = {
  */
 static void __init scb9328_init(void)
 {
-	mxc_register_device(&imx_uart1_device, &uart_pdata);
+	mxc_register_device(&imx1_uart_device0, &uart_pdata);
 
 	printk(KERN_INFO"Scb9328: Adding devices\n");
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-- 
1.7.1
