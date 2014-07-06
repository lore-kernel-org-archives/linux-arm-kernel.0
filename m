From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 6 Jul 2014 23:18:42 +0530
Subject: [PATCH 2/5] ASoC: wm1250-ev1: Use devm_gpio_request_array
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Message-ID: <c5142ab4159ac3f235662257a0c34b5d8cf1dc64.1404665589.git.himangi774@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces a call to the unmanaged function
gpio_request_array by a call to the managed function
devm_gpio_request_array and removes the calls to gpio_free_array
in wm1250_ev1_pdata, which is called by the probe function. The
function wm1250_ev1_free is no longer needed and is removed.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 sound/soc/codecs/wm1250-ev1.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 8011f75..44534e6 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -176,7 +176,8 @@ static int wm1250_ev1_pdata(struct i2c_client *i2c)
 	wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].flags = GPIOF_OUT_INIT_HIGH;
 	wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].flags = GPIOF_OUT_INIT_HIGH;
 
-	ret = gpio_request_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
+	ret = devm_gpio_request_array(&i2c->dev, wm1250->gpios,
+				      ARRAY_SIZE(wm1250->gpios));
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to get GPIOs: %d\n", ret);
 		goto err;
@@ -190,14 +191,6 @@ err:
 	return ret;
 }
 
-static void wm1250_ev1_free(struct i2c_client *i2c)
-{
-	struct wm1250_priv *wm1250 = dev_get_drvdata(&i2c->dev);
-
-	if (wm1250)
-		gpio_free_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
-}
-
 static int wm1250_ev1_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *i2c_id)
 {
@@ -229,7 +222,6 @@ static int wm1250_ev1_probe(struct i2c_client *i2c,
 				     &wm1250_ev1_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		wm1250_ev1_free(i2c);
 		return ret;
 	}
 
@@ -239,7 +231,6 @@ static int wm1250_ev1_probe(struct i2c_client *i2c,
 static int wm1250_ev1_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
-	wm1250_ev1_free(i2c);
 
 	return 0;
 }
-- 
1.9.1
