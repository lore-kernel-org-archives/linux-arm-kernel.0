From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:52 +0100
Subject: [PATCH 24/51] ARM: imx: dynamically allocate imx-keypad devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    2 +
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   19 ---------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    6 +-
 arch/arm/mach-imx/mach-mx27_3ds.c               |    5 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |   46 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    9 ++++
 11 files changed, 74 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-keypad.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e50a164..86bab49 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -163,6 +163,7 @@ choice
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	bool "Eukrea MBIMX27 development board"
 	select IMX_HAVE_PLATFORM_IMX_FB
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
@@ -175,6 +176,7 @@ endchoice
 
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
+	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	help
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index a97e921..0c0eab1 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -21,6 +21,10 @@ extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
 #define imx21_add_imx_i2c(pdata)	\
 	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
 
+extern const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst;
+#define imx21_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx21_imx_keypad_data, pdata)
+
 extern const struct imx_imx_ssi_data imx21_imx_ssi_data[] __initconst;
 #define imx21_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx21_imx_ssi_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index 51bb42d..f1272d4 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -29,6 +29,10 @@ extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
 
+extern const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst;
+#define imx27_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx27_imx_keypad_data, pdata)
+
 extern const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst;
 #define imx27_add_imx_ssi(id, pdata)    \
 	imx_add_imx_ssi(&imx27_imx_ssi_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index d026cfb..4360b9c 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -149,23 +149,4 @@ struct platform_device mx21_usbhc_device = {
 };
 #endif
 
-static struct resource imx_kpp_resources[] = {
-	{
-		.start  = MX2x_KPP_BASE_ADDR,
-		.end    = MX2x_KPP_BASE_ADDR + 0xf,
-		.flags  = IORESOURCE_MEM
-	}, {
-		.start  = MX2x_INT_KPP,
-		.end    = MX2x_INT_KPP,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_kpp_device = {
-	.name = "imx-keypad",
-	.id = -1,
-	.num_resources = ARRAY_SIZE(imx_kpp_resources),
-	.resource = imx_kpp_resources,
-};
-
 #endif
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index a788566..d1e7f48 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,4 +1,3 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
 extern struct platform_device mx21_usbhc_device;
-extern struct platform_device imx_kpp_device;
 #endif
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index fa5aade..3aaa3b9 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -26,7 +26,6 @@
 #include <linux/spi/ads7846.h>
 #include <linux/backlight.h>
 #include <video/platform_lcd.h>
-#include <linux/input/matrix_keypad.h>
 
 #include <asm/mach/arch.h>
 
@@ -109,7 +108,8 @@ static const uint32_t eukrea_mbimx27_keymap[] = {
 	KEY(1, 1, KEY_LEFT),
 };
 
-static struct matrix_keymap_data eukrea_mbimx27_keymap_data = {
+static const struct matrix_keymap_data
+eukrea_mbimx27_keymap_data __initconst = {
 	.keymap         = eukrea_mbimx27_keymap,
 	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
 };
@@ -384,7 +384,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	gpio_request(GPIO_PORTA | 25, "lcd_enable");
 	platform_device_register(&eukrea_mbimx27_lcd_powerdev);
 
-	mxc_register_device(&imx_kpp_device, &eukrea_mbimx27_keymap_data);
+	imx27_add_imx_keypad(&eukrea_mbimx27_keymap_data);
 
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index e6212c3..80399b2 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -22,7 +22,6 @@
 
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/input/matrix_keypad.h>
 #include <linux/irq.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -91,7 +90,7 @@ static const uint32_t mx27_3ds_keymap[] = {
 	KEY(2, 3, KEY_F10),
 };
 
-static struct matrix_keymap_data mx27_3ds_keymap_data = {
+static const struct matrix_keymap_data mx27_3ds_keymap_data __initconst = {
 	.keymap		= mx27_3ds_keymap,
 	.keymap_size	= ARRAY_SIZE(mx27_3ds_keymap),
 };
@@ -127,7 +126,7 @@ static void __init mx27pdk_init(void)
 	mx27_3ds_sdhc1_enable_level_translator();
 	imx27_add_imx_uart0(&uart_pdata);
 	imx27_add_fec(NULL);
-	mxc_register_device(&imx_kpp_device, &mx27_3ds_keymap_data);
+	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 }
 
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 26196d9..212f380 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -25,6 +25,9 @@ config IMX_HAVE_PLATFORM_IMX_FB
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
+config IMX_HAVE_PLATFORM_IMX_KEYPAD
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_SSI
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index e40897e..dd23bab 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_KEYPAD) += platform-imx-keypad.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
new file mode 100644
index 0000000..fdfee55
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_imx_keypad_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _KPP_BASE_ADDR,			\
+		.irq = soc ## _INT_KPP,					\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx_keypad_data imx21_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_imx_keypad_data imx27_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_imx_keypad(
+		const struct imx_imx_keypad_data *data,
+		const struct matrix_keymap_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_16 - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imx-keypad", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index f01fd28..1a67299 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -83,6 +83,15 @@ struct platform_device *__init imx_add_imx_i2c(
 		const struct imx_imx_i2c_data *data,
 		const struct imxi2c_platform_data *pdata);
 
+#include <linux/input/matrix_keypad.h>
+struct imx_imx_keypad_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_imx_keypad(
+		const struct imx_imx_keypad_data *data,
+		const struct matrix_keymap_data *pdata);
+
 #include <mach/ssi.h>
 struct imx_imx_ssi_data {
 	int id;
-- 
1.7.2.3
