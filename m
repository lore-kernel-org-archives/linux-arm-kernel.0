From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:57:47 +0200
Subject: [PATCH 2/7] pinctrl/coh901: retire ancient GPIO block versions
Message-ID: <1344859067-29332-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

As the non-U335 U300 variants are retired from the ARM tree,
also delete the pinctrl driver codepaths for these variants.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c                   |   1 -
 arch/arm/mach-u300/include/mach/gpio-u300.h |  13 +-
 drivers/pinctrl/pinctrl-coh901.c            | 218 ++++++----------------------
 3 files changed, 43 insertions(+), 189 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 1794075..883d5c2 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1440,7 +1440,6 @@ static struct platform_device pinctrl_device = {
  * GPIO block, with different number of ports.
  */
 static struct u300_gpio_platform u300_gpio_plat = {
-	.variant = U300_GPIO_COH901571_3_BS335,
 	.ports = 7,
 	.gpio_base = 0,
 	.gpio_irq_base = IRQ_U300_GPIO_BASE,
diff --git a/arch/arm/mach-u300/include/mach/gpio-u300.h b/arch/arm/mach-u300/include/mach/gpio-u300.h
index e81400c..30dea25 100644
--- a/arch/arm/mach-u300/include/mach/gpio-u300.h
+++ b/arch/arm/mach-u300/include/mach/gpio-u300.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 ST-Ericsson AB
+ * Copyright (C) 2007-2012 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  * GPIO block resgister definitions and inline macros for
  * U300 GPIO COH 901 335 or COH 901 571/3
@@ -10,24 +10,13 @@
 #define __MACH_U300_GPIO_U300_H
 
 /**
- * enum u300_gpio_variant - the type of U300 GPIO employed
- */
-enum u300_gpio_variant {
-	U300_GPIO_COH901335,
-	U300_GPIO_COH901571_3_BS335,
-	U300_GPIO_COH901571_3_BS365,
-};
-
-/**
  * struct u300_gpio_platform - U300 GPIO platform data
- * @variant: IP block variant
  * @ports: number of GPIO block ports
  * @gpio_base: first GPIO number for this block (use a free range)
  * @gpio_irq_base: first GPIO IRQ number for this block (use a free range)
  * @pinctrl_device: pin control device to spawn as child
  */
 struct u300_gpio_platform {
-	enum u300_gpio_variant variant;
 	u8 ports;
 	int gpio_base;
 	int gpio_irq_base;
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index cc0f00d..91a5dc7 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -1,11 +1,8 @@
 /*
  * U300 GPIO module.
  *
- * Copyright (C) 2007-2011 ST-Ericsson AB
+ * Copyright (C) 2007-2012 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
- * This can driver either of the two basic GPIO cores
- * available in the U300 platforms:
- * COH 901 335   - Used in DB3150 (U300 1.0) and DB3200 (U330 1.0)
  * COH 901 571/3 - Used in DB3210 (U365 2.0) and DB3350 (U335 1.0)
  * Author: Linus Walleij <linus.walleij@linaro.org>
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
@@ -27,16 +24,19 @@
 #include <mach/gpio-u300.h>
 #include "pinctrl-coh901.h"
 
+#define U300_GPIO_PORT_STRIDE				(0x30)
 /*
- * Register definitions for COH 901 335 variant
+ * Control Register 32bit (R/W)
+ * bit 15-9 (mask 0x0000FE00) contains the number of cores. 8*cores
+ * gives the number of GPIO pins.
+ * bit 8-2  (mask 0x000001FC) contains the core version ID.
  */
-#define U300_335_PORT_STRIDE				(0x1C)
-/* Port X Pin Data Register 32bit, this is both input and output (R/W) */
-#define U300_335_PXPDIR					(0x00)
-#define U300_335_PXPDOR					(0x00)
-/* Port X Pin Config Register 32bit (R/W) */
-#define U300_335_PXPCR					(0x04)
-/* This register layout is the same in both blocks */
+#define U300_GPIO_CR					(0x00)
+#define U300_GPIO_CR_SYNC_SEL_ENABLE			(0x00000002UL)
+#define U300_GPIO_CR_BLOCK_CLKRQ_ENABLE			(0x00000001UL)
+#define U300_GPIO_PXPDIR				(0x04)
+#define U300_GPIO_PXPDOR				(0x08)
+#define U300_GPIO_PXPCR					(0x0C)
 #define U300_GPIO_PXPCR_ALL_PINS_MODE_MASK		(0x0000FFFFUL)
 #define U300_GPIO_PXPCR_PIN_MODE_MASK			(0x00000003UL)
 #define U300_GPIO_PXPCR_PIN_MODE_SHIFT			(0x00000002UL)
@@ -44,53 +44,17 @@
 #define U300_GPIO_PXPCR_PIN_MODE_OUTPUT_PUSH_PULL	(0x00000001UL)
 #define U300_GPIO_PXPCR_PIN_MODE_OUTPUT_OPEN_DRAIN	(0x00000002UL)
 #define U300_GPIO_PXPCR_PIN_MODE_OUTPUT_OPEN_SOURCE	(0x00000003UL)
-/* Port X Interrupt Event Register 32bit (R/W) */
-#define U300_335_PXIEV					(0x08)
-/* Port X Interrupt Enable Register 32bit (R/W) */
-#define U300_335_PXIEN					(0x0C)
-/* Port X Interrupt Force Register 32bit (R/W) */
-#define U300_335_PXIFR					(0x10)
-/* Port X Interrupt Config Register 32bit (R/W) */
-#define U300_335_PXICR					(0x14)
-/* This register layout is the same in both blocks */
+#define U300_GPIO_PXPER					(0x10)
+#define U300_GPIO_PXPER_ALL_PULL_UP_DISABLE_MASK	(0x000000FFUL)
+#define U300_GPIO_PXPER_PULL_UP_DISABLE			(0x00000001UL)
+#define U300_GPIO_PXIEV					(0x14)
+#define U300_GPIO_PXIEN					(0x18)
+#define U300_GPIO_PXIFR					(0x1C)
+#define U300_GPIO_PXICR					(0x20)
 #define U300_GPIO_PXICR_ALL_IRQ_CONFIG_MASK		(0x000000FFUL)
 #define U300_GPIO_PXICR_IRQ_CONFIG_MASK			(0x00000001UL)
 #define U300_GPIO_PXICR_IRQ_CONFIG_FALLING_EDGE		(0x00000000UL)
 #define U300_GPIO_PXICR_IRQ_CONFIG_RISING_EDGE		(0x00000001UL)
-/* Port X Pull-up Enable Register 32bit (R/W) */
-#define U300_335_PXPER					(0x18)
-/* This register layout is the same in both blocks */
-#define U300_GPIO_PXPER_ALL_PULL_UP_DISABLE_MASK	(0x000000FFUL)
-#define U300_GPIO_PXPER_PULL_UP_DISABLE			(0x00000001UL)
-/* Control Register 32bit (R/W) */
-#define U300_335_CR					(0x54)
-#define U300_335_CR_BLOCK_CLOCK_ENABLE			(0x00000001UL)
-
-/*
- * Register definitions for COH 901 571 / 3 variant
- */
-#define U300_571_PORT_STRIDE				(0x30)
-/*
- * Control Register 32bit (R/W)
- * bit 15-9 (mask 0x0000FE00) contains the number of cores. 8*cores
- * gives the number of GPIO pins.
- * bit 8-2  (mask 0x000001FC) contains the core version ID.
- */
-#define U300_571_CR					(0x00)
-#define U300_571_CR_SYNC_SEL_ENABLE			(0x00000002UL)
-#define U300_571_CR_BLOCK_CLKRQ_ENABLE			(0x00000001UL)
-/*
- * These registers have the same layout and function as the corresponding
- * COH 901 335 registers, just at different offset.
- */
-#define U300_571_PXPDIR					(0x04)
-#define U300_571_PXPDOR					(0x08)
-#define U300_571_PXPCR					(0x0C)
-#define U300_571_PXPER					(0x10)
-#define U300_571_PXIEV					(0x14)
-#define U300_571_PXIEN					(0x18)
-#define U300_571_PXIFR					(0x1C)
-#define U300_571_PXICR					(0x20)
 
 /* 8 bits per port, no version has more than 7 ports */
 #define U300_GPIO_PINS_PER_PORT 8
@@ -149,8 +113,6 @@ struct u300_gpio_confdata {
 
 /* BS335 has seven ports of 8 bits each = GPIO pins 0..55 */
 #define BS335_GPIO_NUM_PORTS 7
-/* BS365 has five ports of 8 bits each = GPIO pins 0..39 */
-#define BS365_GPIO_NUM_PORTS 5
 
 #define U300_FLOATING_INPUT { \
 	.bias_mode = PIN_CONFIG_BIAS_HIGH_IMPEDANCE, \
@@ -172,7 +134,6 @@ struct u300_gpio_confdata {
 	.outval = 1, \
 }
 
-
 /* Initial configuration */
 static const struct __initconst u300_gpio_confdata
 bs335_gpio_config[BS335_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
@@ -255,66 +216,6 @@ bs335_gpio_config[BS335_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
 	}
 };
 
-static const struct __initconst u300_gpio_confdata
-bs365_gpio_config[BS365_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
-	/* Port 0, pins 0-7 */
-	{
-		U300_FLOATING_INPUT,
-		U300_OUTPUT_LOW,
-		U300_FLOATING_INPUT,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-		U300_PULL_UP_INPUT,
-		U300_FLOATING_INPUT,
-	},
-	/* Port 1, pins 0-7 */
-	{
-		U300_OUTPUT_LOW,
-		U300_FLOATING_INPUT,
-		U300_OUTPUT_LOW,
-		U300_FLOATING_INPUT,
-		U300_FLOATING_INPUT,
-		U300_OUTPUT_HIGH,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-	},
-	/* Port 2, pins 0-7 */
-	{
-		U300_FLOATING_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-	},
-	/* Port 3, pins 0-7 */
-	{
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-	},
-	/* Port 4, pins 0-7 */
-	{
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		U300_PULL_UP_INPUT,
-		/* These 4 pins doesn't exist on DB3210 */
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-		U300_OUTPUT_LOW,
-	}
-};
-
 /**
  * to_u300_gpio() - get the pointer to u300_gpio
  * @chip: the gpio chip member of the structure u300_gpio
@@ -716,13 +617,7 @@ static void __init u300_gpio_init_coh901571(struct u300_gpio *gpio,
 			const struct u300_gpio_confdata *conf;
 			int offset = (i*8) + j;
 
-			if (plat->variant == U300_GPIO_COH901571_3_BS335)
-				conf = &bs335_gpio_config[i][j];
-			else if (plat->variant == U300_GPIO_COH901571_3_BS365)
-				conf = &bs365_gpio_config[i][j];
-			else
-				break;
-
+			conf = &bs335_gpio_config[i][j];
 			u300_gpio_init_pin(gpio, offset, conf);
 		}
 	}
@@ -796,50 +691,27 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 		goto err_no_ioremap;
 	}
 
-	if (plat->variant == U300_GPIO_COH901335) {
-		dev_info(gpio->dev,
-			 "initializing GPIO Controller COH 901 335\n");
-		gpio->stride = U300_335_PORT_STRIDE;
-		gpio->pcr = U300_335_PXPCR;
-		gpio->dor = U300_335_PXPDOR;
-		gpio->dir = U300_335_PXPDIR;
-		gpio->per = U300_335_PXPER;
-		gpio->icr = U300_335_PXICR;
-		gpio->ien = U300_335_PXIEN;
-		gpio->iev = U300_335_PXIEV;
-		ifr = U300_335_PXIFR;
-
-		/* Turn on the GPIO block */
-		writel(U300_335_CR_BLOCK_CLOCK_ENABLE,
-		       gpio->base + U300_335_CR);
-	} else if (plat->variant == U300_GPIO_COH901571_3_BS335 ||
-		   plat->variant == U300_GPIO_COH901571_3_BS365) {
-		dev_info(gpio->dev,
-			 "initializing GPIO Controller COH 901 571/3\n");
-		gpio->stride = U300_571_PORT_STRIDE;
-		gpio->pcr = U300_571_PXPCR;
-		gpio->dor = U300_571_PXPDOR;
-		gpio->dir = U300_571_PXPDIR;
-		gpio->per = U300_571_PXPER;
-		gpio->icr = U300_571_PXICR;
-		gpio->ien = U300_571_PXIEN;
-		gpio->iev = U300_571_PXIEV;
-		ifr = U300_571_PXIFR;
-
-		val = readl(gpio->base + U300_571_CR);
-		dev_info(gpio->dev, "COH901571/3 block version: %d, " \
-			 "number of cores: %d totalling %d pins\n",
-			 ((val & 0x000001FC) >> 2),
-			 ((val & 0x0000FE00) >> 9),
-			 ((val & 0x0000FE00) >> 9) * 8);
-		writel(U300_571_CR_BLOCK_CLKRQ_ENABLE,
-		       gpio->base + U300_571_CR);
-		u300_gpio_init_coh901571(gpio, plat);
-	} else {
-		dev_err(gpio->dev, "unknown block variant\n");
-		err = -ENODEV;
-		goto err_unknown_variant;
-	}
+	dev_info(gpio->dev,
+		 "initializing GPIO Controller COH 901 571/3\n");
+	gpio->stride = U300_GPIO_PORT_STRIDE;
+	gpio->pcr = U300_GPIO_PXPCR;
+	gpio->dor = U300_GPIO_PXPDOR;
+	gpio->dir = U300_GPIO_PXPDIR;
+	gpio->per = U300_GPIO_PXPER;
+	gpio->icr = U300_GPIO_PXICR;
+	gpio->ien = U300_GPIO_PXIEN;
+	gpio->iev = U300_GPIO_PXIEV;
+	ifr = U300_GPIO_PXIFR;
+
+	val = readl(gpio->base + U300_GPIO_CR);
+	dev_info(gpio->dev, "COH901571/3 block version: %d, " \
+		 "number of cores: %d totalling %d pins\n",
+		 ((val & 0x000001FC) >> 2),
+		 ((val & 0x0000FE00) >> 9),
+		 ((val & 0x0000FE00) >> 9) * 8);
+	writel(U300_GPIO_CR_BLOCK_CLKRQ_ENABLE,
+	       gpio->base + U300_GPIO_CR);
+	u300_gpio_init_coh901571(gpio, plat);
 
 	/* Add each port with its IRQ separately */
 	INIT_LIST_HEAD(&gpio->port_list);
@@ -906,7 +778,6 @@ err_no_pinctrl:
 err_no_chip:
 err_no_port:
 	u300_gpio_free_ports(gpio);
-err_unknown_variant:
 	iounmap(gpio->base);
 err_no_ioremap:
 	release_mem_region(gpio->memres->start, resource_size(gpio->memres));
@@ -923,16 +794,11 @@ err_no_clk:
 
 static int __exit u300_gpio_remove(struct platform_device *pdev)
 {
-	struct u300_gpio_platform *plat = dev_get_platdata(&pdev->dev);
 	struct u300_gpio *gpio = platform_get_drvdata(pdev);
 	int err;
 
 	/* Turn off the GPIO block */
-	if (plat->variant == U300_GPIO_COH901335)
-		writel(0x00000000U, gpio->base + U300_335_CR);
-	if (plat->variant == U300_GPIO_COH901571_3_BS335 ||
-	    plat->variant == U300_GPIO_COH901571_3_BS365)
-		writel(0x00000000U, gpio->base + U300_571_CR);
+	writel(0x00000000U, gpio->base + U300_GPIO_CR);
 
 	err = gpiochip_remove(&gpio->chip);
 	if (err < 0) {
-- 
1.7.11.3
