From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:53 +0200
Subject: [PATCH 57/61] ARM: imx: dynamically register imx-uart devices (imx25)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-58-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig            |    1 +
 arch/arm/mach-mx25/devices-imx25.h    |   11 ++++
 arch/arm/mach-mx25/devices.c          |   95 ---------------------------------
 arch/arm/mach-mx25/devices.h          |    5 --
 arch/arm/mach-mx25/mach-mx25_3ds.c    |    5 +-
 arch/arm/plat-mxc/include/mach/mx25.h |    8 +++
 6 files changed, 22 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 3c4f1ee..febf841 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -4,6 +4,7 @@ comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
+	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 
 endif
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 33a834e..2025cb9 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -16,6 +16,17 @@
 #define imx25_add_imx_i2c2(pdata)	\
 	imx_add_imx_i2c(2, MX25_I2C3_BASE_ADDR, SZ_16K, MX25_INT_I2C3, pdata)
 
+#define imx25_add_imx_uart0(pdata)	\
+	imx_add_imx_uart_1irq(0, MX25_UART1_BASE_ADDR, SZ_16K, MX25_INT_UART1, pdata)
+#define imx25_add_imx_uart1(pdata)	\
+	imx_add_imx_uart_1irq(1, MX25_UART2_BASE_ADDR, SZ_16K, MX25_INT_UART2, pdata)
+#define imx25_add_imx_uart2(pdata)	\
+	imx_add_imx_uart_1irq(2, MX25_UART3_BASE_ADDR, SZ_16K, MX25_INT_UART3, pdata)
+#define imx25_add_imx_uart3(pdata)	\
+	imx_add_imx_uart_1irq(3, MX25_UART4_BASE_ADDR, SZ_16K, MX25_INT_UART4, pdata)
+#define imx25_add_imx_uart4(pdata)	\
+	imx_add_imx_uart_1irq(4, MX25_UART5_BASE_ADDR, SZ_16K, MX25_INT_UART5, pdata)
+
 #define imx25_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
 
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index c267087..6f98d23 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,101 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource uart0[] = {
-	{
-		.start = 0x43f90000,
-		.end = 0x43f93fff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = 45,
-		.end = 45,
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
-		.start = 0x43f94000,
-		.end = 0x43f97fff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = 32,
-		.end = 32,
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
-		.start = 0x5000c000,
-		.end = 0x5000ffff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = 18,
-		.end = 18,
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
-
-static struct resource uart3[] = {
-	{
-		.start = 0x50008000,
-		.end = 0x5000bfff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = 5,
-		.end = 5,
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
-		.start = 0x5002c000,
-		.end = 0x5002ffff,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = 40,
-		.end = 40,
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
-
 #define MX25_OTG_BASE_ADDR 0x53FF4000
 
 static u64 otg_dmamask = DMA_BIT_MASK(32);
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 1f31cbc..31d22e1 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,8 +1,3 @@
-extern struct platform_device mxc_uart_device0;
-extern struct platform_device mxc_uart_device1;
-extern struct platform_device mxc_uart_device2;
-extern struct platform_device mxc_uart_device3;
-extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_otg;
 extern struct platform_device otg_udc_device;
 extern struct platform_device mxc_usbh2;
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index e1e9886..978ad00 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -38,7 +38,6 @@
 #include <asm/memory.h>
 #include <asm/mach/map.h>
 #include <mach/common.h>
-#include <mach/imx-uart.h>
 #include <mach/mx25.h>
 #include <mach/imxfb.h>
 #include <mach/iomux-mx25.h>
@@ -46,7 +45,7 @@
 #include "devices-imx25.h"
 #include "devices.h"
 
-static struct imxuart_platform_data uart_pdata = {
+static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
@@ -150,7 +149,7 @@ static void __init mx25pdk_init(void)
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
 			ARRAY_SIZE(mx25pdk_pads));
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	imx25_add_imx_uart0(&uart_pdata);
 	mxc_register_device(&mxc_usbh2, NULL);
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
 	mxc_register_device(&mx25_rtc_device, NULL);
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 16ac6b6..ca95b1e 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -33,6 +33,9 @@
 
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
+#define MX25_UART3_BASE_ADDR		0x5000c000
+#define MX25_UART4_BASE_ADDR		0x50008000
+#define MX25_UART5_BASE_ADDR		0x5002c000
 
 #define MX25_CSPI3_BASE_ADDR		0x50004000
 #define MX25_CSPI2_BASE_ADDR		0x50010000
@@ -44,12 +47,17 @@
 #define MX25_INT_CSPI3		0
 #define MX25_INT_I2C1		3
 #define MX25_INT_I2C2		4
+#define MX25_INT_UART4		5
 #define MX25_INT_I2C3		10
 #define MX25_INT_CSPI2		13
 #define MX25_INT_CSPI1		14
+#define MX25_INT_UART3		18
 #define MX25_INT_DRYICE		25
+#define MX25_INT_UART2		32
 #define MX25_INT_NANDFC		33
 #define MX25_INT_LCDC		39
+#define MX25_INT_UART5		40
+#define MX25_INT_UART1		45
 #define MX25_INT_FEC		57
 
 #if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
-- 
1.7.1
