From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Mon, 19 Nov 2012 21:34:22 +0100
Subject: [PATCH] ARM: SAMSUNG: Add s3c24xx/s3c64xx CAMIF GPIO setup helpers
Message-ID: <1353357262-18935-1-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds default helper functions for the camera port
pin configuration. Whenever pinctrl support for s3c24xx/s3c64xx
SoCs is available these code should be removed and proper pinctrl
API should be used in the CAMIF driver.

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/Kconfig       |    1 +
 arch/arm/plat-samsung/Kconfig       |    5 ++
 arch/arm/plat-samsung/Makefile      |    1 +
 arch/arm/plat-samsung/setup-camif.c |   70 +++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/setup-camif.c

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 2b6cb5f..01f70c9 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -405,6 +405,7 @@ config MACH_MINI2440
 	select NEW_LEDS
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
+	select S3C_SETUP_CAMIF
 	help
 	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
 	  available via various sources. It can come with a 3.5" or 7" touch LCD.
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 59401e1..95360e6 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -414,6 +414,11 @@ config S5P_SETUP_MIPIPHY
 	help
 	  Compile in common setup code for MIPI-CSIS and MIPI-DSIM devices
 
+config S3C_SETUP_CAMIF
+	bool
+	help
+	  Compile in common setup code for S3C CAMIF devices
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 9e40e8d..3a7c64d 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
 
+obj-$(CONFIG_S3C_SETUP_CAMIF)	+= setup-camif.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
 
 # DMA support
diff --git a/arch/arm/plat-samsung/setup-camif.c b/arch/arm/plat-samsung/setup-camif.c
new file mode 100644
index 0000000..e01bf76
--- /dev/null
+++ b/arch/arm/plat-samsung/setup-camif.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2012 Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
+ *
+ * Helper functions for S3C24XX/S3C64XX SoC series CAMIF driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
+
+/* Number of camera port pins, without FIELD */
+#define S3C_CAMIF_NUM_GPIOS	13
+
+/* Default camera port configuration helpers. */
+
+static void camif_get_gpios(int *gpio_start, int *gpio_reset)
+{
+#ifdef CONFIG_ARCH_S3C24XX
+	*gpio_start = S3C2410_GPJ(0);
+	*gpio_reset = S3C2410_GPJ(12);
+#else
+	/* s3c64xx */
+	*gpio_start = S3C64XX_GPF(0);
+	*gpio_reset = S3C64XX_GPF(3);
+#endif
+}
+
+int s3c_camif_gpio_get(void)
+{
+	int gpio_start, gpio_reset;
+	int ret, i;
+
+	camif_get_gpios(&gpio_start, &gpio_reset);
+
+	for (i = 0; i < S3C_CAMIF_NUM_GPIOS; i++) {
+		int gpio = gpio_start + i;
+
+		if (gpio == gpio_reset)
+			continue;
+
+		ret = gpio_request(gpio, "camif");
+		if (!ret)
+			ret = s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		if (ret) {
+			pr_err("failed to configure GPIO %d\n", gpio);
+			for (--i; i >= 0; i--)
+				gpio_free(gpio--);
+			return ret;
+		}
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	return 0;
+}
+
+void s3c_camif_gpio_put(void)
+{
+	int i, gpio_start, gpio_reset;
+
+	camif_get_gpios(&gpio_start, &gpio_reset);
+
+	for (i = 0; i < S3C_CAMIF_NUM_GPIOS; i++) {
+		int gpio = gpio_start + i;
+		if (gpio != gpio_reset)
+			gpio_free(gpio);
+	}
+}
-- 
1.7.4.1
