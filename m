From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:18 +0100
Subject: [PATCH 50/51] ARM: mx3: dynamically allocate imx-keypad devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-50-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/devices-imx31.h               |    4 ++++
 arch/arm/mach-mx3/devices-imx35.h               |    4 ++++
 arch/arm/mach-mx3/devices.c                     |   19 -------------------
 arch/arm/mach-mx3/devices.h                     |    1 -
 arch/arm/mach-mx3/mach-mx31_3ds.c               |    5 ++---
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |   10 ++++++++++
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index bcfcf9a..84e4788 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -91,6 +91,7 @@ config MACH_MX31_3DS
 	select SOC_IMX31
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 109f0bc..40f4e84 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -24,6 +24,10 @@ extern const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst;
 #define imx31_add_imx_i2c1(pdata)	imx31_add_imx_i2c(1, pdata)
 #define imx31_add_imx_i2c2(pdata)	imx31_add_imx_i2c(2, pdata)
 
+extern const struct imx_imx_keypad_data imx31_imx_keypad_data __initconst;
+#define imx31_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx31_imx_keypad_data, pdata)
+
 extern const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst;
 #define imx31_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx31_imx_ssi_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 763ee97..c9fdded 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -34,6 +34,10 @@ extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
 #define imx35_add_imx_i2c1(pdata)	imx35_add_imx_i2c(1, pdata)
 #define imx35_add_imx_i2c2(pdata)	imx35_add_imx_i2c(2, pdata)
 
+extern const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst;
+#define imx31_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx35_imx_keypad_data, pdata)
+
 extern const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst;
 #define imx35_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx35_imx_ssi_data[id], pdata)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 448fe56..b6672db 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -113,22 +113,3 @@ struct platform_device imx_rtc_device0 = {
 	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
 	.resource       = imx_rtc_resources,
 };
-
-static struct resource imx_kpp_resources[] = {
-	{
-		.start	= MX3x_KPP_BASE_ADDR,
-		.end	= MX3x_KPP_BASE_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM
-	}, {
-		.start	= MX3x_INT_KPP,
-		.end	= MX3x_INT_KPP,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_kpp_device = {
-	.name = "imx-keypad",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(imx_kpp_resources),
-	.resource = imx_kpp_resources,
-};
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 2f9f877..121962c 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -2,4 +2,3 @@ extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
 extern struct platform_device imx_rtc_device0;
-extern struct platform_device imx_kpp_device;
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 1b46f73..3dea407 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -22,7 +22,6 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
-#include <linux/input/matrix_keypad.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -101,7 +100,7 @@ static const uint32_t mx31_3ds_keymap[] = {
 	KEY(2, 3, KEY_F10),
 };
 
-static struct matrix_keymap_data mx31_3ds_keymap_data = {
+static const struct matrix_keymap_data mx31_3ds_keymap_data __initconst = {
 	.keymap		= mx31_3ds_keymap,
 	.keymap_size	= ARRAY_SIZE(mx31_3ds_keymap),
 };
@@ -245,7 +244,7 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx31_3ds_spi_devs,
 						ARRAY_SIZE(mx31_3ds_spi_devs));
 
-	mxc_register_device(&imx_kpp_device, &mx31_3ds_keymap_data);
+	imx31_add_imx_keypad(&mx31_3ds_keymap_data);
 
 	mx31_3ds_usbotg_init();
 	imx31_add_fsl_usb2_udc(&usbotg_pdata);
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 5f3b367..40238f0 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -31,6 +31,16 @@ const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX27, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
+#ifdef CONFIG_SOC_IMX31
+const struct imx_imx_keypad_data imx31_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX31, SZ_16);
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX35, SZ_16);
+#endif /* ifdef CONFIG_SOC_IMX35 */
+
 struct platform_device *__init imx_add_imx_keypad(
 		const struct imx_imx_keypad_data *data,
 		const struct matrix_keymap_data *pdata)
-- 
1.7.2.3
