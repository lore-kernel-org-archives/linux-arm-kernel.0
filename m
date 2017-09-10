From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Sep 2017 23:44:22 +0200
Subject: [PATCH 3/5] i2c: gpio: Enforce open drain through gpiolib
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Message-ID: <20170910214424.14945-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C GPIO bitbang driver currently emulates open drain
behaviour by implementing what the gpiolib already does:
not actively driving the line high, instead setting it to
input.

This makes no sense. Use the new facility in gpiolib to
request the lines enforced into open drain mode, and let
the open drain emulation already present in the gpiolib
kick in and handle this.

As a bonus: if the GPIO driver in the back-end actually
supports open drain in hardware using the .set_config()
callback, it will be utilized. That's correct: we never
used that hardware feature before, instead relying on
emulating open drain even if the GPIO controller could
actually handle this for us.

Users will sometimes get messages like this:
gpio-485 (?): enforced open drain please flag it properly
  in DT/ACPI DSDT/board file
gpio-486 (?): enforced open drain please flag it properly
  in DT/ACPI DSDT/board file
i2c-gpio gpio-i2c: using lines 485 (SDA) and 486 (SCL)

Which is completely proper: since the line is used as
open drain, it should actually be flagged properly with
e.g.

gpios = <&gpio0 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>,
        <&gpio0 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Or similar facilities in board file descriptor tables
or ACPI DSDT.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-gpio.c | 102 ++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 49e8b3ab30be..18ac4cf2ee75 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -25,23 +25,6 @@ struct i2c_gpio_private_data {
 	struct i2c_gpio_platform_data pdata;
 };
 
-/* Toggle SDA by changing the direction of the pin */
-static void i2c_gpio_setsda_dir(void *data, int state)
-{
-	struct i2c_gpio_private_data *priv = data;
-
-	/*
-	 * This is a way of saying "do not drive
-	 * me actively high" which means emulating open drain.
-	 * The right way to do this is for gpiolib to
-	 * handle this, by the function below.
-	 */
-	if (state)
-		gpiod_direction_input(priv->sda);
-	else
-		gpiod_direction_output(priv->sda, 0);
-}
-
 /*
  * Toggle SDA by changing the output value of the pin. This is only
  * valid for pins configured as open drain (i.e. setting the value
@@ -54,17 +37,6 @@ static void i2c_gpio_setsda_val(void *data, int state)
 	gpiod_set_value(priv->sda, state);
 }
 
-/* Toggle SCL by changing the direction of the pin. */
-static void i2c_gpio_setscl_dir(void *data, int state)
-{
-	struct i2c_gpio_private_data *priv = data;
-
-	if (state)
-		gpiod_direction_input(priv->scl);
-	else
-		gpiod_direction_output(priv->scl, 0);
-}
-
 /*
  * Toggle SCL by changing the output value of the pin. This is used
  * for pins that are configured as open drain and for output-only
@@ -116,30 +88,13 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	enum gpiod_flags gflags;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	/* First get the GPIO pins; if it fails, we'll defer the probe. */
-	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->sda)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
-	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, GPIOD_OUT_LOW);
-	if (IS_ERR(priv->scl)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
-
 	adap = &priv->adap;
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
@@ -157,27 +112,48 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * FIXME: this is a hack emulating the open drain emulation
-	 * that gpiolib can already do for us. Make all clients properly
-	 * flag their lines as open drain and get rid of this property
-	 * and the special callback.
+	 * First get the GPIO pins; if it fails, we'll defer the probe.
+	 * If the SDA line is marked from platform data or device tree as
+	 * "open drain" it means something outside of our control is making
+	 * this line being handled as open drain, and we should just handle
+	 * it as any other output. Else we enforce open drain as this is
+	 * required for an I2C bus.
 	 */
-	if (pdata->sda_is_open_drain) {
-		gpiod_direction_output(priv->sda, 1);
-		bit_data->setsda = i2c_gpio_setsda_val;
-	} else {
-		gpiod_direction_input(priv->sda);
-		bit_data->setsda = i2c_gpio_setsda_dir;
+	if (pdata->sda_is_open_drain)
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
+	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, gflags);
+	if (IS_ERR(priv->sda)) {
+		ret = PTR_ERR(priv->sda);
+		/* FIXME: hack in the old code, is this really necessary? */
+		if (ret == -EINVAL)
+			ret = -EPROBE_DEFER;
+		return ret;
 	}
-
-	if (pdata->scl_is_open_drain || pdata->scl_is_output_only) {
-		gpiod_direction_output(priv->scl, 1);
-		bit_data->setscl = i2c_gpio_setscl_val;
-	} else {
-		gpiod_direction_input(priv->scl);
-		bit_data->setscl = i2c_gpio_setscl_dir;
+	/*
+	 * If the SCL line is marked from platform data or device tree as
+	 * "open drain" it means something outside of our control is making
+	 * this line being handled as open drain, and we should just handle
+	 * it as any other output. Else we enforce open drain as this is
+	 * required for an I2C bus.
+	 */
+	if (pdata->scl_is_open_drain)
+		gflags = GPIOD_OUT_LOW;
+	else
+		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
+	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, gflags);
+	if (IS_ERR(priv->scl)) {
+		ret = PTR_ERR(priv->sda);
+		/* FIXME: hack in the old code, is this really necessary? */
+		if (ret == -EINVAL)
+			ret = -EPROBE_DEFER;
+		return ret;
 	}
 
+	bit_data->setsda = i2c_gpio_setsda_val;
+	bit_data->setscl = i2c_gpio_setscl_val;
+
 	if (!pdata->scl_is_output_only)
 		bit_data->getscl = i2c_gpio_getscl;
 	bit_data->getsda = i2c_gpio_getsda;
-- 
2.13.5
