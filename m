From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:45 +0100
Subject: [PATCH 17/51] ARM: imx: dynamically register imx-fb devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                       |    9 +++-
 arch/arm/mach-imx/devices-imx21.h               |    4 ++
 arch/arm/mach-imx/devices-imx27.h               |    4 ++
 arch/arm/mach-imx/devices.c                     |   29 --------------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    5 +-
 arch/arm/mach-imx/mach-mx21ads.c                |    5 +-
 arch/arm/mach-imx/mach-mx27ads.c                |    5 +-
 arch/arm/mach-imx/mach-mxt_td60.c               |    5 +-
 arch/arm/mach-imx/mach-pca100.c                 |    5 +-
 arch/arm/mach-imx/pcm970-baseboard.c            |    6 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx-fb.c     |   46 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    9 ++++
 arch/arm/plat-mxc/include/mach/imxfb.h          |    3 +
 16 files changed, 90 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-fb.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6b1662c..d3e983e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,7 @@ comment "MX21 platforms:"
 
 config MACH_MX21ADS
 	bool "MX21ADS platform"
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	help
@@ -85,6 +86,7 @@ comment "MX27 platforms:"
 
 config MACH_MX27ADS
 	bool "MX27ADS platform"
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -112,8 +114,8 @@ choice
 	default MACH_PCM970_BASEBOARD
 
 config MACH_PCM970_BASEBOARD
-	prompt "PHYTEC PCM970 development board"
-	bool
+	bool "PHYTEC PCM970 development board"
+	select IMX_HAVE_PLATFORM_IMX_FB
 	help
 	  This adds board specific devices that can be found on Phytec's
 	  PCM970 evaluation board.
@@ -153,6 +155,7 @@ choice
 
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	bool "Eukrea MBIMX27 development board"
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -188,6 +191,7 @@ config MACH_IMX27LITE
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -201,6 +205,7 @@ config MACH_PCA100
 
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
+	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/arch/arm/mach-imx/devices-imx21.h b/arch/arm/mach-imx/devices-imx21.h
index 738dbba..0f782b6 100644
--- a/arch/arm/mach-imx/devices-imx21.h
+++ b/arch/arm/mach-imx/devices-imx21.h
@@ -13,6 +13,10 @@ extern const struct imx_imx2_wdt_data imx21_imx2_wdt_data __initconst;
 #define imx21_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx21_imx2_wdt_data)
 
+extern const struct imx_imx_fb_data imx21_imx_fb_data __initconst;
+#define imx21_add_imx_fb(pdata)	\
+	imx_add_imx_fb(&imx21_imx_fb_data, pdata)
+
 extern const struct imx_imx_i2c_data imx21_imx_i2c_data __initconst;
 #define imx21_add_imx_i2c(pdata)	\
 	imx_add_imx_i2c(&imx21_imx_i2c_data, pdata)
diff --git a/arch/arm/mach-imx/devices-imx27.h b/arch/arm/mach-imx/devices-imx27.h
index b2d4c51..6e11bef 100644
--- a/arch/arm/mach-imx/devices-imx27.h
+++ b/arch/arm/mach-imx/devices-imx27.h
@@ -17,6 +17,10 @@ extern const struct imx_imx2_wdt_data imx27_imx2_wdt_data __initconst;
 #define imx27_add_imx2_wdt(pdata)	\
 	imx_add_imx2_wdt(&imx27_imx2_wdt_data)
 
+extern const struct imx_imx_fb_data imx27_imx_fb_data __initconst;
+#define imx27_add_imx_fb(pdata)	\
+	imx_add_imx_fb(&imx27_imx_fb_data, pdata)
+
 extern const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst;
 #define imx27_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx27_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 20655fb..d784564 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -77,35 +77,6 @@ int __init imx1_register_gpios(void)
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-/*
- * lcdc:
- * - i.MX1: the basic controller
- * - i.MX21: to be checked
- * - i.MX27: like i.MX1, with slightly variations
- */
-static struct resource mxc_fb[] = {
-	{
-		.start = MX2x_LCDC_BASE_ADDR,
-		.end = MX2x_LCDC_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_LCDC,
-		.end = MX2x_INT_LCDC,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-/* mxc lcd driver */
-struct platform_device mxc_fb_device = {
-	.name = "imx-fb",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_fb),
-	.resource = mxc_fb,
-	.dev = {
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-
 static struct resource mxc_pwm_resources[] = {
 	{
 		.start = MX2x_PWM_BASE_ADDR,
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index f441b02..407e90a 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,5 +1,4 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_fb_device;
 extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 026263c6..a226e25 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -32,7 +32,6 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
-#include <mach/imxfb.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/spi.h>
@@ -196,7 +195,7 @@ static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data eukrea_mbimx27_fb_data = {
+static const struct imx_fb_platform_data eukrea_mbimx27_fb_data __initconst = {
 	.mode = eukrea_mbimx27_modes,
 	.num_modes = ARRAY_SIZE(eukrea_mbimx27_modes),
 
@@ -351,7 +350,7 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	imx27_add_imx_uart3(&uart_pdata);
 #endif
 
-	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
+	imx27_add_imx_fb(&eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc_pdata);
 
 	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index e1282e9..4820a67 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -24,7 +24,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <mach/imxfb.h>
 #include <mach/iomux-mx21.h>
 #include <mach/mxc_nand.h>
 #include <mach/mmc.h>
@@ -213,7 +212,7 @@ static struct imx_fb_videomode mx21ads_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data mx21ads_fb_data = {
+static const struct imx_fb_platform_data mx21ads_fb_data __initconst = {
 	.mode = mx21ads_modes,
 	.num_modes = ARRAY_SIZE(mx21ads_modes),
 
@@ -296,7 +295,7 @@ static void __init mx21ads_board_init(void)
 	imx21_add_imx_uart0(&uart_pdata_rts);
 	imx21_add_imx_uart2(&uart_pdata_norts);
 	imx21_add_imx_uart3(&uart_pdata_rts);
-	mxc_register_device(&mxc_fb_device, &mx21ads_fb_data);
+	imx21_add_imx_fb(&mx21ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &mx21ads_sdhc_pdata);
 	imx21_add_mxc_nand(&mx21ads_nand_board_info);
 
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 219899a..d97b25b 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -30,7 +30,6 @@
 #include <mach/gpio.h>
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
-#include <mach/imxfb.h>
 #include <mach/mmc.h>
 
 #include "devices-imx27.h"
@@ -228,7 +227,7 @@ static struct imx_fb_videomode mx27ads_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data mx27ads_fb_data = {
+static const struct imx_fb_platform_data mx27ads_fb_data __initconst = {
 	.mode = mx27ads_modes,
 	.num_modes = ARRAY_SIZE(mx27ads_modes),
 
@@ -307,7 +306,7 @@ static void __init mx27ads_board_init(void)
 	i2c_register_board_info(1, mx27ads_i2c_devices,
 				ARRAY_SIZE(mx27ads_i2c_devices));
 	imx27_add_imx_i2c(1, &mx27ads_i2c1_data);
-	mxc_register_device(&mxc_fb_device, &mx27ads_fb_data);
+	imx27_add_imx_fb(&mx27ads_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc2_pdata);
 
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 38d3a4a..0c94485 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -31,7 +31,6 @@
 #include <mach/iomux-mx27.h>
 #include <mach/mxc_nand.h>
 #include <linux/i2c/pca953x.h>
-#include <mach/imxfb.h>
 #include <mach/mmc.h>
 
 #include "devices-imx27.h"
@@ -196,7 +195,7 @@ static struct imx_fb_videomode mxt_td60_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data mxt_td60_fb_data = {
+static const struct imx_fb_platform_data mxt_td60_fb_data __initconst = {
 	.mode = mxt_td60_modes,
 	.num_modes = ARRAY_SIZE(mxt_td60_modes),
 
@@ -253,7 +252,7 @@ static void __init mxt_td60_board_init(void)
 
 	imx27_add_imx_i2c(0, &mxt_td60_i2c0_data);
 	imx27_add_imx_i2c(1, &mxt_td60_i2c1_data);
-	mxc_register_device(&mxc_fb_device, &mxt_td60_fb_data);
+	imx27_add_imx_fb(&mxt_td60_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 	imx27_add_fec(NULL);
 }
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 11da9c2..30490c3 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -43,7 +43,6 @@
 #include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
-#include <mach/imxfb.h>
 
 #include "devices-imx27.h"
 #include "devices.h"
@@ -350,7 +349,7 @@ static struct imx_fb_videomode pca100_fb_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data pca100_fb_data = {
+static const struct imx_fb_platform_data pca100_fb_data __initconst = {
 	.mode = pca100_fb_modes,
 	.num_modes = ARRAY_SIZE(pca100_fb_modes),
 
@@ -425,7 +424,7 @@ static void __init pca100_init(void)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 	}
 
-	mxc_register_device(&mxc_fb_device, &pca100_fb_data);
+	imx27_add_imx_fb(&pca100_fb_data);
 
 	imx27_add_fec(NULL);
 	imx27_add_imx2_wdt(NULL);
diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
index 9110d9c..9cf9460 100644
--- a/arch/arm/mach-imx/pcm970-baseboard.c
+++ b/arch/arm/mach-imx/pcm970-baseboard.c
@@ -25,10 +25,10 @@
 
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
-#include <mach/imxfb.h>
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 
+#include "devices-imx27.h"
 #include "devices.h"
 
 static const int pcm970_pins[] __initconst = {
@@ -179,7 +179,7 @@ static struct imx_fb_videomode pcm970_modes[] = {
 	},
 };
 
-static struct imx_fb_platform_data pcm038_fb_data = {
+static const struct imx_fb_platform_data pcm038_fb_data __initconst = {
 	.mode = pcm970_modes,
 	.num_modes = ARRAY_SIZE(pcm970_modes),
 
@@ -226,7 +226,7 @@ void __init pcm970_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(pcm970_pins, ARRAY_SIZE(pcm970_pins),
 			"PCM970");
 
-	mxc_register_device(&mxc_fb_device, &pcm038_fb_data);
+	imx27_add_imx_fb(&pcm038_fb_data);
 	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
 	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
 	platform_device_register(&pcm970_sja1000);
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 01b0d0c..2542371 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -16,6 +16,9 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
 config IMX_HAVE_PLATFORM_IMX2_WDT
 	bool
 
+config IMX_HAVE_PLATFORM_IMX_FB
+	bool
+
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 224f665..d3f845e 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-y += platform-imx-dma.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_FB) += platform-imx-fb.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_SSI) += platform-imx-ssi.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UART) += platform-imx-uart.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-fb.c b/arch/arm/plat-mxc/devices/platform-imx-fb.c
new file mode 100644
index 0000000..42ed3be
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-fb.c
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
+#define imx_imx_fb_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _LCDC_BASE_ADDR,			\
+		.irq = soc ## _INT_LCDC,				\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_imx_fb_data imx21_imx_fb_data __initconst =
+	imx_imx_fb_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_imx_fb_data imx27_imx_fb_data __initconst =
+	imx_imx_fb_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_imx_fb(
+		const struct imx_imx_fb_data *data,
+		const struct imx_fb_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device_dmamask("imx-fb", 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 830369e..b1d7656 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -54,6 +54,15 @@ struct imx_imx2_wdt_data {
 struct platform_device *__init imx_add_imx2_wdt(
 		const struct imx_imx2_wdt_data *data);
 
+#include <mach/imxfb.h>
+struct imx_imx_fb_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_imx_fb(
+		const struct imx_imx_fb_data *data,
+		const struct imx_fb_platform_data *pdata);
+
 #include <mach/i2c.h>
 struct imx_imx_i2c_data {
 	int id;
diff --git a/arch/arm/plat-mxc/include/mach/imxfb.h b/arch/arm/plat-mxc/include/mach/imxfb.h
index 5263506..9de8f06 100644
--- a/arch/arm/plat-mxc/include/mach/imxfb.h
+++ b/arch/arm/plat-mxc/include/mach/imxfb.h
@@ -1,6 +1,8 @@
 /*
  * This structure describes the machine which we are running on.
  */
+#ifndef __MACH_IMXFB_H__
+#define __MACH_IMXFB_H__
 
 #include <linux/fb.h>
 
@@ -79,3 +81,4 @@ struct imx_fb_platform_data {
 };
 
 void set_imx_fb_info(struct imx_fb_platform_data *);
+#endif /* ifndef __MACH_IMXFB_H__ */
-- 
1.7.2.3
