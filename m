From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:18 +0200
Subject: [PATCH 22/61] ARM: imx: rename mxc_uart_devicex to follow a common
	naming scheme
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-23-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addionally remove an unneeded include.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c                  |   17 ++++++++---------
 arch/arm/mach-imx/devices.h                  |   14 ++++++++------
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    4 ++--
 arch/arm/mach-imx/mach-cpuimx27.c            |    4 ++--
 arch/arm/mach-imx/mach-imx27lite.c           |    2 +-
 arch/arm/mach-imx/mach-mx21ads.c             |    6 +++---
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c             |   12 ++++++------
 arch/arm/mach-imx/mach-mxt_td60.c            |    6 +++---
 arch/arm/mach-imx/mach-pca100.c              |    2 +-
 arch/arm/mach-imx/mach-pcm038.c              |    6 +++---
 11 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 08ae763..b372805 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -38,7 +38,6 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/mmc.h>
-#include <mach/imx-uart.h>
 
 #include "devices.h"
 
@@ -426,7 +425,7 @@ struct platform_device mxc_usbh2 = {
 DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
-#define DEFINE_IMX_UART_DEVICE(n, baseaddr, irq)			\
+#define DEFINE_IMX2x_UART_DEVICE(n, baseaddr, irq)			\
 	static struct resource imx2x_uart_resources ## n[] = {		\
 		{							\
 			.start = baseaddr,				\
@@ -439,21 +438,21 @@ DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 		},							\
 	};								\
 									\
-	struct platform_device mxc_uart_device ## n = {			\
+	struct platform_device imx2x_uart_device ## n = {		\
 		.name = "imx-uart",					\
 		.id = n,						\
 		.num_resources = ARRAY_SIZE(imx2x_uart_resources ## n),	\
 		.resource = imx2x_uart_resources ## n,			\
 	}
 
-DEFINE_IMX_UART_DEVICE(0, MX2x_UART1_BASE_ADDR, MX2x_INT_UART1);
-DEFINE_IMX_UART_DEVICE(1, MX2x_UART2_BASE_ADDR, MX2x_INT_UART2);
-DEFINE_IMX_UART_DEVICE(2, MX2x_UART3_BASE_ADDR, MX2x_INT_UART3);
-DEFINE_IMX_UART_DEVICE(3, MX2x_UART4_BASE_ADDR, MX2x_INT_UART4);
+DEFINE_IMX2x_UART_DEVICE(0, MX2x_UART1_BASE_ADDR, MX2x_INT_UART1);
+DEFINE_IMX2x_UART_DEVICE(1, MX2x_UART2_BASE_ADDR, MX2x_INT_UART2);
+DEFINE_IMX2x_UART_DEVICE(2, MX2x_UART3_BASE_ADDR, MX2x_INT_UART3);
+DEFINE_IMX2x_UART_DEVICE(3, MX2x_UART4_BASE_ADDR, MX2x_INT_UART4);
 
 #ifdef CONFIG_MACH_MX27
-DEFINE_IMX_UART_DEVICE(4, MX27_UART5_BASE_ADDR, MX27_INT_UART5);
-DEFINE_IMX_UART_DEVICE(5, MX27_UART6_BASE_ADDR, MX27_INT_UART6);
+DEFINE_IMX2x_UART_DEVICE(4, MX27_UART5_BASE_ADDR, MX27_INT_UART5);
+DEFINE_IMX2x_UART_DEVICE(5, MX27_UART6_BASE_ADDR, MX27_INT_UART6);
 #endif
 
 /* GPIO port description */
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 84ed513..65c4a43 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -6,12 +6,14 @@ extern struct platform_device mxc_gpt4;
 extern struct platform_device mxc_gpt5;
 #endif
 extern struct platform_device mxc_wdt;
-extern struct platform_device mxc_uart_device0;
-extern struct platform_device mxc_uart_device1;
-extern struct platform_device mxc_uart_device2;
-extern struct platform_device mxc_uart_device3;
-extern struct platform_device mxc_uart_device4;
-extern struct platform_device mxc_uart_device5;
+extern struct platform_device imx2x_uart_device0;
+extern struct platform_device imx2x_uart_device1;
+extern struct platform_device imx2x_uart_device2;
+extern struct platform_device imx2x_uart_device3;
+#ifdef CONFIG_MACH_MX27
+extern struct platform_device imx2x_uart_device4;
+extern struct platform_device imx2x_uart_device5;
+#endif
 extern struct platform_device mxc_w1_master_device;
 #ifdef CONFIG_MACH_MX21
 extern struct platform_device imx21_nand_device;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index f3b169d..463e80d 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -222,8 +222,8 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
 		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
 
-	mxc_register_device(&mxc_uart_device1, &uart_pdata[0]);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata[1]);
+	mxc_register_device(&imx2x_uart_device1, &uart_pdata[0]);
+	mxc_register_device(&imx2x_uart_device2, &uart_pdata[1]);
 
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, NULL);
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 1f616dc..866a99a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -187,7 +187,7 @@ static void __init eukrea_cpuimx27_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
 		ARRAY_SIZE(eukrea_cpuimx27_pins), "CPUIMX27");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
 
 	mxc_register_device(&imx27_nand_device,
 			&eukrea_cpuimx27_nand_board_info);
@@ -203,7 +203,7 @@ static void __init eukrea_cpuimx27_init(void)
 	/* SDHC2 can be used for Wifi */
 	mxc_register_device(&mxc_sdhc_device1, NULL);
 	/* in which case UART4 is also used for Bluetooth */
-	mxc_register_device(&mxc_uart_device3, &uart_pdata[1]);
+	mxc_register_device(&imx2x_uart_device3, &uart_pdata[1]);
 #endif
 
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index fd1dddb..27da9a1 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -70,7 +70,7 @@ static void __init mx27lite_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27lite_pins, ARRAY_SIZE(mx27lite_pins),
 		"imx27lite");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 99f2492..e51f6f8 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -297,9 +297,9 @@ static void __init mx21ads_board_init(void)
 	mxc_gpio_setup_multiple_pins(mx21ads_pins, ARRAY_SIZE(mx21ads_pins),
 			"mx21ads");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_uart_device2, &uart_norts_pdata);
-	mxc_register_device(&mxc_uart_device3, &uart_pdata);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
+	mxc_register_device(&imx2x_uart_device2, &uart_norts_pdata);
+	mxc_register_device(&imx2x_uart_device3, &uart_pdata);
 	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
 	mxc_register_device(&imx21_nand_device, &mx21ads_nand_board_info);
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index a45df59..c9af5f1 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -75,7 +75,7 @@ static void __init mx27pdk_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 2183e3d..771a63f 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -313,12 +313,12 @@ static void __init mx27ads_board_init(void)
 	mxc_gpio_setup_multiple_pins(mx27ads_pins, ARRAY_SIZE(mx27ads_pins),
 			"mx27ads");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
-	mxc_register_device(&mxc_uart_device3, &uart_pdata[3]);
-	mxc_register_device(&mxc_uart_device4, &uart_pdata[4]);
-	mxc_register_device(&mxc_uart_device5, &uart_pdata[5]);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
+	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
+	mxc_register_device(&imx2x_uart_device3, &uart_pdata[3]);
+	mxc_register_device(&imx2x_uart_device4, &uart_pdata[4]);
+	mxc_register_device(&imx2x_uart_device5, &uart_pdata[5]);
 	mxc_register_device(&imx27_nand_device, &mx27ads_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index bc38559..4f4200b 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -254,9 +254,9 @@ static void __init mxt_td60_board_init(void)
 	mxc_gpio_setup_multiple_pins(mxt_td60_pins, ARRAY_SIZE(mxt_td60_pins),
 			"MXT_TD60");
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
+	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
 	mxc_register_device(&imx27_nand_device, &mxt_td60_nand_board_info);
 
 	i2c_register_board_info(0, mxt_td60_i2c_devices,
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index a87422e..984c4ca 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -320,7 +320,7 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&imx_ssi_device0, &pca100_ssi_pdata);
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata);
 
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 36c8943..b6a15ba 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -305,9 +305,9 @@ static void __init pcm038_init(void)
 
 	pcm038_init_sram();
 
-	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
-	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
-	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
+	mxc_register_device(&imx2x_uart_device0, &uart_pdata[0]);
+	mxc_register_device(&imx2x_uart_device1, &uart_pdata[1]);
+	mxc_register_device(&imx2x_uart_device2, &uart_pdata[2]);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
 	mxc_register_device(&imx27_nand_device, &pcm038_nand_board_info);
-- 
1.7.1
