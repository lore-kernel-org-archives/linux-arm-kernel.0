From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 12:48:19 +0100
Subject: [RFC PATCH 2/5] sa1100: convert to basic-mmio-gpio
In-Reply-To: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1302522502-24381-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic-mmio-gpio driver is capable of supporting this controller so
convert the platform to use it for basic GPIO support.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-sa1100/gpio.c |   69 +++++++++++++++---------------------------
 1 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-sa1100/gpio.c b/arch/arm/mach-sa1100/gpio.c
index 0d3829a..f7bd975 100644
--- a/arch/arm/mach-sa1100/gpio.c
+++ b/arch/arm/mach-sa1100/gpio.c
@@ -8,58 +8,39 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/basic_mmio_gpio.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/gpio.h>
 #include <mach/hardware.h>
 #include "generic.h"
 
-static int sa1100_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	return GPLR & GPIO_GPIO(offset);
-}
-
-static void sa1100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	if (value)
-		GPSR = GPIO_GPIO(offset);
-	else
-		GPCR = GPIO_GPIO(offset);
-}
-
-static int sa1100_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	GPDR &= ~GPIO_GPIO(offset);
-	local_irq_restore(flags);
-	return 0;
-}
-
-static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int value)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sa1100_gpio_set(chip, offset, value);
-	GPDR |= GPIO_GPIO(offset);
-	local_irq_restore(flags);
-	return 0;
-}
-
-static struct gpio_chip sa1100_gpio_chip = {
-	.label			= "gpio",
-	.direction_input	= sa1100_direction_input,
-	.direction_output	= sa1100_direction_output,
-	.set			= sa1100_gpio_set,
-	.get			= sa1100_gpio_get,
-	.base			= 0,
-	.ngpio			= GPIO_MAX + 1,
-};
+#define GPIO_RES(__name, __addr) \
+	{ \
+		.start = (__addr), \
+		.end = (__addr) + 0x3, \
+		.flags = IORESOURCE_MEM, \
+		.name = #__name, \
+	}
 
 void __init sa1100_init_gpio(void)
 {
-	gpiochip_add(&sa1100_gpio_chip);
+	struct resource res[] = {
+		GPIO_RES(set, 0x90040008),
+		GPIO_RES(clr, 0x9004000C),
+		GPIO_RES(dat, 0x90040000),
+		GPIO_RES(dirout, 0x90040004),
+	};
+	struct bgpio_pdata pdata = {
+		.ngpio = GPIO_MAX + 1,
+	};
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_resndata(NULL, "basic-mmio-gpio", 0,
+						 res, ARRAY_SIZE(res), &pdata,
+						 sizeof(pdata));
+	WARN_ON(IS_ERR(pdev));
 }
-- 
1.7.4.2
