From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Dec 2016 18:24:58 +0100
Subject: [PATCH 3/6] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <20161222172501.16121-1-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
Message-ID: <20161222172501.16121-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO management is pretty simple and is part of the same IP than the pin
controller for the Armada 37xx SoCs.  This patch adds the GPIO support to
the pinctrl-armada-37xx.c file, it also allows sharing common functions
between the gpiolib and the pinctrl drivers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 113 ++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 021bfe793af3..4d9571b49ad1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -10,6 +10,7 @@
  * without any warranty of any kind, whether express or implied.
  */
 
+#include <linux/gpio/driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -24,6 +25,8 @@
 #include "../pinctrl-utils.h"
 
 #define OUTPUT_EN	0x0
+#define INPUT_VAL	0x10
+#define OUTPUT_VAL	0x18
 #define OUTPUT_CTL	0x20
 #define SELECTION	0x30
 
@@ -60,6 +63,7 @@ struct armada_37xx_pinctrl {
 	struct regmap			*regmap;
 	struct armada_37xx_pin_data	*data;
 	struct device			*dev;
+	struct gpio_chip		gpio_chip;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
 	struct armada_37xx_pin_group	*groups;
@@ -297,9 +301,10 @@ static int armada_37xx_pmx_set(struct pinctrl_dev *pctldev,
 	return armada_37xx_pmx_set_by_name(pctldev, name, grp);
 }
 
-static int armada_37xx_pmx_direction_input(struct armada_37xx_pinctrl *info,
-					   unsigned int offset)
+static int armada_37xx_gpio_direction_input(struct gpio_chip *chip,
+					    unsigned int offset)
 {
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask;
 
@@ -312,11 +317,28 @@ static int armada_37xx_pmx_direction_input(struct armada_37xx_pinctrl *info,
 	return regmap_update_bits(info->regmap, reg, mask, 0);
 }
 
+static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = OUTPUT_EN;
+	unsigned int val, mask;
+
+	if (offset >= GPIO_PER_REG) {
+		offset -= GPIO_PER_REG;
+		reg += sizeof(u32);
+	}
+	mask = BIT(offset);
+
+	regmap_read(info->regmap, reg, &val);
 
+	return (val & mask) == 0;
+}
 
-static int armada_37xx_pmx_direction_output(struct armada_37xx_pinctrl *info,
-					    unsigned int offset, int value)
+static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
+					     unsigned int offset, int value)
 {
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask;
 
@@ -329,19 +351,54 @@ static int armada_37xx_pmx_direction_output(struct armada_37xx_pinctrl *info,
 	return regmap_update_bits(info->regmap, reg, mask, mask);
 }
 
+static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = INPUT_VAL;
+	unsigned int val, mask;
+
+	if (offset >= GPIO_PER_REG) {
+		offset -= GPIO_PER_REG;
+		reg += sizeof(u32);
+	}
+	mask = BIT(offset);
+
+	regmap_read(info->regmap, reg, &val);
+
+	return (val & mask) != 0;
+}
+
+static void armada_37xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
+				 int value)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = OUTPUT_VAL;
+	unsigned int mask, val;
+
+	if (offset >= GPIO_PER_REG) {
+		offset -= GPIO_PER_REG;
+		reg += sizeof(u32);
+	}
+	mask = BIT(offset);
+	val = value ? mask : 0;
+
+	regmap_update_bits(info->regmap, reg, mask, val);
+}
+
 static int armada_37xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					      struct pinctrl_gpio_range *range,
 					      unsigned int offset, bool input)
 {
 	struct armada_37xx_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
+	struct gpio_chip *chip = range->gc;
 
 	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
 		offset, range->name, offset, input ? "input" : "output");
 
 	if (input)
-		armada_37xx_pmx_direction_input(info, offset);
+		armada_37xx_gpio_direction_input(chip, offset);
 	else
-		armada_37xx_pmx_direction_output(info, offset, 0);
+		armada_37xx_gpio_direction_output(chip, offset, 0);
 
 	return 0;
 }
@@ -371,6 +428,39 @@ static const struct pinmux_ops armada_37xx_pmx_ops = {
 	.gpio_set_direction	= armada_37xx_pmx_gpio_set_direction,
 };
 
+static const struct gpio_chip armada_37xx_gpiolib_chip = {
+	.request = gpiochip_generic_request,
+	.free = gpiochip_generic_free,
+	.set = armada_37xx_gpio_set,
+	.get = armada_37xx_gpio_get,
+	.get_direction	= armada_37xx_gpio_get_direction,
+	.direction_input = armada_37xx_gpio_direction_input,
+	.direction_output = armada_37xx_gpio_direction_output,
+	.owner = THIS_MODULE,
+};
+
+static int armada_37xx_gpiolib_register(struct platform_device *pdev,
+					struct armada_37xx_pinctrl *info)
+{
+	struct gpio_chip *gc;
+	int ret;
+
+	info->gpio_chip = armada_37xx_gpiolib_chip;
+
+	gc = &info->gpio_chip;
+	gc->ngpio = info->data->nr_pins;
+	gc->parent = &pdev->dev;
+	gc->base = -1;
+	gc->of_node = info->dev->of_node;
+	gc->label = info->data->name;
+
+	ret = gpiochip_add_data(gc, info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int _add_function(struct armada_37xx_pmx_func *funcs, int *funcsize,
 			 const char *name)
 {
@@ -551,7 +641,7 @@ static int armada_37xx_pinctrl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct regmap *regmap;
-	int ret;
+	int ret, pinbase = global_pin;
 
 	info = devm_kzalloc(dev, sizeof(struct armada_37xx_pinctrl),
 			    GFP_KERNEL);
@@ -570,10 +660,19 @@ static int armada_37xx_pinctrl_probe(struct platform_device *pdev)
 	match = of_match_node(armada_37xx_pinctrl_of_match, np);
 	info->data = (struct armada_37xx_pin_data *)match->data;
 
+	ret = armada_37xx_gpiolib_register(pdev, info);
+	if (ret)
+		return ret;
+
 	ret = armada_37xx_pinctrl_register(pdev, info);
 	if (ret)
 		return ret;
 
+	ret = gpiochip_add_pin_range(&info->gpio_chip, dev_name(dev), 0,
+				     pinbase, info->data->nr_pins);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, info);
 
 	return 0;
-- 
2.11.0
