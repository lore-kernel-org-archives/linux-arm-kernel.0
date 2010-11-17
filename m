From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:03 +0100
Subject: [PATCH 35/51] ARM: mx25: dynamically allocate imx2-wdt devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-35-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig                      |    1 +
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++++
 arch/arm/mach-mx25/devices.c                    |   15 ---------------
 arch/arm/mach-mx25/devices.h                    |    1 -
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    2 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c   |   14 ++++++++++----
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 7 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 10c0f60..d152af2 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -6,6 +6,7 @@ config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index d80cce0..bf70548 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -27,6 +27,10 @@ extern struct imx_imxdi_rtc_data imx25_imxdi_rtc_data __initconst;
 #define imx25_add_imxdi_rtc(pdata)	\
 	imx_add_imxdi_rtc(&imx25_imxdi_rtc_data)
 
+extern const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst;
+#define imx25_add_imx2_wdt(pdata)	\
+	imx_add_imx2_wdt(&imx25_imx2_wdt_data)
+
 extern const struct imx_imx_fb_data imx25_imx_fb_data __initconst;
 #define imx25_add_imx_fb(pdata)	\
 	imx_add_imx_fb(&imx25_imx_fb_data, pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 09095e0..12f31ef 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,21 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource mxc_wdt_resources[] = {
-	{
-		.start = MX25_WDOG_BASE_ADDR,
-		.end = MX25_WDOG_BASE_ADDR + SZ_16K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_wdt = {
-	.name = "imx2-wdt",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
-	.resource = mxc_wdt_resources,
-};
-
 static struct resource mx25_csi_resources[] = {
 	{
 		.start	= MX25_CSI_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index 11997e2..fbb75ff 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,2 +1 @@
-extern struct platform_device mxc_wdt;
 extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 34492aa..7e72df7 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -195,7 +195,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
 	imx25_add_imxdi_rtc(NULL);
 	imx25_add_imx_fb(&mx25pdk_fb_pdata);
-	mxc_register_device(&mxc_wdt, NULL);
+	imx25_add_imx2_wdt(NULL);
 
 	mx25pdk_fec_reset();
 	imx25_add_fec(&mx25_fec_pdata);
diff --git a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
index 86eb7f1..7508281 100644
--- a/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
+++ b/arch/arm/plat-mxc/devices/platform-imx2-wdt.c
@@ -10,19 +10,25 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_imx2_wdt_data_entry_single(soc)				\
+#define imx_imx2_wdt_data_entry_single(soc, _size)			\
 	{								\
 		.iobase = soc ## _WDOG_BASE_ADDR,			\
+		.iosize = _size,					\
 	}
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX21);
+	imx_imx2_wdt_data_entry_single(MX21, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx2_wdt_data imx25_imx2_wdt_data __initconst =
+        imx_imx2_wdt_data_entry_single(MX25, SZ_16K);
+#endif /* ifdef CONFIG_ARCH_MX25 */
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst =
-	imx_imx2_wdt_data_entry_single(MX27);
+	imx_imx2_wdt_data_entry_single(MX27, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 struct platform_device *__init imx_add_imx2_wdt(
@@ -31,7 +37,7 @@ struct platform_device *__init imx_add_imx2_wdt(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		},
 	};
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index e28453e..95331ae 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -68,6 +68,7 @@ struct platform_device *__init imx_add_imx21_hcd(
 
 struct imx_imx2_wdt_data {
 	resource_size_t iobase;
+	resource_size_t iosize;
 };
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data);
-- 
1.7.2.3
