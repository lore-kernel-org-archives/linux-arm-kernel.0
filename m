From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 18 Nov 2011 09:35:48 -0500
Subject: [PATCH V2 4/6] ARM: S5P64X0: Modified files for SPI consolidation work
In-Reply-To: <1321626950-19859-1-git-send-email-padma.v@samsung.com>
References: <1321626950-19859-1-git-send-email-padma.v@samsung.com>
Message-ID: <1321626950-19859-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine folder.
Setup files are added for SPI GPIO configurations and platform data
initialization.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5p64x0/Kconfig            |    7 +++-
 arch/arm/mach-s5p64x0/Makefile           |    1 +
 arch/arm/mach-s5p64x0/include/mach/map.h |    3 ++
 arch/arm/mach-s5p64x0/setup-spi.c        |   57 ++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi.c

diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 18690c5..dd8c85e 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -36,6 +36,11 @@ config S5P64X0_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S5P64X0_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations
+
 # machine support
 
 config MACH_SMDK6440
@@ -45,7 +50,6 @@ config MACH_SMDK6440
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select S3C64XX_DEV_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
@@ -62,7 +66,6 @@ config MACH_SMDK6450
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select S3C64XX_DEV_SPI
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index e24d316..a7d7a49 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -29,3 +29,4 @@ obj-y				+= dev-audio.o
 
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5P64X0_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5P64X0_SETUP_SPI)		+= setup-spi.o
diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-s5p64x0/include/mach/map.h
index 4d3ac8a..c6af0fc 100644
--- a/arch/arm/mach-s5p64x0/include/mach/map.h
+++ b/arch/arm/mach-s5p64x0/include/mach/map.h
@@ -67,6 +67,8 @@
 #define S3C_PA_RTC		S5P64X0_PA_RTC
 #define S3C_PA_WDT		S5P64X0_PA_WDT
 #define S3C_PA_FB		S5P64X0_PA_FB
+#define S3C_PA_SPI0		S5P64X0_PA_SPI0
+#define S3C_PA_SPI1		S5P64X0_PA_SPI1
 
 #define S5P_PA_CHIPID		S5P64X0_PA_CHIPID
 #define S5P_PA_SROMC		S5P64X0_PA_SROMC
@@ -75,6 +77,7 @@
 
 #define SAMSUNG_PA_ADC		S5P64X0_PA_ADC
 
+
 /* UART */
 
 #define S5P6440_PA_UART(x)	(0xEC000000 + ((x) * S3C_UART_OFFSET))
diff --git a/arch/arm/mach-s5p64x0/setup-spi.c b/arch/arm/mach-s5p64x0/setup-spi.c
new file mode 100644
index 0000000..fb66ff9
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/setup-spi.c
@@ -0,0 +1,57 @@
+/* linux/arch/arm/mach-s5p64x0/setup-spi0.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
+#include <plat/s3c64xx-spi.h>
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.cntrlr_no	= 0,
+};
+
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	if (soc_is_s5p6450())
+		s3c_gpio_cfgall_range(S5P6450_GPC(0), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(S5P6440_GPC(0), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+struct s3c64xx_spi_info s3c64xx_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.cntrlr_no	= 1,
+};
+
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	if (soc_is_s5p6450())
+		s3c_gpio_cfgall_range(S5P6450_GPC(4), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(S5P6440_GPC(4), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
-- 
1.7.1
