From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:13 +0200
Subject: [PATCH v2 03/10] pinctrl: axp209: use drv_data of pinctrl_pin_desc to
 store pin reg
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <7993a30fbc2e50a2d228fa0c8fad643c4034b101.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using a function to retrieve each pin's correct control
register, use drv_data within pinctrl_pin_desc to store the ctrl reg.

Remove axp20x_gpio_get_reg and replace every occurrence by a get from
drv_data.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 42 +++++++--------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index b35e8dd..4bbcba2 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -32,10 +32,11 @@
 #define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
 #define AXP20X_GPIO_FUNCTION_INPUT	2
 
-#define AXP20X_PINCTRL_PIN(_pin_num, _pin)			\
+#define AXP20X_PINCTRL_PIN(_pin_num, _pin, _regs)		\
 	{							\
 		.number = _pin_num,				\
 		.name = _pin,					\
+		.drv_data = _regs,				\
 	}
 
 #define AXP20X_PIN(_pin, ...)					\
@@ -91,17 +92,17 @@ struct axp20x_gpio {
 };
 
 static const struct axp20x_desc_pin axp209_pins[] = {
-	AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0"),
+	AXP20X_PIN(AXP20X_PINCTRL_PIN(0, "GPIO0", (void *)AXP20X_GPIO0_CTRL),
 		   AXP20X_FUNCTION(0x0, "gpio_out"),
 		   AXP20X_FUNCTION(0x2, "gpio_in"),
 		   AXP20X_FUNCTION(0x3, "ldo"),
 		   AXP20X_FUNCTION(0x4, "adc")),
-	AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1"),
+	AXP20X_PIN(AXP20X_PINCTRL_PIN(1, "GPIO1", (void *)AXP20X_GPIO1_CTRL),
 		   AXP20X_FUNCTION(0x0, "gpio_out"),
 		   AXP20X_FUNCTION(0x2, "gpio_in"),
 		   AXP20X_FUNCTION(0x3, "ldo"),
 		   AXP20X_FUNCTION(0x4, "adc")),
-	AXP20X_PIN(AXP20X_PINCTRL_PIN(2, "GPIO2"),
+	AXP20X_PIN(AXP20X_PINCTRL_PIN(2, "GPIO2", (void *)AXP20X_GPIO2_CTRL),
 		   AXP20X_FUNCTION(0x0, "gpio_out"),
 		   AXP20X_FUNCTION(0x2, "gpio_in")),
 };
@@ -111,20 +112,6 @@ static const struct axp20x_pinctrl_desc axp20x_pinctrl_data = {
 	.npins	= ARRAY_SIZE(axp209_pins),
 };
 
-static int axp20x_gpio_get_reg(unsigned offset)
-{
-	switch (offset) {
-	case 0:
-		return AXP20X_GPIO0_CTRL;
-	case 1:
-		return AXP20X_GPIO1_CTRL;
-	case 2:
-		return AXP20X_GPIO2_CTRL;
-	}
-
-	return -EINVAL;
-}
-
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	return pinctrl_gpio_direction_input(chip->base + offset);
@@ -146,12 +133,9 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
+	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
 	unsigned int val;
-	int reg, ret;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
+	int ret;
 
 	ret = regmap_read(gpio->regmap, reg, &val);
 	if (ret)
@@ -184,11 +168,7 @@ static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
 			    int value)
 {
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	int reg;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return;
+	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
 
 	regmap_update_bits(gpio->regmap, reg,
 			   AXP20X_GPIO_FUNCTIONS,
@@ -200,11 +180,7 @@ static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
 			  u8 config)
 {
 	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
-	int reg;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
+	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
 
 	return regmap_update_bits(gpio->regmap, reg, AXP20X_GPIO_FUNCTIONS,
 				  config);
-- 
git-series 0.9.1
