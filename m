From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 11 Sep 2013 18:32:38 +0300
Subject: [PATCH v2 7/9] ASoC: codecs: convert existing I2C client drivers to
 use I2C core runtime PM
In-Reply-To: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <1378913560-2752-8-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core now prepares runtime PM on behalf of the I2C client device, so
only thing the driver needs to do is to call pm_runtime_put() at the end of
its ->probe().

This patch converts ASoC codec drivers to use this model.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 sound/soc/codecs/wm2200.c | 12 +++++-------
 sound/soc/codecs/wm5100.c |  8 ++++----
 sound/soc/codecs/wm8962.c |  5 ++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 57ba315..469b67f 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2407,21 +2407,17 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
 				i2c->irq, ret);
 	}
 
-	pm_runtime_set_active(&i2c->dev);
-	pm_runtime_enable(&i2c->dev);
-	pm_request_idle(&i2c->dev);
-
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_wm2200,
 				     &wm2200_dai, 1);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err_pm_runtime;
+		goto err_reset;
 	}
 
+	pm_runtime_put(&i2c->dev);
+
 	return 0;
 
-err_pm_runtime:
-	pm_runtime_disable(&i2c->dev);
 err_reset:
 	if (wm2200->pdata.reset)
 		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
@@ -2438,6 +2434,8 @@ static int wm2200_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
 
+	pm_runtime_get(&i2c->dev);
+
 	snd_soc_unregister_codec(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm2200);
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ac1745d..5d3b22e 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2612,10 +2612,6 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
-	pm_runtime_set_active(&i2c->dev);
-	pm_runtime_enable(&i2c->dev);
-	pm_request_idle(&i2c->dev);
-
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
@@ -2624,6 +2620,8 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 		goto err_reset;
 	}
 
+	pm_runtime_put(&i2c->dev);
+
 	return ret;
 
 err_reset:
@@ -2650,6 +2648,8 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
+	pm_runtime_get(&i2c->dev);
+
 	snd_soc_unregister_codec(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e2de9ec..4fcf7db 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3715,9 +3715,6 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 				ret);
 	}
 
-	pm_runtime_enable(&i2c->dev);
-	pm_request_idle(&i2c->dev);
-
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
 	if (ret < 0)
@@ -3725,6 +3722,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 
 	/* The drivers should power up as needed */
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
+	pm_runtime_put(&i2c->dev);
 
 	return 0;
 
@@ -3736,6 +3734,7 @@ err:
 
 static int wm8962_i2c_remove(struct i2c_client *client)
 {
+	pm_runtime_get(&client->dev);
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
-- 
1.8.4.rc3
