From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:13 +0200
Subject: [PATCH 17/61] ARM: imx: fold serial.c into devices.c
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... and use cpp magic to reduce repetition.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Makefile  |    2 +-
 arch/arm/mach-imx/devices.c |   32 ++++++++++
 arch/arm/mach-imx/serial.c  |  141 -------------------------------------------
 3 files changed, 33 insertions(+), 142 deletions(-)
 delete mode 100644 arch/arm/mach-imx/serial.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 068f493..9d57ba6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y	:=  devices.o serial.o
+obj-y	:=  devices.o
 
 obj-$(CONFIG_MACH_MX21) += clock-imx21.o mm-imx21.o
 
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index e708bfd..08ae763 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -32,11 +32,13 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/serial.h>
 
 #include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/mmc.h>
+#include <mach/imx-uart.h>
 
 #include "devices.h"
 
@@ -424,6 +426,36 @@ struct platform_device mxc_usbh2 = {
 DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
+#define DEFINE_IMX_UART_DEVICE(n, baseaddr, irq)			\
+	static struct resource imx2x_uart_resources ## n[] = {		\
+		{							\
+			.start = baseaddr,				\
+			.end = baseaddr + 0xb5,				\
+			.flags = IORESOURCE_MEM,			\
+		}, {							\
+			.start = irq,					\
+			.end = irq,					\
+			.flags = IORESOURCE_IRQ,			\
+		},							\
+	};								\
+									\
+	struct platform_device mxc_uart_device ## n = {			\
+		.name = "imx-uart",					\
+		.id = n,						\
+		.num_resources = ARRAY_SIZE(imx2x_uart_resources ## n),	\
+		.resource = imx2x_uart_resources ## n,			\
+	}
+
+DEFINE_IMX_UART_DEVICE(0, MX2x_UART1_BASE_ADDR, MX2x_INT_UART1);
+DEFINE_IMX_UART_DEVICE(1, MX2x_UART2_BASE_ADDR, MX2x_INT_UART2);
+DEFINE_IMX_UART_DEVICE(2, MX2x_UART3_BASE_ADDR, MX2x_INT_UART3);
+DEFINE_IMX_UART_DEVICE(3, MX2x_UART4_BASE_ADDR, MX2x_INT_UART4);
+
+#ifdef CONFIG_MACH_MX27
+DEFINE_IMX_UART_DEVICE(4, MX27_UART5_BASE_ADDR, MX27_INT_UART5);
+DEFINE_IMX_UART_DEVICE(5, MX27_UART6_BASE_ADDR, MX27_INT_UART6);
+#endif
+
 /* GPIO port description */
 #define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
 	{								\
diff --git a/arch/arm/mach-imx/serial.c b/arch/arm/mach-imx/serial.c
deleted file mode 100644
index 1c0c835..0000000
--- a/arch/arm/mach-imx/serial.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/serial.h>
-#include <mach/hardware.h>
-#include <mach/imx-uart.h>
-#include "devices.h"
-
-static struct resource uart0[] = {
-	{
-		.start = MX2x_UART1_BASE_ADDR,
-		.end = MX2x_UART1_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_UART1,
-		.end = MX2x_INT_UART1,
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
-		.start = MX2x_UART2_BASE_ADDR,
-		.end = MX2x_UART2_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_UART2,
-		.end = MX2x_INT_UART2,
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
-		.start = MX2x_UART3_BASE_ADDR,
-		.end = MX2x_UART3_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_UART3,
-		.end = MX2x_INT_UART3,
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
-		.start = MX2x_UART4_BASE_ADDR,
-		.end = MX2x_UART4_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_UART4,
-		.end = MX2x_INT_UART4,
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
-#ifdef CONFIG_MACH_MX27
-static struct resource uart4[] = {
-	{
-		.start = MX27_UART5_BASE_ADDR,
-		.end = MX27_UART5_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_UART5,
-		.end = MX27_INT_UART5,
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
-static struct resource uart5[] = {
-	{
-		.start = MX27_UART6_BASE_ADDR,
-		.end = MX27_UART6_BASE_ADDR + 0x0B5,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_UART6,
-		.end = MX27_INT_UART6,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_uart_device5 = {
-	.name = "imx-uart",
-	.id = 5,
-	.resource = uart5,
-	.num_resources = ARRAY_SIZE(uart5),
-};
-#endif
-- 
1.7.1
