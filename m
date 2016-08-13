From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 13 Aug 2016 19:41:18 +0200
Subject: [PATCH] pinctrl: meson: get rid of unneeded domain structures
Message-ID: <1471110078-5946-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver originally supported more domains (register ranges) per
pinctrl device, but since commit 9dab1868ec0d ("pinctrl: amlogic: Make
driver independent from two-domain configuration") each device gets
assigned a single domain and we instantiate multiple pinctrl devices
in the DT.

Therefore, now the 'meson_domain' and 'meson_domain_data' structures
don't have any reason to exist and can be removed to make the model
simpler to understand. This commit doesn't change behavior.

Tested on a Odroid-C2.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |  24 +---
 drivers/pinctrl/meson/pinctrl-meson.c      | 222 +++++++++++------------------
 drivers/pinctrl/meson/pinctrl-meson.h      |  52 ++-----
 drivers/pinctrl/meson/pinctrl-meson8.c     |  24 +---
 drivers/pinctrl/meson/pinctrl-meson8b.c    |  24 +---
 5 files changed, 118 insertions(+), 228 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index cb4d6ad..233c9c8 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -556,38 +556,28 @@ static struct meson_bank meson_gxbb_aobus_banks[] = {
 	BANK("AO",   PIN(GPIOAO_0, 0),  PIN(GPIOAO_13, 0), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
-static struct meson_domain_data meson_gxbb_periphs_domain_data = {
+struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
-	.banks		= meson_gxbb_periphs_banks,
-	.num_banks	= ARRAY_SIZE(meson_gxbb_periphs_banks),
 	.pin_base	= 14,
-	.num_pins	= 120,
-};
-
-static struct meson_domain_data meson_gxbb_aobus_domain_data = {
-	.name		= "aobus-banks",
-	.banks		= meson_gxbb_aobus_banks,
-	.num_banks	= ARRAY_SIZE(meson_gxbb_aobus_banks),
-	.pin_base	= 0,
-	.num_pins	= 14,
-};
-
-struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
 	.pins		= meson_gxbb_periphs_pins,
 	.groups		= meson_gxbb_periphs_groups,
 	.funcs		= meson_gxbb_periphs_functions,
-	.domain_data	= &meson_gxbb_periphs_domain_data,
+	.banks		= meson_gxbb_periphs_banks,
 	.num_pins	= ARRAY_SIZE(meson_gxbb_periphs_pins),
 	.num_groups	= ARRAY_SIZE(meson_gxbb_periphs_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxbb_periphs_functions),
+	.num_banks	= ARRAY_SIZE(meson_gxbb_periphs_banks),
 };
 
 struct meson_pinctrl_data meson_gxbb_aobus_pinctrl_data = {
+	.name		= "aobus-banks",
+	.pin_base	= 0,
 	.pins		= meson_gxbb_aobus_pins,
 	.groups		= meson_gxbb_aobus_groups,
 	.funcs		= meson_gxbb_aobus_functions,
-	.domain_data	= &meson_gxbb_aobus_domain_data,
+	.banks		= meson_gxbb_aobus_banks,
 	.num_pins	= ARRAY_SIZE(meson_gxbb_aobus_pins),
 	.num_groups	= ARRAY_SIZE(meson_gxbb_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson_gxbb_aobus_functions),
+	.num_banks	= ARRAY_SIZE(meson_gxbb_aobus_banks),
 };
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 11623c6..9678599 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -21,9 +21,8 @@
  * domain which can't be powered off; the bank also uses a set of
  * registers different from the other banks.
  *
- * For each of the two power domains (regular and always-on) there are
- * 4 different register ranges that control the following properties
- * of the pins:
+ * For each pin controller there are 4 different register ranges that
+ * control the following properties of the pins:
  *  1) pin muxing
  *  2) pull enable/disable
  *  3) pull up/down
@@ -33,8 +32,8 @@
  * direction are the same and thus there are only 3 register ranges.
  *
  * Every pinmux group can be enabled by a specific bit in the first
- * register range of the domain; when all groups for a given pin are
- * disabled the pin acts as a GPIO.
+ * register range; when all groups for a given pin are disabled the
+ * pin acts as a GPIO.
  *
  * For the pull and GPIO configuration every bank uses a contiguous
  * set of bits in the register sets described above; the same register
@@ -66,21 +65,21 @@
 /**
  * meson_get_bank() - find the bank containing a given pin
  *
- * @domain:	the domain containing the pin
+ * @pc:		the pinctrl instance
  * @pin:	the pin number
  * @bank:	the found bank
  *
  * Return:	0 on success, a negative value on error
  */
-static int meson_get_bank(struct meson_domain *domain, unsigned int pin,
+static int meson_get_bank(struct meson_pinctrl *pc, unsigned int pin,
 			  struct meson_bank **bank)
 {
 	int i;
 
-	for (i = 0; i < domain->data->num_banks; i++) {
-		if (pin >= domain->data->banks[i].first &&
-		    pin <= domain->data->banks[i].last) {
-			*bank = &domain->data->banks[i];
+	for (i = 0; i < pc->data->num_banks; i++) {
+		if (pin >= pc->data->banks[i].first &&
+		    pin <= pc->data->banks[i].last) {
+			*bank = &pc->data->banks[i];
 			return 0;
 		}
 	}
@@ -89,33 +88,6 @@ static int meson_get_bank(struct meson_domain *domain, unsigned int pin,
 }
 
 /**
- * meson_get_domain_and_bank() - find domain and bank containing a given pin
- *
- * @pc:		Meson pin controller device
- * @pin:	the pin number
- * @domain:	the found domain
- * @bank:	the found bank
- *
- * Return:	0 on success, a negative value on error
- */
-static int meson_get_domain_and_bank(struct meson_pinctrl *pc, unsigned int pin,
-				     struct meson_domain **domain,
-				     struct meson_bank **bank)
-{
-	struct meson_domain *d;
-
-	d = pc->domain;
-
-	if (pin >= d->data->pin_base &&
-	    pin < d->data->pin_base + d->data->num_pins) {
-		*domain = d;
-		return meson_get_bank(d, pin, bank);
-	}
-
-	return -EINVAL;
-}
-
-/**
  * meson_calc_reg_and_bit() - calculate register and bit for a pin
  *
  * @bank:	the bank containing the pin
@@ -190,7 +162,6 @@ static void meson_pmx_disable_other_groups(struct meson_pinctrl *pc,
 					   unsigned int pin, int sel_group)
 {
 	struct meson_pmx_group *group;
-	struct meson_domain *domain;
 	int i, j;
 
 	for (i = 0; i < pc->data->num_groups; i++) {
@@ -201,8 +172,7 @@ static void meson_pmx_disable_other_groups(struct meson_pinctrl *pc,
 		for (j = 0; j < group->num_pins; j++) {
 			if (group->pins[j] == pin) {
 				/* We have found a group using the pin */
-				domain = pc->domain;
-				regmap_update_bits(domain->reg_mux,
+				regmap_update_bits(pc->reg_mux,
 						   group->reg * 4,
 						   BIT(group->bit), 0);
 			}
@@ -216,7 +186,6 @@ static int meson_pmx_set_mux(struct pinctrl_dev *pcdev, unsigned func_num,
 	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	struct meson_pmx_func *func = &pc->data->funcs[func_num];
 	struct meson_pmx_group *group = &pc->data->groups[group_num];
-	struct meson_domain *domain = pc->domain;
 	int i, ret = 0;
 
 	dev_dbg(pc->dev, "enable function %s, group %s\n", func->name,
@@ -231,7 +200,7 @@ static int meson_pmx_set_mux(struct pinctrl_dev *pcdev, unsigned func_num,
 
 	/* Function 0 (GPIO) doesn't need any additional setting */
 	if (func_num)
-		ret = regmap_update_bits(domain->reg_mux, group->reg * 4,
+		ret = regmap_update_bits(pc->reg_mux, group->reg * 4,
 					 BIT(group->bit), BIT(group->bit));
 
 	return ret;
@@ -287,14 +256,13 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 			     unsigned long *configs, unsigned num_configs)
 {
 	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
-	struct meson_domain *domain;
 	struct meson_bank *bank;
 	enum pin_config_param param;
 	unsigned int reg, bit;
 	int i, ret;
 	u16 arg;
 
-	ret = meson_get_domain_and_bank(pc, pin, &domain, &bank);
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
@@ -307,7 +275,7 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(domain->reg_pull, reg,
+			ret = regmap_update_bits(pc->reg_pull, reg,
 						 BIT(bit), 0);
 			if (ret)
 				return ret;
@@ -317,13 +285,13 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
 					       &reg, &bit);
-			ret = regmap_update_bits(domain->reg_pullen, reg,
+			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), BIT(bit));
 			if (ret)
 				return ret;
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(domain->reg_pull, reg,
+			ret = regmap_update_bits(pc->reg_pull, reg,
 						 BIT(bit), BIT(bit));
 			if (ret)
 				return ret;
@@ -333,13 +301,13 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
 					       &reg, &bit);
-			ret = regmap_update_bits(domain->reg_pullen, reg,
+			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), BIT(bit));
 			if (ret)
 				return ret;
 
 			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(domain->reg_pull, reg,
+			ret = regmap_update_bits(pc->reg_pull, reg,
 						 BIT(bit), 0);
 			if (ret)
 				return ret;
@@ -354,18 +322,17 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 
 static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 {
-	struct meson_domain *domain;
 	struct meson_bank *bank;
 	unsigned int reg, bit, val;
 	int ret, conf;
 
-	ret = meson_get_domain_and_bank(pc, pin, &domain, &bank);
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
 	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
 
-	ret = regmap_read(domain->reg_pullen, reg, &val);
+	ret = regmap_read(pc->reg_pullen, reg, &val);
 	if (ret)
 		return ret;
 
@@ -374,7 +341,7 @@ static int meson_pinconf_get_pull(struct meson_pinctrl *pc, unsigned int pin)
 	} else {
 		meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
 
-		ret = regmap_read(domain->reg_pull, reg, &val);
+		ret = regmap_read(pc->reg_pull, reg, &val);
 		if (ret)
 			return ret;
 
@@ -452,82 +419,82 @@ static int meson_gpio_request(struct gpio_chip *chip, unsigned gpio)
 
 static void meson_gpio_free(struct gpio_chip *chip, unsigned gpio)
 {
-	struct meson_domain *domain = gpiochip_get_data(chip);
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
 
-	pinctrl_free_gpio(domain->data->pin_base + gpio);
+	pinctrl_free_gpio(pc->data->pin_base + gpio);
 }
 
 static int meson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct meson_domain *domain = gpiochip_get_data(chip);
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
 	unsigned int reg, bit, pin;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = domain->data->pin_base + gpio;
-	ret = meson_get_bank(domain, pin, &bank);
+	pin = pc->data->pin_base + gpio;
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
 	meson_calc_reg_and_bit(bank, pin, REG_DIR, &reg, &bit);
 
-	return regmap_update_bits(domain->reg_gpio, reg, BIT(bit), BIT(bit));
+	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit), BIT(bit));
 }
 
 static int meson_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 				       int value)
 {
-	struct meson_domain *domain = gpiochip_get_data(chip);
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
 	unsigned int reg, bit, pin;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = domain->data->pin_base + gpio;
-	ret = meson_get_bank(domain, pin, &bank);
+	pin = pc->data->pin_base + gpio;
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
 	meson_calc_reg_and_bit(bank, pin, REG_DIR, &reg, &bit);
-	ret = regmap_update_bits(domain->reg_gpio, reg, BIT(bit), 0);
+	ret = regmap_update_bits(pc->reg_gpio, reg, BIT(bit), 0);
 	if (ret)
 		return ret;
 
 	meson_calc_reg_and_bit(bank, pin, REG_OUT, &reg, &bit);
-	return regmap_update_bits(domain->reg_gpio, reg, BIT(bit),
+	return regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
 				  value ? BIT(bit) : 0);
 }
 
 static void meson_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 {
-	struct meson_domain *domain = gpiochip_get_data(chip);
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
 	unsigned int reg, bit, pin;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = domain->data->pin_base + gpio;
-	ret = meson_get_bank(domain, pin, &bank);
+	pin = pc->data->pin_base + gpio;
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return;
 
 	meson_calc_reg_and_bit(bank, pin, REG_OUT, &reg, &bit);
-	regmap_update_bits(domain->reg_gpio, reg, BIT(bit),
+	regmap_update_bits(pc->reg_gpio, reg, BIT(bit),
 			   value ? BIT(bit) : 0);
 }
 
 static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 {
-	struct meson_domain *domain = gpiochip_get_data(chip);
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
 	unsigned int reg, bit, val, pin;
 	struct meson_bank *bank;
 	int ret;
 
-	pin = domain->data->pin_base + gpio;
-	ret = meson_get_bank(domain, pin, &bank);
+	pin = pc->data->pin_base + gpio;
+	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
 	meson_calc_reg_and_bit(bank, pin, REG_IN, &reg, &bit);
-	regmap_read(domain->reg_gpio, reg, &val);
+	regmap_read(pc->reg_gpio, reg, &val);
 
 	return !!(val & BIT(bit));
 }
@@ -562,35 +529,32 @@ static const struct of_device_id meson_pinctrl_dt_match[] = {
 
 static int meson_gpiolib_register(struct meson_pinctrl *pc)
 {
-	struct meson_domain *domain;
 	int ret;
 
-	domain = pc->domain;
-
-	domain->chip.label = domain->data->name;
-	domain->chip.parent = pc->dev;
-	domain->chip.request = meson_gpio_request;
-	domain->chip.free = meson_gpio_free;
-	domain->chip.direction_input = meson_gpio_direction_input;
-	domain->chip.direction_output = meson_gpio_direction_output;
-	domain->chip.get = meson_gpio_get;
-	domain->chip.set = meson_gpio_set;
-	domain->chip.base = domain->data->pin_base;
-	domain->chip.ngpio = domain->data->num_pins;
-	domain->chip.can_sleep = false;
-	domain->chip.of_node = domain->of_node;
-	domain->chip.of_gpio_n_cells = 2;
-
-	ret = gpiochip_add_data(&domain->chip, domain);
+	pc->chip.label = pc->data->name;
+	pc->chip.parent = pc->dev;
+	pc->chip.request = meson_gpio_request;
+	pc->chip.free = meson_gpio_free;
+	pc->chip.direction_input = meson_gpio_direction_input;
+	pc->chip.direction_output = meson_gpio_direction_output;
+	pc->chip.get = meson_gpio_get;
+	pc->chip.set = meson_gpio_set;
+	pc->chip.base = pc->data->pin_base;
+	pc->chip.ngpio = pc->data->num_pins;
+	pc->chip.can_sleep = false;
+	pc->chip.of_node = pc->of_node;
+	pc->chip.of_gpio_n_cells = 2;
+
+	ret = gpiochip_add_data(&pc->chip, pc);
 	if (ret) {
 		dev_err(pc->dev, "can't add gpio chip %s\n",
-			domain->data->name);
+			pc->data->name);
 		goto fail;
 	}
 
-	ret = gpiochip_add_pin_range(&domain->chip, dev_name(pc->dev),
-				     0, domain->data->pin_base,
-				     domain->chip.ngpio);
+	ret = gpiochip_add_pin_range(&pc->chip, dev_name(pc->dev),
+				     0, pc->data->pin_base,
+				     pc->chip.ngpio);
 	if (ret) {
 		dev_err(pc->dev, "can't add pin range\n");
 		goto fail;
@@ -598,7 +562,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 
 	return 0;
 fail:
-	gpiochip_remove(&pc->domain->chip);
+	gpiochip_remove(&pc->chip);
 
 	return ret;
 }
@@ -637,58 +601,46 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
 static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 				  struct device_node *node)
 {
-	struct device_node *np;
-	struct meson_domain *domain;
-	int num_domains = 0;
+	struct device_node *np, *gpio_np = NULL;
 
 	for_each_child_of_node(node, np) {
 		if (!of_find_property(np, "gpio-controller", NULL))
 			continue;
-		num_domains++;
+		if (gpio_np) {
+			dev_err(pc->dev, "multiple gpio nodes\n");
+			return -EINVAL;
+		}
+		gpio_np = np;
 	}
 
-	if (num_domains != 1) {
-		dev_err(pc->dev, "wrong number of subnodes\n");
+	if (!gpio_np) {
+		dev_err(pc->dev, "no gpio node found\n");
 		return -EINVAL;
 	}
 
-	pc->domain = devm_kzalloc(pc->dev, sizeof(struct meson_domain), GFP_KERNEL);
-	if (!pc->domain)
-		return -ENOMEM;
-
-	domain = pc->domain;
-	domain->data = pc->data->domain_data;
-
-	for_each_child_of_node(node, np) {
-		if (!of_find_property(np, "gpio-controller", NULL))
-			continue;
-
-		domain->of_node = np;
+	pc->of_node = gpio_np;
 
-		domain->reg_mux = meson_map_resource(pc, np, "mux");
-		if (IS_ERR(domain->reg_mux)) {
-			dev_err(pc->dev, "mux registers not found\n");
-			return PTR_ERR(domain->reg_mux);
-		}
-
-		domain->reg_pull = meson_map_resource(pc, np, "pull");
-		if (IS_ERR(domain->reg_pull)) {
-			dev_err(pc->dev, "pull registers not found\n");
-			return PTR_ERR(domain->reg_pull);
-		}
+	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
+	if (IS_ERR(pc->reg_mux)) {
+		dev_err(pc->dev, "mux registers not found\n");
+		return PTR_ERR(pc->reg_mux);
+	}
 
-		domain->reg_pullen = meson_map_resource(pc, np, "pull-enable");
-		/* Use pull region if pull-enable one is not present */
-		if (IS_ERR(domain->reg_pullen))
-			domain->reg_pullen = domain->reg_pull;
+	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
+	if (IS_ERR(pc->reg_pull)) {
+		dev_err(pc->dev, "pull registers not found\n");
+		return PTR_ERR(pc->reg_pull);
+	}
 
-		domain->reg_gpio = meson_map_resource(pc, np, "gpio");
-		if (IS_ERR(domain->reg_gpio)) {
-			dev_err(pc->dev, "gpio registers not found\n");
-			return PTR_ERR(domain->reg_gpio);
-		}
+	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
+	/* Use pull region if pull-enable one is not present */
+	if (IS_ERR(pc->reg_pullen))
+		pc->reg_pullen = pc->reg_pull;
 
-		break;
+	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
+	if (IS_ERR(pc->reg_gpio)) {
+		dev_err(pc->dev, "gpio registers not found\n");
+		return PTR_ERR(pc->reg_gpio);
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index d89442e..98b5080 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -95,54 +95,17 @@ struct meson_bank {
 	struct meson_reg_desc regs[NUM_REG];
 };
 
-/**
- * struct meson_domain_data - domain platform data
- *
- * @name:	name of the domain
- * @banks:	set of banks belonging to the domain
- * @num_banks:	number of banks in the domain
- */
-struct meson_domain_data {
-	const char *name;
-	struct meson_bank *banks;
-	unsigned int num_banks;
-	unsigned int pin_base;
-	unsigned int num_pins;
-};
-
-/**
- * struct meson_domain
- *
- * @reg_mux:	registers for mux settings
- * @reg_pullen:	registers for pull-enable settings
- * @reg_pull:	registers for pull settings
- * @reg_gpio:	registers for gpio settings
- * @chip:	gpio chip associated with the domain
- * @data;	platform data for the domain
- * @node:	device tree node for the domain
- *
- * A domain represents a set of banks controlled by the same set of
- * registers.
- */
-struct meson_domain {
-	struct regmap *reg_mux;
-	struct regmap *reg_pullen;
-	struct regmap *reg_pull;
-	struct regmap *reg_gpio;
-
-	struct gpio_chip chip;
-	struct meson_domain_data *data;
-	struct device_node *of_node;
-};
-
 struct meson_pinctrl_data {
+	const char *name;
 	const struct pinctrl_pin_desc *pins;
 	struct meson_pmx_group *groups;
 	struct meson_pmx_func *funcs;
-	struct meson_domain_data *domain_data;
+	unsigned int pin_base;
 	unsigned int num_pins;
 	unsigned int num_groups;
 	unsigned int num_funcs;
+	struct meson_bank *banks;
+	unsigned int num_banks;
 };
 
 struct meson_pinctrl {
@@ -150,7 +113,12 @@ struct meson_pinctrl {
 	struct pinctrl_dev *pcdev;
 	struct pinctrl_desc desc;
 	struct meson_pinctrl_data *data;
-	struct meson_domain *domain;
+	struct regmap *reg_mux;
+	struct regmap *reg_pullen;
+	struct regmap *reg_pull;
+	struct regmap *reg_gpio;
+	struct gpio_chip chip;
+	struct device_node *of_node;
 };
 
 #define PIN(x, b)	(b + x)
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 32de191..07f1cb2 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -931,38 +931,28 @@ static struct meson_bank meson8_aobus_banks[] = {
 	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
-static struct meson_domain_data meson8_cbus_domain_data = {
+struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
-	.banks		= meson8_cbus_banks,
-	.num_banks	= ARRAY_SIZE(meson8_cbus_banks),
 	.pin_base	= 0,
-	.num_pins	= 120,
-};
-
-static struct meson_domain_data meson8_aobus_domain_data = {
-	.name		= "ao-bank",
-	.banks		= meson8_aobus_banks,
-	.num_banks	= ARRAY_SIZE(meson8_aobus_banks),
-	.pin_base	= 120,
-	.num_pins	= 16,
-};
-
-struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
 	.pins		= meson8_cbus_pins,
 	.groups		= meson8_cbus_groups,
 	.funcs		= meson8_cbus_functions,
-	.domain_data	= &meson8_cbus_domain_data,
+	.banks		= meson8_cbus_banks,
 	.num_pins	= ARRAY_SIZE(meson8_cbus_pins),
 	.num_groups	= ARRAY_SIZE(meson8_cbus_groups),
 	.num_funcs	= ARRAY_SIZE(meson8_cbus_functions),
+	.num_banks	= ARRAY_SIZE(meson8_cbus_banks),
 };
 
 struct meson_pinctrl_data meson8_aobus_pinctrl_data = {
+	.name		= "ao-bank",
+	.pin_base	= 120,
 	.pins		= meson8_aobus_pins,
 	.groups		= meson8_aobus_groups,
 	.funcs		= meson8_aobus_functions,
-	.domain_data	= &meson8_aobus_domain_data,
+	.banks		= meson8_aobus_banks,
 	.num_pins	= ARRAY_SIZE(meson8_aobus_pins),
 	.num_groups	= ARRAY_SIZE(meson8_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson8_aobus_functions),
+	.num_banks	= ARRAY_SIZE(meson8_aobus_banks),
 };
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 874f2ed..76f077f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -896,38 +896,28 @@ static struct meson_bank meson8b_aobus_banks[] = {
 	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
-static struct meson_domain_data meson8b_cbus_domain_data = {
+struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 	.name		= "cbus-banks",
-	.banks		= meson8b_cbus_banks,
-	.num_banks	= ARRAY_SIZE(meson8b_cbus_banks),
 	.pin_base	= 0,
-	.num_pins	= 130,
-};
-
-static struct meson_domain_data meson8b_aobus_domain_data = {
-	.name		= "aobus-banks",
-	.banks		= meson8b_aobus_banks,
-	.num_banks	= ARRAY_SIZE(meson8b_aobus_banks),
-	.pin_base	= 130,
-	.num_pins	= 16,
-};
-
-struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
 	.pins		= meson8b_cbus_pins,
 	.groups		= meson8b_cbus_groups,
 	.funcs		= meson8b_cbus_functions,
-	.domain_data	= &meson8b_cbus_domain_data,
+	.banks		= meson8b_cbus_banks,
 	.num_pins	= ARRAY_SIZE(meson8b_cbus_pins),
 	.num_groups	= ARRAY_SIZE(meson8b_cbus_groups),
 	.num_funcs	= ARRAY_SIZE(meson8b_cbus_functions),
+	.num_banks	= ARRAY_SIZE(meson8b_cbus_banks),
 };
 
 struct meson_pinctrl_data meson8b_aobus_pinctrl_data = {
+	.name		= "aobus-banks",
+	.pin_base	= 130,
 	.pins		= meson8b_aobus_pins,
 	.groups		= meson8b_aobus_groups,
 	.funcs		= meson8b_aobus_functions,
-	.domain_data	= &meson8b_aobus_domain_data,
+	.banks		= meson8b_aobus_banks,
 	.num_pins	= ARRAY_SIZE(meson8b_aobus_pins),
 	.num_groups	= ARRAY_SIZE(meson8b_aobus_groups),
 	.num_funcs	= ARRAY_SIZE(meson8b_aobus_functions),
+	.num_banks	= ARRAY_SIZE(meson8b_aobus_banks),
 };
-- 
2.7.4
