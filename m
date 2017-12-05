From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  5 Dec 2017 15:46:46 +0100
Subject: [PATCH v5 8/9] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
References: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
Message-ID: <20171205144647.17594-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP813 has only two GPIOs. GPIO0 can either be used as a GPIO, an
LDO regulator or an ADC. GPIO1 can be used either as a GPIO or an LDO
regulator.

Moreover, the status bit of the GPIOs when in input mode is not offset
by 4 unlike the AXP209.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpio/gpio-axp209.txt       | 13 +++++++-
 drivers/pinctrl/pinctrl-axp209.c                   | 35 +++++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index 0d77597c3f92..fc42b2caa06d 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -9,7 +9,9 @@ Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 This driver employs the per-pin muxing pattern.
 
 Required properties:
-- compatible: Should be "x-powers,axp209-gpio"
+- compatible: Should be one of:
+	- "x-powers,axp209-gpio"
+	- "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
 - gpio-controller: Marks the device node as a GPIO controller.
@@ -57,8 +59,17 @@ GPIOs and their functions
 Each GPIO is independent from the other (i.e. GPIO0 in gpio_in function does
 not force GPIO1 and GPIO2 to be in gpio_in function as well).
 
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
index 9bb8722ba90f..22d3bb0bf927 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -41,6 +42,8 @@
 #define AXP20X_MUX_GPIO_IN		BIT(1)
 #define AXP20X_MUX_ADC			BIT(2)
 
+#define AXP813_MUX_ADC			(BIT(2) | BIT(0))
+
 struct axp20x_pctrl_desc {
 	const struct pinctrl_pin_desc	*pins;
 	unsigned int			npins;
@@ -74,6 +77,11 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
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
@@ -83,6 +91,15 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.adc_mux = AXP20X_MUX_ADC,
 };
 
+static const struct axp20x_pctrl_desc axp813_data = {
+	.pins	= axp813_pins,
+	.npins	= ARRAY_SIZE(axp813_pins),
+	.ldo_mask = BIT(0) | BIT(1),
+	.adc_mask = BIT(0),
+	.gpio_status_offset = 0,
+	.adc_mux = AXP813_MUX_ADC,
+};
+
 static int axp20x_gpio_get_reg(unsigned int offset)
 {
 	switch (offset) {
@@ -357,10 +374,18 @@ static void axp20x_build_funcs_groups(struct platform_device *pdev)
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
 
@@ -388,9 +413,9 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
 	pctl->chip.set			= axp20x_gpio_set;
 	pctl->chip.direction_input	= axp20x_gpio_input;
 	pctl->chip.direction_output	= axp20x_gpio_output;
-	pctl->chip.ngpio		= 3;
+	pctl->chip.ngpio		= pctl->desc->npins;
 
-	pctl->desc = &axp20x_data;
+	pctl->desc = (struct axp20x_pctrl_desc *)of_device_get_match_data(dev);
 	pctl->regmap = axp20x->regmap;
 	pctl->dev = &pdev->dev;
 
@@ -435,12 +460,6 @@ static int axp20x_pctl_probe(struct platform_device *pdev)
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
2.14.1
