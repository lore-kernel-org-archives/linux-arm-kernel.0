From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 11:39:06 +0200
Subject: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Message-ID: <20170917093906.16325-8-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for using the "sda" and "scl" GPIOs in
device tree instead of anonymously using index 0 and 1 of
the "gpios" property.

We add a helper function to retrieve the GPIO descriptors
and some explicit error handling since the probe may have
to be deferred. At least this happened to me when moving
to using named "sda" and "scl" lines (all of a sudden this
started to probe before the GPIO driver) so we need to
gracefully defer probe when we ge -ENOENT in the error
pointer.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is pretty much a rewrite of Geerts patch on top of
my own changes to support descriptors.
---
 drivers/i2c/busses/i2c-gpio.c | 59 +++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index beb5ce523684..2738b851f470 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -82,6 +82,42 @@ static void of_i2c_gpio_get_props(struct device_node *np,
 		of_property_read_bool(np, "i2c-gpio,scl-output-only");
 }
 
+static struct gpio_desc *i2c_gpio_get_desc(struct device *dev,
+					   const char *con_id,
+					   unsigned int index,
+					   enum gpiod_flags gflags)
+{
+	struct gpio_desc *retdesc;
+	int ret;
+
+	retdesc = devm_gpiod_get(dev, con_id, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from name %s\n", con_id);
+		return retdesc;
+	}
+
+	retdesc = devm_gpiod_get_index(dev, NULL, index, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from index %u\n", index);
+		return retdesc;
+	}
+
+	ret = PTR_ERR(retdesc);
+
+	/* FIXME: hack in the old code, is this really necessary? */
+	if (ret == -EINVAL)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	/* This happens if the GPIO driver is not yet probed, let's defer */
+	if (ret == -ENOENT)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "error trying to get descriptor: %ld\n", ret);
+
+	return retdesc;
+}
+
 static int i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
@@ -125,14 +161,10 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-	priv->sda = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(priv->sda)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->sda = i2c_gpio_get_desc(dev, "sda", 0, gflags);
+	if (IS_ERR(priv->sda))
+		return PTR_ERR(priv->sda);
+
 	/*
 	 * If the SCL line is marked from platform data or device tree as
 	 * "open drain" it means something outside of our control is making
@@ -144,14 +176,9 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_LOW;
 	else
 		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	priv->scl = devm_gpiod_get_index(dev, NULL, 1, gflags);
-	if (IS_ERR(priv->scl)) {
-		ret = PTR_ERR(priv->scl);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->scl = i2c_gpio_get_desc(dev, "scl", 1, gflags);
+	if (IS_ERR(priv->scl))
+		return PTR_ERR(priv->scl);
 
 	bit_data->setsda = i2c_gpio_setsda_val;
 	bit_data->setscl = i2c_gpio_setscl_val;
-- 
2.13.5
