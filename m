From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  6 Oct 2010 12:00:18 +0200
Subject: [PATCH 2/3] ARM: imx: dynamically register fec devices
In-Reply-To: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1286359219-5869-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   21 --------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c              |    6 +--
 arch/arm/mach-imx/mach-mx27_3ds.c               |    6 +--
 arch/arm/mach-imx/mach-mx27ads.c                |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c               |    7 +--
 arch/arm/mach-imx/mach-pca100.c                 |    2 +-
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +-
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++
 arch/arm/mach-mx25/devices.c                    |   20 --------
 arch/arm/mach-mx25/devices.h                    |    1 -
 arch/arm/mach-mx25/mach-cpuimx25.c              |    5 +-
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    5 +-
 arch/arm/mach-mx3/devices-imx35.h               |    4 ++
 arch/arm/mach-mx3/devices.c                     |   21 --------
 arch/arm/mach-mx3/devices.h                     |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c               |    2 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c               |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                 |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c              |    2 +-
 arch/arm/mach-mx5/board-mx51_babbage.c          |    6 +--
 arch/arm/mach-mx5/devices-imx51.h               |    4 ++
 arch/arm/mach-mx5/devices.c                     |   19 -------
 arch/arm/mach-mx5/devices.h                     |    1 -
 arch/arm/plat-mxc/devices/Kconfig               |    4 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-fec.c        |   58 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    9 ++++
 arch/arm/plat-mxc/include/mach/mx51.h           |    4 +-
 32 files changed, 107 insertions(+), 123 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-fec.c

diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index e11606b..7011690 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -9,6 +9,10 @@
 #include <mach/mx27.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fec_data imx27_fec_data __initconst;
+#define imx27_add_fec(pdata)	\
+	imx_add_fec(&imx27_fec_data, pdata)
+
 extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 423fa05..fba5047 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -314,27 +314,6 @@ struct platform_device mxc_fb_device = {
 	},
 };
 
-#ifdef CONFIG_MACH_MX27
-static struct resource mxc_fec_resources[] = {
-	{
-		.start = MX27_FEC_BASE_ADDR,
-		.end = MX27_FEC_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX27_INT_FEC,
-		.end = MX27_INT_FEC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_fec_device = {
-	.name = "fec",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_fec_resources),
-	.resource = mxc_fec_resources,
-};
-#endif
-
 static struct resource mxc_pwm_resources[] = {
 	{
 		.start = MX2x_PWM_BASE_ADDR,
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 57d4b1c..807f02a 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -16,7 +16,6 @@ extern struct platform_device mxc_gpt5;
 extern struct platform_device mxc_wdt;
 extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mxc_fb_device;
-extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index d4cb592..28f73a1 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -157,7 +157,6 @@ cpuimx27_nand_board_info __initconst = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&eukrea_cpuimx27_nor_mtd_device,
-	&mxc_fec_device,
 	&mxc_wdt,
 	&mxc_w1_master_device,
 };
@@ -261,6 +260,7 @@ static void __init eukrea_cpuimx27_init(void)
 
 	imx27_add_imx_i2c(1, &cpuimx27_i2c1_data);
 
+	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX27_USESDHC2)
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 21904f3..a0d78fa 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -185,7 +185,6 @@ static struct platform_device visstrim_m10_nor_mtd_device = {
 static struct platform_device *platform_devices[] __initdata = {
 	&visstrim_gpio_keys_device,
 	&visstrim_m10_nor_mtd_device,
-	&mxc_fec_device,
 };
 
 /* Visstrim_M10 uses UART0 as console */
@@ -240,6 +239,7 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_imx_i2c(1, &visstrim_m10_i2c_data);
 	mxc_register_device(&mxc_sdhc_device0, &visstrim_m10_sdhc_pdata);
 	mxc_register_device(&mxc_otg_host, &visstrim_m10_usbotg_pdata);
+	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 67480b6..60d4d0a 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -58,16 +58,12 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&mxc_fec_device,
-};
-
 static void __init mx27lite_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27lite_pins, ARRAY_SIZE(mx27lite_pins),
 		"imx27lite");
 	imx27_add_imx_uart0(&uart_pdata);
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_fec(NULL);
 }
 
 static void __init mx27lite_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 9f6832d..a69dba2 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -64,10 +64,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&mxc_fec_device,
-};
-
 /*
  * Matrix keyboard
  */
@@ -94,7 +90,7 @@ static void __init mx27pdk_init(void)
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
 		"mx27pdk");
 	imx27_add_imx_uart0(&uart_pdata);
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_fec(NULL);
 	mxc_register_device(&imx_kpp_device, &mx27_3ds_keymap_data);
 }
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 1a33288..ffb39a4 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -284,7 +284,6 @@ static struct imxmmc_platform_data sdhc2_pdata = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&mx27ads_nor_mtd_device,
-	&mxc_fec_device,
 	&mxc_w1_master_device,
 };
 
@@ -313,6 +312,7 @@ static void __init mx27ads_board_init(void)
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc2_pdata);
 
+	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 58fb0d6..f4c397d 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -231,10 +231,6 @@ static struct imxmmc_platform_data sdhc1_pdata = {
 	.exit = mxt_td60_sdhc1_exit,
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&mxc_fec_device,
-};
-
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -259,8 +255,7 @@ static void __init mxt_td60_board_init(void)
 	imx27_add_imx_i2c(1, &mxt_td60_i2c1_data);
 	mxc_register_device(&mxc_fb_device, &mxt_td60_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
-
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx27_add_fec(NULL);
 }
 
 static void __init mxt_td60_timer_init(void)
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 1247ce9..223c31c 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -173,7 +173,6 @@ pca100_nand_board_info __initconst = {
 
 static struct platform_device *platform_devices[] __initdata = {
 	&mxc_w1_master_device,
-	&mxc_fec_device,
 	&mxc_wdt,
 };
 
@@ -433,6 +432,7 @@ static void __init pca100_init(void)
 
 	mxc_register_device(&mxc_fb_device, &pca100_fb_data);
 
+	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 3fbed66..b9888a8 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -173,7 +173,6 @@ pcm038_nand_board_info __initconst = {
 static struct platform_device *platform_devices[] __initdata = {
 	&pcm038_nor_mtd_device,
 	&mxc_w1_master_device,
-	&mxc_fec_device,
 	&pcm038_sram_mtd_device,
 	&mxc_wdt,
 };
@@ -325,6 +324,7 @@ static void __init pcm038_init(void)
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 
+	imx27_add_fec(NULL);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 
 #ifdef CONFIG_MACH_PCM970_BASEBOARD
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index eab19c0..b780d9f 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -9,6 +9,10 @@
 #include <mach/mx25.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fec_data imx25_fec_data __initconst;
+#define imx25_add_fec(pdata)	\
+	imx_add_fec(&imx25_fec_data, pdata)
+
 #define imx25_add_flexcan0(pdata)	\
 	imx_add_flexcan(0, MX25_CAN1_BASE_ADDR, SZ_16K, MX25_INT_CAN1, pdata)
 #define imx25_add_flexcan1(pdata)	\
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index bc19e8c..1d0eb3e 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -208,26 +208,6 @@ int __init imx25_register_gpios(void)
 	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
 }
 
-static struct resource mx25_fec_resources[] = {
-	{
-		.start	= MX25_FEC_BASE_ADDR,
-		.end	= MX25_FEC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_FEC,
-		.end	= MX25_INT_FEC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mx25_fec_device = {
-	.name	= "fec",
-	.id	= 0,
-	.num_resources	= ARRAY_SIZE(mx25_fec_resources),
-	.resource	= mx25_fec_resources,
-};
-
 static struct resource mx25_rtc_resources[] = {
 	{
 		.start	= MX25_DRYICE_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index f6e6d3a..7b70a43 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -6,7 +6,6 @@ extern struct platform_device mxc_pwm_device1;
 extern struct platform_device mxc_pwm_device2;
 extern struct platform_device mxc_pwm_device3;
 extern struct platform_device mxc_keypad_device;
-extern struct platform_device mx25_fec_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index e064bb3..21d9b9e 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/fec.h>
 #include <linux/platform_device.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -67,7 +66,7 @@ static struct pad_desc eukrea_cpuimx25_pads[] = {
 	MX25_PAD_I2C1_DAT__I2C1_DAT,
 };
 
-static struct fec_platform_data mx25_fec_pdata = {
+static const struct fec_platform_data mx25_fec_pdata __initconst = {
 	.phy	= PHY_INTERFACE_MODE_RMII,
 };
 
@@ -129,7 +128,7 @@ static void __init eukrea_cpuimx25_init(void)
 	imx25_add_imx_uart0(&uart_pdata);
 	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
 	mxc_register_device(&mx25_rtc_device, NULL);
-	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+	imx25_add_fec(&mx25_fec_pdata);
 
 	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 62bc21f..bd18056 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -28,7 +28,6 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
-#include <linux/fec.h>
 #include <linux/platform_device.h>
 #include <linux/input/matrix_keypad.h>
 
@@ -99,7 +98,7 @@ static struct pad_desc mx25pdk_pads[] = {
 	MX25_PAD_KPP_COL3__KPP_COL3,
 };
 
-static struct fec_platform_data mx25_fec_pdata = {
+static const struct fec_platform_data mx25_fec_pdata __initconst = {
         .phy    = PHY_INTERFACE_MODE_RMII,
 };
 
@@ -192,7 +191,7 @@ static void __init mx25pdk_init(void)
 	mxc_register_device(&mxc_wdt, NULL);
 
 	mx25pdk_fec_reset();
-	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+	imx25_add_fec(&mx25_fec_pdata);
 	mxc_register_device(&mx25_kpp_device, &mx25pdk_keymap_data);
 }
 
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 56404de..786e7ad 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -9,6 +9,10 @@
 #include <mach/mx35.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fec_data imx35_fec_data __initconst;
+#define imx35_add_fec(pdata)	\
+	imx_add_fec(&imx35_fec_data, pdata)
+
 #define imx35_add_flexcan0(pdata)	\
 	imx_add_flexcan(0, MX35_CAN1_BASE_ADDR, SZ_16K, MX35_INT_CAN1, pdata)
 #define imx35_add_flexcan1(pdata)	\
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 87a9a21..f4dff11 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -281,27 +281,6 @@ struct platform_device mxc_usbh2 = {
 	.num_resources = ARRAY_SIZE(mxc_usbh2_resources),
 };
 
-#if defined(CONFIG_ARCH_MX35)
-static struct resource mxc_fec_resources[] = {
-	{
-		.start	= MXC_FEC_BASE_ADDR,
-		.end	= MXC_FEC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MXC_INT_FEC,
-		.end	= MXC_INT_FEC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_fec_device = {
-	.name = "fec",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_fec_resources),
-	.resource = mxc_fec_resources,
-};
-#endif
-
 static struct resource imx_wdt_resources[] = {
 	{
 		.flags = IORESOURCE_MEM,
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 2a69465..585f814 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -2,7 +2,6 @@ extern struct platform_device mxc_w1_master_device;
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device mxc_fec_device;
 extern struct platform_device mxcsdhc_device0;
 extern struct platform_device mxcsdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 2a4f8b7..fb4d140 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -98,7 +98,6 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 };
 
 static struct platform_device *devices[] __initdata = {
-	&mxc_fec_device,
 	&imx_wdt_device0,
 };
 
@@ -180,6 +179,7 @@ static void __init mxc_board_init(void)
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx35_pads,
 			ARRAY_SIZE(eukrea_cpuimx35_pads));
 
+	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1dd7baa..91bb065 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -74,7 +74,6 @@ static const struct mxc_nand_platform_data mx35pdk_nand_board_info __initconst =
 };
 
 static struct platform_device *devices[] __initdata = {
-	&mxc_fec_device,
 	&mx35pdk_flash,
 };
 
@@ -131,6 +130,7 @@ static void __init mxc_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads, ARRAY_SIZE(mx35pdk_pads));
 
+	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index dcc216b..0ab4d0b 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -140,7 +140,6 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
 
 static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
-	&mxc_fec_device,
 	&imx_wdt_device0,
 };
 
@@ -356,6 +355,7 @@ static void __init mxc_board_init(void)
 			MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
 			MXC_AUDMUX_V2_PDCR_RXDSEL(3));
 
+	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index a6c09c7..61f0510 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -108,7 +108,6 @@ static struct platform_device serial_device = {
 #endif
 
 static struct platform_device *devices[] __initdata = {
-	&mxc_fec_device,
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 	&serial_device,
 #endif
@@ -253,6 +252,7 @@ static void __init eukrea_cpuimx51_init(void)
 	gpio_direction_input(CPUIMX51_QUARTD_GPIO);
 	gpio_free(CPUIMX51_QUARTD_GPIO);
 
+	imx51_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx51_add_imx_i2c(1, &eukrea_cpuimx51_i2c_data);
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 7c0b661..23ee4a4 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -46,10 +46,6 @@
 #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
 #define	MX51_USB_PLL_DIV_24_MHZ	0x02
 
-static struct platform_device *devices[] __initdata = {
-	&mxc_fec_device,
-};
-
 static struct pad_desc mx51babbage_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
@@ -290,7 +286,7 @@ static void __init mxc_board_init(void)
 					ARRAY_SIZE(mx51babbage_pads));
 	mxc_init_imx_uart();
 	babbage_fec_reset();
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx51_add_fec(NULL);
 
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
 	imx51_add_imx_i2c(1, &babbage_i2c_data);
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 41d93c3..c233379 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -9,6 +9,10 @@
 #include <mach/mx51.h>
 #include <mach/devices-common.h>
 
+extern const struct imx_fec_data imx51_fec_data __initconst;
+#define imx51_add_fec(pdata)	\
+	imx_add_fec(&imx51_fec_data, pdata)
+
 extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 5f40082..4c7be87 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -17,25 +17,6 @@
 #include <mach/imx-uart.h>
 #include <mach/irqs.h>
 
-static struct resource mxc_fec_resources[] = {
-	{
-		.start	= MX51_MXC_FEC_BASE_ADDR,
-		.end	= MX51_MXC_FEC_BASE_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= MX51_MXC_INT_FEC,
-		.end	= MX51_MXC_INT_FEC,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_fec_device = {
-	.name = "fec",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_fec_resources),
-	.resource = mxc_fec_resources,
-};
-
 static struct resource mxc_hsi2c_resources[] = {
 	{
 		.start = MX51_HSI2C_DMA_BASE_ADDR,
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index 67a6d69..af1d07c 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -1,4 +1,3 @@
-extern struct platform_device mxc_fec_device;
 extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index d736c3d..938817e2 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,3 +1,7 @@
+config IMX_HAVE_PLATFORM_FEC
+	bool
+	default y if ARCH_MX25 || SOC_IMX27 || ARCH_MX35 || ARCH_MX51
+
 config IMX_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN
 	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 2663fb1..821fd10 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_IMX_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
new file mode 100644
index 0000000..11d087f
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_fec_data_entry_single(soc)					\
+	{								\
+		.iobase = soc ## _FEC_BASE_ADDR,			\
+		.irq = soc ## _INT_FEC,					\
+	}
+
+#ifdef CONFIG_ARCH_MX25
+const struct imx_fec_data imx25_fec_data __initconst =
+	imx_fec_data_entry_single(MX25);
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_fec_data imx27_fec_data __initconst =
+	imx_fec_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+#ifdef CONFIG_ARCH_MX35
+const struct imx_fec_data imx35_fec_data __initconst =
+	imx_fec_data_entry_single(MX35);
+#endif
+
+#ifdef CONFIG_ARCH_MX51
+const struct imx_fec_data imx51_fec_data __initconst =
+	imx_fec_data_entry_single(MX51);
+#endif
+
+struct platform_device *__init imx_add_fec(
+		const struct imx_fec_data *data,
+		const struct fec_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("fec", 0 /* -1? */,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index f87aa1a..85740e9 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -14,6 +14,15 @@ struct platform_device *imx_add_platform_device(const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data);
 
+#include <linux/fec.h>
+struct imx_fec_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_fec(
+		const struct imx_fec_data *data,
+		const struct fec_platform_data *pdata);
+
 #include <linux/can/platform/flexcan.h>
 struct platform_device *__init imx_add_flexcan(int id,
 		resource_size_t iobase, resource_size_t iosize,
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 1906ee5a5..c54b5c3 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -140,7 +140,7 @@
 #define MX51_ATA_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe0000)
 #define MX51_SIM_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe4000)
 #define MX51_SSI3BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xe8000)
-#define MX51_MXC_FEC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xec000)
+#define MX51_FEC_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xec000)
 #define MX51_TVE_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xf0000)
 #define MX51_VPU_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xf4000)
 #define MX51_SAHARA_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0xf8000)
@@ -366,7 +366,7 @@
 #define MX51_MXC_INT_GPU2_IRQ		84
 #define MX51_MXC_INT_GPU2_BUSY		85
 #define MX51_MXC_INT_RESV86		86
-#define MX51_MXC_INT_FEC		87
+#define MX51_INT_FEC			87
 #define MX51_MXC_INT_OWIRE		88
 #define MX51_MXC_INT_CTI1_TG2		89
 #define MX51_MXC_INT_SJC		90
-- 
1.7.2.3
