From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Aug 2011 11:38:26 +0200
Subject: [PATCH 5/8] ARM: mx5: dynamically allocate high speed i2c (imx-i2c
	actually)
In-Reply-To: <1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110801093759.GD9250@pengutronix.de>
	<1312191509-21895-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1312191509-21895-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the last device from devices.c.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Makefile                   |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c       |    5 +--
 arch/arm/mach-mx5/devices-imx51.h            |    2 +
 arch/arm/mach-mx5/devices.c                  |   37 --------------------------
 arch/arm/mach-mx5/devices.h                  |    1 -
 arch/arm/plat-mxc/devices/platform-imx-i2c.c |    6 ++++
 6 files changed, 11 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/devices.c
 delete mode 100644 arch/arm/mach-mx5/devices.h

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 383e7cd..7f45243 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51-mx53.o devices.o ehci.o system.o
+obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
 obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
 
 obj-$(CONFIG_PM) += pm-imx5.o
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 576a799..41a911f 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -31,7 +31,6 @@
 #include <asm/mach/time.h>
 
 #include "devices-imx51.h"
-#include "devices.h"
 #include "cpu_op-mx51.h"
 
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
@@ -176,7 +175,7 @@ static const struct imxi2c_platform_data babbage_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
-static struct imxi2c_platform_data babbage_hsi2c_data = {
+static const struct imxi2c_platform_data babbage_hsi2c_data __initconst = {
 	.bitrate = 400000,
 };
 
@@ -381,7 +380,7 @@ static void __init mx51_babbage_init(void)
 
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
 	imx51_add_imx_i2c(1, &babbage_i2c_data);
-	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
+	imx51_add_hsi2c(&babbage_hsi2c_data);
 
 	if (otg_mode_host)
 		imx51_add_mxc_ehci_otg(&dr_utmi_config);
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 2f2cdb9..f311c96 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -20,6 +20,8 @@ extern const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data;
 extern const struct imx_imx_i2c_data imx51_imx_i2c_data[];
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
+#define imx51_add_hsi2c(pdata)	\
+	imx51_add_imx_i2c(2, pdata)
 
 extern const struct imx_imx_ssi_data imx51_imx_ssi_data[];
 #define imx51_add_imx_ssi(id, pdata)	\
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
deleted file mode 100644
index 1c09026..0000000
--- a/arch/arm/mach-mx5/devices.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright 2009 Amit Kucheria <amit.kucheria@canonical.com>
- * Copyright (C) 2010 Freescale Semiconductor, Inc.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <mach/hardware.h>
-#include <mach/imx-uart.h>
-#include <mach/irqs.h>
-
-static struct resource mxc_hsi2c_resources[] = {
-	{
-		.start = MX51_HSI2C_DMA_BASE_ADDR,
-		.end = MX51_HSI2C_DMA_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	{
-		.start = MX51_INT_HS_I2C,
-		.end = MX51_INT_HS_I2C,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_hsi2c_device = {
-	.name = "imx-i2c",
-	.id = 2,
-	.num_resources = ARRAY_SIZE(mxc_hsi2c_resources),
-	.resource = mxc_hsi2c_resources
-};
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
deleted file mode 100644
index 6b2edfe..0000000
--- a/arch/arm/mach-mx5/devices.h
+++ /dev/null
@@ -1 +0,0 @@
-extern struct platform_device mxc_hsi2c_device;
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index afe60f7..19ad580 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -85,6 +85,12 @@ const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
 	imx_imx_i2c_data_entry(MX51, _id, _hwid, SZ_4K)
 	imx51_imx_i2c_data_entry(0, 1),
 	imx51_imx_i2c_data_entry(1, 2),
+	{
+		.id = 2,
+		.iobase = MX51_HSI2C_DMA_BASE_ADDR,
+		.iosize = SZ_16K,
+		.irq = MX51_INT_HS_I2C,
+	},
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
-- 
1.7.5.4
