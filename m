From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:35 +0200
Subject: [PATCH 39/61] ARM: imx: Change the way nand devices are registered
	(imx31)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-40-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of new mechanism to register a nand device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig             |    4 ++++
 arch/arm/mach-mx3/devices-imx31.h     |   13 +++++++++++++
 arch/arm/mach-mx3/devices.c           |    8 ++++++--
 arch/arm/mach-mx3/devices.h           |    2 ++
 arch/arm/mach-mx3/mach-armadillo5x0.c |    7 ++++---
 arch/arm/mach-mx3/mach-mx31_3ds.c     |    8 +++++---
 arch/arm/mach-mx3/mach-mx31lite.c     |    7 ++++---
 arch/arm/mach-mx3/mach-pcm037.c       |    7 ++++---
 8 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-mx3/devices-imx31.h

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 344753f..cb9368f 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -34,6 +34,7 @@ config MACH_MX31ADS_WM1133_EV1
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm037 platform. This includes
@@ -51,6 +52,7 @@ config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
 	select ARCH_MX31
 	select MXC_ULPI if USB_ULPI
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -58,6 +60,7 @@ config MACH_MX31LITE
 config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
 	  Include support for MX31PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -105,6 +108,7 @@ config MACH_PCM043
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
 	select ARCH_MX31
+	select IMX_HAVE_PLATFORM_MXC_NAND
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Atmark Armadillo-500 platform. This includes
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
new file mode 100644
index 0000000..8bd8b38
--- /dev/null
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx31.h>
+#include <mach/devices-common.h>
+
+#define imx31_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand_v1(MX31_NFC_BASE_ADDR, MX31_INT_NANDFC, pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index f6da0ff..baa4bd1 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -167,6 +167,7 @@ struct platform_device mxc_w1_master_device = {
 	.resource = mxc_w1_master_resources,
 };
 
+#if defined(CONFIG_ARCH_MX35)
 static struct resource mxc_nand_resources[] = {
 	{
 		.start	= 0, /* runtime dependent */
@@ -185,6 +186,7 @@ struct platform_device mxc_nand_device = {
 	.num_resources = ARRAY_SIZE(mxc_nand_resources),
 	.resource = mxc_nand_resources,
 };
+#endif
 
 static struct resource mxc_i2c0_resources[] = {
 	{
@@ -628,13 +630,14 @@ struct platform_device imx_kpp_device = {
 
 static int __init mx3_devices_init(void)
 {
+#if defined(CONFIG_ARCH_MX31)
 	if (cpu_is_mx31()) {
-		mxc_nand_resources[0].start = MX31_NFC_BASE_ADDR;
-		mxc_nand_resources[0].end = MX31_NFC_BASE_ADDR + 0xfff;
 		imx_wdt_resources[0].start = MX31_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX31_WDOG_BASE_ADDR + 0x3fff;
 		mxc_register_device(&mxc_rnga_device, NULL);
 	}
+#endif
+#if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
 		mxc_nand_resources[0].start = MX35_NFC_BASE_ADDR;
 		mxc_nand_resources[0].end = MX35_NFC_BASE_ADDR + 0x1fff;
@@ -653,6 +656,7 @@ static int __init mx3_devices_init(void)
 		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
+#endif
 
 	return 0;
 }
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 2c3c864..6bb71d3 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -5,7 +5,9 @@ extern struct platform_device mxc_uart_device2;
 extern struct platform_device mxc_uart_device3;
 extern struct platform_device mxc_uart_device4;
 extern struct platform_device mxc_w1_master_device;
+#if defined(CONFIG_ARCH_MX35)
 extern struct platform_device mxc_nand_device;
+#endif
 extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 2a8de89..633107a 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -53,10 +53,10 @@
 #include <mach/mmc.h>
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_nand.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 #include "crm_regs.h"
 
@@ -300,7 +300,8 @@ static struct platform_device armadillo5x0_button_device = {
 /*
  * NAND Flash
  */
-static struct mxc_nand_platform_data armadillo5x0_nand_flash_pdata = {
+static const struct mxc_nand_platform_data
+armadillo5x0_nand_board_info __initconst = {
 	.width		= 1,
 	.hw_ecc		= 1,
 };
@@ -531,7 +532,7 @@ static void __init armadillo5x0_init(void)
 			    &armadillo5x0_nor_flash_pdata);
 
 	/* Register NAND Flash */
-	mxc_register_device(&mxc_nand_device, &armadillo5x0_nand_flash_pdata);
+	imx31_add_mxc_nand(&armadillo5x0_nand_board_info);
 
 	/* set NAND page size to 2k if not configured via boot mode pins */
 	__raw_writel(__raw_readl(MXC_CCM_RCSR) | (1 << 30), MXC_CCM_RCSR);
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 33f2554..c730c09 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -35,8 +35,9 @@
 #include <mach/common.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
-#include <mach/mxc_nand.h>
 #include <mach/spi.h>
+
+#include "devices-imx31.h"
 #include "devices.h"
 
 /* Definitions for components on the Debug board */
@@ -189,7 +190,8 @@ static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
 /*
  * NAND Flash
  */
-static struct mxc_nand_platform_data imx31_3ds_nand_flash_pdata = {
+static const struct mxc_nand_platform_data
+mx31_3ds_nand_board_info __initconst = {
 	.width		= 1,
 	.hw_ecc		= 1,
 #ifdef MACH_MX31_3DS_MXC_NAND_USE_BBT
@@ -415,7 +417,7 @@ static void __init mxc_board_init(void)
 				      "mx31_3ds");
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_nand_device, &imx31_3ds_nand_flash_pdata);
+	imx31_add_mxc_nand(&mx31_3ds_nand_board_info);
 
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 	spi_register_board_info(mx31_3ds_spi_devs,
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index edcc711..f0a68e6 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -41,11 +41,11 @@
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
 #include <mach/irqs.h>
-#include <mach/mxc_nand.h>
 #include <mach/spi.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 
 /*
@@ -65,7 +65,8 @@ static unsigned int mx31lite_pins[] = {
 	MX31_PIN_CSPI2_SS2__SS2,
 };
 
-static struct mxc_nand_platform_data mx31lite_nand_board_info = {
+static const struct mxc_nand_platform_data
+mx31lite_nand_board_info __initconst  = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -249,7 +250,7 @@ static void __init mxc_board_init(void)
 
 	/* NOR and NAND flash */
 	platform_device_register(&physmap_flash_device);
-	mxc_register_device(&mxc_nand_device, &mx31lite_nand_board_info);
+	imx31_add_mxc_nand(&mx31lite_nand_board_info);
 
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
 	spi_register_board_info(&mc13783_spi_dev, 1);
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index c1f335c..d7fef46 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -48,10 +48,10 @@
 #include <mach/mmc.h>
 #include <mach/mx3_camera.h>
 #include <mach/mx3fb.h>
-#include <mach/mxc_nand.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
 
+#include "devices-imx31.h"
 #include "devices.h"
 #include "pcm037.h"
 
@@ -274,7 +274,8 @@ static struct platform_device pcm037_sram_device = {
 	.resource = &pcm038_sram_resource,
 };
 
-static struct mxc_nand_platform_data pcm037_nand_board_info = {
+static const struct mxc_nand_platform_data
+pcm037_nand_board_info __initconst = {
 	.width = 1,
 	.hw_ecc = 1,
 };
@@ -632,7 +633,7 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_i2c_device1, &pcm037_i2c_1_data);
 	mxc_register_device(&mxc_i2c_device2, &pcm037_i2c_2_data);
 
-	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+	imx31_add_mxc_nand(&pcm037_nand_board_info);
 	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
-- 
1.7.1
