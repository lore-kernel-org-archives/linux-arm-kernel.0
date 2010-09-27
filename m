From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:50:52 +0200
Subject: [PATCH 16/40] ARM: mx5: dynamically register imx-i2c devices
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/board-cpuimx51.c           |    6 ++--
 arch/arm/mach-mx5/devices-imx51.h            |   14 +++++++++
 arch/arm/mach-mx5/devices.c                  |   38 --------------------------
 arch/arm/mach-mx5/devices.h                  |    2 -
 arch/arm/plat-mxc/devices/platform-imx-i2c.c |    9 ++++++
 6 files changed, 27 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 0848db5..1b5c028 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -24,6 +24,7 @@ config MACH_MX51_3DS
 
 config MACH_EUKREA_CPUIMX51
 	bool "Support Eukrea CPUIMX51 module"
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	help
 	  Include support for Eukrea CPUIMX51 platform. This includes
 	  specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 623607a..d52f252 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -30,7 +30,6 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx51.h>
-#include <mach/i2c.h>
 #include <mach/mxc_ehci.h>
 
 #include <asm/irq.h>
@@ -152,7 +151,8 @@ static struct imxuart_platform_data uart_pdata = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct imxi2c_platform_data eukrea_cpuimx51_i2c_data = {
+static const
+struct imxi2c_platform_data eukrea_cpuimx51_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -255,7 +255,7 @@ static void __init eukrea_cpuimx51_init(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-	mxc_register_device(&mxc_i2c_device1, &eukrea_cpuimx51_i2c_data);
+	imx51_add_imx_i2c(1, &eukrea_cpuimx51_i2c_data);
 	i2c_register_board_info(1, eukrea_cpuimx51_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx51_i2c_devices));
 
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
new file mode 100644
index 0000000..a3cc383
--- /dev/null
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx51.h>
+#include <mach/devices-common.h>
+
+extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
+#define imx51_add_imx_i2c(id, pdata)	\
+	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 1920ff4..70b76d1 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -93,44 +93,6 @@ struct platform_device mxc_fec_device = {
 	.resource = mxc_fec_resources,
 };
 
-static struct resource mxc_i2c0_resources[] = {
-	{
-		.start = MX51_I2C1_BASE_ADDR,
-		.end = MX51_I2C1_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX51_MXC_INT_I2C1,
-		.end = MX51_MXC_INT_I2C1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_i2c_device0 = {
-	.name = "imx-i2c",
-	.id = 0,
-	.num_resources = ARRAY_SIZE(mxc_i2c0_resources),
-	.resource = mxc_i2c0_resources,
-};
-
-static struct resource mxc_i2c1_resources[] = {
-	{
-		.start = MX51_I2C2_BASE_ADDR,
-		.end = MX51_I2C2_BASE_ADDR + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.start = MX51_MXC_INT_I2C2,
-		.end = MX51_MXC_INT_I2C2,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mxc_i2c_device1 = {
-	.name = "imx-i2c",
-	.id = 1,
-	.num_resources = ARRAY_SIZE(mxc_i2c1_resources),
-	.resource = mxc_i2c1_resources,
-};
-
 static struct resource mxc_hsi2c_resources[] = {
 	{
 		.start = MX51_HSI2C_DMA_BASE_ADDR,
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index e509cfa..5c2918f 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -6,7 +6,5 @@ extern struct platform_device mxc_usbdr_host_device;
 extern struct platform_device mxc_usbh1_device;
 extern struct platform_device mxc_usbdr_udc_device;
 extern struct platform_device mxc_wdt;
-extern struct platform_device mxc_i2c_device0;
-extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_hsi2c_device;
 extern struct platform_device mxc_keypad_device;
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index ab9670b..ca988d4 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -68,6 +68,15 @@ const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
+#define imx51_imx_i2c_data_entry(_id, _hwid)				\
+	imx_imx_i2c_data_entry(MX51, _id, _hwid, SZ_4K)
+	imx51_imx_i2c_data_entry(0, 1),
+	imx51_imx_i2c_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_imx_i2c(
 		const struct imx_imx_i2c_data *data,
 		const struct imxi2c_platform_data *pdata)
-- 
1.7.2.3
