From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 15:41:47 +0200
Subject: [PATCH 2/3] pinctrl: oxnas: Add support for OX820
In-Reply-To: <20161004134148.23028-1-narmstrong@baylibre.com>
References: <20161004134148.23028-1-narmstrong@baylibre.com>
Message-ID: <20161004134148.23028-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Oxford Semiconductor OX820 which is similar as OX810 but
has 50 pins and two registers banks to setup alternate functions.
Add specific pins, groups and functions structures.
Add DT match data to select corresponding support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/pinctrl-oxnas.c | 433 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 433 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 218ad48..494ec9a 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -47,6 +47,15 @@
 #define PINMUX_810_PULLUP_CTRL0		0xac
 #define PINMUX_810_PULLUP_CTRL1		0xb0
 
+/* OX820 Regmap Offsets */
+#define PINMUX_820_BANK_OFFSET		0x100000
+#define PINMUX_820_SECONDARY_SEL	0x14
+#define PINMUX_820_TERTIARY_SEL		0x8c
+#define PINMUX_820_QUATERNARY_SEL	0x94
+#define PINMUX_820_DEBUG_SEL		0x9c
+#define PINMUX_820_ALTERNATIVE_SEL	0xa4
+#define PINMUX_820_PULLUP_CTRL		0xac
+
 /* GPIO Registers */
 #define INPUT_VALUE	0x00
 #define OUTPUT_EN	0x04
@@ -138,6 +147,59 @@ static const struct pinctrl_pin_desc oxnas_ox810se_pins[] = {
 	PINCTRL_PIN(34, "gpio34"),
 };
 
+static const struct pinctrl_pin_desc oxnas_ox820_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+	PINCTRL_PIN(23, "gpio23"),
+	PINCTRL_PIN(24, "gpio24"),
+	PINCTRL_PIN(25, "gpio25"),
+	PINCTRL_PIN(26, "gpio26"),
+	PINCTRL_PIN(27, "gpio27"),
+	PINCTRL_PIN(28, "gpio28"),
+	PINCTRL_PIN(29, "gpio29"),
+	PINCTRL_PIN(30, "gpio30"),
+	PINCTRL_PIN(31, "gpio31"),
+	PINCTRL_PIN(32, "gpio32"),
+	PINCTRL_PIN(33, "gpio33"),
+	PINCTRL_PIN(34, "gpio34"),
+	PINCTRL_PIN(35, "gpio35"),
+	PINCTRL_PIN(36, "gpio36"),
+	PINCTRL_PIN(37, "gpio37"),
+	PINCTRL_PIN(38, "gpio38"),
+	PINCTRL_PIN(39, "gpio39"),
+	PINCTRL_PIN(40, "gpio40"),
+	PINCTRL_PIN(41, "gpio41"),
+	PINCTRL_PIN(42, "gpio42"),
+	PINCTRL_PIN(43, "gpio43"),
+	PINCTRL_PIN(44, "gpio44"),
+	PINCTRL_PIN(45, "gpio45"),
+	PINCTRL_PIN(46, "gpio46"),
+	PINCTRL_PIN(47, "gpio47"),
+	PINCTRL_PIN(48, "gpio48"),
+	PINCTRL_PIN(49, "gpio49"),
+};
+
 static const char * const oxnas_ox810se_fct0_group[] = {
 	"gpio0",  "gpio1",  "gpio2",  "gpio3",
 	"gpio4",  "gpio5",  "gpio6",  "gpio7",
@@ -161,6 +223,40 @@ static const char * const oxnas_ox810se_fct3_group[] = {
 	"gpio34"
 };
 
+static const char * const oxnas_ox820_fct0_group[] = {
+	"gpio0",  "gpio1",  "gpio2",  "gpio3",
+	"gpio4",  "gpio5",  "gpio6",  "gpio7",
+	"gpio8",  "gpio9",  "gpio10", "gpio11",
+	"gpio12", "gpio13", "gpio14", "gpio15",
+	"gpio16", "gpio17", "gpio18", "gpio19",
+	"gpio20", "gpio21", "gpio22", "gpio23",
+	"gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31",
+	"gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39",
+	"gpio40", "gpio41", "gpio42", "gpio43",
+	"gpio44", "gpio45", "gpio46", "gpio47",
+	"gpio48", "gpio49"
+};
+
+static const char * const oxnas_ox820_fct1_group[] = {
+	"gpio3", "gpio4",
+	"gpio12", "gpio13", "gpio14", "gpio15",
+	"gpio16", "gpio17", "gpio18", "gpio19",
+	"gpio20", "gpio21", "gpio22", "gpio23",
+	"gpio24"
+};
+
+static const char * const oxnas_ox820_fct4_group[] = {
+	"gpio5", "gpio6", "gpio7", "gpio8",
+	"gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio40", "gpio41", "gpio42", "gpio43"
+};
+
+static const char * const oxnas_ox820_fct5_group[] = {
+	"gpio28", "gpio29", "gpio30", "gpio31"
+};
+
 #define FUNCTION(_name, _gr)					\
 	{							\
 		.name = #_name,					\
@@ -173,6 +269,13 @@ static const struct oxnas_function oxnas_ox810se_functions[] = {
 	FUNCTION(fct3, ox810se_fct3),
 };
 
+static const struct oxnas_function oxnas_ox820_functions[] = {
+	FUNCTION(gpio, ox820_fct0),
+	FUNCTION(fct1, ox820_fct1),
+	FUNCTION(fct4, ox820_fct4),
+	FUNCTION(fct5, ox820_fct5),
+};
+
 #define OXNAS_PINCTRL_GROUP(_pin, _name, ...)				\
 	{								\
 		.name = #_name,						\
@@ -285,6 +388,140 @@ static const struct oxnas_pin_group oxnas_ox810se_groups[] = {
 			OXNAS_PINCTRL_FUNCTION(fct3, 3)),
 };
 
+static const struct oxnas_pin_group oxnas_ox820_groups[] = {
+	OXNAS_PINCTRL_GROUP(0, gpio0,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(1, gpio1,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(2, gpio2,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(3, gpio3,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(4, gpio4,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(5, gpio5,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(6, gpio6,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(7, gpio7,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(8, gpio8,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(9, gpio9,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(10, gpio10,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(11, gpio11,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(12, gpio12,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(13, gpio13,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(14, gpio14,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(15, gpio15,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(16, gpio16,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(17, gpio17,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(18, gpio18,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(19, gpio19,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(20, gpio20,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(21, gpio21,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(22, gpio22,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(23, gpio23,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1)),
+	OXNAS_PINCTRL_GROUP(24, gpio24,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct1, 1),
+			OXNAS_PINCTRL_FUNCTION(fct4, 5)),
+	OXNAS_PINCTRL_GROUP(25, gpio25,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(26, gpio26,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(27, gpio27,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(28, gpio28,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct5, 5)),
+	OXNAS_PINCTRL_GROUP(29, gpio29,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct5, 5)),
+	OXNAS_PINCTRL_GROUP(30, gpio30,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct5, 5)),
+	OXNAS_PINCTRL_GROUP(31, gpio31,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct5, 5)),
+	OXNAS_PINCTRL_GROUP(32, gpio32,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(33, gpio33,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(34, gpio34,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(35, gpio35,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(36, gpio36,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(37, gpio37,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(38, gpio38,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(39, gpio39,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(40, gpio40,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(41, gpio41,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(42, gpio42,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(43, gpio43,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0),
+			OXNAS_PINCTRL_FUNCTION(fct4, 4)),
+	OXNAS_PINCTRL_GROUP(44, gpio44,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(45, gpio45,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(46, gpio46,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(47, gpio47,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(48, gpio48,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+	OXNAS_PINCTRL_GROUP(49, gpio49,
+			OXNAS_PINCTRL_FUNCTION(gpio, 0)),
+};
+
 static inline struct oxnas_gpio_bank *pctl_to_bank(struct oxnas_pinctrl *pctl,
 						   unsigned int pin)
 {
@@ -405,6 +642,61 @@ static int oxnas_ox810se_pinmux_enable(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
+static int oxnas_ox820_pinmux_enable(struct pinctrl_dev *pctldev,
+				     unsigned int func, unsigned int group)
+{
+	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct oxnas_pin_group *pg = &pctl->groups[group];
+	const struct oxnas_function *pf = &pctl->functions[func];
+	const char *fname = pf->name;
+	struct oxnas_desc_function *functions = pg->functions;
+	unsigned int offset = (pg->bank ? PINMUX_820_BANK_OFFSET : 0);
+	u32 mask = BIT(pg->pin);
+
+	while (functions->name) {
+		if (!strcmp(functions->name, fname)) {
+			dev_dbg(pctl->dev,
+				"setting function %s bank %d pin %d fct %d mask %x\n",
+				fname, pg->bank, pg->pin,
+				functions->fct, mask);
+
+			regmap_write_bits(pctl->regmap,
+					  offset + PINMUX_820_SECONDARY_SEL,
+					  mask,
+					  (functions->fct == 1 ?
+						mask : 0));
+			regmap_write_bits(pctl->regmap,
+					  offset + PINMUX_820_TERTIARY_SEL,
+					  mask,
+					  (functions->fct == 2 ?
+						mask : 0));
+			regmap_write_bits(pctl->regmap,
+					  offset + PINMUX_820_QUATERNARY_SEL,
+					  mask,
+					  (functions->fct == 3 ?
+						mask : 0));
+			regmap_write_bits(pctl->regmap,
+					  offset + PINMUX_820_DEBUG_SEL,
+					  mask,
+					  (functions->fct == 4 ?
+						mask : 0));
+			regmap_write_bits(pctl->regmap,
+					  offset + PINMUX_820_ALTERNATIVE_SEL,
+					  mask,
+					  (functions->fct == 5 ?
+						mask : 0));
+
+			return 0;
+		}
+
+		functions++;
+	}
+
+	dev_err(pctl->dev, "cannot mux pin %u to function %u\n", group, func);
+
+	return -EINVAL;
+}
+
 static int oxnas_ox810se_gpio_request_enable(struct pinctrl_dev *pctldev,
 					     struct pinctrl_gpio_range *range,
 					     unsigned int offset)
@@ -435,6 +727,37 @@ static int oxnas_ox810se_gpio_request_enable(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int oxnas_ox820_gpio_request_enable(struct pinctrl_dev *pctldev,
+					   struct pinctrl_gpio_range *range,
+					   unsigned int offset)
+{
+	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct oxnas_gpio_bank *bank = gpiochip_get_data(range->gc);
+	unsigned int bank_offset = (bank->id ? PINMUX_820_BANK_OFFSET : 0);
+	u32 mask = BIT(offset - bank->gpio_chip.base);
+
+	dev_dbg(pctl->dev, "requesting gpio %d in bank %d (id %d) with mask 0x%x\n",
+		offset, bank->gpio_chip.base, bank->id, mask);
+
+	regmap_write_bits(pctl->regmap,
+			  bank_offset + PINMUX_820_SECONDARY_SEL,
+			  mask, 0);
+	regmap_write_bits(pctl->regmap,
+			  bank_offset + PINMUX_820_TERTIARY_SEL,
+			  mask, 0);
+	regmap_write_bits(pctl->regmap,
+			  bank_offset + PINMUX_820_QUATERNARY_SEL,
+			  mask, 0);
+	regmap_write_bits(pctl->regmap,
+			  bank_offset + PINMUX_820_DEBUG_SEL,
+			  mask, 0);
+	regmap_write_bits(pctl->regmap,
+			  bank_offset + PINMUX_820_ALTERNATIVE_SEL,
+			  mask, 0);
+
+	return 0;
+}
+
 static int oxnas_gpio_get_direction(struct gpio_chip *chip,
 				      unsigned int offset)
 {
@@ -510,6 +833,15 @@ static const struct pinmux_ops oxnas_ox810se_pinmux_ops = {
 	.gpio_set_direction = oxnas_gpio_set_direction,
 };
 
+static const struct pinmux_ops oxnas_ox820_pinmux_ops = {
+	.get_functions_count = oxnas_pinmux_get_functions_count,
+	.get_function_name = oxnas_pinmux_get_function_name,
+	.get_function_groups = oxnas_pinmux_get_function_groups,
+	.set_mux = oxnas_ox820_pinmux_enable,
+	.gpio_request_enable = oxnas_ox820_gpio_request_enable,
+	.gpio_set_direction = oxnas_gpio_set_direction,
+};
+
 static int oxnas_ox810se_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int pin, unsigned long *config)
 {
@@ -541,6 +873,36 @@ static int oxnas_ox810se_pinconf_get(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int oxnas_ox820_pinconf_get(struct pinctrl_dev *pctldev,
+				   unsigned int pin, unsigned long *config)
+{
+	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int bank_offset = (bank->id ? PINMUX_820_BANK_OFFSET : 0);
+	u32 mask = BIT(pin - bank->gpio_chip.base);
+	int ret;
+	u32 arg;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		ret = regmap_read(pctl->regmap,
+				  bank_offset + PINMUX_820_PULLUP_CTRL,
+				  &arg);
+		if (ret)
+			return ret;
+
+		arg = !!(arg & mask);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
 static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
 				     unsigned int pin, unsigned long *configs,
 				     unsigned int num_configs)
@@ -579,12 +941,55 @@ static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int oxnas_ox820_pinconf_set(struct pinctrl_dev *pctldev,
+				   unsigned int pin, unsigned long *configs,
+				   unsigned int num_configs)
+{
+	struct oxnas_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct oxnas_gpio_bank *bank = pctl_to_bank(pctl, pin);
+	unsigned int bank_offset = (bank->id ? PINMUX_820_BANK_OFFSET : 0);
+	unsigned int param;
+	u32 arg;
+	unsigned int i;
+	u32 offset = pin - bank->gpio_chip.base;
+	u32 mask = BIT(offset);
+
+	dev_dbg(pctl->dev, "setting pin %d bank %d mask 0x%x\n",
+		pin, bank->gpio_chip.base, mask);
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_PULL_UP:
+			dev_dbg(pctl->dev, "   pullup\n");
+			regmap_write_bits(pctl->regmap,
+					  bank_offset + PINMUX_820_PULLUP_CTRL,
+					  mask, mask);
+			break;
+		default:
+			dev_err(pctl->dev, "Property %u not supported\n",
+				param);
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
 static const struct pinconf_ops oxnas_ox810se_pinconf_ops = {
 	.pin_config_get = oxnas_ox810se_pinconf_get,
 	.pin_config_set = oxnas_ox810se_pinconf_set,
 	.is_generic = true,
 };
 
+static const struct pinconf_ops oxnas_ox820_pinconf_ops = {
+	.pin_config_get = oxnas_ox820_pinconf_get,
+	.pin_config_set = oxnas_ox820_pinconf_set,
+	.is_generic = true,
+};
+
 static void oxnas_gpio_irq_ack(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
@@ -714,15 +1119,42 @@ static struct pinctrl_desc oxnas_ox810se_pinctrl_desc = {
 	.owner = THIS_MODULE,
 };
 
+static struct oxnas_pinctrl ox820_pinctrl = {
+	.functions = oxnas_ox820_functions,
+	.nfunctions = ARRAY_SIZE(oxnas_ox820_functions),
+	.groups = oxnas_ox820_groups,
+	.ngroups = ARRAY_SIZE(oxnas_ox820_groups),
+	.gpio_banks = oxnas_gpio_banks,
+	.nbanks = ARRAY_SIZE(oxnas_gpio_banks),
+};
+
+static struct pinctrl_desc oxnas_ox820_pinctrl_desc = {
+	.name = "oxnas-pinctrl",
+	.pins = oxnas_ox820_pins,
+	.npins = ARRAY_SIZE(oxnas_ox820_pins),
+	.pctlops = &oxnas_pinctrl_ops,
+	.pmxops = &oxnas_ox820_pinmux_ops,
+	.confops = &oxnas_ox820_pinconf_ops,
+	.owner = THIS_MODULE,
+};
+
 static struct oxnas_pinctrl_data oxnas_ox810se_pinctrl_data = {
 	.desc = &oxnas_ox810se_pinctrl_desc,
 	.pctl = &ox810se_pinctrl,
 };
 
+static struct oxnas_pinctrl_data oxnas_ox820_pinctrl_data = {
+	.desc = &oxnas_ox820_pinctrl_desc,
+	.pctl = &ox820_pinctrl,
+};
+
 static const struct of_device_id oxnas_pinctrl_of_match[] = {
 	{ .compatible = "oxsemi,ox810se-pinctrl",
 	  .data = &oxnas_ox810se_pinctrl_data
 	},
+	{ .compatible = "oxsemi,ox820-pinctrl",
+	  .data = &oxnas_ox820_pinctrl_data,
+	},
 	{ },
 };
 
@@ -847,6 +1279,7 @@ static struct platform_driver oxnas_pinctrl_driver = {
 
 static const struct of_device_id oxnas_gpio_of_match[] = {
 	{ .compatible = "oxsemi,ox810se-gpio", },
+	{ .compatible = "oxsemi,ox820-gpio", },
 	{ },
 };
 
-- 
2.7.0
