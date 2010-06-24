From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:36 +0200
Subject: [PATCH 40/61] ARM: imx: Change the way nand devices are registered
	(imx35)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-41-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of new mechanism to register a nand device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/devices-imx35.h |   13 +++++++++++++
 arch/arm/mach-mx3/devices.c       |   23 -----------------------
 arch/arm/mach-mx3/devices.h       |    3 ---
 arch/arm/mach-mx3/mach-pcm043.c   |    7 ++++---
 5 files changed, 18 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/mach-mx3/devices-imx35.h

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index cb9368f..5611b23 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -100,6 +100,7 @@ config MACH_QONG
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select ARCH_MX35
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm043 platform. This includes
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
new file mode 100644
index 0000000..69dac76
--- /dev/null
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx35.h>
+#include <mach/devices-common.h>
+
+#define imx35_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand_v21(MX35_NFC_BASE_ADDR, MX35_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index baa4bd1..c8db849 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -167,27 +167,6 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
-#if defined(CONFIG_ARCH_MX35)
-static struct resource mxc_nand_resources[] = {
-	{
-		.start	= 0, /* runtime dependent */
-		.end	= 0,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_NANDFC,
-		.end	= MXC_INT_NANDFC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_nand_device = {
-	.name = "mxc_nand",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_nand_resources),
-	.resource = mxc_nand_resources,
-};
-#endif
-
 static struct resource mxc_i2c0_resources[] = {
 	{
 		.start = I2C_BASE_ADDR,
@@ -639,8 +618,6 @@ static int __init mx3_devices_init(void)
 #endif
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
-		mxc_nand_resources[0].start = MX35_NFC_BASE_ADDR;
-		mxc_nand_resources[0].end = MX35_NFC_BASE_ADDR + 0x1fff;
 		otg_resources[0].start = MX35_OTG_BASE_ADDR;
 		otg_resources[0].end = MX35_OTG_BASE_ADDR + 0x1ff;
 		otg_resources[1].start = MXC_INT_USBOTG;
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 6bb71d3..4a224e6 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -5,9 +5,6 @@ extern struct platform_device mxc_uart_device2;
 extern struct platform_device mxc_uart_device3;
 extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_w1_master_device;
-#if defined(CONFIG_ARCH_MX35)
-extern struct platform_device mxc_nand_device;
-#endif
 extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 100bb77..58de305 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -43,12 +43,12 @@
 #include <mach/iomux-mx35.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_nand.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 #include <mach/audmux.h>
 #include <mach/ssi.h>
 
+#include "devices-imx35.h"
 #include "devices.h"
 
 static const struct fb_videomode fb_modedb[] = {
@@ -300,7 +300,8 @@ static struct imx_ssi_platform_data pcm043_ssi_pdata = {
 	.flags = IMX_SSI_USE_AC97,
 };
 
-static struct mxc_nand_platform_data pcm037_nand_board_info = {
+static const struct mxc_nand_platform_data
+pcm037_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -358,7 +359,7 @@ static void __init mxc_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+	imx35_add_mxc_nand(&pcm037_nand_board_info);
 	mxc_register_device(&imx_ssi_device0, &pcm043_ssi_pdata);
 
 	mxc_register_device(&mxc_uart_device1, &uart_pdata);
-- 
1.7.1
