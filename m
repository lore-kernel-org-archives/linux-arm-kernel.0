From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Sep 2017 23:44:24 +0200
Subject: [PATCH 5/5] i2c: gpio: Local vars in probe
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Message-ID: <20170910214424.14945-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By creating local variables for *dev and *np, the code become
much easier to read, in my opinion.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I put this at the end of the series because compared to the
rest of the patches it is completely unimportant.
---
 drivers/i2c/busses/i2c-gpio.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 18ac4cf2ee75..7fe599f4fdb0 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -88,10 +88,12 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	enum gpiod_flags gflags;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -99,15 +101,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
 
-	if (pdev->dev.of_node) {
-		of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
+	if (np) {
+		of_i2c_gpio_get_props(np, pdata);
 	} else {
 		/*
 		 * If all platform data settings are zero it is OK
 		 * to not provide any platform data from the board.
 		 */
-		if (dev_get_platdata(&pdev->dev))
-			memcpy(pdata, dev_get_platdata(&pdev->dev),
+		if (dev_get_platdata(dev))
+			memcpy(pdata, dev_get_platdata(dev),
 			       sizeof(*pdata));
 	}
 
@@ -123,7 +125,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, gflags);
+	priv->sda = devm_gpiod_get_index(dev, NULL, 0, gflags);
 	if (IS_ERR(priv->sda)) {
 		ret = PTR_ERR(priv->sda);
 		/* FIXME: hack in the old code, is this really necessary? */
@@ -142,7 +144,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_LOW;
 	else
 		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, gflags);
+	priv->scl = devm_gpiod_get_index(dev, NULL, 1, gflags);
 	if (IS_ERR(priv->scl)) {
 		ret = PTR_ERR(priv->sda);
 		/* FIXME: hack in the old code, is this really necessary? */
@@ -173,15 +175,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	bit_data->data = priv;
 
 	adap->owner = THIS_MODULE;
-	if (pdev->dev.of_node)
-		strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name));
+	if (np)
+		strlcpy(adap->name, dev_name(dev), sizeof(adap->name));
 	else
 		snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->dev.parent = dev;
+	adap->dev.of_node = np;
 
 	adap->nr = pdev->id;
 	ret = i2c_bit_add_numbered_bus(adap);
@@ -195,7 +197,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	 * get accessors to get the actual name of the GPIO line,
 	 * from the descriptor, then provide that instead.
 	 */
-	dev_info(&pdev->dev, "using lines %u (SDA) and %u (SCL%s)\n",
+	dev_info(dev, "using lines %u (SDA) and %u (SCL%s)\n",
 		 desc_to_gpio(priv->sda), desc_to_gpio(priv->scl),
 		 pdata->scl_is_output_only
 		 ? ", no clock stretching" : "");
-- 
2.13.5
