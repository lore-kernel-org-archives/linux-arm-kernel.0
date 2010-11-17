From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:14 +0100
Subject: [PATCH 46/51] ARM: mx3: dynamically allocate mxc_rnga devices
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-46-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                     |    2 +-
 arch/arm/mach-mx3/devices.c                   |   18 --------
 arch/arm/mach-mx3/devices.h                   |    1 -
 arch/arm/plat-mxc/devices/Kconfig             |    4 ++
 arch/arm/plat-mxc/devices/Makefile            |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_rnga.c |   56 +++++++++++++++++++++++++
 6 files changed, 62 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rnga.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 46fffa5..17ae7d3 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -12,7 +12,7 @@ config ARCH_MX35
 
 config SOC_IMX31
 	bool
-	select ARCH_HAS_RNGA
+	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MX31
 
diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 079b98e..202c06c 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -29,23 +29,6 @@
 
 #include "devices.h"
 
-#ifdef CONFIG_ARCH_MX31
-static struct resource rnga_resources[] = {
-	{
-		.start = MX3x_RNGA_BASE_ADDR,
-		.end = MX3x_RNGA_BASE_ADDR + 0x28,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device mxc_rnga_device = {
-	.name = "mxc_rnga",
-	.id = -1,
-	.num_resources = 1,
-	.resource = rnga_resources,
-};
-#endif /* CONFIG_ARCH_MX31 */
-
 /* i.MX31 Image Processing Unit */
 
 /* The resource order is important! */
@@ -262,7 +245,6 @@ static int __init mx3_devices_init(void)
 	if (cpu_is_mx31()) {
 		imx_wdt_resources[0].start = MX31_WDOG_BASE_ADDR;
 		imx_wdt_resources[0].end = MX31_WDOG_BASE_ADDR + 0x3fff;
-		mxc_register_device(&mxc_rnga_device, NULL);
 	}
 #endif
 #if defined(CONFIG_ARCH_MX35)
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 2020474..d472c45 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -5,7 +5,6 @@ extern struct platform_device mxc_otg_udc_device;
 extern struct platform_device mxc_otg_host;
 extern struct platform_device mxc_usbh1;
 extern struct platform_device mxc_usbh2;
-extern struct platform_device mxc_rnga_device;
 extern struct platform_device imx_wdt_device0;
 extern struct platform_device imx_rtc_device0;
 extern struct platform_device imx_kpp_device;
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 1be4476..f34c139 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -62,6 +62,10 @@ config IMX_HAVE_PLATFORM_MXC_NAND
 config IMX_HAVE_PLATFORM_MXC_PWM
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_RNGA
+	bool
+	select ARCH_HAS_RNGA
+
 config IMX_HAVE_PLATFORM_MXC_W1
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index f1c3767..91fdd6c 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI) += platform-mxc-ehci.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) += platform-mxc_rnga.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) += platform-mxc_w1.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=  platform-spi_imx.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_rnga.c b/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
new file mode 100644
index 0000000..602d1e7
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_rnga.c
@@ -0,0 +1,56 @@
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
+struct imx_mxc_rnga_data {
+	resource_size_t iobase;
+};
+
+#define imx_mxc_rnga_data_entry_single(soc, _size)			\
+	{								\
+		.iobase = soc ## _RNGA_BASE_ADDR,			\
+	}
+
+#ifdef CONFIG_SOC_IMX31
+static const struct imx_mxc_rnga_data imx31_mxc_rnga_data __initconst =
+	imx_mxc_rnga_data_entry_single(MX31, SZ_4K);
+#endif /* ifdef CONFIG_SOC_IMX31 */
+
+static struct platform_device *__init imx_add_mxc_rnga(
+		const struct imx_mxc_rnga_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_16K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+	return imx_add_platform_device("mxc_rnga", -1,
+			res, ARRAY_SIZE(res), NULL, 0);
+}
+
+static int __init imxXX_add_mxc_rnga(void)
+{
+	struct platform_device *ret;
+
+#if defined(CONFIG_SOC_IMX31)
+	if (cpu_is_mx31()) 
+		ret = imx_add_mxc_rnga(&imx31_mxc_rnga_data);
+	else
+#endif /* if defined(CONFIG_SOC_IMX31) */
+		ret = ERR_PTR(-ENODEV);
+
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	return 0;
+}
+arch_initcall(imxXX_add_mxc_rnga);
-- 
1.7.2.3
