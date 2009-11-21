From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 21 Nov 2009 16:59:21 +0100
Subject: [PATCH 6/8 v2] S3C: merge ADC drivers and add support for the S3C64xx
In-Reply-To: <4B06A8F4.5070307@gmail.com>
References: <b2e8f9f70911200404w12cc286fw3fa763c3e04fa1f9@mail.gmail.com>
	<200911201416.16299.anarsoul@gmail.com> <4B06A8F4.5070307@gmail.com>
Message-ID: <b2e8f9f70911210759u6f51c8e4g66714e7fd83cab70@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the S3C24xx ADC driver to plat-s3c and adds support
for the S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

---
 arch/arm/mach-s3c6400/include/mach/map.h  |    1 +
 arch/arm/plat-s3c/Kconfig                 |    9 +++++
 arch/arm/plat-s3c/Makefile                |    4 ++
 arch/arm/{plat-s3c24xx => plat-s3c}/adc.c |   21 +++++++++--
 arch/arm/plat-s3c/include/plat/adc.h      |    6 +++-
 arch/arm/plat-s3c/include/plat/regs-adc.h |    2 +
 arch/arm/plat-s3c24xx/Kconfig             |    7 ----
 arch/arm/plat-s3c24xx/Makefile            |    1 -
 arch/arm/plat-s3c24xx/devs.c              |   14 ++++++--
 arch/arm/plat-s3c64xx/Makefile            |    4 ++
 arch/arm/plat-s3c64xx/dev-adc.c           |   51 +++++++++++++++++++++++++++++
 11 files changed, 103 insertions(+), 17 deletions(-)
 rename arch/arm/{plat-s3c24xx => plat-s3c}/adc.c (96%)
 create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..b66bfaf 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -42,6 +42,7 @@
 #define S3C64XX_PA_FB		(0x77100000)
 #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
 #define S3C64XX_PA_WATCHDOG	(0x7E004000)
+#define S3C64XX_PA_ADC		(0x7E00B000)
 #define S3C64XX_PA_SYSCON	(0x7E00F000)
 #define S3C64XX_PA_AC97		(0x7F001000)
 #define S3C64XX_PA_IIS0		(0x7F002000)
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 8931c5f..82ed66d 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -166,6 +166,15 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core

+# ADC
+
+config S3C_ADC
+	bool "ADC common driver support"
+	help
+	  Core support for the ADC block found in the S3C SoC systems
+	  for drivers such as the touchscreen and hwmon to use to share
+	  this resource.
+
 # device definitions to compile in

 config S3C_DEV_HSMMC
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 3c09109..788056a 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -22,6 +22,10 @@ obj-y				+= gpio-config.o

 obj-$(CONFIG_S3C_DMA)		+= dma.o

+# ADC support
+
+obj-$(CONFIG_S3C_ADC)		+= adc.o
+
 # PM support

 obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c/adc.c
similarity index 96%
rename from arch/arm/plat-s3c24xx/adc.c
rename to arch/arm/plat-s3c/adc.c
index df47322..76cb740 100644
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
@@ -64,6 +64,7 @@ struct adc_device {
 	unsigned int		 prescale;

 	int			 irq;
+	struct s3c_adc_platdata* pd;
 };

 static struct adc_device *adc_dev;
@@ -262,7 +263,7 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)

 	if (!client) {
 		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
-		return IRQ_HANDLED;
+		goto exit;
 	}

 	data0 = readl(adc->regs + S3C2410_ADCDAT0);
@@ -289,16 +290,27 @@ static irqreturn_t s3c_adc_irq(int irq, void *pw)
 		local_irq_restore(flags);
 	}

+exit:
+	if(adc->pd->adc_type == 1)
+		writel(0, adc->regs + S3C6410_ADCCLRI);
+
 	return IRQ_HANDLED;
 }

 static int s3c_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct s3c_adc_platdata *pd;
 	struct adc_device *adc;
 	struct resource *regs;
 	int ret;

+	pd = pdev->dev.platform_data;
+	if (!pd) {
+		dev_err(dev, "no platform data specified\n");
+		return -EINVAL;
+	}
+
 	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
 	if (adc == NULL) {
 		dev_err(dev, "failed to allocate adc_device\n");
@@ -306,6 +318,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	}

 	adc->pdev = pdev;
+	adc->pd = pd;
 	adc->prescale = S3C2410_ADCCON_PRSCVL(49);

 	adc->irq = platform_get_irq(pdev, 1);
@@ -412,7 +425,7 @@ static int s3c_adc_resume(struct platform_device *pdev)

 static struct platform_driver s3c_adc_driver = {
 	.driver		= {
-		.name	= "s3c24xx-adc",
+		.name	= "s3c-adc",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= s3c_adc_probe,
diff --git a/arch/arm/plat-s3c/include/plat/adc.h
b/arch/arm/plat-s3c/include/plat/adc.h
index 5f3b1cd..a8c9f27 100644
--- a/arch/arm/plat-s3c/include/plat/adc.h
+++ b/arch/arm/plat-s3c/include/plat/adc.h
@@ -4,7 +4,7 @@
  *	http://armlinux.simnte.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C24XX ADC driver information
+ * S3C ADC driver information
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +14,10 @@
 #ifndef __ASM_PLAT_ADC_H
 #define __ASM_PLAT_ADC_H __FILE__

+struct s3c_adc_platdata {
+	int adc_type;
+};
+
 struct s3c_adc_client;

 extern int s3c_adc_start(struct s3c_adc_client *client,
diff --git a/arch/arm/plat-s3c/include/plat/regs-adc.h
b/arch/arm/plat-s3c/include/plat/regs-adc.h
index 4323ccc..933ba79 100644
--- a/arch/arm/plat-s3c/include/plat/regs-adc.h
+++ b/arch/arm/plat-s3c/include/plat/regs-adc.h
@@ -19,6 +19,8 @@
 #define S3C2410_ADCDLY	   S3C2410_ADCREG(0x08)
 #define S3C2410_ADCDAT0	   S3C2410_ADCREG(0x0C)
 #define S3C2410_ADCDAT1	   S3C2410_ADCREG(0x10)
+#define S3C6410_ADCCLRI	   S3C2410_ADCREG(0x18)
+#define S3C6410_ADCCIDU	   S3C2410_ADCREG(0x20)


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
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index f52a92c..1b131e3 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -33,6 +33,7 @@
 #include <plat/regs-serial.h>
 #include <plat/udc.h>

+#include <plat/adc.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-spi.h>
@@ -321,11 +322,16 @@ static struct resource s3c_adc_resource[] = {

 };

+static struct s3c_adc_platdata s3c_adc_pdata = {
+	.adc_type	= 0,
+};
+
 struct platform_device s3c_device_adc = {
-	.name		  = "s3c24xx-adc",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_adc_resource),
-	.resource	  = s3c_adc_resource,
+	.name		   = "s3c-adc",
+	.id		   = -1,
+	.num_resources	   = ARRAY_SIZE(s3c_adc_resource),
+	.resource	   = s3c_adc_resource,
+	.dev.platform_data = &s3c_adc_pdata,
 };

 /* HWMON */
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index b85b435..8060017 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -35,6 +35,10 @@ obj-$(CONFIG_PM)		+= irq-pm.o

 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o

+# ADC support
+
+obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
+
 # Device setup

 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
diff --git a/arch/arm/plat-s3c64xx/dev-adc.c b/arch/arm/plat-s3c64xx/dev-adc.c
new file mode 100644
index 0000000..5861ab3
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/dev-adc.c
@@ -0,0 +1,51 @@
+/* linux/arch/arm/plat-s3c64xx/dev-adc.c
+ *
+ * Copyright 2009 Maurus Cuelenaere
+ *
+ * S3C64xx series device definition for ADC device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/adc.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_ADC,
+		.end   = S3C64XX_PA_ADC + SZ_256 - 1,
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
+	},
+};
+
+static struct s3c_adc_platdata s3c_adc_pdata = {
+	.adc_type	= 1,
+};
+
+struct platform_device s3c_device_adc = {
+	.name			= "s3c-adc",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(s3c_adc_resource),
+	.resource		= s3c_adc_resource,
+	.dev.platform_data	= &s3c_adc_pdata,
+};
-- 
1.6.5.3
