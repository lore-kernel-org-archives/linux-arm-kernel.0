From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:26 +0100
Subject: [PATCH 08/21] ARM: S5PC1XX: move s5pc100 specific device helpers to
	mach-s5pc100 dir
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-9-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

All device helpers that are defined in plat-s5pc1xx are S5PC100
specific. This patch moves them to mach-s5pc100 directory to make use of
newly created sub-platform support.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |   32 ++++++++++--
 arch/arm/mach-s5pc100/Makefile           |    4 ++
 arch/arm/mach-s5pc100/setup-fb-24bpp.c   |   49 +++++++++++++++++
 arch/arm/mach-s5pc100/setup-i2c0.c       |   30 ++++++++++
 arch/arm/mach-s5pc100/setup-i2c1.c       |   30 ++++++++++
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c |   86 ++++++++++++++++++++++++++++++
 arch/arm/plat-s5pc1xx/Kconfig            |   24 --------
 arch/arm/plat-s5pc1xx/Makefile           |    4 --
 arch/arm/plat-s5pc1xx/setup-fb-24bpp.c   |   49 -----------------
 arch/arm/plat-s5pc1xx/setup-i2c0.c       |   30 ----------
 arch/arm/plat-s5pc1xx/setup-i2c1.c       |   30 ----------
 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c |   86 ------------------------------
 12 files changed, 227 insertions(+), 227 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/setup-fb-24bpp.c
 create mode 100644 arch/arm/mach-s5pc100/setup-i2c0.c
 create mode 100644 arch/arm/mach-s5pc100/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pc100/setup-sdhci-gpio.c
 delete mode 100644 arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
 delete mode 100644 arch/arm/plat-s5pc1xx/setup-i2c0.c
 delete mode 100644 arch/arm/plat-s5pc1xx/setup-i2c1.c
 delete mode 100644 arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index c393ae6..21d5cdd 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -12,12 +12,36 @@ config CPU_S5PC100
 	help
 	  Enable S5PC100 CPU support
 
+config S5PC100_SETUP_FB_24BPP
+	bool
+	help
+          Common setup code for S5PC1XX with an 24bpp RGB display helper.
+
+config S5PC100_SETUP_I2C0
+	bool
+	default y
+	help
+	  Common setup code for i2c bus 0.
+
+	  Note, currently since i2c0 is always compiled, this setup helper
+	  is always compiled with it.
+
+config S5PC100_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
 config S5PC100_SETUP_SDHCI
         bool
-        select S5PC1XX_SETUP_SDHCI_GPIO
+        select S5PC100_SETUP_SDHCI_GPIO
         help
           Internal helper functions for S5PC100 based SDHCI systems
 
+config S5PC100_SETUP_SDHCI_GPIO
+	bool
+	help
+	  Common setup code for SDHCI gpio.
+
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
@@ -26,9 +50,9 @@ config MACH_SMDKC100
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
-	select S5PC1XX_SETUP_I2C0
-	select S5PC1XX_SETUP_I2C1
-	select S5PC1XX_SETUP_FB_24BPP
+	select S5PC100_SETUP_I2C0
+	select S5PC100_SETUP_I2C1
+	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 8d29ea1..b0664ce 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -19,7 +19,11 @@ obj-$(CONFIG_CPU_S5PC100)	+= uarts.o
 
 # Helper and device support
 
+obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PC100_SETUP_I2C0)	+= setup-i2c0.o
+obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)       += setup-sdhci.o
+obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
 obj-$(CONFIG_MACH_SMDKC100)	+= mach-smdkc100.o
diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
new file mode 100644
index 0000000..1a63768
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -0,0 +1,49 @@
+/*
+ * linux/arch/arm/plat-s5pc100/setup-fb-24bpp.c
+ *
+ * Copyright 2009 Samsung Electronics
+ *
+ * Base S5PC1XX setup information for 24bpp LCD framebuffer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/fb.h>
+#include <linux/gpio.h>
+
+#include <mach/regs-fb.h>
+#include <mach/map.h>
+#include <plat/fb.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-s5pc1xx.h>
+
+#define DISR_OFFSET	0x7008
+
+void s5pc100_fb_gpio_setup_24bpp(void)
+{
+	unsigned int gpio = 0;
+
+	for (gpio = S5PC100_GPF0(0); gpio <= S5PC100_GPF0(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	for (gpio = S5PC100_GPF1(0); gpio <= S5PC100_GPF1(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	for (gpio = S5PC100_GPF2(0); gpio <= S5PC100_GPF2(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	for (gpio = S5PC100_GPF3(0); gpio <= S5PC100_GPF3(3); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
diff --git a/arch/arm/mach-s5pc100/setup-i2c0.c b/arch/arm/mach-s5pc100/setup-i2c0.c
new file mode 100644
index 0000000..5e4a7c3
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-i2c0.c
@@ -0,0 +1,30 @@
+/* linux/arch/arm/plat-s5pc1xx/setup-i2c0.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Base S5PC1XX I2C bus 0 gpio configuration
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
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pc100/setup-i2c1.c b/arch/arm/mach-s5pc100/setup-i2c1.c
new file mode 100644
index 0000000..a0a8b4a
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-i2c1.c
@@ -0,0 +1,30 @@
+/* linux/arch/arm/plat-s3c64xx/setup-i2c1.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Base S5PC1XX I2C bus 1 gpio configuration
+ *
+ * Based on plat-s3c64xx/setup-i2c1.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PC100_GPD(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(5), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPD(6), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPD(6), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
new file mode 100644
index 0000000..185c894
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -0,0 +1,86 @@
+/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
+ *
+ * Copyright 2009 Samsung Eletronics
+ *
+ * S5PC1XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/regs-sdhci.h>
+
+void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+	unsigned int num;
+
+	num = width;
+	/* In case of 8 width, we should decrease the 2 */
+	if (width == 8)
+		num = width - 2;
+
+	end = S5PC100_GPG0(2 + num);
+
+	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
+	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	if (width == 8) {
+		for (gpio = S5PC100_GPG1(0); gpio <= S5PC100_GPG1(1); gpio++) {
+			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		}
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG1(2), S3C_GPIO_SFN(2));
+}
+
+void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S5PC100_GPG2(2 + width);
+
+	/* Set all the necessary GPG2 pins to special-function 2 */
+	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
+}
+
+void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S5PC100_GPG3(2 + width);
+
+	/* Set all the necessary GPG3 pins to special-function 2 */
+	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
+}
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 33a3e79..10c9130 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -38,28 +38,4 @@ endchoice
 
 # platform specific device setup
 
-config S5PC1XX_SETUP_FB_24BPP
-	bool
-	help
-          Common setup code for S5PC1XX with an 24bpp RGB display helper.
-
-config S5PC1XX_SETUP_I2C0
-	bool
-	default y
-	help
-	  Common setup code for i2c bus 0.
-
-	  Note, currently since i2c0 is always compiled, this setup helper
-	  is always compiled with it.
-
-config S5PC1XX_SETUP_I2C1
-	bool
-	help
-	  Common setup code for i2c bus 1.
-
-config S5PC1XX_SETUP_SDHCI_GPIO
-	bool
-	help
-	  Common setup code for SDHCI gpio.
-
 endif
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 39dd0a1..ad187b2 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -21,7 +21,3 @@ obj-y				+= gpiolib.o
 # Device setup
 
 obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
-obj-$(CONFIG_S5PC1XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
-obj-$(CONFIG_S5PC1XX_SETUP_I2C0) += setup-i2c0.o
-obj-$(CONFIG_S5PC1XX_SETUP_I2C1) += setup-i2c1.o
-obj-$(CONFIG_S5PC1XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c b/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
deleted file mode 100644
index 1a63768..0000000
--- a/arch/arm/plat-s5pc1xx/setup-fb-24bpp.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * linux/arch/arm/plat-s5pc100/setup-fb-24bpp.c
- *
- * Copyright 2009 Samsung Electronics
- *
- * Base S5PC1XX setup information for 24bpp LCD framebuffer
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/fb.h>
-#include <linux/gpio.h>
-
-#include <mach/regs-fb.h>
-#include <mach/map.h>
-#include <plat/fb.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-s5pc1xx.h>
-
-#define DISR_OFFSET	0x7008
-
-void s5pc100_fb_gpio_setup_24bpp(void)
-{
-	unsigned int gpio = 0;
-
-	for (gpio = S5PC100_GPF0(0); gpio <= S5PC100_GPF0(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S5PC100_GPF1(0); gpio <= S5PC100_GPF1(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S5PC100_GPF2(0); gpio <= S5PC100_GPF2(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S5PC100_GPF3(0); gpio <= S5PC100_GPF3(3); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-}
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c0.c b/arch/arm/plat-s5pc1xx/setup-i2c0.c
deleted file mode 100644
index 5e4a7c3..0000000
--- a/arch/arm/plat-s5pc1xx/setup-i2c0.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/setup-i2c0.c
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * Base S5PC1XX I2C bus 0 gpio configuration
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <plat/iic.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgpin(S5PC100_GPD(3), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(3), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPD(4), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(4), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/plat-s5pc1xx/setup-i2c1.c b/arch/arm/plat-s5pc1xx/setup-i2c1.c
deleted file mode 100644
index a0a8b4a..0000000
--- a/arch/arm/plat-s5pc1xx/setup-i2c1.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/setup-i2c1.c
- *
- * Copyright 2009 Samsung Electronics Co.
- *	Byungho Min <bhmin@samsung.com>
- *
- * Base S5PC1XX I2C bus 1 gpio configuration
- *
- * Based on plat-s3c64xx/setup-i2c1.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <linux/gpio.h>
-#include <plat/iic.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c1_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgpin(S5PC100_GPD(5), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPD(6), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PC100_GPD(6), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c b/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
deleted file mode 100644
index 185c894..0000000
--- a/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/setup-sdhci-gpio.c
- *
- * Copyright 2009 Samsung Eletronics
- *
- * S5PC1XX - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/card.h>
-
-#include <plat/gpio-cfg.h>
-#include <plat/regs-sdhci.h>
-
-void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
-{
-	unsigned int gpio;
-	unsigned int end;
-	unsigned int num;
-
-	num = width;
-	/* In case of 8 width, we should decrease the 2 */
-	if (width == 8)
-		num = width - 2;
-
-	end = S5PC100_GPG0(2 + num);
-
-	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
-	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	if (width == 8) {
-		for (gpio = S5PC100_GPG1(0); gpio <= S5PC100_GPG1(1); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
-	}
-
-	s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG1(2), S3C_GPIO_SFN(2));
-}
-
-void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
-{
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S5PC100_GPG2(2 + width);
-
-	/* Set all the necessary GPG2 pins to special-function 2 */
-	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
-}
-
-void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
-{
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S5PC100_GPG3(2 + width);
-
-	/* Set all the necessary GPG3 pins to special-function 2 */
-	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
-}
-- 
1.6.4
