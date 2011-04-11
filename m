From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 12:48:18 +0100
Subject: [RFC PATCH 1/5] gemini: convert to basic-mmio-gpio
In-Reply-To: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1302522502-24381-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic-mmio-gpio driver is capable of supporting this controller so
convert the platform to use it for basic GPIO support.

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-gemini/gpio.c |   83 ++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-gemini/gpio.c b/arch/arm/mach-gemini/gpio.c
index fdc7ef1..08cc1f8 100644
--- a/arch/arm/mach-gemini/gpio.c
+++ b/arch/arm/mach-gemini/gpio.c
@@ -18,6 +18,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/basic_mmio_gpio.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -150,60 +153,13 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_set_type = gpio_set_irq_type,
 };
 
-static void _set_gpio_direction(struct gpio_chip *chip, unsigned offset,
-				int dir)
-{
-	unsigned int base = GPIO_BASE(offset / 32);
-	unsigned int reg;
-
-	reg = __raw_readl(base + GPIO_DIR);
-	if (dir)
-		reg |= 1 << (offset % 32);
-	else
-		reg &= ~(1 << (offset % 32));
-	__raw_writel(reg, base + GPIO_DIR);
-}
-
-static void gemini_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	unsigned int base = GPIO_BASE(offset / 32);
-
-	if (value)
-		__raw_writel(1 << (offset % 32), base + GPIO_DATA_SET);
-	else
-		__raw_writel(1 << (offset % 32), base + GPIO_DATA_CLR);
-}
-
-static int gemini_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	unsigned int base = GPIO_BASE(offset / 32);
-
-	return (__raw_readl(base + GPIO_DATA_IN) >> (offset % 32)) & 1;
-}
-
-static int gemini_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	_set_gpio_direction(chip, offset, 0);
-	return 0;
-}
-
-static int gemini_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
-					int value)
-{
-	_set_gpio_direction(chip, offset, 1);
-	gemini_gpio_set(chip, offset, value);
-	return 0;
-}
-
-static struct gpio_chip gemini_gpio_chip = {
-	.label			= "Gemini",
-	.direction_input	= gemini_gpio_direction_input,
-	.get			= gemini_gpio_get,
-	.direction_output	= gemini_gpio_direction_output,
-	.set			= gemini_gpio_set,
-	.base			= 0,
-	.ngpio			= GPIO_PORT_NUM * 32,
-};
+#define GPIO_RES(__name, __addr) \
+	{ \
+		.start = (__addr), \
+		.end = (__addr) + 0x3, \
+		.flags = IORESOURCE_MEM, \
+		.name = #__name, \
+	}
 
 void __init gemini_gpio_init(void)
 {
@@ -226,5 +182,22 @@ void __init gemini_gpio_init(void)
 		irq_set_handler_data(IRQ_GPIO(i), (void *)i);
 	}
 
-	BUG_ON(gpiochip_add(&gemini_gpio_chip));
+	for (i = 0; i < GPIO_PORT_NUM; ++i) {
+		struct resource res[] = {
+			GPIO_RES(dirout, GEMINI_GPIO_BASE(i) + GPIO_DIR),
+			GPIO_RES(set, GEMINI_GPIO_BASE(i) + GPIO_DATA_SET),
+			GPIO_RES(clr, GEMINI_GPIO_BASE(i) + GPIO_DATA_CLR),
+			GPIO_RES(dat, GEMINI_GPIO_BASE(i) + GPIO_DATA_IN),
+		};
+		struct bgpio_pdata pdata = {
+			.base = i * 32,
+			.ngpio = 32,
+		};
+		struct platform_device *pdev;
+
+		pdev = platform_device_register_resndata(NULL,
+			"basic-mmio-gpio", i, res, ARRAY_SIZE(res), &pdata,
+			sizeof(pdata));
+		WARN_ON(IS_ERR(pdev));
+	}
 }
-- 
1.7.4.2
