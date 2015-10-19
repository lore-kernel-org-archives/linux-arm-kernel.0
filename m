From: pramodku@broadcom.com (Pramod Kumar)
Date: Mon, 19 Oct 2015 11:13:09 +0530
Subject: [PATCH 02/11] pinctrl: Remove GPIO to Pinctrl pin mapping from driver
In-Reply-To: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
Message-ID: <1445233398-27129-3-git-send-email-pramodku@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove gpio to pinctrl pin mapping code from driver and
address this through standard property "gpio-ranges".

Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c | 131 +-----------------------------
 1 file changed, 3 insertions(+), 128 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
index 1ca7830..12a48f4 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
@@ -29,7 +29,6 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
@@ -597,127 +596,6 @@ static const struct pinconf_ops cygnus_pconf_ops = {
 };
 
 /*
- * Map a GPIO in the local gpio_chip pin space to a pin in the Cygnus IOMUX
- * pinctrl pin space
- */
-struct cygnus_gpio_pin_range {
-	unsigned offset;
-	unsigned pin_base;
-	unsigned num_pins;
-};
-
-#define CYGNUS_PINRANGE(o, p, n) { .offset = o, .pin_base = p, .num_pins = n }
-
-/*
- * Pin mapping table for mapping local GPIO pins to Cygnus IOMUX pinctrl pins
- */
-static const struct cygnus_gpio_pin_range cygnus_gpio_pintable[] = {
-	CYGNUS_PINRANGE(0, 42, 1),
-	CYGNUS_PINRANGE(1, 44, 3),
-	CYGNUS_PINRANGE(4, 48, 1),
-	CYGNUS_PINRANGE(5, 50, 3),
-	CYGNUS_PINRANGE(8, 126, 1),
-	CYGNUS_PINRANGE(9, 155, 1),
-	CYGNUS_PINRANGE(10, 152, 1),
-	CYGNUS_PINRANGE(11, 154, 1),
-	CYGNUS_PINRANGE(12, 153, 1),
-	CYGNUS_PINRANGE(13, 127, 3),
-	CYGNUS_PINRANGE(16, 140, 1),
-	CYGNUS_PINRANGE(17, 145, 7),
-	CYGNUS_PINRANGE(24, 130, 10),
-	CYGNUS_PINRANGE(34, 141, 4),
-	CYGNUS_PINRANGE(38, 54, 1),
-	CYGNUS_PINRANGE(39, 56, 3),
-	CYGNUS_PINRANGE(42, 60, 3),
-	CYGNUS_PINRANGE(45, 64, 3),
-	CYGNUS_PINRANGE(48, 68, 2),
-	CYGNUS_PINRANGE(50, 84, 6),
-	CYGNUS_PINRANGE(56, 94, 6),
-	CYGNUS_PINRANGE(62, 72, 1),
-	CYGNUS_PINRANGE(63, 70, 1),
-	CYGNUS_PINRANGE(64, 80, 1),
-	CYGNUS_PINRANGE(65, 74, 3),
-	CYGNUS_PINRANGE(68, 78, 1),
-	CYGNUS_PINRANGE(69, 82, 1),
-	CYGNUS_PINRANGE(70, 156, 17),
-	CYGNUS_PINRANGE(87, 104, 12),
-	CYGNUS_PINRANGE(99, 102, 2),
-	CYGNUS_PINRANGE(101, 90, 4),
-	CYGNUS_PINRANGE(105, 116, 6),
-	CYGNUS_PINRANGE(111, 100, 2),
-	CYGNUS_PINRANGE(113, 122, 4),
-	CYGNUS_PINRANGE(123, 11, 1),
-	CYGNUS_PINRANGE(124, 38, 4),
-	CYGNUS_PINRANGE(128, 43, 1),
-	CYGNUS_PINRANGE(129, 47, 1),
-	CYGNUS_PINRANGE(130, 49, 1),
-	CYGNUS_PINRANGE(131, 53, 1),
-	CYGNUS_PINRANGE(132, 55, 1),
-	CYGNUS_PINRANGE(133, 59, 1),
-	CYGNUS_PINRANGE(134, 63, 1),
-	CYGNUS_PINRANGE(135, 67, 1),
-	CYGNUS_PINRANGE(136, 71, 1),
-	CYGNUS_PINRANGE(137, 73, 1),
-	CYGNUS_PINRANGE(138, 77, 1),
-	CYGNUS_PINRANGE(139, 79, 1),
-	CYGNUS_PINRANGE(140, 81, 1),
-	CYGNUS_PINRANGE(141, 83, 1),
-	CYGNUS_PINRANGE(142, 10, 1)
-};
-
-/*
- * The Cygnus IOMUX controller mainly supports group based mux configuration,
- * but certain pins can be muxed to GPIO individually. Only the ASIU GPIO
- * controller can support this, so it's an optional configuration
- *
- * Return -ENODEV means no support and that's fine
- */
-static int cygnus_gpio_pinmux_add_range(struct cygnus_gpio *chip)
-{
-	struct device_node *node = chip->dev->of_node;
-	struct device_node *pinmux_node;
-	struct platform_device *pinmux_pdev;
-	struct gpio_chip *gc = &chip->gc;
-	int i, ret = 0;
-
-	/* parse DT to find the phandle to the pinmux controller */
-	pinmux_node = of_parse_phandle(node, "pinmux", 0);
-	if (!pinmux_node)
-		return -ENODEV;
-
-	pinmux_pdev = of_find_device_by_node(pinmux_node);
-	/* no longer need the pinmux node */
-	of_node_put(pinmux_node);
-	if (!pinmux_pdev) {
-		dev_err(chip->dev, "failed to get pinmux device\n");
-		return -EINVAL;
-	}
-
-	/* now need to create the mapping between local GPIO and PINMUX pins */
-	for (i = 0; i < ARRAY_SIZE(cygnus_gpio_pintable); i++) {
-		ret = gpiochip_add_pin_range(gc, dev_name(&pinmux_pdev->dev),
-					     cygnus_gpio_pintable[i].offset,
-					     cygnus_gpio_pintable[i].pin_base,
-					     cygnus_gpio_pintable[i].num_pins);
-		if (ret) {
-			dev_err(chip->dev, "unable to add GPIO pin range\n");
-			goto err_put_device;
-		}
-	}
-
-	chip->pinmux_is_supported = true;
-
-	/* no need for pinmux_pdev device reference anymore */
-	put_device(&pinmux_pdev->dev);
-	return 0;
-
-err_put_device:
-	put_device(&pinmux_pdev->dev);
-	gpiochip_remove_pin_ranges(gc);
-	return ret;
-}
-
-/*
  * Cygnus GPIO controller supports some PINCONF related configurations such as
  * pull up, pull down, and drive strength, when the pin is configured to GPIO
  *
@@ -851,18 +729,15 @@ static int cygnus_gpio_probe(struct platform_device *pdev)
 	gc->set = cygnus_gpio_set;
 	gc->get = cygnus_gpio_get;
 
+	chip->pinmux_is_supported = of_property_read_bool(dev->of_node,
+							"gpio-ranges");
+
 	ret = gpiochip_add(gc);
 	if (ret < 0) {
 		dev_err(dev, "unable to add GPIO chip\n");
 		return ret;
 	}
 
-	ret = cygnus_gpio_pinmux_add_range(chip);
-	if (ret && ret != -ENODEV) {
-		dev_err(dev, "unable to add GPIO pin range\n");
-		goto err_rm_gpiochip;
-	}
-
 	ret = cygnus_gpio_register_pinconf(chip);
 	if (ret) {
 		dev_err(dev, "unable to register pinconf\n");
-- 
1.9.1
