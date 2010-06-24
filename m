From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:32 +0200
Subject: [PATCH 36/61] ARM: imx: Change the way nand devices are registered
	(imx21)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-37-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of new mechanism to register a nand device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/devices-imx21.h |   13 +++++++++++++
 arch/arm/mach-imx/devices.c       |    4 ----
 arch/arm/mach-imx/devices.h       |    3 ---
 arch/arm/mach-imx/mach-mx21ads.c  |    6 ++++--
 5 files changed, 18 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-imx/devices-imx21.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 73c70af..2367182 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -68,6 +68,7 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX21ADS platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
new file mode 100644
index 0000000..e85dcb1
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx21.h>
+#include <mach/devices-common.h>
+
+#define imx21_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand_v1(MX21_NFC_BASE_ADDR, MX21_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index ceae641..dbd1460 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -357,10 +357,6 @@ struct platform_device mxc_w1_master_device = {
 		.resource = pfx ## _nand_resources,			\
 	}
 
-#ifdef CONFIG_MACH_MX21
-DEFINE_MXC_NAND_DEVICE(imx21, MX21_NFC_BASE_ADDR, MX21_INT_NANDFC);
-#endif
-
 #ifdef CONFIG_MACH_MX27
 DEFINE_MXC_NAND_DEVICE(imx27, MX27_NFC_BASE_ADDR, MX27_INT_NANDFC);
 #endif
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 5c1a0dc..d3c381f 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -26,9 +26,6 @@ extern struct platform_device imx2x_uart_device4;
 extern struct platform_device imx2x_uart_device5;
 #endif
 extern struct platform_device mxc_w1_master_device;
-#ifdef CONFIG_MACH_MX21
-extern struct platform_device imx21_nand_device;
-#endif
 #ifdef CONFIG_MACH_MX27
 extern struct platform_device imx27_nand_device;
 #endif
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 39c645a..fde2a57 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -30,6 +30,7 @@
 #include <mach/mxc_nand.h>
 #include <mach/mmc.h>
 
+#include "devices-imx21.h"
 #include "devices.h"
 
 /*
@@ -257,7 +258,8 @@ static struct imxmmc_platform_data mx21ads_sdhc_pdata = {
 	.exit = mx21ads_sdhc_exit,
 };
 
-static struct mxc_nand_platform_data mx21ads_nand_board_info = {
+static const struct mxc_nand_platform_data
+mx21ads_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -298,7 +300,7 @@ static void __init mx21ads_board_init(void)
 	mxc_register_device(&imx2x_uart_device3, &uart_pdata);
 	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
-	mxc_register_device(&imx21_nand_device, &mx21ads_nand_board_info);
+	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
-- 
1.7.1
