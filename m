From: banajit.g@samsung.com (Banajit Goswami)
Date: Sat, 26 Feb 2011 13:29:01 +0900
Subject: [PATCH 1/6] ARM: SAMSUNG: Move PWM device definition from
	plat-s3c24xx to plat-samsung
In-Reply-To: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
References: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1298694546-16816-2-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following:
1. It moves file pwm.c from plat-s3c24xx to plat-samsung. This will
   enable all machines with Samsung SoCs to make use of the same code.
2. The device definitions have been separated to a new file dev-pwm.c
   for better clarity and structure.
3. It will enable all Samsung S3C and S5P series SoC's to use common
   PWM Kconfig definition.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig   |    4 +-
 arch/arm/plat-s3c24xx/Kconfig   |    7 -----
 arch/arm/plat-samsung/Kconfig   |   13 +++++++++
 arch/arm/plat-samsung/Makefile  |    1 +
 arch/arm/plat-samsung/dev-pwm.c |   52 +++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/pwm.c     |   33 ------------------------
 6 files changed, 68 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-pwm.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 579d2f0..f3a953f 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -231,7 +231,7 @@ config MACH_HMT
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
 	select S3C64XX_SETUP_FB_24BPP
-	select HAVE_PWM
+	select SAMSUNG_DEV_PWM
 	help
 	  Machine support for the Airgoo HMT
 
@@ -249,8 +249,8 @@ config MACH_SMARTQ
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_FB_24BPP
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
-	select HAVE_PWM
 	help
 	    Shared machine support for SmartQ 5/7
 
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index eb105e6..d9c4096 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -56,13 +56,6 @@ config S3C24XX_DCLK
 	help
 	  Clock code for supporting DCLK/CLKOUT on S3C24XX architectures
 
-config S3C24XX_PWM
-	bool "PWM device support"
-	select HAVE_PWM
-	help
-	  Support for exporting the PWM timer blocks via the pwm device
-	  system.
-
 # gpio configurations
 
 config S3C24XX_GPIO_EXTRA
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 32be05c..184a85a 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -273,6 +273,19 @@ config SAMSUNG_DEV_KEYPAD
 	help
 	  Compile in platform device definitions for keypad
 
+config SAMSUNG_DEV_PWM
+	bool
+	default y if ARCH_S3C2410
+	help
+	  Compile in platform device definition for PWM Timer
+
+config S3C24XX_PWM
+	bool "PWM device support"
+	select HAVE_PWM
+	help
+	  Support for exporting the PWM timer blocks via the pwm device
+	  system.
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 29932f8..e9de58a 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_IDE)	+= dev-ide.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
 obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)	+= dev-keypad.o
+obj-$(CONFIG_SAMSUNG_DEV_PWM)	+= dev-pwm.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-pwm.c b/arch/arm/plat-samsung/dev-pwm.c
new file mode 100644
index 0000000..68c5986
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-pwm.c
@@ -0,0 +1,53 @@
+/* linux/arch/arm/plat-samsung/dev-pwm.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Copyright (c) 2007 Ben Dooks
+ * Copyright (c) 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
+ *
+ * S3C series device definition for the PWM timer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+
+#include <plat/devs.h>
+
+#define TIMER_RESOURCE_SIZE (1)
+
+#define TIMER_RESOURCE(_tmr, _irq)			\
+	(struct resource [TIMER_RESOURCE_SIZE]) {	\
+		[0] = {					\
+			.start	= _irq,			\
+			.end	= _irq,			\
+			.flags	= IORESOURCE_IRQ	\
+		}					\
+	}
+
+#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
+	.name		= "s3c24xx-pwm",		\
+	.id		= _tmr_no,			\
+	.num_resources	= TIMER_RESOURCE_SIZE,		\
+	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
+
+/*
+ * since we already have an static mapping for the timer,
+ * we do not bother setting any IO resource for the base.
+ */
+
+struct platform_device s3c_device_timer[] = {
+	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
+	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
+	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
+	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
+	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
+};
+EXPORT_SYMBOL(s3c_device_timer);
diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index 2eeb49f..f37457c 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -20,10 +20,8 @@
 #include <linux/io.h>
 #include <linux/pwm.h>
 
-#include <mach/irqs.h>
 #include <mach/map.h>
 
-#include <plat/devs.h>
 #include <plat/regs-timer.h>
 
 struct pwm_device {
@@ -47,37 +45,6 @@ struct pwm_device {
 
 static struct clk *clk_scaler[2];
 
-/* Standard setup for a timer block. */
-
-#define TIMER_RESOURCE_SIZE (1)
-
-#define TIMER_RESOURCE(_tmr, _irq)			\
-	(struct resource [TIMER_RESOURCE_SIZE]) {	\
-		[0] = {					\
-			.start	= _irq,			\
-			.end	= _irq,			\
-			.flags	= IORESOURCE_IRQ	\
-		}					\
-	}
-
-#define DEFINE_S3C_TIMER(_tmr_no, _irq)			\
-	.name		= "s3c24xx-pwm",		\
-	.id		= _tmr_no,			\
-	.num_resources	= TIMER_RESOURCE_SIZE,		\
-	.resource	= TIMER_RESOURCE(_tmr_no, _irq),	\
-
-/* since we already have an static mapping for the timer, we do not
- * bother setting any IO resource for the base.
- */
-
-struct platform_device s3c_device_timer[] = {
-	[0] = { DEFINE_S3C_TIMER(0, IRQ_TIMER0) },
-	[1] = { DEFINE_S3C_TIMER(1, IRQ_TIMER1) },
-	[2] = { DEFINE_S3C_TIMER(2, IRQ_TIMER2) },
-	[3] = { DEFINE_S3C_TIMER(3, IRQ_TIMER3) },
-	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
-};
-
 static inline int pwm_is_tdiv(struct pwm_device *pwm)
 {
 	return clk_get_parent(pwm->clk) == pwm->clk_div;
-- 
1.6.5.2
