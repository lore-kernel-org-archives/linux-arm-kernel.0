From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:17 +0100
Subject: [PATCH 49/51] ARM: mx3: dynamically allocate imx2-wdt devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-49-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                     |    4 +++
 arch/arm/mach-mx3/devices-imx31.h             |    4 +++
 arch/arm/mach-mx3/devices-imx35.h             |    4 +++
 arch/arm/mach-mx3/devices.c                   |   33 -------------------------
 arch/arm/mach-mx3/devices.h                   |    1 -
 arch/arm/mach-mx3/mach-cpuimx35.c             |    6 +----
 arch/arm/mach-mx3/mach-pcm037.c               |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c               |    2 +-
 arch/arm/mach-mx3/mx31lite-db.c               |    2 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c |   10 +++++++
 10 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 1573483..bcfcf9a 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -51,6 +51,7 @@ config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
@@ -75,6 +76,7 @@ config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
 	select SOC_IMX31
 	select MXC_ULPI if USB_ULPI
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -143,6 +145,7 @@ config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
 	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -193,6 +196,7 @@ config MACH_EUKREA_CPUIMX35
 	bool "Support Eukrea CPUIMX35 Platform"
 	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 6571dd7..109f0bc 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -13,6 +13,10 @@ extern const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst;
 #define imx31_add_fsl_usb2_udc(pdata)	\
 	imx_add_fsl_usb2_udc(&imx31_fsl_usb2_udc_data, pdata)
 
+extern const struct imx_imx2_wdt_data imx31_imx2_wdt_data __initconst;
+#define imx31_add_imx2_wdt(pdata)       \
+	imx_add_imx2_wdt(&imx31_imx2_wdt_data)
+
 extern const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst;
 #define imx31_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx31_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 849c48a..763ee97 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -23,6 +23,10 @@ extern const struct imx_flexcan_data imx35_flexcan_data[] __initconst;
 #define imx35_add_flexcan0(pdata)	imx35_add_flexcan(0, pdata)
 #define imx35_add_flexcan1(pdata)	imx35_add_flexcan(1, pdata)
 
+extern const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst;
+#define imx35_add_imx2_wdt(pdata)       \
+	imx_add_imx2_wdt(&imx35_imx2_wdt_data)
+
 extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
 #define imx35_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx35_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index c122c0f..448fe56 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -95,19 +95,6 @@ struct platform_device mx3_camera = {
 	},
 };
 
-static struct resource imx_wdt_resources[] = {
-	{
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device imx_wdt_device0 = {
-	.name           = "imx2-wdt",
-	.id             = 0,
-	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
-	.resource       = imx_wdt_resources,
-};
-
 static struct resource imx_rtc_resources[] = {
 	{
 		.start  = MX31_RTC_BASE_ADDR,
@@ -145,23 +132,3 @@ struct platform_device imx_kpp_device = {
 	.num_resources = ARRAY_SIZE(imx_kpp_resources),
 	.resource = imx_kpp_resources,
 };
-
-static int __init mx3_devices_init(void)
-{
-#if defined(CONFIG_ARCH_MX31)
-	if (cpu_is_mx31()) {
-		imx_wdt_resources[0].start = MX31_WDOG_BASE_ADDR;
-		imx_wdt_resources[0].end = MX31_WDOG_BASE_ADDR + 0x3fff;
-	}
-#endif
-#if defined(CONFIG_ARCH_MX35)
-	if (cpu_is_mx35()) {
-		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
-		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
-	}
-#endif
-
-	return 0;
-}
-
-subsys_initcall(mx3_devices_init);
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 1bc2918..2f9f877 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,6 +1,5 @@
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device imx_wdt_device0;
 extern struct platform_device imx_rtc_device0;
 extern struct platform_device imx_kpp_device;
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 0af1e84..dda1988 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -72,10 +72,6 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	},
 };
 
-static struct platform_device *devices[] __initdata = {
-	&imx_wdt_device0,
-};
-
 static struct pad_desc eukrea_cpuimx35_pads[] = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
@@ -156,7 +152,7 @@ static void __init mxc_board_init(void)
 			ARRAY_SIZE(eukrea_cpuimx35_pads));
 
 	imx35_add_fec(NULL);
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx35_add_imx2_wdt(NULL);
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&eukrea_cpuimx35_nand_board_info);
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 2d29743..cb65769 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -440,7 +440,6 @@ static int __init pcm037_camera_alloc_dma(const size_t buf_size)
 static struct platform_device *devices[] __initdata = {
 	&pcm037_flash,
 	&pcm037_sram_device,
-	&imx_wdt_device0,
 	&pcm037_mt9t031,
 	&pcm037_mt9v022,
 };
@@ -606,6 +605,7 @@ static void __init mxc_board_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	imx31_add_imx2_wdt(NULL);
 	imx31_add_imx_uart0(&uart_pdata);
 	/* XXX: should't this have .flags = 0 (i.e. no RTSCTS) on PCM037_EET? */
 	imx31_add_imx_uart1(&uart_pdata);
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index f9e7da9..f2f2fd0 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -138,7 +138,6 @@ static struct i2c_board_info pcm043_i2c_devices[] = {
 
 static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
-	&imx_wdt_device0,
 };
 
 static struct pad_desc pcm043_pads[] = {
@@ -362,6 +361,7 @@ static void __init mxc_board_init(void)
 
 	imx35_add_fec(NULL);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	imx35_add_imx2_wdt(NULL);
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index a06161e..3124ea8 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -199,6 +199,6 @@ void __init mx31lite_db_init(void)
 	imx31_add_mxc_mmc(0, &mmc_pdata);
 	imx31_add_spi_imx0(&spi0_pdata);
 	platform_device_register(&litekit_led_device);
-	mxc_register_device(&imx_wdt_device0, NULL);
+	imx31_add_imx2_wdt(NULL);
 	mxc_register_device(&imx_rtc_device0, NULL);
 }
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index bd9c546..e64d474 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -31,6 +31,16 @@ const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
 	imx_imx2_wdt_data_entry_single(MX27, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX31
+const struct imx_imx2_wdt_data imx31_imx2_wdt_data __initconst =
+	imx_imx2_wdt_data_entry_single(MX31, SZ_16K);
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_imx2_wdt_data imx35_imx2_wdt_data __initconst =
+	imx_imx2_wdt_data_entry_single(MX35, SZ_16K);
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data)
 {
-- 
1.7.2.3
