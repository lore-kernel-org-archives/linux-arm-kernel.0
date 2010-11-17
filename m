From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:00 +0100
Subject: [PATCH 32/51] ARM: mx25: dynamically allocate imx-keypad devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-32-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc-keypad device seems to be the result of an early and partial
merge of the keypad driver.  It's unused and there is no corresponding
driver available, so just remove it.

Cc: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Kconfig                      |    3 +-
 arch/arm/mach-mx25/devices-imx25.h              |    4 ++
 arch/arm/mach-mx25/devices.c                    |   39 -----------------------
 arch/arm/mach-mx25/devices.h                    |    2 -
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    4 +-
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |   14 ++++++--
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 7 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 2944bb7..e9d4456 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -4,10 +4,11 @@ comment "MX25 platforms:"
 
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
+	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
-	select IMX_HAVE_PLATFORM_ESDHC
 
 config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
index 448939a..a35123f 100644
--- a/arch/arm/mach-mx25/devices-imx25.h
+++ b/arch/arm/mach-mx25/devices-imx25.h
@@ -30,6 +30,10 @@ extern const struct imx_imx_i2c_data imx25_imx_i2c_data[] __initconst;
 #define imx25_add_imx_i2c1(pdata)	imx25_add_imx_i2c(1, pdata)
 #define imx25_add_imx_i2c2(pdata)	imx25_add_imx_i2c(2, pdata)
 
+extern const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst;
+#define imx25_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx25_imx_keypad_data, pdata)
+
 extern const struct imx_imx_ssi_data imx25_imx_ssi_data[] __initconst;
 #define imx25_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx25_imx_ssi_data[id], pdata)
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 1798be9..052adbb 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -22,25 +22,6 @@
 #include <mach/mx25.h>
 #include <mach/irqs.h>
 
-static struct resource mxc_keypad_resources[] = {
-	{
-		.start	= 0x43fa8000,
-		.end	= 0x43fabfff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start   = 24,
-		.end     = 24,
-		.flags   = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_keypad_device = {
-	.name = "mxc-keypad",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(mxc_keypad_resources),
-	.resource = mxc_keypad_resources,
-};
-
 static struct resource mx25_rtc_resources[] = {
 	{
 		.start	= MX25_DRYICE_BASE_ADDR,
@@ -98,26 +79,6 @@ struct platform_device mxc_wdt = {
 	.resource = mxc_wdt_resources,
 };
 
-static struct resource mx25_kpp_resources[] = {
-	{
-		.start	= MX25_KPP_BASE_ADDR,
-		.end	= MX25_KPP_BASE_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= MX25_INT_KPP,
-		.end	= MX25_INT_KPP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mx25_kpp_device = {
-	.name	= "imx-keypad",
-	.id	= -1,
-	.num_resources	= ARRAY_SIZE(mx25_kpp_resources),
-	.resource	= mx25_kpp_resources,
-};
-
 static struct resource mx25_csi_resources[] = {
 	{
 		.start	= MX25_CSI_BASE_ADDR,
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index afc60dd..dd1fded 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -1,6 +1,4 @@
-extern struct platform_device mxc_keypad_device;
 extern struct platform_device mx25_rtc_device;
 extern struct platform_device mx25_fb_device;
 extern struct platform_device mxc_wdt;
-extern struct platform_device mx25_kpp_device;
 extern struct platform_device mx25_csi_device;
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index 574c41f..1d07cfb 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -181,7 +181,7 @@ static const uint32_t mx25pdk_keymap[] = {
 	KEY(3, 3, KEY_POWER),
 };
 
-static struct matrix_keymap_data mx25pdk_keymap_data = {
+static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
 	.keymap		= mx25pdk_keymap,
 	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
 };
@@ -200,7 +200,7 @@ static void __init mx25pdk_init(void)
 
 	mx25pdk_fec_reset();
 	imx25_add_fec(&mx25_fec_pdata);
-	mxc_register_device(&mx25_kpp_device, &mx25pdk_keymap_data);
+	imx25_add_imx_keypad(&mx25pdk_keymap_data);
 
 	imx25_add_esdhc(0, NULL);
 }
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index fdfee55..5995e81 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -9,20 +9,26 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_imx_keypad_data_entry_single(soc)				\
+#define imx_imx_keypad_data_entry_single(soc, _size)			\
 	{								\
 		.iobase = soc ## _KPP_BASE_ADDR,			\
+		.iosize = _size,					\
 		.irq = soc ## _INT_KPP,					\
 	}
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst =
-	imx_imx_keypad_data_entry_single(MX21);
+	imx_imx_keypad_data_entry_single(MX21, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
+#ifdef CONFIG_ARCH_MX25
+const struct imx_imx_keypad_data imx25_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX25, SZ_16K);
+#endif
+
 #ifdef CONFIG_SOC_IMX27
 const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
-	imx_imx_keypad_data_entry_single(MX27);
+	imx_imx_keypad_data_entry_single(MX27, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 struct platform_device *__init imx_add_imx_keypad(
@@ -32,7 +38,7 @@ struct platform_device *__init imx_add_imx_keypad(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_16 - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 07223b2..8482613 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -95,6 +95,7 @@ struct platform_device *__init imx_add_imx_i2c(
 #include <linux/input/matrix_keypad.h>
 struct imx_imx_keypad_data {
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_imx_keypad(
-- 
1.7.2.3
