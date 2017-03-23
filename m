From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Mar 2017 16:19:04 +0100
Subject: [PATCH v3 4/7] pinctrl: armada-37xx: Add gpio support
In-Reply-To: <cover.72ded2a212a37139db2a4193482b04a84a545a48.1490282185.git-series.gregory.clement@free-electrons.com>
References: <cover.72ded2a212a37139db2a4193482b04a84a545a48.1490282185.git-series.gregory.clement@free-electrons.com>
Message-ID: <33b78632f0f461f353dffbc75a80a2a9673fb0a6.1490282185.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO management is pretty simple and is part of the same IP than the pin
controller for the Armada 37xx SoCs.  This patch adds the GPIO support to
the pinctrl-armada-37xx.c file, it also allows sharing common functions
between the gpiolib and the pinctrl drivers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 127 ++++++++++++++++++---
 1 file changed, 113 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index f2ff9801d0f4..31e921aa2f86 100644
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
 
@@ -73,6 +76,7 @@ struct armada_37xx_pinctrl {
 	struct regmap			*regmap;
 	struct armada_37xx_pin_data	*data;
 	struct device			*dev;
+	struct gpio_chip		gpio_chip;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
 	struct armada_37xx_pin_group	*groups;
@@ -310,51 +314,99 @@ static int armada_37xx_pmx_set(struct pinctrl_dev *pctldev,
 	return armada_37xx_pmx_set_by_name(pctldev, name, grp);
 }
 
-static int armada_37xx_pmx_direction_input(struct armada_37xx_pinctrl *info,
-					   unsigned int offset)
+static inline void aramda_37xx_update_reg(unsigned int *reg,
+					  unsigned int offset)
 {
-	unsigned int reg = OUTPUT_EN;
-	unsigned int mask;
-
+	/* We never have more than 2 registers */
 	if (offset >= GPIO_PER_REG) {
 		offset -= GPIO_PER_REG;
-		reg += sizeof(u32);
+		*reg += sizeof(u32);
 	}
+}
+
+static int armada_37xx_gpio_direction_input(struct gpio_chip *chip,
+					    unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = OUTPUT_EN;
+	unsigned int mask;
+
+	aramda_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	return regmap_update_bits(info->regmap, reg, mask, 0);
 }
 
+static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = OUTPUT_EN;
+	unsigned int val, mask;
+
+	aramda_37xx_update_reg(&reg, offset);
+	mask = BIT(offset);
+
+	regmap_read(info->regmap, reg, &val);
 
+	return !(val & mask);
+}
 
-static int armada_37xx_pmx_direction_output(struct armada_37xx_pinctrl *info,
-					    unsigned int offset, int value)
+static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
+					     unsigned int offset, int value)
 {
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask;
 
-	if (offset >= GPIO_PER_REG) {
-		offset -= GPIO_PER_REG;
-		reg += sizeof(u32);
-	}
+	aramda_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	return regmap_update_bits(info->regmap, reg, mask, mask);
 }
 
+static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	unsigned int reg = INPUT_VAL;
+	unsigned int val, mask;
+
+	aramda_37xx_update_reg(&reg, offset);
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
+	aramda_37xx_update_reg(&reg, offset);
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
@@ -384,6 +436,49 @@ static const struct pinmux_ops armada_37xx_pmx_ops = {
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
+static int armada_37xx_gpiochip_register(struct platform_device *pdev,
+					struct armada_37xx_pinctrl *info)
+{
+	struct device_node *np;
+	struct gpio_chip *gc;
+	int ret = -ENODEV;
+
+	for_each_child_of_node(info->dev->of_node, np) {
+		if (of_find_property(np, "gpio-controller", NULL)) {
+			ret = 0;
+			break;
+		}
+	};
+	if (ret)
+		return ret;
+
+	info->gpio_chip = armada_37xx_gpiolib_chip;
+
+	gc = &info->gpio_chip;
+	gc->ngpio = info->data->nr_pins;
+	gc->parent = &pdev->dev;
+	gc->base = -1;
+	gc->of_node = np;
+	gc->label = info->data->name;
+
+	ret = gpiochip_add_data(gc, info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int armada_37xx_add_function(struct armada_37xx_pmx_func *funcs,
 				    int *funcsize, const char *name)
 {
@@ -586,6 +681,10 @@ static int armada_37xx_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = armada_37xx_gpiochip_register(pdev, info);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, info);
 
 	return 0;
-- 
git-series 0.9.1
