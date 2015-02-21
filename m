From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 21 Feb 2015 16:33:24 +0100
Subject: [PATCH] ASoC: improve usage of gpiod API
Message-ID: <1424532804-23789-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additional
parameter that allows to specify direction and initial value for
output. Simplify drivers accordingly.

Also there is an *_optional variant that serves well here. The sematics
is slightly changed here by using it as error checking is more strict
now: If GPIOLIB is not enabled an error is returned instead of just
ignoring the gpio. On one hand this is bad for devices that don't "have"
the respective gpio as the driver is failing now. On the other hand
there is no means to assert that this gpio is really not needed or if
only the driver to control it is not available. The latter is a real
reason to fail and so it's defensive to fail here, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 sound/soc/codecs/adau1977.c | 17 +++++------------
 sound/soc/codecs/cs35l32.c  | 19 ++++++-------------
 sound/soc/codecs/cs4265.c   | 19 ++++++-------------
 sound/soc/codecs/sta350.c   | 30 +++++++++---------------------
 sound/soc/codecs/tas2552.c  | 13 +++----------
 5 files changed, 29 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 70ab35744aba..7ad8e156e2df 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -938,22 +938,15 @@ int adau1977_probe(struct device *dev, struct regmap *regmap,
 		adau1977->dvdd_reg = NULL;
 	}
 
-	adau1977->reset_gpio = devm_gpiod_get(dev, "reset");
-	if (IS_ERR(adau1977->reset_gpio)) {
-		ret = PTR_ERR(adau1977->reset_gpio);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return PTR_ERR(adau1977->reset_gpio);
-		adau1977->reset_gpio = NULL;
-	}
+	adau1977->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(adau1977->reset_gpio))
+		return PTR_ERR(adau1977->reset_gpio);
 
 	dev_set_drvdata(dev, adau1977);
 
-	if (adau1977->reset_gpio) {
-		ret = gpiod_direction_output(adau1977->reset_gpio, 0);
-		if (ret)
-			return ret;
+	if (adau1977->reset_gpio)
 		ndelay(100);
-	}
 
 	ret = adau1977_power_enable(adau1977);
 	if (ret)
diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index f2b8aad21274..60598b230341 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -437,20 +437,13 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	/* Reset the Device */
-	cs35l32->reset_gpio = devm_gpiod_get(&i2c_client->dev,
-		"reset-gpios");
-	if (IS_ERR(cs35l32->reset_gpio)) {
-		ret = PTR_ERR(cs35l32->reset_gpio);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		cs35l32->reset_gpio = NULL;
-	} else {
-		ret = gpiod_direction_output(cs35l32->reset_gpio, 0);
-		if (ret)
-			return ret;
+	cs35l32->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs35l32->reset_gpio))
+		return PTR_ERR(cs35l32->reset_gpio);
+
+	if (cs35l32->reset_gpio)
 		gpiod_set_value_cansleep(cs35l32->reset_gpio, 1);
-	}
 
 	/* initialize codec */
 	ret = regmap_read(cs35l32->regmap, CS35L32_DEVID_AB, &reg);
diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index ce6086835ebd..cac48ddf3ba6 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -605,21 +605,14 @@ static int cs4265_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
-	cs4265->reset_gpio = devm_gpiod_get(&i2c_client->dev,
-		"reset-gpios");
-	if (IS_ERR(cs4265->reset_gpio)) {
-		ret = PTR_ERR(cs4265->reset_gpio);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		cs4265->reset_gpio = NULL;
-	} else {
-		ret = gpiod_direction_output(cs4265->reset_gpio, 0);
-		if (ret)
-			return ret;
+	cs4265->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
+		"reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cs4265->reset_gpio))
+		return PTR_ERR(cs4265->reset_gpio);
+
+	if (cs4265->reset_gpio) {
 		mdelay(1);
 		gpiod_set_value_cansleep(cs4265->reset_gpio, 1);
-
 	}
 
 	i2c_set_clientdata(i2c_client, cs4265);
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index bda2ee18769e..669e3228241e 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -1213,27 +1213,15 @@ static int sta350_i2c_probe(struct i2c_client *i2c,
 #endif
 
 	/* GPIOs */
-	sta350->gpiod_nreset = devm_gpiod_get(dev, "reset");
-	if (IS_ERR(sta350->gpiod_nreset)) {
-		ret = PTR_ERR(sta350->gpiod_nreset);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		sta350->gpiod_nreset = NULL;
-	} else {
-		gpiod_direction_output(sta350->gpiod_nreset, 0);
-	}
-
-	sta350->gpiod_power_down = devm_gpiod_get(dev, "power-down");
-	if (IS_ERR(sta350->gpiod_power_down)) {
-		ret = PTR_ERR(sta350->gpiod_power_down);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		sta350->gpiod_power_down = NULL;
-	} else {
-		gpiod_direction_output(sta350->gpiod_power_down, 0);
-	}
+	sta350->gpiod_nreset = devm_gpiod_get_optional(dev, "reset",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(sta350->gpiod_nreset))
+		return PTR_ERR(sta350->gpiod_nreset);
+
+	sta350->gpiod_power_down = devm_gpiod_get(dev, "power-down",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(sta350->gpiod_power_down))
+		return PTR_ERR(sta350->gpiod_power_down);
 
 	/* regulators */
 	for (i = 0; i < ARRAY_SIZE(sta350->supplies); i++)
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index ae23acdd2708..dfb4ff5cc9ea 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -485,16 +485,9 @@ static int tas2552_probe(struct i2c_client *client,
 	if (data == NULL)
 		return -ENOMEM;
 
-	data->enable_gpio = devm_gpiod_get(dev, "enable");
-	if (IS_ERR(data->enable_gpio)) {
-		ret = PTR_ERR(data->enable_gpio);
-		if (ret != -ENOENT && ret != -ENOSYS)
-			return ret;
-
-		data->enable_gpio = NULL;
-	} else {
-		gpiod_direction_output(data->enable_gpio, 0);
-	}
+	data->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(data->enable_gpio))
+		return PTR_ERR(data->enable_gpio);
 
 	data->tas2552_client = client;
 	data->regmap = devm_regmap_init_i2c(client, &tas2552_regmap_config);
-- 
2.1.4
