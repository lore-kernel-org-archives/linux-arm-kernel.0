From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 22:13:17 +0900
Subject: [PATCH 1/3] ARM: S5P6440: Add support for I2C channel 0 and 1 on
	SMDK6440
In-Reply-To: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
References: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279285999-27555-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds helper functions for I2C channel 0 and 1, GPIO
configurations for I2C on S5P6440 and support I2C-0/1 devices
on SMDK6440.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/Kconfig            |    7 +++++++
 arch/arm/mach-s5p6440/Makefile           |    1 +
 arch/arm/mach-s5p6440/include/mach/map.h |    2 ++
 arch/arm/mach-s5p6440/mach-smdk6440.c    |   20 ++++++++++++++++++++
 arch/arm/mach-s5p6440/setup-i2c0.c       |    7 ++++++-
 arch/arm/mach-s5p6440/setup-i2c1.c       |   30 ++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/setup-i2c1.c

diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
index f066fae..ba3927b 100644
--- a/arch/arm/mach-s5p6440/Kconfig
+++ b/arch/arm/mach-s5p6440/Kconfig
@@ -13,13 +13,20 @@ config CPU_S5P6440
 	help
 	  Enable S5P6440 CPU support
 
+config S5P6440_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
 config MACH_SMDK6440
 	bool "SMDK6440"
 	select CPU_S5P6440
 	select SAMSUNG_DEV_TS
 	select SAMSUNG_DEV_ADC
+	select S3C_DEV_I2C1
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S5P6440_SETUP_I2C1
 	help
 	  Machine support for the Samsung SMDK6440
 
diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index be3c53a..c3fe4d3 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
 # device support
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+obj-$(CONFIG_S5P6440_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-s5p6440/include/mach/map.h b/arch/arm/mach-s5p6440/include/mach/map.h
index 44011b9..d6a3a29 100644
--- a/arch/arm/mach-s5p6440/include/mach/map.h
+++ b/arch/arm/mach-s5p6440/include/mach/map.h
@@ -53,6 +53,7 @@
 #define S5P_SZ_UART		SZ_256
 
 #define S5P6440_PA_IIC0		(0xEC104000)
+#define S5P6440_PA_IIC1		(0xEC20F000)
 
 #define S5P6440_PA_SPI0		0xEC400000
 #define S5P6440_PA_SPI1		0xEC500000
@@ -77,6 +78,7 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5P6440_PA_UART
 #define S3C_PA_IIC		S5P6440_PA_IIC0
+#define S3C_PA_IIC1		S5P6440_PA_IIC1
 #define S3C_PA_WDT		S5P6440_PA_WDT
 
 #define SAMSUNG_PA_ADC		S5P6440_PA_ADC
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 8291fec..623354e 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -15,6 +15,7 @@
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/i2c.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -37,6 +38,7 @@
 #include <mach/regs-clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/iic.h>
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
@@ -88,10 +90,20 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 static struct platform_device *smdk6440_devices[] __initdata = {
 	&s5p6440_device_iis,
 	&s3c_device_adc,
+	&s3c_device_i2c0,
+	&s3c_device_i2c1,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
 
+static struct i2c_board_info smdk6440_i2c_devs0[] __initdata = {
+	{ I2C_BOARD_INFO("24c08", 0x50), },
+};
+
+static struct i2c_board_info smdk6440_i2c_devs1[] __initdata = {
+	/* To be populated */
+};
+
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
@@ -109,6 +121,14 @@ static void __init smdk6440_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
 
+	/* I2C */
+	s3c_i2c0_set_platdata(NULL);
+	s3c_i2c1_set_platdata(NULL);
+	i2c_register_board_info(0, smdk6440_i2c_devs0,
+			ARRAY_SIZE(smdk6440_i2c_devs0));
+	i2c_register_board_info(1, smdk6440_i2c_devs1,
+			ARRAY_SIZE(smdk6440_i2c_devs1));
+
 	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
 }
 
diff --git a/arch/arm/mach-s5p6440/setup-i2c0.c b/arch/arm/mach-s5p6440/setup-i2c0.c
index 69e8a66..2c99d14 100644
--- a/arch/arm/mach-s5p6440/setup-i2c0.c
+++ b/arch/arm/mach-s5p6440/setup-i2c0.c
@@ -17,9 +17,14 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	/* Will be populated later */
+	s3c_gpio_cfgpin(S5P6440_GPB(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5P6440_GPB(5), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5P6440_GPB(6), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5P6440_GPB(6), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5p6440/setup-i2c1.c b/arch/arm/mach-s5p6440/setup-i2c1.c
new file mode 100644
index 0000000..9a1537f
--- /dev/null
+++ b/arch/arm/mach-s5p6440/setup-i2c1.c
@@ -0,0 +1,30 @@
+/* linux/arch/arm/mach-s5p6440/setup-i2c1.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C1 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/gpio.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <plat/gpio-cfg.h>
+#include <plat/iic.h>
+
+void s3c_i2c1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5P6440_GPR(9), S3C_GPIO_SFN(6));
+	s3c_gpio_setpull(S5P6440_GPR(9), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5P6440_GPR(10), S3C_GPIO_SFN(6));
+	s3c_gpio_setpull(S5P6440_GPR(10), S3C_GPIO_PULL_UP);
+}
-- 
1.6.2.5
