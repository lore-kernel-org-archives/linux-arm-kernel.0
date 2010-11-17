From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:47 +0100
Subject: [PATCH 19/51] ARM: imx: dynamically allocate mxc_pwm devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-19-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c                     |   19 ----------
 arch/arm/mach-imx/devices.h                     |    1 -
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c    |   45 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    7 ++++
 6 files changed, 56 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_pwm.c

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index d784564..9ee0e09 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -77,25 +77,6 @@ int __init imx1_register_gpios(void)
 #endif
 
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-static struct resource mxc_pwm_resources[] = {
-	{
-		.start = MX2x_PWM_BASE_ADDR,
-		.end = MX2x_PWM_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX2x_INT_PWM,
-		.end = MX2x_INT_PWM,
-		.flags = IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device mxc_pwm_device = {
-	.name = "mxc_pwm",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_pwm_resources),
-	.resource = mxc_pwm_resources,
-};
-
 #define DEFINE_MXC_MMC_DEVICE(n, baseaddr, irq, dmareq)			\
 	static struct resource mxc_sdhc_resources ## n[] = {		\
 		{							\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 407e90a..1ba5042 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,5 +1,4 @@
 #if defined(CONFIG_MACH_MX21) || defined(CONFIG_MACH_MX27)
-extern struct platform_device mxc_pwm_device;
 extern struct platform_device mxc_sdhc_device0;
 extern struct platform_device mxc_sdhc_device1;
 extern struct platform_device mxc_otg_udc_device;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 2542371..2ded17b 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -40,6 +40,9 @@ config IMX_HAVE_PLATFORM_MX2_CAMERA
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_PWM
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_W1
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index d3f845e..8ecd974 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
new file mode 100644
index 0000000..3ebbc67
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mxc_pwm_data_entry_single(soc)				\
+	{								\
+		.iobase = soc ## _PWM_BASE_ADDR,			\
+		.irq = soc ## _INT_PWM,					\
+	}
+
+#ifdef CONFIG_SOC_IMX21
+const struct imx_mxc_pwm_data imx21_mxc_pwm_data __initconst =
+	imx_mxc_pwm_data_entry_single(MX21);
+#endif /* ifdef CONFIG_SOC_IMX21 */
+
+#ifdef CONFIG_SOC_IMX27
+const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
+	imx_mxc_pwm_data_entry_single(MX27);
+#endif /* ifdef CONFIG_SOC_IMX27 */
+
+struct platform_device *__init imx_add_mxc_pwm(
+		const struct imx_mxc_pwm_data *data)
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
+
+	return imx_add_platform_device("mxc_pwm", 0,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index b1d7656..e241e41 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -168,6 +168,13 @@ struct platform_device *__init imx_add_mxc_nand(
 		const struct imx_mxc_nand_data *data,
 		const struct mxc_nand_platform_data *pdata);
 
+struct imx_mxc_pwm_data {
+	resource_size_t iobase;
+	resource_size_t irq;
+};
+struct platform_device *__init imx_add_mxc_pwm(
+		const struct imx_mxc_pwm_data *data);
+
 struct imx_mxc_w1_data {
 	resource_size_t iobase;
 };
-- 
1.7.2.3
