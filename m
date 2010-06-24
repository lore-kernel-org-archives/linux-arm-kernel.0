From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:34 +0200
Subject: [PATCH 38/61] ARM: imx: Change the way nand devices are registered
	(imx27)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-39-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of new mechanism to register a nand device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig         |    5 +++++
 arch/arm/mach-imx/devices-imx27.h |   13 +++++++++++++
 arch/arm/mach-imx/devices.c       |   24 ------------------------
 arch/arm/mach-imx/devices.h       |    3 ---
 arch/arm/mach-imx/mach-cpuimx27.c |    7 ++++---
 arch/arm/mach-imx/mach-mx27ads.c  |    6 ++++--
 arch/arm/mach-imx/mach-mxt_td60.c |    6 ++++--
 arch/arm/mach-imx/mach-pca100.c   |    6 ++++--
 arch/arm/mach-imx/mach-pcm038.c   |    6 ++++--
 9 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-imx/devices-imx27.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2367182..5af1c22 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -81,12 +81,14 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX27ADS platform. This includes specific
 	  configurations for the board and its peripherals.
 
 config MACH_PCM038
 	bool "Phytec phyCORE-i.MX27 CPU module (pcm038)"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
@@ -108,6 +110,7 @@ endchoice
 
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
@@ -147,6 +150,7 @@ config MACH_IMX27LITE
 
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
@@ -154,6 +158,7 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for i-MXT (aka td60) platform. This
 	  includes specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
new file mode 100644
index 0000000..b2f6a12
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx27.h>
+#include <mach/devices-common.h>
+
+#define imx27_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand_v1(MX27_NFC_BASE_ADDR, MX27_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index dbd1460..3a599e9 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -337,30 +337,6 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
-#define DEFINE_MXC_NAND_DEVICE(pfx, baseaddr, irq)			\
-	static struct resource pfx ## _nand_resources[] = {		\
-		{							\
-			.start = baseaddr,				\
-			.end = baseaddr + SZ_4K - 1,			\
-			.flags = IORESOURCE_MEM,			\
-		}, {							\
-			.start = irq,					\
-			.end = irq,					\
-			.flags = IORESOURCE_IRQ,			\
-		},							\
-	};								\
-									\
-	struct platform_device pfx ## _nand_device = {			\
-		.name = "mxc_nand",					\
-		.id = 0,						\
-		.num_resources = ARRAY_SIZE(pfx ## _nand_resources),	\
-		.resource = pfx ## _nand_resources,			\
-	}
-
-#ifdef CONFIG_MACH_MX27
-DEFINE_MXC_NAND_DEVICE(imx27, MX27_NFC_BASE_ADDR, MX27_INT_NANDFC);
-#endif
-
 /*
  * lcdc:
  * - i.MX1: the basic controller
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index d3c381f..4ce7eef 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -26,9 +26,6 @@ extern struct platform_device imx2x_uart_device4;
 extern struct platform_device imx2x_uart_device5;
 #endif
 extern struct platform_device mxc_w1_master_device;
-#ifdef CONFIG_MACH_MX27
-extern struct platform_device imx27_nand_device;
-#endif
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 866a99a..5d07c2a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -40,6 +40,7 @@
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static int eukrea_cpuimx27_pins[] = {
@@ -119,7 +120,8 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-static struct mxc_nand_platform_data eukrea_cpuimx27_nand_board_info = {
+static const struct mxc_nand_platform_data
+cpuimx27_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -189,8 +191,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
 
-	mxc_register_device(&imx27_nand_device,
-			&eukrea_cpuimx27_nand_board_info);
+	imx27_add_mxc_nand(&cpuimx27_nand_board_info);
 
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 186b93a..1a3ebf5 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -35,6 +35,7 @@
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 /*
@@ -166,7 +167,8 @@ static unsigned int mx27ads_pins[] = {
 	PB9_PF_SD2_CLK,
 };
 
-static struct mxc_nand_platform_data mx27ads_nand_board_info = {
+static const struct mxc_nand_platform_data
+mx27ads_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -315,7 +317,7 @@ static void __init mx27ads_board_init(void)
 	mxc_register_device(&imx2x_uart_device3, &uart_pdata[3]);
 	mxc_register_device(&imx2x_uart_device4, &uart_pdata[4]);
 	mxc_register_device(&imx2x_uart_device5, &uart_pdata[5]);
-	mxc_register_device(&imx27_nand_device, &mx27ads_nand_board_info);
+	imx27_add_mxc_nand(&mx27ads_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, mx27ads_i2c_devices,
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 0e5ddba..447c68f 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -36,6 +36,7 @@
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static unsigned int mxt_td60_pins[] __initdata = {
@@ -124,7 +125,8 @@ static unsigned int mxt_td60_pins[] __initdata = {
 	PB9_PF_SD2_CLK,
 };
 
-static struct mxc_nand_platform_data mxt_td60_nand_board_info = {
+static const struct mxc_nand_platform_data
+mxt_td60_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -253,7 +255,7 @@ static void __init mxt_td60_board_init(void)
 	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
 	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
 	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
-	mxc_register_device(&imx27_nand_device, &mxt_td60_nand_board_info);
+	imx27_add_mxc_nand(&mxt_td60_nand_board_info);
 
 	i2c_register_board_info(0, mxt_td60_i2c_devices,
 				ARRAY_SIZE(mxt_td60_i2c_devices));
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 984c4ca..6efbc6e 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -50,6 +50,7 @@
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 #define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
@@ -137,7 +138,8 @@ static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct mxc_nand_platform_data pca100_nand_board_info = {
+static const struct mxc_nand_platform_data
+pca100_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -325,7 +327,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 
-	mxc_register_device(&imx27_nand_device, &pca100_nand_board_info);
+	imx27_add_mxc_nand(&pca100_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pca100_i2c_devices,
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index b6a15ba..bc44d6f 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -43,6 +43,7 @@
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static int pcm038_pins[] = {
@@ -172,7 +173,8 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
-static struct mxc_nand_platform_data pcm038_nand_board_info = {
+static const struct mxc_nand_platform_data
+pcm038_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -310,7 +312,7 @@ static void __init pcm038_init(void)
 	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
-	mxc_register_device(&imx27_nand_device, &pcm038_nand_board_info);
+	imx27_add_mxc_nand(&pcm038_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pcm038_i2c_devices,
-- 
1.7.1
