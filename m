From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:12 +0200
Subject: [PATCH 37/39] pinctrl: get rid of all platform data for coh901
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-38-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This deletes the dependency on any platform data for
the COH901 pin controller. There is only one user in the
kernel, and if we at some point want to support more
variants, they shall provide their variant info through
the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c                    | 12 +-----------
 drivers/pinctrl/pinctrl-coh901.c             | 23 +++++++++--------------
 include/linux/platform_data/pinctrl-coh901.h | 22 ----------------------
 3 files changed, 10 insertions(+), 47 deletions(-)
 delete mode 100644 include/linux/platform_data/pinctrl-coh901.h

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 6e5744a..4f7ac2a 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -12,7 +12,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_data/clk-u300.h>
-#include <linux/platform_data/pinctrl-coh901.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -194,15 +193,6 @@ static void __init u300_map_io(void)
 	iotable_init(u300_io_desc, ARRAY_SIZE(u300_io_desc));
 }
 
-/*
- * The different variants have a few different versions of the
- * GPIO block, with different number of ports.
- */
-static struct u300_gpio_platform u300_gpio_plat = {
-	.ports = 7,
-	.gpio_base = 0,
-};
-
 static unsigned long pin_pullup_conf[] = {
 	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 1),
 };
@@ -332,7 +322,7 @@ static struct of_dev_auxdata u300_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,pinctrl-u300", U300_SYSCON_BASE,
 		"pinctrl-u300", NULL),
 	OF_DEV_AUXDATA("stericsson,gpio-coh901", U300_GPIO_BASE,
-		"u300-gpio", &u300_gpio_plat),
+		"u300-gpio", NULL),
 	OF_DEV_AUXDATA("stericsson,coh901327", U300_WDOG_BASE,
 		"coh901327_wdog", NULL),
 	OF_DEV_AUXDATA("stericsson,coh901331", U300_RTC_BASE,
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index d4f8afd..46ff140 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <linux/platform_data/pinctrl-coh901.h>
 #include "pinctrl-coh901.h"
 
 #define U300_GPIO_PORT_STRIDE				(0x30)
@@ -58,8 +57,9 @@
 #define U300_GPIO_PXICR_IRQ_CONFIG_RISING_EDGE		(0x00000001UL)
 
 /* 8 bits per port, no version has more than 7 ports */
+#define U300_GPIO_NUM_PORTS 7
 #define U300_GPIO_PINS_PER_PORT 8
-#define U300_GPIO_MAX (U300_GPIO_PINS_PER_PORT * 7)
+#define U300_GPIO_MAX (U300_GPIO_PINS_PER_PORT * U300_GPIO_NUM_PORTS)
 
 struct u300_gpio {
 	struct gpio_chip chip;
@@ -111,9 +111,6 @@ struct u300_gpio_confdata {
 	int outval;
 };
 
-/* BS335 has seven ports of 8 bits each = GPIO pins 0..55 */
-#define BS335_GPIO_NUM_PORTS 7
-
 #define U300_FLOATING_INPUT { \
 	.bias_mode = PIN_CONFIG_BIAS_HIGH_IMPEDANCE, \
 	.output = false, \
@@ -136,7 +133,7 @@ struct u300_gpio_confdata {
 
 /* Initial configuration */
 static const struct __initconst u300_gpio_confdata
-bs335_gpio_config[BS335_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
+bs335_gpio_config[U300_GPIO_NUM_PORTS][U300_GPIO_PINS_PER_PORT] = {
 	/* Port 0, pins 0-7 */
 	{
 		U300_FLOATING_INPUT,
@@ -630,13 +627,12 @@ static void __init u300_gpio_init_pin(struct u300_gpio *gpio,
 	}
 }
 
-static void __init u300_gpio_init_coh901571(struct u300_gpio *gpio,
-				     struct u300_gpio_platform *plat)
+static void __init u300_gpio_init_coh901571(struct u300_gpio *gpio)
 {
 	int i, j;
 
 	/* Write default config and values to all pins */
-	for (i = 0; i < plat->ports; i++) {
+	for (i = 0; i < U300_GPIO_NUM_PORTS; i++) {
 		for (j = 0; j < 8; j++) {
 			const struct u300_gpio_confdata *conf;
 			int offset = (i*8) + j;
@@ -693,7 +689,6 @@ static struct coh901_pinpair coh901_pintable[] = {
 
 static int __init u300_gpio_probe(struct platform_device *pdev)
 {
-	struct u300_gpio_platform *plat = dev_get_platdata(&pdev->dev);
 	struct u300_gpio *gpio;
 	struct resource *memres;
 	int err = 0;
@@ -707,9 +702,9 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpio->chip = u300_gpio_chip;
-	gpio->chip.ngpio = plat->ports * U300_GPIO_PINS_PER_PORT;
+	gpio->chip.ngpio = U300_GPIO_NUM_PORTS * U300_GPIO_PINS_PER_PORT;
 	gpio->chip.dev = &pdev->dev;
-	gpio->chip.base = plat->gpio_base;
+	gpio->chip.base = 0;
 	gpio->dev = &pdev->dev;
 
 	memres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -755,11 +750,11 @@ static int __init u300_gpio_probe(struct platform_device *pdev)
 		 ((val & 0x0000FE00) >> 9) * 8);
 	writel(U300_GPIO_CR_BLOCK_CLKRQ_ENABLE,
 	       gpio->base + U300_GPIO_CR);
-	u300_gpio_init_coh901571(gpio, plat);
+	u300_gpio_init_coh901571(gpio);
 
 	/* Add each port with its IRQ separately */
 	INIT_LIST_HEAD(&gpio->port_list);
-	for (portno = 0 ; portno < plat->ports; portno++) {
+	for (portno = 0 ; portno < U300_GPIO_NUM_PORTS; portno++) {
 		struct u300_gpio_port *port =
 			kmalloc(sizeof(struct u300_gpio_port), GFP_KERNEL);
 
diff --git a/include/linux/platform_data/pinctrl-coh901.h b/include/linux/platform_data/pinctrl-coh901.h
deleted file mode 100644
index dfbc65d..0000000
--- a/include/linux/platform_data/pinctrl-coh901.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2007-2012 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * GPIO block resgister definitions and inline macros for
- * U300 GPIO COH 901 335 or COH 901 571/3
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-#ifndef __MACH_U300_GPIO_U300_H
-#define __MACH_U300_GPIO_U300_H
-
-/**
- * struct u300_gpio_platform - U300 GPIO platform data
- * @ports: number of GPIO block ports
- * @gpio_base: first GPIO number for this block (use a free range)
- */
-struct u300_gpio_platform {
-	u8 ports;
-	int gpio_base;
-};
-
-#endif /* __MACH_U300_GPIO_U300_H */
-- 
1.7.11.3
