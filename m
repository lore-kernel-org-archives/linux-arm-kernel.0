From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:33 +0200
Subject: [PATCH 37/61] ARM: imx: Change the way nand devices are registered
	(imx25)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-38-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of new mechanism to register a nand device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig         |    1 +
 arch/arm/mach-mx25/devices-imx25.h |   13 +++++++++++++
 arch/arm/mach-mx25/devices.c       |   20 --------------------
 arch/arm/mach-mx25/devices.h       |    1 -
 arch/arm/mach-mx25/mach-mx25_3ds.c |   10 ++++++----
 5 files changed, 20 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-mx25/devices-imx25.h

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 54d2173..3c4f1ee 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -4,5 +4,6 @@ comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 
 endif
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
new file mode 100644
index 0000000..f8d4ee0
--- /dev/null
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx25.h>
+#include <mach/devices-common.h>
+
+#define imx25_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand_v21(MX25_NFC_BASE_ADDR, MX25_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 80f3131..e1c3cd1 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -439,26 +439,6 @@ struct platform_device mx25_fec_device = {
 	.resource	= mx25_fec_resources,
 };
 
-static struct resource mxc_nand_resources[] = {
-	{
-		.start	= MX25_NFC_BASE_ADDR,
-		.end	= MX25_NFC_BASE_ADDR + 0x1fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_NANDFC,
-		.end	= MX25_INT_NANDFC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_nand_device = {
-	.name		= "mxc_nand",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(mxc_nand_resources),
-	.resource	= mxc_nand_resources,
-};
-
 static struct resource mx25_rtc_resources[] = {
 	{
 		.start	= MX25_DRYICE_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index cee12c0..f212c93 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -18,7 +18,6 @@ extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
 extern struct platform_device mx25_fec_device;
-extern struct platform_device mxc_nand_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 26ba246..e1e9886 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -40,11 +40,12 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/mx25.h>
-#include <mach/mxc_nand.h>
 #include <mach/imxfb.h>
-#include "devices.h"
 #include <mach/iomux-mx25.h>
 
+#include "devices-imx25.h"
+#include "devices.h"
+
 static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -109,7 +110,8 @@ static void __init mx25pdk_fec_reset(void)
 	gpio_set_value(FEC_RESET_B_GPIO, 1);
 }
 
-static struct mxc_nand_platform_data mx25pdk_nand_board_info = {
+static const struct mxc_nand_platform_data
+mx25pdk_nand_board_info __initconst = {
 	.width		= 1,
 	.hw_ecc		= 1,
 	.flash_bbt	= 1,
@@ -150,7 +152,7 @@ static void __init mx25pdk_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxc_usbh2, NULL);
-	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
+	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
 	mxc_register_device(&mx25_rtc_device, NULL);
 	mxc_register_device(&mx25_fb_device, &mx25pdk_fb_pdata);
 
-- 
1.7.1
