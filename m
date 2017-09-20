From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:25 +0200
Subject: [PATCH 6/8] pinctrl: meson: get rid of pin_base
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pin_base was used with the manually set pin offset in meson pinctrl. This
is no longer the case, pin_base is 0 on every meson pinctrl controllers
and should go away.

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |  2 --
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  |  2 --
 drivers/pinctrl/meson/pinctrl-meson.c      | 30 +++++++++++++-----------------
 drivers/pinctrl/meson/pinctrl-meson8.c     |  2 --
 drivers/pinctrl/meson/pinctrl-meson8b.c    |  2 --
 5 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 6d52842d3ee5..8e0d6e4a31b4 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -820,7 +820,6 @@ static struct meson_bank meson_gxbb_aobus_banks[] = {
 
 struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
-	.pin_base	= 0,
 	.pins		= meson_gxbb_periphs_pins,
 	.groups		= meson_gxbb_periphs_groups,
 	.funcs		= meson_gxbb_periphs_functions,
@@ -833,7 +832,6 @@ struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 
 struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
-	.pin_base	= 0,
 	.pins		= meson_gxbb_aobus_pins,
 	.groups		= meson_gxbb_aobus_groups,
 	.funcs		= meson_gxbb_aobus_functions,
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 32e35ba9c04e..0d90ddab6ddd 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -807,7 +807,6 @@ static struct meson_bank meson_gxl_aobus_banks[] = {
 
 struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
-	.pin_base	= 0,
 	.pins		= meson_gxl_periphs_pins,
 	.groups		= meson_gxl_periphs_groups,
 	.funcs		= meson_gxl_periphs_functions,
@@ -820,7 +819,6 @@ struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
 
 struct meson_pinctrl_data meson_gxl_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
-	.pin_base	= 0,
 	.pins		= meson_gxl_aobus_pins,
 	.groups		= meson_gxl_aobus_groups,
 	.funcs		= meson_gxl_aobus_functions,
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 247208150b19..c9cd54de0449 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -413,16 +413,15 @@ static const struct pinconf_ops meson_pinconf_ops = {
 static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit, pin;
+	unsigned int reg, bit;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = pc->data->pin_base + gpio;
-	ret = meson_get_bank(pc, pin, &bank);
+	ret = meson_get_bank(pc, gpio, &bank);
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DIR, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
 
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit), BIT(bit));
 }
@@ -431,21 +430,20 @@ static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 				       int value)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit, pin;
+	unsigned int reg, bit;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = pc->data->pin_base + gpio;
-	ret = meson_get_bank(pc, pin, &bank);
+	ret = meson_get_bank(pc, gpio, &bank);
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_DIR, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, REG_DIR, &reg, &bit);
 	ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_OUT, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
 	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
 				  value ? BIT(bit) : 0);
 }
@@ -453,16 +451,15 @@ static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 static void meson_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit, pin;
+	unsigned int reg, bit;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = pc->data->pin_base + gpio;
-	ret = meson_get_bank(pc, pin, &bank);
+	ret = meson_get_bank(pc, gpio, &bank);
 	if (ret)
 		return;
 
-	meson_calc_reg_and_bit(bank, pin, REG_OUT, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, REG_OUT, &reg, &bit);
 	regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
 			   value ? BIT(bit) : 0);
 }
@@ -470,16 +467,15 @@ static void meson_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
-	unsigned int reg, bit, val, pin;
+	unsigned int reg, bit, val;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = pc->data->pin_base + gpio;
-	ret = meson_get_bank(pc, pin, &bank);
+	ret = meson_get_bank(pc, gpio, &bank);
 	if (ret)
 		return ret;
 
-	meson_calc_reg_and_bit(bank, pin, REG_IN, &reg, &bit);
+	meson_calc_reg_and_bit(bank, gpio, REG_IN, &reg, &bit);
 	regmap_read(pc->reg_gpio, reg, &val);
 
 	return !!(val & BIT(bit));
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 7344f8577467..fbf8ecd1c2b6 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -1046,7 +1046,6 @@ static struct meson_bank meson8_aobus_banks[] = {
 
 struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
-	.pin_base	= 0,
 	.pins		= meson8_cbus_pins,
 	.groups		= meson8_cbus_groups,
 	.funcs		= meson8_cbus_functions,
@@ -1059,7 +1058,6 @@ struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8_aobus_pinctrl_data = {
 	.name		= "ao-bank",
-	.pin_base	= 0,
 	.pins		= meson8_aobus_pins,
 	.groups		= meson8_aobus_groups,
 	.funcs		= meson8_aobus_functions,
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index c3c247bfbc60..7af296db48c8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -906,7 +906,6 @@ static struct meson_bank meson8b_aobus_banks[] = {
 
 struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
-	.pin_base	= 0,
 	.pins		= meson8b_cbus_pins,
 	.groups		= meson8b_cbus_groups,
 	.funcs		= meson8b_cbus_functions,
@@ -919,7 +918,6 @@ struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 
 struct meson_pinctrl_data meson8b_aobus_pinctrl_data = {
 	.name		= "aobus-banks",
-	.pin_base	= 0,
 	.pins		= meson8b_aobus_pins,
 	.groups		= meson8b_aobus_groups,
 	.funcs		= meson8b_aobus_functions,
-- 
2.13.5
