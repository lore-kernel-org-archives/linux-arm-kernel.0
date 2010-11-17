From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:55 +0100
Subject: [PATCH 27/51] ARM: imx: move registration of gpios to plat-mxc/gpio.c
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-27-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This finally gets rid of mach-imx/devices.c.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Makefile  |    2 -
 arch/arm/mach-imx/devices.c |  124 -------------------------------------------
 arch/arm/plat-mxc/gpio.c    |   59 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 126 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5582692..d099c4a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -4,8 +4,6 @@
 
 # Object file lists.
 
-obj-y	:=  devices.o
-
 obj-$(CONFIG_IMX_HAVE_DMA_V1) += dma-v1.o
 
 obj-$(CONFIG_ARCH_MX1) += clock-imx1.o mm-imx1.o
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
deleted file mode 100644
index cfc6891..0000000
--- a/arch/arm/mach-imx/devices.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * Author: MontaVista Software, Inc.
- *       <source@mvista.com>
- *
- * Based on the OMAP devices.c
- *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Copyright 2006-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
- * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
- * Copyright (c) 2008 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
- * Copyright (c) 2008 Darius Augulis <darius.augulis@teltonika.lt>
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
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/dma-mapping.h>
-#include <linux/serial.h>
-
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-#include <mach/common.h>
-#include <mach/mmc.h>
-
-#if defined(CONFIG_ARCH_MX1)
-/* GPIO port description */
-static struct mxc_gpio_port imx_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
-		.irq = MX1_GPIO_INT_PORTA,
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	}, {
-		.chip.label = "gpio-1",
-		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
-		.irq = MX1_GPIO_INT_PORTB,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	}, {
-		.chip.label = "gpio-2",
-		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
-		.irq = MX1_GPIO_INT_PORTC,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	}, {
-		.chip.label = "gpio-3",
-		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
-		.irq = MX1_GPIO_INT_PORTD,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
-	}
-};
-
-int __init imx1_register_gpios(void)
-{
-	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
-}
-#endif
-
-#if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-/* GPIO port description */
-#define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
-	{								\
-		.chip.label = "gpio-" #n,				\
-		.irq = _irq,						\
-		.base = SOC ## _IO_ADDRESS(MX2x_GPIO_BASE_ADDR +	\
-				n * 0x100),				\
-		.virtual_irq_start = MXC_GPIO_IRQ_START + n * 32,	\
-	}
-
-#define DEFINE_MXC_GPIO_PORT(SOC, n)					\
-	{								\
-		.chip.label = "gpio-" #n,				\
-		.base = SOC ## _IO_ADDRESS(MX2x_GPIO_BASE_ADDR +	\
-				n * 0x100),				\
-		.virtual_irq_start = MXC_GPIO_IRQ_START + n * 32,	\
-	}
-
-#define DEFINE_MXC_GPIO_PORTS(SOC, pfx)					\
-	static struct mxc_gpio_port pfx ## _gpio_ports[] = {		\
-		DEFINE_MXC_GPIO_PORT_IRQ(SOC, 0, SOC ## _INT_GPIO),	\
-		DEFINE_MXC_GPIO_PORT(SOC, 1),				\
-		DEFINE_MXC_GPIO_PORT(SOC, 2),				\
-		DEFINE_MXC_GPIO_PORT(SOC, 3),				\
-		DEFINE_MXC_GPIO_PORT(SOC, 4),				\
-		DEFINE_MXC_GPIO_PORT(SOC, 5),				\
-	}
-
-#ifdef CONFIG_MACH_MX21
-DEFINE_MXC_GPIO_PORTS(MX21, imx21);
-
-int __init imx21_register_gpios(void)
-{
-	return mxc_gpio_init(imx21_gpio_ports, ARRAY_SIZE(imx21_gpio_ports));
-}
-#endif
-
-#ifdef CONFIG_MACH_MX27
-DEFINE_MXC_GPIO_PORTS(MX27, imx27);
-
-int __init imx27_register_gpios(void)
-{
-	return mxc_gpio_init(imx27_gpio_ports, ARRAY_SIZE(imx27_gpio_ports));
-}
-#endif
-
-#endif
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index a43d9cc..2c00d9b 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -349,3 +349,62 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 
 	return 0;
 }
+
+#define DEFINE_IMX_GPIO_PORT_IRQ(soc, n, _irq)				\
+	{								\
+		.chip.label = "gpio-" #n,				\
+		.irq = _irq,						\
+		.base = soc ## _IO_ADDRESS(soc ## _GPIO_BASE_ADDR +	\
+				(n) * SZ_256),				\
+		.virtual_irq_start = MXC_GPIO_IRQ_START + (n) * 32,	\
+	}
+
+#define DEFINE_IMX_GPIO_PORT(soc, n)					\
+	DEFINE_IMX_GPIO_PORT_IRQ(soc, n, 0)
+
+#define DEFINE_REGISTER_FUNCTION(prefix)				\
+int __init prefix ## _register_gpios(void)				\
+{									\
+	return mxc_gpio_init(prefix ## _gpio_ports,			\
+			ARRAY_SIZE(prefix ## _gpio_ports));		\
+}
+
+#if defined(CONFIG_SOC_IMX1)
+static struct mxc_gpio_port imx1_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 0, MX1_GPIO_INT_PORTA),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 1, MX1_GPIO_INT_PORTB),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 2, MX1_GPIO_INT_PORTC),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 3, MX1_GPIO_INT_PORTD),
+};
+
+DEFINE_REGISTER_FUNCTION(imx1)
+
+#endif /* if defined(CONFIG_SOC_IMX1) */
+
+#if defined(CONFIG_SOC_IMX21)
+static struct mxc_gpio_port imx21_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX21, 0, MX21_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX21, 1),
+	DEFINE_IMX_GPIO_PORT(MX21, 2),
+	DEFINE_IMX_GPIO_PORT(MX21, 3),
+	DEFINE_IMX_GPIO_PORT(MX21, 4),
+	DEFINE_IMX_GPIO_PORT(MX21, 5),
+};
+
+DEFINE_REGISTER_FUNCTION(imx21)
+
+#endif /* if defined(CONFIG_SOC_IMX21) */
+
+#if defined(CONFIG_SOC_IMX27)
+static struct mxc_gpio_port imx27_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX27, 0, MX27_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX27, 1),
+	DEFINE_IMX_GPIO_PORT(MX27, 2),
+	DEFINE_IMX_GPIO_PORT(MX27, 3),
+	DEFINE_IMX_GPIO_PORT(MX27, 4),
+	DEFINE_IMX_GPIO_PORT(MX27, 5),
+};
+
+DEFINE_REGISTER_FUNCTION(imx27)
+
+#endif /* if defined(CONFIG_SOC_IMX27) */
-- 
1.7.2.3
