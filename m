From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 19:12:04 +0100
Subject: [PATCH v3 1/4] regulator: Set ena_gpio_initialized in regulator
 drivers
In-Reply-To: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
References: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1415038327-32616-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets ena_gpio_initialized for all drivers which set a
ena_gpio from parsed DT properties. Drivers using pdata may get zero
initialized pdata and therefore copy a 0 into the regulator_config
ena_gpio field.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/arizona-ldo1.c       | 2 ++
 drivers/regulator/fixed.c              | 5 ++++-
 drivers/regulator/gpio-regulator.c     | 4 +++-
 drivers/regulator/max8952.c            | 2 ++
 drivers/regulator/s2mps11.c            | 1 +
 drivers/regulator/s5m8767.c            | 1 +
 drivers/regulator/tps65090-regulator.c | 1 +
 drivers/regulator/wm8994-regulator.c   | 6 ++++--
 8 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 4c9db589f6c1..559e7ea9dcf3 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -260,6 +260,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 			ret = arizona_ldo1_of_get_pdata(arizona, &config);
 			if (ret < 0)
 				return ret;
+
+			config.ena_gpio_initialized = true;
 		}
 	}
 
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 354105eff1f8..17f6a7d331f8 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -157,8 +157,11 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	drvdata->desc.fixed_uV = config->microvolts;
 
-	if (config->gpio >= 0)
+	if (config->gpio >= 0) {
 		cfg.ena_gpio = config->gpio;
+		if (pdev->dev.of_node)
+			cfg.ena_gpio_initialized = true;
+	}
 	cfg.ena_gpio_invert = !config->enable_high;
 	if (config->enabled_at_boot) {
 		if (config->enable_high)
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 989b23b377c0..5da0125fac6a 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -322,8 +322,10 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = np;
 
-	if (config->enable_gpio >= 0)
+	if (config->enable_gpio >= 0) {
 		cfg.ena_gpio = config->enable_gpio;
+		cfg.ena_gpio_initialized = true;
+	}
 	cfg.ena_gpio_invert = !config->enable_high;
 	if (config->enabled_at_boot) {
 		if (config->enable_high)
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index f7f9efcfedb7..dec57fb9cd1c 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -225,6 +225,8 @@ static int max8952_pmic_probe(struct i2c_client *client,
 	config.of_node = client->dev.of_node;
 
 	config.ena_gpio = pdata->gpio_en;
+	if (client->dev.of_node)
+		config.ena_gpio_initialized = true;
 	if (pdata->reg_data->constraints.boot_on)
 		config.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;
 
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index adab82d5279f..b4ae022091eb 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -886,6 +886,7 @@ common_reg:
 	config.regmap = iodev->regmap_pmic;
 	config.driver_data = s2mps11;
 	config.ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
+	config.ena_gpio_initialized = true;
 	for (i = 0; i < s2mps11->rdev_num; i++) {
 		struct regulator_dev *regulator;
 
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 0ab5cbeeb797..4225df68dd4d 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -950,6 +950,7 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		config.of_node = pdata->regulators[i].reg_node;
 		config.ena_gpio = -EINVAL;
 		config.ena_gpio_flags = 0;
+		config.ena_gpio_initialized = true;
 		if (gpio_is_valid(pdata->regulators[i].ext_control_gpio))
 			s5m8767_regulator_config_ext_control(s5m8767,
 					&pdata->regulators[i], &config);
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index d5df1e9ad1da..2e92aa8718cc 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -312,6 +312,7 @@ static void tps65090_configure_regulator_config(
 			gpio_flag = GPIOF_OUT_INIT_HIGH;
 
 		config->ena_gpio = tps_pdata->gpio;
+		config->ena_gpio_initialized = true;
 		config->ena_gpio_flags = gpio_flag;
 	}
 }
diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index c24346db8a71..88f5064e412b 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -145,10 +145,12 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 	config.driver_data = ldo;
 	config.regmap = wm8994->regmap;
 	config.init_data = &ldo->init_data;
-	if (pdata)
+	if (pdata) {
 		config.ena_gpio = pdata->ldo[id].enable;
-	else if (wm8994->dev->of_node)
+	} else if (wm8994->dev->of_node) {
 		config.ena_gpio = wm8994->pdata.ldo[id].enable;
+		config.ena_gpio_initialized = true;
+	}
 
 	/* Use default constraints if none set up */
 	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
-- 
2.1.1
