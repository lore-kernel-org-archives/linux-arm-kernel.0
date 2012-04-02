From: stigge@antcom.de (Roland Stigge)
Date: Mon,  2 Apr 2012 16:21:04 +0200
Subject: [PATCH RFC] gpio: Device tree support for LPC32xx
Message-ID: <1333376464-25712-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support for gpio-lpc32xx.c

---

Hi!

I'm adding device tree support to the LPC32xx platform. Currently struggling
with GPIO, see patch below.

Generally, it works - GPIOs registered successfully like before:

================================================================
gpiochip_add: registered GPIOs 0 to 7 on device: gpio_p0
gpiochip_add: registered GPIOs 8 to 31 on device: gpio_p1
gpiochip_add: registered GPIOs 32 to 44 on device: gpio_p2
gpiochip_add: registered GPIOs 45 to 50 on device: gpio_p3
gpiochip_add: registered GPIOs 51 to 78 on device: gpi_p3
gpiochip_add: registered GPIOs 79 to 102 on device: gpo_p3
================================================================

But in connection with gpio-leds which I'm using like this:

        leds {
                compatible = "gpio-leds";
                led0 {
                        gpios = <&gpio 0x50 1>; /* GPIO 80, active low */
                        linux,default-trigger = "heartbeat";
                        default-state = "keep";
                };
        };

I get the following error:

================================================================
Skipping unavailable LED gpio -22 (led0)
================================================================

Traced it back to drivers/of/gpio.c:144: (errno: -22 == -EINVAL)

When I disable the "lpc32xx_gpiochip[i].of_node = pdev->dev.of_node" in l.466,
it changes to:

================================================================
Skipping unavailable LED gpio -19 (led0)
================================================================

which comes from drivers/of/gpio.c:52: (errno: -19 == -ENODEV)

I suspect the strategy to do several gpiochip_add()s, ported from the non-DT
platform code, doesn't work well with the of_* registration - e.g.,
gpiochip_find() compares the static structs I'm registering with gpiochip_add()
with another (of_node's) one not in the registeded list. Should the various
GPIO areas be moved from lpc32xx_gpiochip[] to a dts file? So many callbacks
and memory references in there...

Any suggestions appreciated!

Thanks in advance,

Roland


 Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt |   18 ++++++++
 arch/arm/mach-lpc32xx/include/mach/gpio.h               |    9 +++-
 drivers/gpio/gpio-lpc32xx.c                             |   34 +++++++++++++++-
 3 files changed, 58 insertions(+), 3 deletions(-)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
@@ -0,0 +1,18 @@
+NXP LPC32xx SoC GPIO controller
+
+Required properties:
+- compatible : "nxp,lpc32xx-gpio"
+- reg : Physical base address and length of the controller's registers.
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters:
+  - bit 0 specifies polarity (0 for normal, 1 for inverted)
+- gpio-controller : Marks the device node as a GPIO controller.
+
+Example:
+
+gpio: gpio at 40028000 {
+	compatible = "nxp,lpc32xx-gpio";
+	reg = <0x40028000 0x1000>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
--- linux-2.6.orig/arch/arm/mach-lpc32xx/include/mach/gpio.h
+++ linux-2.6/arch/arm/mach-lpc32xx/include/mach/gpio.h
@@ -1 +1,8 @@
-/* empty */
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H
+
+#include "gpio-lpc32xx.h"
+
+#define ARCH_NR_GPIOS (LPC32XX_GPO_P3_GRP + LPC32XX_GPO_P3_MAX)
+
+#endif /* __MACH_GPIO_H */
--- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
+++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
@@ -21,6 +21,9 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
@@ -454,10 +457,37 @@ static struct lpc32xx_gpio_chip lpc32xx_
 	},
 };
 
-void __init lpc32xx_gpio_init(void)
+static int __devinit lpc32xx_gpio_probe(struct platform_device *pdev)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++)
+	for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++) {
+#ifdef CONFIG_OF_GPIO
+		lpc32xx_gpiochip[i].chip.of_node = pdev->dev.of_node;
+#endif
 		gpiochip_add(&lpc32xx_gpiochip[i].chip);
+	}
+
+	return 0;
 }
+
+static struct of_device_id lpc32xx_gpio_of_match[] __devinitdata = {
+	{ .compatible = "nxp,lpc32xx-gpio", },
+	{ },
+};
+
+static struct platform_driver lpc32xx_gpio_driver = {
+	.driver		= {
+		.name	= "lpc32xx-gpio",
+		.owner	= THIS_MODULE,
+		.of_match_table = lpc32xx_gpio_of_match,
+	},
+	.probe		= lpc32xx_gpio_probe,
+};
+
+static int __init lpc32xx_gpio_init(void)
+{
+	return platform_driver_register(&lpc32xx_gpio_driver);
+}
+postcore_initcall(lpc32xx_gpio_init);
+
