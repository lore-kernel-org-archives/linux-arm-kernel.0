From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:25:20 -0400
Subject: [PATCH 4/7] ARM: SAMSUNG: Create SPI device setup files in respective
	machine folder
In-Reply-To: <1309436723-662-1-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
Message-ID: <1309436723-662-5-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI device specific setup files are created for S3C64XX,S5P64X0,S5PC100
and S5PV210 to configure the GPIO pins corresponding to specific SoC.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig      |   14 ++++++++++++++
 arch/arm/mach-s3c64xx/Makefile     |    3 ++-
 arch/arm/mach-s3c64xx/setup-spi0.c |   21 +++++++++++++++++++++
 arch/arm/mach-s3c64xx/setup-spi1.c |   21 +++++++++++++++++++++
 arch/arm/mach-s5p64x0/Kconfig      |   20 ++++++++++++++++++--
 arch/arm/mach-s5p64x0/Makefile     |    3 ++-
 arch/arm/mach-s5p64x0/setup-spi0.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-s5p64x0/setup-spi1.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-s5pc100/Kconfig      |   21 +++++++++++++++++++++
 arch/arm/mach-s5pc100/Makefile     |    4 +++-
 arch/arm/mach-s5pc100/setup-spi0.c |   21 +++++++++++++++++++++
 arch/arm/mach-s5pc100/setup-spi1.c |   21 +++++++++++++++++++++
 arch/arm/mach-s5pc100/setup-spi2.c |   23 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/Kconfig      |   14 ++++++++++++++
 arch/arm/mach-s5pv210/Makefile     |    3 ++-
 arch/arm/mach-s5pv210/setup-spi0.c |   23 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-spi1.c |   23 +++++++++++++++++++++++
 17 files changed, 291 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi0.c
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi1.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi0.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi1.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi0.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi1.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi2.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi0.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi1.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 4e2c371..d2acce0 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -77,6 +77,16 @@ config S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for S3C64XX SDHCI GPIO configurations
 
+config S3C64XX_SETUP_SPI0
+	bool
+	help
+	  Common setup code for SPI channel 0
+
+config S3C64XX_SETUP_SPI1
+	bool
+	help
+	  Common setup code for SPI channel 1
+
 # S36400 Macchine support
 
 config MACH_SMDK6400
@@ -142,6 +152,8 @@ config MACH_SMDK6410
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
@@ -150,6 +162,8 @@ config MACH_SMDK6410
 	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_KEYPAD
+	select S3C64XX_SETUP_SPI0
+	select S3C64XX_SETUP_SPI1
 	help
 	  Machine support for the Samsung SMDK6410
 
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 88d7fd2..f3d2f81 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
+obj-$(CONFIG_S3C64XX_SETUP_SPI0) += setup-spi0.o
+obj-$(CONFIG_S3C64XX_SETUP_SPI1) += setup-spi1.o
 
 # PM
 
@@ -65,6 +67,5 @@ obj-$(CONFIG_MACH_WLF_CRAGG_6410) += mach-crag6410.o
 
 obj-y				+= dev-uart.o
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
 obj-$(CONFIG_S3C64XX_DEV_ONENAND1)	+= dev-onenand1.o
diff --git a/arch/arm/mach-s3c64xx/setup-spi0.c b/arch/arm/mach-s3c64xx/setup-spi0.c
new file mode 100644
index 0000000..bdf881d
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-spi0.c
@@ -0,0 +1,21 @@
+/* linux/arch/arm/mach-s3c64xx/setup-spi0.c
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
+int s3c_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S3C64XX_GPC(0), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s3c64xx/setup-spi1.c b/arch/arm/mach-s3c64xx/setup-spi1.c
new file mode 100644
index 0000000..3d8acad
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-spi1.c
@@ -0,0 +1,21 @@
+/* linux/arch/arm/mach-s3c64xx/setup-spi1.c
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
+int s3c_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 017af4c..6f3ac6f 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -26,6 +26,16 @@ config S5P64X0_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S5P64X0_SETUP_SPI0
+	bool
+	help
+	  Common setup code for SPI channel 0
+
+config S5P64X0_SETUP_SPI1
+	bool
+	help
+	  Common setup code for SPI channel 1
+
 # machine support
 
 config MACH_SMDK6440
@@ -34,11 +44,14 @@ config MACH_SMDK6440
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select S3C64XX_DEV_SPI
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SPI0
+	select S5P64X0_SETUP_SPI1
 	help
 	  Machine support for the Samsung SMDK6440
 
@@ -48,11 +61,14 @@ config MACH_SMDK6450
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
-	select S3C64XX_DEV_SPI
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5P64X0_SETUP_I2C1
+	select S5P64X0_SETUP_SPI0
+	select S5P64X0_SETUP_SPI1
 	help
 	  Machine support for the Samsung SMDK6450
 
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
index ae6bf6f..4af3b11 100644
--- a/arch/arm/mach-s5p64x0/Makefile
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_MACH_SMDK6450)	+= mach-smdk6450.o
 # device support
 
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5P64X0_SETUP_SPI0)	+= setup-spi0.o
+obj-$(CONFIG_S5P64X0_SETUP_SPI1)	+= setup-spi1.o
diff --git a/arch/arm/mach-s5p64x0/setup-spi0.c b/arch/arm/mach-s5p64x0/setup-spi0.c
new file mode 100644
index 0000000..aa8db6a
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/setup-spi0.c
@@ -0,0 +1,31 @@
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
+
+#include <mach/regs-clock.h>
+
+int s3c_spi0_cfg_gpio(struct platform_device *dev)
+{
+	unsigned int id;
+	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+
+	if (id == 0x50000)
+		s3c_gpio_cfgall_range(S5P6450_GPC(0), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(S5P6440_GPC(0), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5p64x0/setup-spi1.c b/arch/arm/mach-s5p64x0/setup-spi1.c
new file mode 100644
index 0000000..44cef48
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/setup-spi1.c
@@ -0,0 +1,31 @@
+/* linux/arch/arm/mach-s5p64x0/setup-spi1.c
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
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <plat/gpio-cfg.h>
+
+#include <mach/regs-clock.h>
+
+int s3c_spi1_cfg_gpio(struct platform_device *dev)
+{
+	unsigned int id;
+	id = __raw_readl(S5P64X0_SYS_ID) & 0xFF000;
+
+	if (id == 0x50000)
+		s3c_gpio_cfgall_range(S5P6450_GPC(4), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(S5P6440_GPC(4), 3,
+					S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 608722f..eac5dc9 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -45,6 +45,21 @@ config S5PC100_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config S5PC100_SETUP_SPI0
+	bool
+	help
+	  Common setup code for SPI channel 0
+
+config S5PC100_SETUP_SPI1
+	bool
+	help
+	  Common setup code for SPI channel 1
+
+config S5PC100_SETUP_SPI2
+	bool
+	help
+	  Common setup code for SPI channel 2
+
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
@@ -55,6 +70,9 @@ config MACH_SMDKC100
 	select S3C_DEV_I2C1
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
+	select SAMSUNG_DEV_SPI2
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
@@ -65,6 +83,9 @@ config MACH_SMDKC100
 	select S5PC100_SETUP_IDE
 	select S5PC100_SETUP_KEYPAD
 	select S5PC100_SETUP_SDHCI
+	select S5PC100_SETUP_SPI0
+	select S5PC100_SETUP_SPI1
+	select S5PC100_SETUP_SPI2
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index a5e6e60..76052ca 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -23,10 +23,12 @@ obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S5PC100_SETUP_SPI0)	+= setup-spi0.o
+obj-$(CONFIG_S5PC100_SETUP_SPI1)	+= setup-spi1.o
+obj-$(CONFIG_S5PC100_SETUP_SPI2)	+= setup-spi2.o
 
 # device support
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pc100/setup-spi0.c b/arch/arm/mach-s5pc100/setup-spi0.c
new file mode 100644
index 0000000..05882e9
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-spi0.c
@@ -0,0 +1,21 @@
+/* linux/arch/arm/mach-s5pc100/setup-spi0.c
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
+int s3c_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S5PC100_GPB(0), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5pc100/setup-spi1.c b/arch/arm/mach-s5pc100/setup-spi1.c
new file mode 100644
index 0000000..b567f34
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-spi1.c
@@ -0,0 +1,21 @@
+/* linux/arch/arm/mach-s5pc100/setup-spi1.c
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
+int s3c_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgall_range(S5PC100_GPB(4), 3,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5pc100/setup-spi2.c b/arch/arm/mach-s5pc100/setup-spi2.c
new file mode 100644
index 0000000..54c29e3
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-spi2.c
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-s5pc100/setup-spi2.c
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
+int s3c_spi2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PC100_GPB(2), 2,
+				S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 37b5a97..59879ee 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -59,6 +59,16 @@ config S5PV210_SETUP_FIMC
 	help
 	  Common setup code for the camera interfaces.
 
+config S5PV210_SETUP_SPI0
+	bool
+	help
+	  Common setup code for SPI channel 0
+
+config S5PV210_SETUP_SPI1
+	bool
+	help
+	  Common setup code for SPI channel 1
+
 menu "S5PC110 Machines"
 
 config MACH_AQUILA
@@ -138,12 +148,16 @@ config MACH_SMDKV210
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_IDE
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
+	select S5PV210_SETUP_SPI0
+	select S5PV210_SETUP_SPI1
 	help
 	  Machine support for Samsung SMDKV210
 
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 50907ac..283b04b 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
 # device support
 
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_FIMC)	+= setup-fimc.o
@@ -38,3 +37,5 @@ obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S5PV210_SETUP_SPI0)	+= setup-spi0.o
+obj-$(CONFIG_S5PV210_SETUP_SPI1)	+= setup-spi1.o
diff --git a/arch/arm/mach-s5pv210/setup-spi0.c b/arch/arm/mach-s5pv210/setup-spi0.c
new file mode 100644
index 0000000..7c3256b
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-spi0.c
@@ -0,0 +1,23 @@
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
+int s3c_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPB(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPB(2), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-s5pv210/setup-spi1.c b/arch/arm/mach-s5pv210/setup-spi1.c
new file mode 100644
index 0000000..b22e56e
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-spi1.c
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-s5pv210/setup-spi1.c
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
+int s3c_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPB(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPB(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5PV210_GPB(6), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
-- 
1.7.0.4
