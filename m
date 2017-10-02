From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:47 +0200
Subject: [PATCH v3 05/12] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-6-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP813 has only two GPIOs. GPIO0 can either be used as a GPIO, an
LDO regulator or an ADC. GPIO1 can be used either as a GPIO or an LDO
regulator.

Moreover, the status bit of the GPIOs when in input mode is not offset
by 4 unlike the AXP209.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-axp209.txt | 13 ++++++++-
 drivers/pinctrl/pinctrl-axp209.c                   | 32 ++++++++++++++++------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
index 388c04492afd..a4e4dbef65d6 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
@@ -4,7 +4,9 @@ This driver follows the usual GPIO bindings found in
 Documentation/devicetree/bindings/gpio/gpio.txt
 
 Required properties:
-- compatible: Should be "x-powers,axp209-gpio"
+- compatible: Should be one of:
+	- "x-powers,axp209-gpio"
+	- "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
 - gpio-controller: Marks the device node as a GPIO controller.
@@ -49,8 +51,17 @@ Example:
 GPIOs and their functions
 -------------------------
 
+axp209
+------
 GPIO	|	Functions
 ------------------------
 GPIO0	|	gpio_in, gpio_out, ldo, adc
 GPIO1	|	gpio_in, gpio_out, ldo, adc
 GPIO2	|	gpio_in, gpio_out
+
+axp813
+------
+GPIO	|	Functions
+------------------------
+GPIO0	|	gpio_in, gpio_out, ldo, adc
+GPIO1	|	gpio_in, gpio_out, ldo
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 17146496b22a..4466b2541137 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -70,6 +71,11 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
 	PINCTRL_PIN(2, "GPIO2"),
 };
 
+static const struct pinctrl_pin_desc axp813_pins[] = {
+	PINCTRL_PIN(0, "GPIO0"),
+	PINCTRL_PIN(1, "GPIO1"),
+};
+
 static const struct axp20x_pctrl_desc axp20x_data = {
 	.pins	= axp209_pins,
 	.npins	= ARRAY_SIZE(axp209_pins),
@@ -78,6 +84,14 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.gpio_status_offset = 4,
 };
 
+static const struct axp20x_pctrl_desc axp813_data = {
+	.pins	= axp813_pins,
+	.npins	= ARRAY_SIZE(axp813_pins),
+	.ldo_mask = BIT(0) | BIT(1),
+	.adc_mask = BIT(0),
+	.gpio_status_offset = 0,
+};
+
 static int axp20x_gpio_get_reg(unsigned offset)
 {
 	switch (offset) {
@@ -341,10 +355,18 @@ static void axp20x_build_funcs_groups(struct platform_device *pdev)
 				      pctl->desc->pins);
 }
 
+static const struct of_device_id axp20x_pctl_match[] = {
+	{ .compatible = "x-powers,axp209-gpio", .data = &axp20x_data, },
+	{ .compatible = "x-powers,axp813-gpio", .data = &axp813_data, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axp20x_pctl_match);
+
 static int axp20x_pctl_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct axp20x_pctl *pctl;
+	struct device *dev = &pdev->dev;
 	struct pinctrl_desc *pctrl_desc;
 	int ret;
 
@@ -372,9 +394,9 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 	pctl->chip.set			= axp20x_gpio_set;
 	pctl->chip.direction_input	= axp20x_gpio_input;
 	pctl->chip.direction_output	= axp20x_gpio_output;
-	pctl->chip.ngpio		= 3;
+	pctl->chip.ngpio		= pctl->desc->npins;
 
-	pctl->desc = &axp20x_data;
+	pctl->desc = (struct axp20x_pctrl_desc *)of_device_get_match_data(dev);
 
 	pctl->regmap = axp20x->regmap;
 
@@ -421,12 +443,6 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id axp20x_pctl_match[] = {
-	{ .compatible = "x-powers,axp209-gpio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, axp20x_pctl_match);
-
 static struct platform_driver axp20x_pctl_driver = {
 	.probe		= axp20x_pctl_probe,
 	.driver = {
-- 
2.11.0
