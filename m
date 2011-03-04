From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  4 Mar 2011 21:51:18 +0100
Subject: [PATCH 2/6] ARM: mx3: dynamically allocate "mxc_rtc" devices
In-Reply-To: <20110304205008.GX22310@pengutronix.de>
References: <20110304205008.GX22310@pengutronix.de>
Message-ID: <1299271882-2130-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/devices-imx31.h               |    4 ++
 arch/arm/mach-mx3/devices.c                     |   19 -----------
 arch/arm/mach-mx3/devices.h                     |    1 -
 arch/arm/mach-mx3/mx31lite-db.c                 |    2 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_rtc.c    |   40 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    9 +++++
 9 files changed, 59 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rtc.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 340809a..5e82d30 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -83,6 +83,7 @@ config MACH_MX31LITE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
diff --git a/arch/arm/mach-mx3/devices-imx31.h b/arch/arm/mach-mx3/devices-imx31.h
index 40f4e84..b6da93c 100644
--- a/arch/arm/mach-mx3/devices-imx31.h
+++ b/arch/arm/mach-mx3/devices-imx31.h
@@ -56,6 +56,10 @@ extern const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst;
 #define imx31_add_mxc_nand(pdata)	\
 	imx_add_mxc_nand(&imx31_mxc_nand_data, pdata)
 
+extern const struct imx_mxc_rtc_data imx31_mxc_rtc_data __initconst;
+#define imx31_add_mxc_rtc(pdata)	\
+	imx_add_mxc_rtc(&imx31_mxc_rtc_data)
+
 extern const struct imx_mxc_w1_data imx31_mxc_w1_data __initconst;
 #define imx31_add_mxc_w1(pdata)	\
 	imx_add_mxc_w1(&imx31_mxc_w1_data)
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index b6672db..0701ee4 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -94,22 +94,3 @@ struct platform_device mx3_camera = {
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
-
-static struct resource imx_rtc_resources[] = {
-	{
-		.start  = MX31_RTC_BASE_ADDR,
-		.end    = MX31_RTC_BASE_ADDR + 0x3fff,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start  = MX31_INT_RTC,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_rtc_device0 = {
-	.name           = "mxc_rtc",
-	.id             = -1,
-	.num_resources  = ARRAY_SIZE(imx_rtc_resources),
-	.resource       = imx_rtc_resources,
-};
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 121962c..d23f853 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,4 +1,3 @@
 extern struct platform_device mx3_ipu;
 extern struct platform_device mx3_fb;
 extern struct platform_device mx3_camera;
-extern struct platform_device imx_rtc_device0;
diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 3124ea8..04fab65 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -200,5 +200,5 @@ void __init mx31lite_db_init(void)
 	imx31_add_spi_imx0(&spi0_pdata);
 	platform_device_register(&litekit_led_device);
 	imx31_add_imx2_wdt(NULL);
-	mxc_register_device(&imx_rtc_device0, NULL);
+	imx31_add_mxc_rtc(NULL);
 }
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..0e8d7ab 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -63,6 +63,9 @@ config IMX_HAVE_PLATFORM_MXC_RNGA
 	bool
 	select ARCH_HAS_RNGA
 
+config IMX_HAVE_PLATFORM_MXC_RTC
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_W1
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..ca227ea 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) += platform-mxc_rtc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) += platform-sdhci-esdhc-imx.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_rtc.c b/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
new file mode 100644
index 0000000..16d0ec4
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_rtc.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2010-2011 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mxc_rtc_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _RTC_BASE_ADDR,			\
+		.irq = soc ## _INT_RTC,					\
+	}
+
+#ifdef CONFIG_SOC_IMX31
+const struct imx_mxc_rtc_data imx31_mxc_rtc_data __initconst =
+	imx_mxc_rtc_data_entry_single(MX31);
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+struct platform_device *__init imx_add_mxc_rtc(
+		const struct imx_mxc_rtc_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("mxc_rtc", -1,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..b0bc198 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -237,6 +237,15 @@ struct imx_mxc_pwm_data {
 struct platform_device *__init imx_add_mxc_pwm(
 		const struct imx_mxc_pwm_data *data);
 
+/* mxc_rtc */
+struct imx_mxc_rtc_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_mxc_rtc(
+		const struct imx_mxc_rtc_data *data);
+
+/* mxc_w1 */
 struct imx_mxc_w1_data {
 	resource_size_t iobase;
 };
-- 
1.7.2.3
