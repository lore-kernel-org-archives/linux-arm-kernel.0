From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 15:41:46 +0200
Subject: [PATCH 1/3] pinctrl: oxnas: Move OX810SE specific function and
 structure as separate
In-Reply-To: <20161004134148.23028-1-narmstrong@baylibre.com>
References: <20161004134148.23028-1-narmstrong@baylibre.com>
Message-ID: <20161004134148.23028-2-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add refactoring to move ox810se specific functions into specific ops structures
an add support for the dt match data to get soc specific structures.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/pinctrl-oxnas.c | 176 +++++++++++++++++++++++-----------------
 1 file changed, 101 insertions(+), 75 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 917a7d2..218ad48 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -37,15 +37,15 @@
 
 #define GPIO_BANK_START(bank)		((bank) * PINS_PER_BANK)
 
-/* Regmap Offsets */
-#define PINMUX_PRIMARY_SEL0	0x0c
-#define PINMUX_SECONDARY_SEL0	0x14
-#define PINMUX_TERTIARY_SEL0	0x8c
-#define PINMUX_PRIMARY_SEL1	0x10
-#define PINMUX_SECONDARY_SEL1	0x18
-#define PINMUX_TERTIARY_SEL1	0x90
-#define PINMUX_PULLUP_CTRL0	0xac
-#define PINMUX_PULLUP_CTRL1	0xb0
+/* OX810 Regmap Offsets */
+#define PINMUX_810_PRIMARY_SEL0		0x0c
+#define PINMUX_810_SECONDARY_SEL0	0x14
+#define PINMUX_810_TERTIARY_SEL0	0x8c
+#define PINMUX_810_PRIMARY_SEL1		0x10
+#define PINMUX_810_SECONDARY_SEL1	0x18
+#define PINMUX_810_TERTIARY_SEL1	0x90
+#define PINMUX_810_PULLUP_CTRL0		0xac
+#define PINMUX_810_PULLUP_CTRL1		0xb0
 
 /* GPIO Registers */
 #define INPUT_VALUE	0x00
@@ -87,8 +87,6 @@ struct oxnas_pinctrl {
 	struct regmap *regmap;
 	struct device *dev;
 	struct pinctrl_dev *pctldev;
-	const struct pinctrl_pin_desc *pins;
-	unsigned int npins;
 	const struct oxnas_function *functions;
 	unsigned int nfunctions;
 	const struct oxnas_pin_group *groups;
@@ -97,7 +95,12 @@ struct oxnas_pinctrl {
 	unsigned int nbanks;
 };
 
-static const struct pinctrl_pin_desc oxnas_pins[] = {
+struct oxnas_pinctrl_data {
+	struct pinctrl_desc *desc;
+	struct oxnas_pinctrl *pctl;
+};
+
+static const struct pinctrl_pin_desc oxnas_ox810se_pins[] = {
 	PINCTRL_PIN(0, "gpio0"),
 	PINCTRL_PIN(1, "gpio1"),
 	PINCTRL_PIN(2, "gpio2"),
@@ -135,7 +138,7 @@ static const struct pinctrl_pin_desc oxnas_pins[] = {
 	PINCTRL_PIN(34, "gpio34"),
 };
 
-static const char * const oxnas_fct0_group[] = {
+static const char * const oxnas_ox810se_fct0_group[] = {
 	"gpio0",  "gpio1",  "gpio2",  "gpio3",
 	"gpio4",  "gpio5",  "gpio6",  "gpio7",
 	"gpio8",  "gpio9",  "gpio10", "gpio11",
@@ -147,7 +150,7 @@ static const char * const oxnas_fct0_group[] = {
 	"gpio32", "gpio33", "gpio34"
 };
 
-static const char * const oxnas_fct3_group[] = {
+static const char * const oxnas_ox810se_fct3_group[] = {
 	"gpio0",  "gpio1",  "gpio2",  "gpio3",
 	"gpio4",  "gpio5",  "gpio6",  "gpio7",
 	"gpio8",  "gpio9",
@@ -165,9 +168,9 @@ static const char * const oxnas_fct3_group[] = {
 		.ngroups = ARRAY_SIZE(oxnas_##_gr##_group),	\
 	}
 
-static const struct oxnas_function oxnas_functions[] = {
-	FUNCTION(gpio, fct0),
-	FUNCTION(fct3, fct3),
+static const struct oxnas_function oxnas_ox810se_functions[] = {
+	FUNCTION(gpio, ox810se_fct0),
+	FUNCTION(fct3, ox810se_fct3),
 };
 
 #define OXNAS_PINCTRL_GROUP(_pin, _name, ...)				\
@@ -185,7 +188,7 @@ static const struct oxnas_function oxnas_functions[] = {
 		.fct = _fct,				\
 	}
 
-static const struct oxnas_pin_group oxnas_groups[] = {
+static const struct oxnas_pin_group oxnas_ox810se_groups[] = {
 	OXNAS_PINCTRL_GROUP(0, gpio0,
 			OXNAS_PINCTRL_FUNCTION(gpio, 0),
 			OXNAS_PINCTRL_FUNCTION(fct3, 3)),
@@ -352,8 +355,8 @@ static int oxnas_pinmux_get_function_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static int oxnas_pinmux_enable(struct pinctrl_dev *pctldev,
-			       unsigned int func, unsigned int group)
+static int oxnas_ox810se_pinmux_enable(struct pinctrl_dev *pctldev,
+				       unsigned int func, unsigned int group)
 {
 	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	const struct oxnas_pin_group *pg = &pctl->groups[group];
@@ -371,22 +374,22 @@ static int oxnas_pinmux_enable(struct pinctrl_dev *pctldev,
 
 			regmap_write_bits(pctl->regmap,
 					  (pg->bank ?
-						PINMUX_PRIMARY_SEL1 :
-						PINMUX_PRIMARY_SEL0),
+						PINMUX_810_PRIMARY_SEL1 :
+						PINMUX_810_PRIMARY_SEL0),
 					  mask,
 					  (functions->fct == 1 ?
 						mask : 0));
 			regmap_write_bits(pctl->regmap,
 					  (pg->bank ?
-						PINMUX_SECONDARY_SEL1 :
-						PINMUX_SECONDARY_SEL0),
+						PINMUX_810_SECONDARY_SEL1 :
+						PINMUX_810_SECONDARY_SEL0),
 					  mask,
 					  (functions->fct == 2 ?
 						mask : 0));
 			regmap_write_bits(pctl->regmap,
 					  (pg->bank ?
-						PINMUX_TERTIARY_SEL1 :
-						PINMUX_TERTIARY_SEL0),
+						PINMUX_810_TERTIARY_SEL1 :
+						PINMUX_810_TERTIARY_SEL0),
 					  mask,
 					  (functions->fct == 3 ?
 						mask : 0));
@@ -402,9 +405,9 @@ static int oxnas_pinmux_enable(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
-static int oxnas_gpio_request_enable(struct pinctrl_dev *pctldev,
-				     struct pinctrl_gpio_range *range,
-				     unsigned int offset)
+static int oxnas_ox810se_gpio_request_enable(struct pinctrl_dev *pctldev,
+					     struct pinctrl_gpio_range *range,
+					     unsigned int offset)
 {
 	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct oxnas_gpio_bank *bank = gpiochip_get_data(range->gc);
@@ -415,18 +418,18 @@ static int oxnas_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	regmap_write_bits(pctl->regmap,
 			  (bank->id ?
-				PINMUX_PRIMARY_SEL1 :
-				PINMUX_PRIMARY_SEL0),
+				PINMUX_810_PRIMARY_SEL1 :
+				PINMUX_810_PRIMARY_SEL0),
 			  mask, 0);
 	regmap_write_bits(pctl->regmap,
 			  (bank->id ?
-				PINMUX_SECONDARY_SEL1 :
-				PINMUX_SECONDARY_SEL0),
+				PINMUX_810_SECONDARY_SEL1 :
+				PINMUX_810_SECONDARY_SEL0),
 			  mask, 0);
 	regmap_write_bits(pctl->regmap,
 			  (bank->id ?
-				PINMUX_TERTIARY_SEL1 :
-				PINMUX_TERTIARY_SEL0),
+				PINMUX_810_TERTIARY_SEL1 :
+				PINMUX_810_TERTIARY_SEL0),
 			  mask, 0);
 
 	return 0;
@@ -498,17 +501,17 @@ static int oxnas_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static const struct pinmux_ops oxnas_pinmux_ops = {
+static const struct pinmux_ops oxnas_ox810se_pinmux_ops = {
 	.get_functions_count = oxnas_pinmux_get_functions_count,
 	.get_function_name = oxnas_pinmux_get_function_name,
 	.get_function_groups = oxnas_pinmux_get_function_groups,
-	.set_mux = oxnas_pinmux_enable,
-	.gpio_request_enable = oxnas_gpio_request_enable,
+	.set_mux = oxnas_ox810se_pinmux_enable,
+	.gpio_request_enable = oxnas_ox810se_gpio_request_enable,
 	.gpio_set_direction = oxnas_gpio_set_direction,
 };
 
-static int oxnas_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
-			     unsigned long *config)
+static int oxnas_ox810se_pinconf_get(struct pinctrl_dev *pctldev,
+				     unsigned int pin, unsigned long *config)
 {
 	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
@@ -521,8 +524,8 @@ static int oxnas_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		ret = regmap_read(pctl->regmap,
 				  (bank->id ?
-					PINMUX_PULLUP_CTRL1 :
-					PINMUX_PULLUP_CTRL0),
+					PINMUX_810_PULLUP_CTRL1 :
+					PINMUX_810_PULLUP_CTRL0),
 				  &arg);
 		if (ret)
 			return ret;
@@ -538,8 +541,9 @@ static int oxnas_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 	return 0;
 }
 
-static int oxnas_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			     unsigned long *configs, unsigned int num_configs)
+static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
+				     unsigned int pin, unsigned long *configs,
+				     unsigned int num_configs)
 {
 	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
@@ -561,8 +565,8 @@ static int oxnas_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			dev_dbg(pctl->dev, "   pullup\n");
 			regmap_write_bits(pctl->regmap,
 					  (bank->id ?
-						PINMUX_PULLUP_CTRL1 :
-						PINMUX_PULLUP_CTRL0),
+						PINMUX_810_PULLUP_CTRL1 :
+						PINMUX_810_PULLUP_CTRL0),
 					  mask, mask);
 			break;
 		default:
@@ -575,20 +579,12 @@ static int oxnas_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	return 0;
 }
 
-static const struct pinconf_ops oxnas_pinconf_ops = {
-	.pin_config_get = oxnas_pinconf_get,
-	.pin_config_set = oxnas_pinconf_set,
+static const struct pinconf_ops oxnas_ox810se_pinconf_ops = {
+	.pin_config_get = oxnas_ox810se_pinconf_get,
+	.pin_config_set = oxnas_ox810se_pinconf_set,
 	.is_generic = true,
 };
 
-static struct pinctrl_desc oxnas_pinctrl_desc = {
-	.name = "oxnas-pinctrl",
-	.pctlops = &oxnas_pinctrl_ops,
-	.pmxops = &oxnas_pinmux_ops,
-	.confops = &oxnas_pinconf_ops,
-	.owner = THIS_MODULE,
-};
-
 static void oxnas_gpio_irq_ack(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
@@ -699,10 +695,51 @@ static struct oxnas_gpio_bank oxnas_gpio_banks[] = {
 	GPIO_BANK(1),
 };
 
+static struct oxnas_pinctrl ox810se_pinctrl = {
+	.functions = oxnas_ox810se_functions,
+	.nfunctions = ARRAY_SIZE(oxnas_ox810se_functions),
+	.groups = oxnas_ox810se_groups,
+	.ngroups = ARRAY_SIZE(oxnas_ox810se_groups),
+	.gpio_banks = oxnas_gpio_banks,
+	.nbanks = ARRAY_SIZE(oxnas_gpio_banks),
+};
+
+static struct pinctrl_desc oxnas_ox810se_pinctrl_desc = {
+	.name = "oxnas-pinctrl",
+	.pins = oxnas_ox810se_pins,
+	.npins = ARRAY_SIZE(oxnas_ox810se_pins),
+	.pctlops = &oxnas_pinctrl_ops,
+	.pmxops = &oxnas_ox810se_pinmux_ops,
+	.confops = &oxnas_ox810se_pinconf_ops,
+	.owner = THIS_MODULE,
+};
+
+static struct oxnas_pinctrl_data oxnas_ox810se_pinctrl_data = {
+	.desc = &oxnas_ox810se_pinctrl_desc,
+	.pctl = &ox810se_pinctrl,
+};
+
+static const struct of_device_id oxnas_pinctrl_of_match[] = {
+	{ .compatible = "oxsemi,ox810se-pinctrl",
+	  .data = &oxnas_ox810se_pinctrl_data
+	},
+	{ },
+};
+
 static int oxnas_pinctrl_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *id;
+	const struct oxnas_pinctrl_data *data;
 	struct oxnas_pinctrl *pctl;
 
+	id = of_match_node(oxnas_pinctrl_of_match, pdev->dev.of_node);
+	if (!id)
+		return -ENODEV;
+
+	data = id->data;
+	if (!data || !data->pctl || !data->desc)
+		return -EINVAL;
+
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
 		return -ENOMEM;
@@ -716,20 +753,14 @@ static int oxnas_pinctrl_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pctl->pins = oxnas_pins;
-	pctl->npins = ARRAY_SIZE(oxnas_pins);
-	pctl->functions = oxnas_functions;
-	pctl->nfunctions = ARRAY_SIZE(oxnas_functions);
-	pctl->groups = oxnas_groups;
-	pctl->ngroups = ARRAY_SIZE(oxnas_groups);
-	pctl->gpio_banks = oxnas_gpio_banks;
-	pctl->nbanks = ARRAY_SIZE(oxnas_gpio_banks);
+	pctl->functions = data->pctl->functions;
+	pctl->nfunctions = data->pctl->nfunctions;
+	pctl->groups = data->pctl->groups;
+	pctl->ngroups = data->pctl->ngroups;
+	pctl->gpio_banks = data->pctl->gpio_banks;
+	pctl->nbanks = data->pctl->nbanks;
 
-	oxnas_pinctrl_desc.pins = pctl->pins;
-	oxnas_pinctrl_desc.npins = pctl->npins;
-
-	pctl->pctldev = pinctrl_register(&oxnas_pinctrl_desc,
-					 &pdev->dev, pctl);
+	pctl->pctldev = pinctrl_register(data->desc, &pdev->dev, pctl);
 	if (IS_ERR(pctl->pctldev)) {
 		dev_err(&pdev->dev, "Failed to register pinctrl device\n");
 		return PTR_ERR(pctl->pctldev);
@@ -805,11 +836,6 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id oxnas_pinctrl_of_match[] = {
-	{ .compatible = "oxsemi,ox810se-pinctrl", },
-	{ },
-};
-
 static struct platform_driver oxnas_pinctrl_driver = {
 	.driver = {
 		.name = "oxnas-pinctrl",
-- 
2.7.0
