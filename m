From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:38 +0200
Subject: [PATCH 42/61] ARM: imx: dynamically register imx-i2c devices (imx1)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-43-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/devices-imx1.h     |   13 +++++++++++++
 arch/arm/mach-imx/devices.c          |   19 -------------------
 arch/arm/mach-imx/devices.h          |    1 -
 arch/arm/mach-imx/mach-mx1ads.c      |    5 +++--
 arch/arm/plat-mxc/include/mach/mx1.h |    4 ++--
 6 files changed, 19 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-imx/devices-imx1.h

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5af1c22..3f88d4a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -16,6 +16,7 @@ config MACH_MXLADS
 config ARCH_MX1ADS
 	bool "MX1ADS platform"
 	select MACH_MXLADS
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	help
 	  Say Y here if you are using Motorola MX1ADS/MXLADS boards
 
diff --git a/arch/arm/mach-imx/devices-imx1.h b/arch/arm/mach-imx/devices-imx1.h
new file mode 100644
index 0000000..a5cfe04
--- /dev/null
+++ b/arch/arm/mach-imx/devices-imx1.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx1.h>
+#include <mach/devices-common.h>
+
+#define imx1_add_i2c_imx(pdata)		\
+	imx_add_imx_i2c(0, MX1_I2C_BASE_ADDR, SZ_4K, MX1_INT_I2C, pdata)
diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index 3a599e9..a34ad60 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -70,25 +70,6 @@ struct platform_device imx1_camera_device = {
 	.num_resources  = ARRAY_SIZE(imx1_camera_resources),
 };
 
-static struct resource imx_i2c_resources[] = {
-	{
-		.start  = 0x00217000,
-		.end    = 0x00217010,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.start  = MX1_I2C_INT,
-		.end    = MX1_I2C_INT,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device imx_i2c_device0 = {
-	.name           = "imx-i2c",
-	.id             = 0,
-	.resource       = imx_i2c_resources,
-	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
-};
-
 #define DEFINE_IMX1_UART_DEVICE(n, baseaddr, irqrx, irqtx, irqrts)	\
 	static struct resource imx1_uart_resources ## n[] = {		\
 		{							\
diff --git a/arch/arm/mach-imx/devices.h b/arch/arm/mach-imx/devices.h
index 4ce7eef..b4eb8a0 100644
--- a/arch/arm/mach-imx/devices.h
+++ b/arch/arm/mach-imx/devices.h
@@ -1,6 +1,5 @@
 #ifdef CONFIG_ARCH_MX1
 extern struct platform_device imx1_camera_device;
-extern struct platform_device imx_i2c_device0;
 extern struct platform_device imx1_uart_device0;
 extern struct platform_device imx1_uart_device1;
 extern struct platform_device imx_rtc_device;
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 5d7c85f..339d41a 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -30,6 +30,7 @@
 #include <mach/iomux-mx1.h>
 #include <mach/irqs.h>
 
+#include "devices-imx1.h"
 #include "devices.h"
 
 static int mx1ads_pins[] = {
@@ -98,7 +99,7 @@ static struct pcf857x_platform_data pcf857x_data[] = {
 	}
 };
 
-static struct imxi2c_platform_data mx1ads_i2c_data = {
+static const struct imxi2c_platform_data mx1ads_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
@@ -131,7 +132,7 @@ static void __init mx1ads_init(void)
 	i2c_register_board_info(0, mx1ads_i2c_devices,
 				ARRAY_SIZE(mx1ads_i2c_devices));
 
-	mxc_register_device(&imx_i2c_device0, &mx1ads_i2c_data);
+	imx1_add_i2c_imx(&mx1ads_i2c_data);
 }
 
 static void __init mx1ads_timer_init(void)
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 5eba7e6..e99c0b2 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -108,7 +108,7 @@
 #define MX1_PEN_DATA_INT	33
 #define MX1_PWM_INT		34
 #define MX1_SDHC_INT		35
-#define MX1_I2C_INT		39
+#define MX1_INT_I2C		39
 #define MX1_CSPI_INT		41
 #define MX1_SSI_TX_INT		42
 #define MX1_SSI_TX_ERR_INT	43
@@ -245,7 +245,7 @@
 #define PEN_DATA_INT MX1_PEN_DATA_INT
 #define PWM_INT MX1_PWM_INT
 #define SDHC_INT MX1_SDHC_INT
-#define I2C_INT MX1_I2C_INT
+#define I2C_INT MX1_INT_I2C
 #define CSPI_INT MX1_CSPI_INT
 #define SSI_TX_INT MX1_SSI_TX_INT
 #define SSI_TX_ERR_INT MX1_SSI_TX_ERR_INT
-- 
1.7.1
