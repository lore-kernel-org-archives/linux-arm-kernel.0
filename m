From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 08:18:54 +0200
Subject: [PATCH 03/15] ARM: Samsung: move driver strength gpio configuration
	helper to common dir
In-Reply-To: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1273817946-29404-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver strength parameter can be changed not only on S5PC100 but also
on S5PV210/S5PC110 platforms, so move the helper functions to the common
plat-samsung directory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                          |    1 +
 arch/arm/plat-s5pc1xx/Kconfig                      |    2 +-
 arch/arm/plat-s5pc1xx/Makefile                     |    1 -
 arch/arm/plat-s5pc1xx/gpio-config.c                |   62 --------------------
 .../plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h   |   32 ----------
 arch/arm/plat-s5pc1xx/setup-fb-24bpp.c             |    1 -
 arch/arm/plat-samsung/Kconfig                      |   12 ++--
 arch/arm/plat-samsung/gpio-config.c                |   48 +++++++++++++++
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   30 ++++++++++
 9 files changed, 86 insertions(+), 103 deletions(-)
 delete mode 100644 arch/arm/plat-s5pc1xx/gpio-config.c
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index d400a6a..92bd756 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -13,6 +13,7 @@ config PLAT_S5P
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
+	select S5P_GPIO_DRVSTR
 	select SAMSUNG_GPIOLIB_4BIT
 	select S3C_GPIO_CFG_S3C64XX
 	select S3C_GPIO_PULL_UPDOWN
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index c7ccdf2..79d3be7 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -16,9 +16,9 @@ config PLAT_S5PC1XX
 	select SAMSUNG_IRQ_VIC_TIMER
 	select S3C_GPIO_TRACK
 	select S3C_GPIO_PULL_UPDOWN
+	select S5P_GPIO_DRVSTR
 	select S3C_GPIO_CFG_S3C24XX
 	select S3C_GPIO_CFG_S3C64XX
-	select S5P_GPIO_CFG_S5PC1XX
 	help
 	  Base platform code for any Samsung S5PC1XX device
 
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 278f268..66a8f3e 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
 
 # Device setup
 
-obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
 obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
diff --git a/arch/arm/plat-s5pc1xx/gpio-config.c b/arch/arm/plat-s5pc1xx/gpio-config.c
deleted file mode 100644
index a4f67e8..0000000
--- a/arch/arm/plat-s5pc1xx/gpio-config.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/gpio-config.c
- *
- * Copyright 2009 Samsung Electronics
- *
- * S5PC1XX GPIO Configuration.
- *
- * Based on plat-s3c64xx/gpio-config.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg-s5pc1xx.h>
-
-s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin, unsigned int off)
-{
-	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
-	void __iomem *reg;
-	int shift = off * 2;
-	u32 drvstr;
-
-	if (!chip)
-		return -EINVAL;
-
-	reg = chip->base + 0x0C;
-
-	drvstr = __raw_readl(reg);
-	drvstr = 0xffff & (0x3 << shift);
-	drvstr = drvstr >> shift;
-
-	return (__force s5p_gpio_drvstr_t)drvstr;
-}
-EXPORT_SYMBOL(s5p_gpio_get_drvstr);
-
-int s5p_gpio_set_drvstr(unsigned int pin, unsigned int off,
-			s5p_gpio_drvstr_t drvstr)
-{
-	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
-	void __iomem *reg;
-	int shift = off * 2;
-	u32 tmp;
-
-	if (!chip)
-		return -EINVAL;
-
-	reg = chip->base + 0x0C;
-
-	tmp = __raw_readl(reg);
-	tmp |= drvstr << shift;
-
-	__raw_writel(tmp, reg);
-
-	return 0;
-}
-EXPORT_SYMBOL(s5p_gpio_set_drvstr);
diff --git a/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h b/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
deleted file mode 100644
index 72ad59f..0000000
--- a/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg.h
- *
- * Copyright 2009 Samsung Electronic
- *
- * S5PC1XX Platform - GPIO pin configuration
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* This file contains the necessary definitions to get the basic gpio
- * pin configuration done such as setting a pin to input or output or
- * changing the pull-{up,down} configurations.
- */
-
-#ifndef __GPIO_CFG_S5PC1XX_H
-#define __GPIO_CFG_S5PC1XX_H __FILE__
-
-typedef unsigned int __bitwise__ s5p_gpio_drvstr_t;
-
-#define S5P_GPIO_DRVSTR_LV1	0x00
-#define S5P_GPIO_DRVSTR_LV2	0x01
-#define S5P_GPIO_DRVSTR_LV3	0x10
-#define S5P_GPIO_DRVSTR_LV4	0x11
-
-extern s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin, unsigned int off);
-
-extern int s5p_gpio_set_drvstr(unsigned int pin, unsigned int off,
-			s5p_gpio_drvstr_t drvstr);
-
-#endif /* __GPIO_CFG_S5PC1XX_H */
diff --git a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c b/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
index 1a63768..b02c36f 100644
--- a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
+++ b/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
@@ -19,7 +19,6 @@
 #include <mach/map.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-s5pc1xx.h>
 
 #define DISR_OFFSET	0x7008
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 287e6f7..6ccfd60 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -90,12 +90,6 @@ config S3C_GPIO_CFG_S3C64XX
 	  Internal configuration to enable S3C64XX style GPIO configuration
 	  functions.
 
-config S5P_GPIO_CFG_S5PC1XX
-	bool
-	help
-	  Internal configuration to enable S5PC1XX style GPIO configuration
-	  functions.
-
 config S3C_GPIO_PULL_UPDOWN
 	bool
 	help
@@ -111,6 +105,12 @@ config S3C_GPIO_PULL_UP
 	help
 	  Internal configuration to enable the correct GPIO pull helper
 
+config S5P_GPIO_DRVSTR
+	bool
+	help
+	  Internal configuration to get and set correct GPIO driver strength
+	  helper
+
 config SAMSUNG_GPIO_EXTRA
 	int "Number of additional GPIO pins"
 	default 0
diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
index 3282db3..d0e67a2 100644
--- a/arch/arm/plat-samsung/gpio-config.c
+++ b/arch/arm/plat-samsung/gpio-config.c
@@ -261,3 +261,51 @@ s3c_gpio_pull_t s3c_gpio_getpull_1up(struct s3c_gpio_chip *chip,
 }
 #endif /* CONFIG_S3C_GPIO_PULL_UP */
 
+#ifdef CONFIG_S5P_GPIO_DRVSTR
+s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned int off;
+	void __iomem *reg;
+	int shift;
+	u32 drvstr;
+
+	if (!chip)
+		return -EINVAL;
+
+	off = chip->chip.base - pin;
+	shift = off * 2;
+	reg = chip->base + 0x0C;
+
+	drvstr = __raw_readl(reg);
+	drvstr = 0xffff & (0x3 << shift);
+	drvstr = drvstr >> shift;
+
+	return (__force s5p_gpio_drvstr_t)drvstr;
+}
+EXPORT_SYMBOL(s5p_gpio_get_drvstr);
+
+int s5p_gpio_set_drvstr(unsigned int pin, s5p_gpio_drvstr_t drvstr)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	unsigned int off;
+	void __iomem *reg;
+	int shift;
+	u32 tmp;
+
+	if (!chip)
+		return -EINVAL;
+
+	off = chip->chip.base - pin;
+	shift = off * 2;
+	reg = chip->base + 0x0C;
+
+	tmp = __raw_readl(reg);
+	tmp |= drvstr << shift;
+
+	__raw_writel(tmp, reg);
+
+	return 0;
+}
+EXPORT_SYMBOL(s5p_gpio_set_drvstr);
+#endif	/* CONFIG_S5P_GPIO_DRVSTR */
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index 8d01e85..34efdd2 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -25,6 +25,7 @@
 #define __PLAT_GPIO_CFG_H __FILE__
 
 typedef unsigned int __bitwise__ s3c_gpio_pull_t;
+typedef unsigned int __bitwise__ s5p_gpio_drvstr_t;
 
 /* forward declaration if gpio-core.h hasn't been included */
 struct s3c_gpio_chip;
@@ -118,4 +119,33 @@ extern int s3c_gpio_setpull(unsigned int pin, s3c_gpio_pull_t pull);
 */
 extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
 
+/* Define values for the drvstr available for each gpio pin.
+ *
+ * These values control the value of the output signal driver strength,
+ * configurable on most pins on the S5C series.
+ */
+#define S5P_GPIO_DRVSTR_LV1	((__force s5p_gpio_drvstr_t)0x00)
+#define S5P_GPIO_DRVSTR_LV2	((__force s5p_gpio_drvstr_t)0x01)
+#define S5P_GPIO_DRVSTR_LV3	((__force s5p_gpio_drvstr_t)0x10)
+#define S5P_GPIO_DRVSTR_LV4	((__force s5p_gpio_drvstr_t)0x11)
+
+/**
+ * s5c_gpio_get_drvstr() - get the driver streght value of a gpio pin
+ * @pin: The pin number to get the settings for
+ *
+ * Read the driver streght value for the specified pin.
+*/
+extern s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin);
+
+/**
+ * s3c_gpio_set_drvstr() - set the driver streght value of a gpio pin
+ * @pin: The pin number to configure the driver streght value
+ * @drvstr: The new value of the driver strength
+ *
+ * This function sets the driver strength value for the specified pin.
+ * It will return 0 if successfull, or a negative error code if the pin
+ * cannot support the requested setting.
+*/
+extern int s5p_gpio_set_drvstr(unsigned int pin, s5p_gpio_drvstr_t drvstr);
+
 #endif /* __PLAT_GPIO_CFG_H */
-- 
1.6.4
