From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:03 +0100
Subject: [PATCH 08/39] arm/mx2: use per-SOC nand device
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous commit introduced one nand device per SoC.  Use this
directly instead of the compatibility macro that will break for
multi-SoC kernels.  And while at it remove the compatibility macro now
that all in-tree users are fixed.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.h       |    4 ----
 arch/arm/mach-mx2/mach-cpuimx27.c |    3 ++-
 arch/arm/mach-mx2/mach-mx21ads.c  |    2 +-
 arch/arm/mach-mx2/mach-mx27ads.c  |    2 +-
 arch/arm/mach-mx2/mach-mxt_td60.c |    2 +-
 arch/arm/mach-mx2/mach-pca100.c   |    2 +-
 arch/arm/mach-mx2/mach-pcm038.c   |    2 +-
 7 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index 02e5dd2..f15df2a 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -15,13 +15,9 @@ extern struct platform_device mxc_uart_device5;
 extern struct platform_device mxc_w1_master_device;
 #ifdef CONFIG_MACH_MX21
 extern struct platform_device imx21_nand_device;
-#define mxc_nand_device imx21_nand_device
 #endif
 #ifdef CONFIG_MACH_MX27
 extern struct platform_device imx27_nand_device;
-#ifndef CONFIG_MACH_MX21
-#define mxc_nand_device imx27_nand_device
-#endif
 #endif
 extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_fec_device;
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index 92fd1bf..e69c64e 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -189,7 +189,8 @@ static void __init eukrea_cpuimx27_init(void)
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 
-	mxc_register_device(&mxc_nand_device, &eukrea_cpuimx27_nand_board_info);
+	mxc_register_device(&imx27_nand_device,
+			&eukrea_cpuimx27_nand_board_info);
 
 	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
diff --git a/arch/arm/mach-mx2/mach-mx21ads.c b/arch/arm/mach-mx2/mach-mx21ads.c
index d5eb806..393bc07 100644
--- a/arch/arm/mach-mx2/mach-mx21ads.c
+++ b/arch/arm/mach-mx2/mach-mx21ads.c
@@ -268,7 +268,7 @@ static void __init mx21ads_board_init(void)
 	mxc_register_device(&mxc_uart_device3, &uart_pdata);
 	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
-	mxc_register_device(&mxc_nand_device, &mx21ads_nand_board_info);
+	mxc_register_device(&imx21_nand_device, &mx21ads_nand_board_info);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
diff --git a/arch/arm/mach-mx2/mach-mx27ads.c b/arch/arm/mach-mx2/mach-mx27ads.c
index 808ca27..721f5c7 100644
--- a/arch/arm/mach-mx2/mach-mx27ads.c
+++ b/arch/arm/mach-mx2/mach-mx27ads.c
@@ -290,7 +290,7 @@ static void __init mx27ads_board_init(void)
 	mxc_register_device(&mxc_uart_device3, &uart_pdata[3]);
 	mxc_register_device(&mxc_uart_device4, &uart_pdata[4]);
 	mxc_register_device(&mxc_uart_device5, &uart_pdata[5]);
-	mxc_register_device(&mxc_nand_device, &mx27ads_nand_board_info);
+	mxc_register_device(&imx27_nand_device, &mx27ads_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, mx27ads_i2c_devices,
diff --git a/arch/arm/mach-mx2/mach-mxt_td60.c b/arch/arm/mach-mx2/mach-mxt_td60.c
index df954d8..43a4e86 100644
--- a/arch/arm/mach-mx2/mach-mxt_td60.c
+++ b/arch/arm/mach-mx2/mach-mxt_td60.c
@@ -257,7 +257,7 @@ static void __init mxt_td60_board_init(void)
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
-	mxc_register_device(&mxc_nand_device, &mxt_td60_nand_board_info);
+	mxc_register_device(&imx27_nand_device, &mxt_td60_nand_board_info);
 
 	i2c_register_board_info(0, mxt_td60_i2c_devices,
 				ARRAY_SIZE(mxt_td60_i2c_devices));
diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 9279b42..0c82ee1 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -196,7 +196,7 @@ static void __init pca100_init(void)
 	mxc_gpio_mode(GPIO_PORTC | 29 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 
-	mxc_register_device(&mxc_nand_device, &pca100_nand_board_info);
+	mxc_register_device(&imx27_nand_device, &pca100_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pca100_i2c_devices,
diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index e055d9d..2290195 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -289,7 +289,7 @@ static void __init pcm038_init(void)
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
-	mxc_register_device(&mxc_nand_device, &pcm038_nand_board_info);
+	mxc_register_device(&imx27_nand_device, &pcm038_nand_board_info);
 
 	/* only the i2c master 1 is used on this CPU card */
 	i2c_register_board_info(1, pcm038_i2c_devices,
-- 
1.6.6.2
