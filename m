From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 04 Nov 2011 08:43:53 -0400
Subject: [PATCH 5/6] ARM: S5PV210: Modified files for SPI consolidation work
In-Reply-To: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
References: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
Message-ID: <1320410634-10788-6-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As SPI platform devices are consolidated to plat-samsung, some
corresponding changes are required in the respective machine folder.
Setup files are added for SPI GPIO configurations.
SPI platform specific data is initialized in the corresponding
machine file.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    5 ++++
 arch/arm/mach-s5pv210/Makefile           |    1 +
 arch/arm/mach-s5pv210/include/mach/map.h |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c    |   21 +++++++++++++++++
 arch/arm/mach-s5pv210/setup-spi.c        |   36 ++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-spi.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 646057a..2cdc42e 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -60,6 +60,11 @@ config S5PV210_SETUP_FIMC
 	help
 	  Common setup code for the camera interfaces.
 
+config S5PV210_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations.
+
 menu "S5PC110 Machines"
 
 config MACH_AQUILA
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 7eb8677..471df5d 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S5PV210_SETUP_SPI)		+= setup-spi.o
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 7ff609f..89c34b8 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -109,6 +109,8 @@
 #define S3C_PA_RTC			S5PV210_PA_RTC
 #define S3C_PA_USB_HSOTG		S5PV210_PA_HSOTG
 #define S3C_PA_WDT			S5PV210_PA_WATCHDOG
+#define S3C_PA_SPI0			S5PV210_PA_SPI0
+#define S3C_PA_SPI1			S5PV210_PA_SPI1
 
 #define S5P_PA_CHIPID			S5PV210_PA_CHIPID
 #define S5P_PA_FIMC0			S5PV210_PA_FIMC0
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a9106c3..723dfb6 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -46,6 +46,7 @@
 #include <plat/s5p-time.h>
 #include <plat/backlight.h>
 #include <plat/regs-fb-v4.h>
+#include <plat/s3c64xx-spi.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -275,6 +276,26 @@ static struct platform_pwm_backlight_data smdkv210_bl_data = {
 	.pwm_id = 3,
 };
 
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+static struct s3c64xx_spi_info smdkv210_spi0_pdata = {
+	.cfg_gpio	= s3c64xx_spi0_cfg_gpio,
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.tx_st_done	= 25,
+};
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+static struct s3c64xx_spi_info smdkv210_spi1_pdata = {
+	.cfg_gpio	= s3c64xx_spi1_cfg_gpio,
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.tx_st_done	= 25,
+};
+#endif
+
 static void __init smdkv210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
diff --git a/arch/arm/mach-s5pv210/setup-spi.c b/arch/arm/mach-s5pv210/setup-spi.c
new file mode 100644
index 0000000..e53d697
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-spi.c
@@ -0,0 +1,36 @@
+/* linux/arch/arm/mach-s5pv210/setup-spi0.c
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
+
+#include <plat/gpio-cfg.h>
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+int s3c64xx_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPB(2), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_S3C64XX_DEV_SPI1
+int s3c64xx_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPB(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPB(6), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
+#endif
-- 
1.7.0.4
