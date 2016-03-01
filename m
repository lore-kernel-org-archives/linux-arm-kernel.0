From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Mar 2016 23:04:34 +0100
Subject: [PATCH 2/4] pinctrl: amlogic: Make driver independent from two-domain
 configuration
In-Reply-To: <1456869876-19320-1-git-send-email-carlo@caione.org>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
Message-ID: <1456869876-19320-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In the Amlogic Meson8 / Meson8b platforms we have two different buses:
cbus and aobus, corresponding to 2 different power domains (regular and
always-on). On each bus a different set of registers is mapped to manage
muxes, GPIOs and in general to control a clear subset of the pins.

Considering this architecture, having two different pinctrl devices, one
for each bus / power domain, makes much more sense than just having one
single device.

Right now we have one single pin controller driver that uses two
different domains (represented by 'gpio' and 'gpio-ao' sub-nodes in the
DTS) to manage the set of registers on the two buses. This dual-domain
configuration is hardcoded into the driver that strictly requires one
domain for each bus in the same pin controller device.

With this patch we refactor the driver to allow splitting the driver in
two parts. This change is needed to have a proper description of the HW
in the device-tree where we want to introduce aobus and cbus.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c   | 135 ++++++++++++---------------
 drivers/pinctrl/meson/pinctrl-meson.h   |  21 +----
 drivers/pinctrl/meson/pinctrl-meson8.c  | 137 +++++++++++++++------------
 drivers/pinctrl/meson/pinctrl-meson8b.c | 159 +++++++++++++++++---------------
 4 files changed, 228 insertions(+), 224 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 50cab27..c50aaab 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -104,15 +104,13 @@ static int meson_get_domain_and_bank(struct meson_pinctrl *pc, unsigned int pin,
 				     struct meson_bank **bank)
 {
 	struct meson_domain *d;
-	int i;
 
-	for (i = 0; i < pc->data->num_domains; i++) {
-		d = &pc->domains[i];
-		if (pin >= d->data->pin_base &&
-		    pin < d->data->pin_base + d->data->num_pins) {
-			*domain = d;
-			return meson_get_bank(d, pin, bank);
-		}
+	d = pc->domain;
+
+	if (pin >= d->data->pin_base &&
+	    pin < d->data->pin_base + d->data->num_pins) {
+		*domain = d;
+		return meson_get_bank(d, pin, bank);
 	}
 
 	return -EINVAL;
@@ -204,7 +202,7 @@ static void meson_pmx_disable_other_groups(struct meson_pinctrl *pc,
 		for (j = 0; j < group->num_pins; j++) {
 			if (group->pins[j] == pin) {
 				/* We have found a group using the pin */
-				domain = &pc->domains[group->domain];
+				domain = pc->domain;
 				regmap_update_bits(domain->reg_mux,
 						   group->reg * 4,
 						   BIT(group->bit), 0);
@@ -219,7 +217,7 @@ static int meson_pmx_set_mux(struct pinctrl_dev *pcdev, unsigned func_num,
 	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	struct meson_pmx_func *func = &pc->data->funcs[func_num];
 	struct meson_pmx_group *group = &pc->data->groups[group_num];
-	struct meson_domain *domain = &pc->domains[group->domain];
+	struct meson_domain *domain = pc->domain;
 	int i, ret = 0;
 
 	dev_dbg(pc->dev, "enable function %s, group %s\n", func->name,
@@ -537,12 +535,20 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 
 static const struct of_device_id meson_pinctrl_dt_match[] = {
 	{
-		.compatible = "amlogic,meson8-pinctrl",
-		.data = &meson8_pinctrl_data,
+		.compatible = "amlogic,meson8-cbus-pinctrl",
+		.data = &meson8_cbus_pinctrl_data,
+	},
+	{
+		.compatible = "amlogic,meson8b-cbus-pinctrl",
+		.data = &meson8b_cbus_pinctrl_data,
+	},
+	{
+		.compatible = "amlogic,meson8-aobus-pinctrl",
+		.data = &meson8_aobus_pinctrl_data,
 	},
 	{
-		.compatible = "amlogic,meson8b-pinctrl",
-		.data = &meson8b_pinctrl_data,
+		.compatible = "amlogic,meson8b-aobus-pinctrl",
+		.data = &meson8b_aobus_pinctrl_data,
 	},
 	{ },
 };
@@ -551,62 +557,46 @@ MODULE_DEVICE_TABLE(of, meson_pinctrl_dt_match);
 static int meson_gpiolib_register(struct meson_pinctrl *pc)
 {
 	struct meson_domain *domain;
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < pc->data->num_domains; i++) {
-		domain = &pc->domains[i];
-
-		domain->chip.label = domain->data->name;
-		domain->chip.parent = pc->dev;
-		domain->chip.request = meson_gpio_request;
-		domain->chip.free = meson_gpio_free;
-		domain->chip.direction_input = meson_gpio_direction_input;
-		domain->chip.direction_output = meson_gpio_direction_output;
-		domain->chip.get = meson_gpio_get;
-		domain->chip.set = meson_gpio_set;
-		domain->chip.base = domain->data->pin_base;
-		domain->chip.ngpio = domain->data->num_pins;
-		domain->chip.can_sleep = false;
-		domain->chip.of_node = domain->of_node;
-		domain->chip.of_gpio_n_cells = 2;
-
-		ret = gpiochip_add_data(&domain->chip, domain);
-		if (ret) {
-			dev_err(pc->dev, "can't add gpio chip %s\n",
-				domain->data->name);
-			goto fail;
-		}
+	domain = pc->domain;
+
+	domain->chip.label = domain->data->name;
+	domain->chip.parent = pc->dev;
+	domain->chip.request = meson_gpio_request;
+	domain->chip.free = meson_gpio_free;
+	domain->chip.direction_input = meson_gpio_direction_input;
+	domain->chip.direction_output = meson_gpio_direction_output;
+	domain->chip.get = meson_gpio_get;
+	domain->chip.set = meson_gpio_set;
+	domain->chip.base = domain->data->pin_base;
+	domain->chip.ngpio = domain->data->num_pins;
+	domain->chip.can_sleep = false;
+	domain->chip.of_node = domain->of_node;
+	domain->chip.of_gpio_n_cells = 2;
+
+	ret = gpiochip_add_data(&domain->chip, domain);
+	if (ret) {
+		dev_err(pc->dev, "can't add gpio chip %s\n",
+			domain->data->name);
+		goto fail;
+	}
 
-		ret = gpiochip_add_pin_range(&domain->chip, dev_name(pc->dev),
-					     0, domain->data->pin_base,
-					     domain->chip.ngpio);
-		if (ret) {
-			dev_err(pc->dev, "can't add pin range\n");
-			goto fail;
-		}
+	ret = gpiochip_add_pin_range(&domain->chip, dev_name(pc->dev),
+				     0, domain->data->pin_base,
+				     domain->chip.ngpio);
+	if (ret) {
+		dev_err(pc->dev, "can't add pin range\n");
+		goto fail;
 	}
 
 	return 0;
 fail:
-	for (i--; i >= 0; i--)
-		gpiochip_remove(&pc->domains[i].chip);
+	gpiochip_remove(&pc->domain->chip);
 
 	return ret;
 }
 
-static struct meson_domain_data *meson_get_domain_data(struct meson_pinctrl *pc,
-						       struct device_node *np)
-{
-	int i;
-
-	for (i = 0; i < pc->data->num_domains; i++) {
-		if (!strcmp(np->name, pc->data->domain_data[i].name))
-			return &pc->data->domain_data[i];
-	}
-
-	return NULL;
-}
-
 static struct regmap_config meson_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -643,7 +633,7 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 {
 	struct device_node *np;
 	struct meson_domain *domain;
-	int i = 0, num_domains = 0;
+	int num_domains = 0;
 
 	for_each_child_of_node(node, np) {
 		if (!of_find_property(np, "gpio-controller", NULL))
@@ -651,29 +641,22 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 		num_domains++;
 	}
 
-	if (num_domains != pc->data->num_domains) {
+	if (num_domains != 1) {
 		dev_err(pc->dev, "wrong number of subnodes\n");
 		return -EINVAL;
 	}
 
-	pc->domains = devm_kzalloc(pc->dev, num_domains *
-				   sizeof(struct meson_domain), GFP_KERNEL);
-	if (!pc->domains)
+	pc->domain = devm_kzalloc(pc->dev, sizeof(struct meson_domain), GFP_KERNEL);
+	if (!pc->domain)
 		return -ENOMEM;
 
+	domain = pc->domain;
+	domain->data = pc->data->domain_data;
+
 	for_each_child_of_node(node, np) {
 		if (!of_find_property(np, "gpio-controller", NULL))
 			continue;
 
-		domain = &pc->domains[i];
-
-		domain->data = meson_get_domain_data(pc, np);
-		if (!domain->data) {
-			dev_err(pc->dev, "domain data not found for node %s\n",
-				np->name);
-			return -ENODEV;
-		}
-
 		domain->of_node = np;
 
 		domain->reg_mux = meson_map_resource(pc, np, "mux");
@@ -699,7 +682,7 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 			return PTR_ERR(domain->reg_gpio);
 		}
 
-		i++;
+		break;
 	}
 
 	return 0;
@@ -718,7 +701,7 @@ static int meson_pinctrl_probe(struct platform_device *pdev)
 
 	pc->dev = dev;
 	match = of_match_node(meson_pinctrl_dt_match, pdev->dev.of_node);
-	pc->data = (struct meson_pinctrl_data *)match->data;
+	pc->data = (struct meson_pinctrl_data *) match->data;
 
 	ret = meson_pinctrl_parse_dt(pc, pdev->dev.of_node);
 	if (ret)
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 0fe7d53..9c93e0d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -34,7 +34,6 @@ struct meson_pmx_group {
 	bool is_gpio;
 	unsigned int reg;
 	unsigned int bit;
-	unsigned int domain;
 };
 
 /**
@@ -144,7 +143,6 @@ struct meson_pinctrl_data {
 	unsigned int num_pins;
 	unsigned int num_groups;
 	unsigned int num_funcs;
-	unsigned int num_domains;
 };
 
 struct meson_pinctrl {
@@ -152,7 +150,7 @@ struct meson_pinctrl {
 	struct pinctrl_dev *pcdev;
 	struct pinctrl_desc desc;
 	struct meson_pinctrl_data *data;
-	struct meson_domain *domains;
+	struct meson_domain *domain;
 };
 
 #define PIN(x, b)	(b + x)
@@ -164,7 +162,6 @@ struct meson_pinctrl {
 		.num_pins = ARRAY_SIZE(grp ## _pins),			\
 		.reg = r,						\
 		.bit = b,						\
-		.domain = 0,						\
 	 }
 
 #define GPIO_GROUP(gpio, b)						\
@@ -175,16 +172,6 @@ struct meson_pinctrl {
 		.is_gpio = true,					\
 	 }
 
-#define GROUP_AO(grp, r, b)						\
-	{								\
-		.name = #grp,						\
-		.pins = grp ## _pins,					\
-		.num_pins = ARRAY_SIZE(grp ## _pins),			\
-		.reg = r,						\
-		.bit = b,						\
-		.domain = 1,						\
-	 }
-
 #define FUNCTION(fn)							\
 	{								\
 		.name = #fn,						\
@@ -208,5 +195,7 @@ struct meson_pinctrl {
 
 #define MESON_PIN(x, b) PINCTRL_PIN(PIN(x, b), #x)
 
-extern struct meson_pinctrl_data meson8_pinctrl_data;
-extern struct meson_pinctrl_data meson8b_pinctrl_data;
+extern struct meson_pinctrl_data meson8_cbus_pinctrl_data;
+extern struct meson_pinctrl_data meson8_aobus_pinctrl_data;
+extern struct meson_pinctrl_data meson8b_cbus_pinctrl_data;
+extern struct meson_pinctrl_data meson8b_aobus_pinctrl_data;
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 7b1cc91..32de191 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -16,7 +16,7 @@
 
 #define AO_OFF	120
 
-static const struct pinctrl_pin_desc meson8_pins[] = {
+static const struct pinctrl_pin_desc meson8_cbus_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
 	MESON_PIN(GPIOX_1, 0),
 	MESON_PIN(GPIOX_2, 0),
@@ -137,6 +137,9 @@ static const struct pinctrl_pin_desc meson8_pins[] = {
 	MESON_PIN(BOOT_16, 0),
 	MESON_PIN(BOOT_17, 0),
 	MESON_PIN(BOOT_18, 0),
+};
+
+static const struct pinctrl_pin_desc meson8_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, AO_OFF),
 	MESON_PIN(GPIOAO_1, AO_OFF),
 	MESON_PIN(GPIOAO_2, AO_OFF),
@@ -379,7 +382,7 @@ static const unsigned int uart_rx_ao_b1_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 static const unsigned int i2c_mst_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
 static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
-static struct meson_pmx_group meson8_groups[] = {
+static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOX_0, 0),
 	GPIO_GROUP(GPIOX_1, 0),
 	GPIO_GROUP(GPIOX_2, 0),
@@ -474,22 +477,6 @@ static struct meson_pmx_group meson8_groups[] = {
 	GPIO_GROUP(GPIOZ_12, 0),
 	GPIO_GROUP(GPIOZ_13, 0),
 	GPIO_GROUP(GPIOZ_14, 0),
-	GPIO_GROUP(GPIOAO_0, AO_OFF),
-	GPIO_GROUP(GPIOAO_1, AO_OFF),
-	GPIO_GROUP(GPIOAO_2, AO_OFF),
-	GPIO_GROUP(GPIOAO_3, AO_OFF),
-	GPIO_GROUP(GPIOAO_4, AO_OFF),
-	GPIO_GROUP(GPIOAO_5, AO_OFF),
-	GPIO_GROUP(GPIOAO_6, AO_OFF),
-	GPIO_GROUP(GPIOAO_7, AO_OFF),
-	GPIO_GROUP(GPIOAO_8, AO_OFF),
-	GPIO_GROUP(GPIOAO_9, AO_OFF),
-	GPIO_GROUP(GPIOAO_10, AO_OFF),
-	GPIO_GROUP(GPIOAO_11, AO_OFF),
-	GPIO_GROUP(GPIOAO_12, AO_OFF),
-	GPIO_GROUP(GPIOAO_13, AO_OFF),
-	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
-	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
@@ -675,26 +662,45 @@ static struct meson_pmx_group meson8_groups[] = {
 	GROUP(sdxc_d0_b,	2,	7),
 	GROUP(sdxc_clk_b,	2,	5),
 	GROUP(sdxc_cmd_b,	2,	4),
+};
+
+static struct meson_pmx_group meson8_aobus_groups[] = {
+	GPIO_GROUP(GPIOAO_0, AO_OFF),
+	GPIO_GROUP(GPIOAO_1, AO_OFF),
+	GPIO_GROUP(GPIOAO_2, AO_OFF),
+	GPIO_GROUP(GPIOAO_3, AO_OFF),
+	GPIO_GROUP(GPIOAO_4, AO_OFF),
+	GPIO_GROUP(GPIOAO_5, AO_OFF),
+	GPIO_GROUP(GPIOAO_6, AO_OFF),
+	GPIO_GROUP(GPIOAO_7, AO_OFF),
+	GPIO_GROUP(GPIOAO_8, AO_OFF),
+	GPIO_GROUP(GPIOAO_9, AO_OFF),
+	GPIO_GROUP(GPIOAO_10, AO_OFF),
+	GPIO_GROUP(GPIOAO_11, AO_OFF),
+	GPIO_GROUP(GPIOAO_12, AO_OFF),
+	GPIO_GROUP(GPIOAO_13, AO_OFF),
+	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
+	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
 
 	/* bank AO */
-	GROUP_AO(uart_tx_ao_a,		0,	12),
-	GROUP_AO(uart_rx_ao_a,		0,	11),
-	GROUP_AO(uart_cts_ao_a,		0,	10),
-	GROUP_AO(uart_rts_ao_a,		0,	9),
+	GROUP(uart_tx_ao_a,		0,	12),
+	GROUP(uart_rx_ao_a,		0,	11),
+	GROUP(uart_cts_ao_a,		0,	10),
+	GROUP(uart_rts_ao_a,		0,	9),
 
-	GROUP_AO(remote_input,		0,	0),
+	GROUP(remote_input,		0,	0),
 
-	GROUP_AO(i2c_slave_sck_ao,	0,	2),
-	GROUP_AO(i2c_slave_sda_ao,	0,	1),
+	GROUP(i2c_slave_sck_ao,		0,	2),
+	GROUP(i2c_slave_sda_ao,		0,	1),
 
-	GROUP_AO(uart_tx_ao_b0,		0,	26),
-	GROUP_AO(uart_rx_ao_b0,		0,	25),
+	GROUP(uart_tx_ao_b0,		0,	26),
+	GROUP(uart_rx_ao_b0,		0,	25),
 
-	GROUP_AO(uart_tx_ao_b1,		0,	24),
-	GROUP_AO(uart_rx_ao_b1,		0,	23),
+	GROUP(uart_tx_ao_b1,		0,	24),
+	GROUP(uart_rx_ao_b1,		0,	23),
 
-	GROUP_AO(i2c_mst_sck_ao,	0,	6),
-	GROUP_AO(i2c_mst_sda_ao,	0,	5),
+	GROUP(i2c_mst_sck_ao,		0,	6),
+	GROUP(i2c_mst_sda_ao,		0,	5),
 };
 
 static const char * const gpio_groups[] = {
@@ -872,7 +878,7 @@ static const char * const i2c_mst_ao_groups[] = {
 	"i2c_mst_sck_ao", "i2c_mst_sda_ao"
 };
 
-static struct meson_pmx_func meson8_functions[] = {
+static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(sd_a),
 	FUNCTION(sdxc_a),
@@ -899,6 +905,9 @@ static struct meson_pmx_func meson8_functions[] = {
 	FUNCTION(nor),
 	FUNCTION(sd_b),
 	FUNCTION(sdxc_b),
+};
+
+static struct meson_pmx_func meson8_aobus_functions[] = {
 	FUNCTION(uart_ao),
 	FUNCTION(remote),
 	FUNCTION(i2c_slave_ao),
@@ -906,7 +915,7 @@ static struct meson_pmx_func meson8_functions[] = {
 	FUNCTION(i2c_mst_ao),
 };
 
-static struct meson_bank meson8_banks[] = {
+static struct meson_bank meson8_cbus_banks[] = {
 	/*   name    first             last                 pullen  pull    dir     out     in  */
 	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
 	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
@@ -917,35 +926,43 @@ static struct meson_bank meson8_banks[] = {
 	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
 };
 
-static struct meson_bank meson8_ao_banks[] = {
+static struct meson_bank meson8_aobus_banks[] = {
 	/*   name    first                  last                      pullen  pull    dir     out     in  */
 	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
-static struct meson_domain_data meson8_domain_data[] = {
-	{
-		.name		= "banks",
-		.banks		= meson8_banks,
-		.num_banks	= ARRAY_SIZE(meson8_banks),
-		.pin_base	= 0,
-		.num_pins	= 120,
-	},
-	{
-		.name		= "ao-bank",
-		.banks		= meson8_ao_banks,
-		.num_banks	= ARRAY_SIZE(meson8_ao_banks),
-		.pin_base	= 120,
-		.num_pins	= 16,
-	},
-};
-
-struct meson_pinctrl_data meson8_pinctrl_data = {
-	.pins		= meson8_pins,
-	.groups		= meson8_groups,
-	.funcs		= meson8_functions,
-	.domain_data	= meson8_domain_data,
-	.num_pins	= ARRAY_SIZE(meson8_pins),
-	.num_groups	= ARRAY_SIZE(meson8_groups),
-	.num_funcs	= ARRAY_SIZE(meson8_functions),
-	.num_domains	= ARRAY_SIZE(meson8_domain_data),
+static struct meson_domain_data meson8_cbus_domain_data = {
+	.name		= "cbus-banks",
+	.banks		= meson8_cbus_banks,
+	.num_banks	= ARRAY_SIZE(meson8_cbus_banks),
+	.pin_base	= 0,
+	.num_pins	= 120,
+};
+
+static struct meson_domain_data meson8_aobus_domain_data = {
+	.name		= "ao-bank",
+	.banks		= meson8_aobus_banks,
+	.num_banks	= ARRAY_SIZE(meson8_aobus_banks),
+	.pin_base	= 120,
+	.num_pins	= 16,
+};
+
+struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
+	.pins		= meson8_cbus_pins,
+	.groups		= meson8_cbus_groups,
+	.funcs		= meson8_cbus_functions,
+	.domain_data	= &meson8_cbus_domain_data,
+	.num_pins	= ARRAY_SIZE(meson8_cbus_pins),
+	.num_groups	= ARRAY_SIZE(meson8_cbus_groups),
+	.num_funcs	= ARRAY_SIZE(meson8_cbus_functions),
+};
+
+struct meson_pinctrl_data meson8_aobus_pinctrl_data = {
+	.pins		= meson8_aobus_pins,
+	.groups		= meson8_aobus_groups,
+	.funcs		= meson8_aobus_functions,
+	.domain_data	= &meson8_aobus_domain_data,
+	.num_pins	= ARRAY_SIZE(meson8_aobus_pins),
+	.num_groups	= ARRAY_SIZE(meson8_aobus_groups),
+	.num_funcs	= ARRAY_SIZE(meson8_aobus_functions),
 };
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 0c9572e..a100bcf 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -17,7 +17,7 @@
 
 #define AO_OFF	130
 
-static const struct pinctrl_pin_desc meson8b_pins[] = {
+static const struct pinctrl_pin_desc meson8b_cbus_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
 	MESON_PIN(GPIOX_1, 0),
 	MESON_PIN(GPIOX_2, 0),
@@ -107,7 +107,9 @@ static const struct pinctrl_pin_desc meson8b_pins[] = {
 	MESON_PIN(DIF_3_N, 0),
 	MESON_PIN(DIF_4_P, 0),
 	MESON_PIN(DIF_4_N, 0),
+};
 
+static const struct pinctrl_pin_desc meson8b_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, AO_OFF),
 	MESON_PIN(GPIOAO_1, AO_OFF),
 	MESON_PIN(GPIOAO_2, AO_OFF),
@@ -346,7 +348,7 @@ static const unsigned int eth_ref_clk_pins[]	= { PIN(DIF_3_N, 0) };
 static const unsigned int eth_mdc_pins[]	= { PIN(DIF_4_P, 0) };
 static const unsigned int eth_mdio_en_pins[]	= { PIN(DIF_4_N, 0) };
 
-static struct meson_pmx_group meson8b_groups[] = {
+static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GPIO_GROUP(GPIOX_0, 0),
 	GPIO_GROUP(GPIOX_1, 0),
 	GPIO_GROUP(GPIOX_2, 0),
@@ -409,23 +411,6 @@ static struct meson_pmx_group meson8b_groups[] = {
 	GPIO_GROUP(DIF_4_P, 0),
 	GPIO_GROUP(DIF_4_N, 0),
 
-	GPIO_GROUP(GPIOAO_0, AO_OFF),
-	GPIO_GROUP(GPIOAO_1, AO_OFF),
-	GPIO_GROUP(GPIOAO_2, AO_OFF),
-	GPIO_GROUP(GPIOAO_3, AO_OFF),
-	GPIO_GROUP(GPIOAO_4, AO_OFF),
-	GPIO_GROUP(GPIOAO_5, AO_OFF),
-	GPIO_GROUP(GPIOAO_6, AO_OFF),
-	GPIO_GROUP(GPIOAO_7, AO_OFF),
-	GPIO_GROUP(GPIOAO_8, AO_OFF),
-	GPIO_GROUP(GPIOAO_9, AO_OFF),
-	GPIO_GROUP(GPIOAO_10, AO_OFF),
-	GPIO_GROUP(GPIOAO_11, AO_OFF),
-	GPIO_GROUP(GPIOAO_12, AO_OFF),
-	GPIO_GROUP(GPIOAO_13, AO_OFF),
-	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
-	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
-
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
 	GROUP(sd_d1_a,		8,	4),
@@ -572,6 +557,37 @@ static struct meson_pmx_group meson8b_groups[] = {
 	GROUP(sdxc_clk_b,	2,	5),
 	GROUP(sdxc_cmd_b,	2,	4),
 
+	/* bank DIF */
+	GROUP(eth_rxd1,		6,	0),
+	GROUP(eth_rxd0,		6,	1),
+	GROUP(eth_rx_dv,	6,	2),
+	GROUP(eth_rx_clk,	6,	3),
+	GROUP(eth_txd0_1,	6,	4),
+	GROUP(eth_txd1_1,	6,	5),
+	GROUP(eth_tx_en,	6,	0),
+	GROUP(eth_ref_clk,	6,	8),
+	GROUP(eth_mdc,		6,	9),
+	GROUP(eth_mdio_en,	6,	10),
+};
+
+static struct meson_pmx_group meson8b_aobus_groups[] = {
+	GPIO_GROUP(GPIOAO_0, AO_OFF),
+	GPIO_GROUP(GPIOAO_1, AO_OFF),
+	GPIO_GROUP(GPIOAO_2, AO_OFF),
+	GPIO_GROUP(GPIOAO_3, AO_OFF),
+	GPIO_GROUP(GPIOAO_4, AO_OFF),
+	GPIO_GROUP(GPIOAO_5, AO_OFF),
+	GPIO_GROUP(GPIOAO_6, AO_OFF),
+	GPIO_GROUP(GPIOAO_7, AO_OFF),
+	GPIO_GROUP(GPIOAO_8, AO_OFF),
+	GPIO_GROUP(GPIOAO_9, AO_OFF),
+	GPIO_GROUP(GPIOAO_10, AO_OFF),
+	GPIO_GROUP(GPIOAO_11, AO_OFF),
+	GPIO_GROUP(GPIOAO_12, AO_OFF),
+	GPIO_GROUP(GPIOAO_13, AO_OFF),
+	GPIO_GROUP(GPIO_BSD_EN, AO_OFF),
+	GPIO_GROUP(GPIO_TEST_N, AO_OFF),
+
 	/* bank AO */
 	GROUP(uart_tx_ao_a,	0,	12),
 	GROUP(uart_rx_ao_a,	0,	11),
@@ -601,18 +617,6 @@ static struct meson_pmx_group meson8b_groups[] = {
 	GROUP(i2s_in_ch01,	0,	13),
 	GROUP(i2s_ao_clk_in,	0,	15),
 	GROUP(i2s_lr_clk_in,	0,	14),
-
-	/* bank DIF */
-	GROUP(eth_rxd1,		6,	0),
-	GROUP(eth_rxd0,		6,	1),
-	GROUP(eth_rx_dv,	6,	2),
-	GROUP(eth_rx_clk,	6,	3),
-	GROUP(eth_txd0_1,	6,	4),
-	GROUP(eth_txd1_1,	6,	5),
-	GROUP(eth_tx_en,	6,	0),
-	GROUP(eth_ref_clk,	6,	8),
-	GROUP(eth_mdc,		6,	9),
-	GROUP(eth_mdio_en,	6,	10),
 };
 
 static const char * const gpio_groups[] = {
@@ -774,11 +778,11 @@ static const char * const i2c_mst_ao_groups[] = {
 };
 
 static const char * const clk_24m_groups[] = {
-	"clk_24m_out",
+	"clk_24m_out"
 };
 
 static const char * const clk_32k_groups[] = {
-	"clk_32k_in_out",
+	"clk_32k_in_out"
 };
 
 static const char * const spdif_0_groups[] = {
@@ -829,7 +833,7 @@ static const char * const tsin_b_groups[] = {
 	"tsin_d0_b", "tsin_clk_b", "tsin_sop_b", "tsin_d_valid_b"
 };
 
-static struct meson_pmx_func meson8b_functions[] = {
+static struct meson_pmx_func meson8b_cbus_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(sd_a),
 	FUNCTION(sdxc_a),
@@ -842,7 +846,6 @@ static struct meson_pmx_func meson8b_functions[] = {
 	FUNCTION(uart_c),
 	FUNCTION(i2c_c),
 	FUNCTION(hdmi),
-	FUNCTION(hdmi_cec),
 	FUNCTION(spi),
 	FUNCTION(ethernet),
 	FUNCTION(i2c_a),
@@ -853,18 +856,9 @@ static struct meson_pmx_func meson8b_functions[] = {
 	FUNCTION(nor),
 	FUNCTION(sd_b),
 	FUNCTION(sdxc_b),
-	FUNCTION(uart_ao),
-	FUNCTION(remote),
-	FUNCTION(i2c_slave_ao),
-	FUNCTION(uart_ao_b),
-	FUNCTION(i2c_mst_ao),
-	FUNCTION(clk_32k),
 	FUNCTION(spdif_0),
-	FUNCTION(spdif_1),
-	FUNCTION(i2s),
 	FUNCTION(pwm_b),
 	FUNCTION(pwm_c),
-	FUNCTION(pwm_c_ao),
 	FUNCTION(pwm_d),
 	FUNCTION(pwm_e),
 	FUNCTION(pwm_vs),
@@ -873,7 +867,20 @@ static struct meson_pmx_func meson8b_functions[] = {
 	FUNCTION(clk_24m),
 };
 
-static struct meson_bank meson8b_banks[] = {
+static struct meson_pmx_func meson8b_aobus_functions[] = {
+	FUNCTION(uart_ao),
+	FUNCTION(uart_ao_b),
+	FUNCTION(i2c_slave_ao),
+	FUNCTION(i2c_mst_ao),
+	FUNCTION(i2s),
+	FUNCTION(remote),
+	FUNCTION(clk_32k),
+	FUNCTION(pwm_c_ao),
+	FUNCTION(spdif_1),
+	FUNCTION(hdmi_cec),
+};
+
+static struct meson_bank meson8b_cbus_banks[] = {
 	/*   name    first                      last                   pullen  pull    dir     out     in  */
 	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
 	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
@@ -884,35 +891,43 @@ static struct meson_bank meson8b_banks[] = {
 	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
 };
 
-static struct meson_bank meson8b_ao_banks[] = {
+static struct meson_bank meson8b_aobus_banks[] = {
 	/*   name    first                  last                      pullen  pull    dir     out     in  */
 	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
 };
 
-static struct meson_domain_data meson8b_domain_data[] = {
-	{
-		.name		= "banks",
-		.banks		= meson8b_banks,
-		.num_banks	= ARRAY_SIZE(meson8b_banks),
-		.pin_base	= 0,
-		.num_pins	= 130,
-	},
-	{
-		.name		= "ao-bank",
-		.banks		= meson8b_ao_banks,
-		.num_banks	= ARRAY_SIZE(meson8b_ao_banks),
-		.pin_base	= 130,
-		.num_pins	= 16,
-	},
-};
-
-struct meson_pinctrl_data meson8b_pinctrl_data = {
-	.pins		= meson8b_pins,
-	.groups		= meson8b_groups,
-	.funcs		= meson8b_functions,
-	.domain_data	= meson8b_domain_data,
-	.num_pins	= ARRAY_SIZE(meson8b_pins),
-	.num_groups	= ARRAY_SIZE(meson8b_groups),
-	.num_funcs	= ARRAY_SIZE(meson8b_functions),
-	.num_domains	= ARRAY_SIZE(meson8b_domain_data),
+static struct meson_domain_data meson8b_cbus_domain_data = {
+	.name		= "cbus-banks",
+	.banks		= meson8b_cbus_banks,
+	.num_banks	= ARRAY_SIZE(meson8b_cbus_banks),
+	.pin_base	= 0,
+	.num_pins	= 130,
+};
+
+static struct meson_domain_data meson8b_aobus_domain_data = {
+	.name		= "aobus-banks",
+	.banks		= meson8b_aobus_banks,
+	.num_banks	= ARRAY_SIZE(meson8b_aobus_banks),
+	.pin_base	= 130,
+	.num_pins	= 16,
+};
+
+struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
+	.pins		= meson8b_cbus_pins,
+	.groups		= meson8b_cbus_groups,
+	.funcs		= meson8b_cbus_functions,
+	.domain_data	= &meson8b_cbus_domain_data,
+	.num_pins	= ARRAY_SIZE(meson8b_cbus_pins),
+	.num_groups	= ARRAY_SIZE(meson8b_cbus_groups),
+	.num_funcs	= ARRAY_SIZE(meson8b_cbus_functions),
+};
+
+struct meson_pinctrl_data meson8b_aobus_pinctrl_data = {
+	.pins		= meson8b_aobus_pins,
+	.groups		= meson8b_aobus_groups,
+	.funcs		= meson8b_aobus_functions,
+	.domain_data	= &meson8b_aobus_domain_data,
+	.num_pins	= ARRAY_SIZE(meson8b_aobus_pins),
+	.num_groups	= ARRAY_SIZE(meson8b_aobus_groups),
+	.num_funcs	= ARRAY_SIZE(meson8b_aobus_functions),
 };
-- 
1.9.1
