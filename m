From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Sep 2012 17:13:02 +0200
Subject: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
In-Reply-To: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1348758784-15245-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the devm_kzalloc managed function to stripdown the error and remove
code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 68b1f8e..ecb1d69 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -71,7 +71,7 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux) {
 		ret = -ENOMEM;
 		goto alloc_failed;
@@ -79,11 +79,12 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	mux->parent = parent;
 	mux->data = *pdata;
-	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
-			    GFP_KERNEL);
+	mux->adap = devm_kzalloc(&pdev->dev,
+				 sizeof(*mux->adap) * pdata->n_values,
+				 GFP_KERNEL);
 	if (!mux->adap) {
 		ret = -ENOMEM;
-		goto alloc_failed2;
+		goto alloc_failed;
 	}
 
 	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
@@ -128,9 +129,6 @@ add_adapter_failed:
 err_request_gpio:
 	for (; i > 0; i--)
 		gpio_free(pdata->gpios[i - 1]);
-	kfree(mux->adap);
-alloc_failed2:
-	kfree(mux);
 alloc_failed:
 	i2c_put_adapter(parent);
 
@@ -150,8 +148,6 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
-	kfree(mux->adap);
-	kfree(mux);
 
 	return 0;
 }
-- 
1.7.9.5
