From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 20 Nov 2009 13:04:10 +0100
Subject: [PATCH 6/8] S3C: merge ADC drivers and add support for the S3C64xx
Message-ID: <b2e8f9f70911200404w12cc286fw3fa763c3e04fa1f9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the S3C24xx ADC driver to plat-s3c and adds support
for the S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-s3c/Kconfig                 |    7 +++++
 arch/arm/plat-s3c/Makefile                |    4 +++
 arch/arm/{plat-s3c24xx => plat-s3c}/adc.c |   17 +++++++++--
 arch/arm/plat-s3c/include/plat/regs-adc.h |    3 ++
 arch/arm/plat-s3c24xx/Kconfig             |    7 -----
 arch/arm/plat-s3c24xx/Makefile            |    1 -
 arch/arm/plat-s3c64xx/Makefile            |    1 +
 arch/arm/plat-s3c64xx/dev-adc.c           |   42 +++++++++++++++++++++++++++++
 8 files changed, 71 insertions(+), 11 deletions(-)
 rename arch/arm/{plat-s3c24xx => plat-s3c}/adc.c (95%)
 create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 57e685b..4184084 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -159,6 +159,13 @@ config S3C_GPIO_CFG_S3C64XX
 	  Internal configuration to enable S3C64XX style GPIO configuration
 	  functions.

+config S3C_ADC
+	bool "ADC common driver support"
+	help
+	  Core support for the ADC block found in the S3C SoC systems
+	  for drivers such as the touchscreen and hwmon to use to share
+	  this resource.
+
 # DMA

 config S3C_DMA
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 50444da..960fb43 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -32,6 +32,10 @@ obj-$(CONFIG_S3C2410_PM_CHECK)	+= pm-check.o

 obj-$(CONFIG_HAVE_PWM)		+= pwm.o

+# ADC support
+
+obj-$(CONFIG_S3C_ADC)		+= adc.o
+
 # devices

 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c/adc.c
similarity index 95%
rename from arch/arm/plat-s3c24xx/adc.c
rename to arch/arm/plat-s3c/adc.c
index df47322..572b7be 100644
--- a/arch/arm/plat-s3c24xx/adc.c
+++ b/arch/arm/plat-s3c/adc.c
@@ -1,10 +1,10 @@
-/* arch/arm/plat-s3c24xx/adc.c
+/* arch/arm/plat-s3c/adc.c
  *
  * Copyright (c) 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
  *
- * S3C24XX ADC device core
+ * S3C ADC device core
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,10 +72,18 @@ static LIST_HEAD(adc_pending);

 #define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)

+#define AUTOPST (S3C2410_ADCTSC_YM_SEN | S3C2410_ADCTSC_YP_SEN | \
+		S3C2410_ADCTSC_XP_SEN | S3C2410_ADCTSC_AUTO_PST | \
+		S3C2410_ADCTSC_XY_PST(0))
+
 static inline void s3c_adc_convert(struct adc_device *adc)
 {
 	unsigned con = readl(adc->regs + S3C2410_ADCCON);

+	if (adc->cur->is_ts)
+		writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST,
+			adc->regs + S3C2410_ADCTSC);
+
 	con |= S3C2410_ADCCON_ENABLE_START;
 	writel(con, adc->regs + S3C2410_ADCCON);
 }
@@ -260,6 +268,9 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 	unsigned long flags;
 	unsigned data0, data1;

+	/* Clear ADC interrupt */
+	__raw_writel(0x0, adc->regs + S3C6400_ADCCLRINT);
+
 	if (!client) {
 		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
 		return IRQ_HANDLED;
@@ -412,7 +423,7 @@ static int s3c_adc_resume(struct platform_device *pdev)

 static struct platform_driver s3c_adc_driver = {
 	.driver		= {
-		.name	= "s3c24xx-adc",
+		.name	= "s3c-adc",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= s3c_adc_probe,
diff --git a/arch/arm/plat-s3c/include/plat/regs-adc.h
b/arch/arm/plat-s3c/include/plat/regs-adc.h
index 4323ccc..cd7d2a5 100644
--- a/arch/arm/plat-s3c/include/plat/regs-adc.h
+++ b/arch/arm/plat-s3c/include/plat/regs-adc.h
@@ -19,6 +19,9 @@
 #define S3C2410_ADCDLY	   S3C2410_ADCREG(0x08)
 #define S3C2410_ADCDAT0	   S3C2410_ADCREG(0x0C)
 #define S3C2410_ADCDAT1	   S3C2410_ADCREG(0x10)
+#define S3C6400_ADCUPDN	   S3C2410_ADCREG(0x14)
+#define S3C6400_ADCCLRINT  S3C2410_ADCREG(0x18)
+#define S3C6400_ADCCLRIPD  S3C2410_ADCREG(0x20)


 /* ADCCON Register Bits */
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 9c7aca4..c402ed9 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -119,13 +119,6 @@ config S3C2410_DMA_DEBUG
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.

-config S3C24XX_ADC
-	bool "ADC common driver support"
-	help
-	  Core support for the ADC block found in the S3C24XX SoC systems
-	  for drivers such as the touchscreen and hwmon to use to share
-	  this resource.
-
 # SPI default pin configuration code

 config S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 7780d2d..a2cb87b 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
-obj-$(CONFIG_S3C24XX_ADC)	+= adc.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index b85b435..a8c5d17 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core files

 obj-y				+= dev-uart.o
+obj-y				+= dev-adc.o
 obj-y				+= cpu.o
 obj-y				+= irq.o
 obj-y				+= irq-eint.o
diff --git a/arch/arm/plat-s3c64xx/dev-adc.c b/arch/arm/plat-s3c64xx/dev-adc.c
new file mode 100644
index 0000000..8cff72e
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/dev-adc.c
@@ -0,0 +1,42 @@
+/* linux/arch/arm/plat-s3c64xx/dev-adc.c
+ *
+ * Copyright 2009 by Maurus Cuelenaere <mcuelenaere@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_ADC,
+		.end   = S3C64XX_PA_ADC + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = IRQ_ADC,
+		.end   = IRQ_ADC,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_adc = {
+	.name		  = "s3c-adc",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(s3c_adc_resource),
+	.resource	  = s3c_adc_resource,
+};
-- 
1.6.5.3
