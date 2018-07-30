From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 30 Jul 2018 17:42:31 +0100
Subject: [PATCH v2 6/7] drm/i2c: tda998x: cleanup from previous changes
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <E1fkBFf-000496-Ve@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the code a little from the effects of the previous changes:
- Move tda998x_destroy() to be above tda998x_create()
- Use 'dev' directly in tda998x_create() where appropriate.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 76 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 476161967742..ea71602d1139 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1567,31 +1567,6 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.enable = tda998x_bridge_enable,
 };
 
-static void tda998x_destroy(struct device *dev)
-{
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
-
-	drm_bridge_remove(&priv->bridge);
-
-	/* disable all IRQs and free the IRQ handler */
-	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
-	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
-
-	if (priv->audio_pdev)
-		platform_device_unregister(priv->audio_pdev);
-
-	if (priv->hdmi->irq)
-		free_irq(priv->hdmi->irq, priv);
-
-	del_timer_sync(&priv->edid_delay_timer);
-	cancel_work_sync(&priv->detect_work);
-
-	i2c_unregister_device(priv->cec);
-
-	if (priv->cec_notify)
-		cec_notifier_put(priv->cec_notify);
-}
-
 /* I2C driver functions */
 
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
@@ -1655,6 +1630,31 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
+static void tda998x_destroy(struct device *dev)
+{
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+
+	drm_bridge_remove(&priv->bridge);
+
+	/* disable all IRQs and free the IRQ handler */
+	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
+	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+
+	if (priv->audio_pdev)
+		platform_device_unregister(priv->audio_pdev);
+
+	if (priv->hdmi->irq)
+		free_irq(priv->hdmi->irq, priv);
+
+	del_timer_sync(&priv->edid_delay_timer);
+	cancel_work_sync(&priv->detect_work);
+
+	i2c_unregister_device(priv->cec);
+
+	if (priv->cec_notify)
+		cec_notifier_put(priv->cec_notify);
+}
+
 static int tda998x_create(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1696,13 +1696,13 @@ static int tda998x_create(struct device *dev)
 	/* read version: */
 	rev_lo = reg_read(priv, REG_VERSION_LSB);
 	if (rev_lo < 0) {
-		dev_err(&client->dev, "failed to read version: %d\n", rev_lo);
+		dev_err(dev, "failed to read version: %d\n", rev_lo);
 		return rev_lo;
 	}
 
 	rev_hi = reg_read(priv, REG_VERSION_MSB);
 	if (rev_hi < 0) {
-		dev_err(&client->dev, "failed to read version: %d\n", rev_hi);
+		dev_err(dev, "failed to read version: %d\n", rev_hi);
 		return rev_hi;
 	}
 
@@ -1713,20 +1713,19 @@ static int tda998x_create(struct device *dev)
 
 	switch (priv->rev) {
 	case TDA9989N2:
-		dev_info(&client->dev, "found TDA9989 n2");
+		dev_info(dev, "found TDA9989 n2");
 		break;
 	case TDA19989:
-		dev_info(&client->dev, "found TDA19989");
+		dev_info(dev, "found TDA19989");
 		break;
 	case TDA19989N2:
-		dev_info(&client->dev, "found TDA19989 n2");
+		dev_info(dev, "found TDA19989 n2");
 		break;
 	case TDA19988:
-		dev_info(&client->dev, "found TDA19988");
+		dev_info(dev, "found TDA19988");
 		break;
 	default:
-		dev_err(&client->dev, "found unsupported device: %04x\n",
-			priv->rev);
+		dev_err(dev, "found unsupported device: %04x\n", priv->rev);
 		return -ENXIO;
 	}
 
@@ -1769,8 +1768,7 @@ static int tda998x_create(struct device *dev)
 					   tda998x_irq_thread, irq_flags,
 					   "tda998x", priv);
 		if (ret) {
-			dev_err(&client->dev,
-				"failed to request IRQ#%u: %d\n",
+			dev_err(dev, "failed to request IRQ#%u: %d\n",
 				client->irq, ret);
 			goto err_irq;
 		}
@@ -1779,13 +1777,13 @@ static int tda998x_create(struct device *dev)
 		cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
 	}
 
-	priv->cec_notify = cec_notifier_get(&client->dev);
+	priv->cec_notify = cec_notifier_get(dev);
 	if (!priv->cec_notify) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	priv->cec_glue.parent = &client->dev;
+	priv->cec_glue.parent = dev;
 	priv->cec_glue.data = priv;
 	priv->cec_glue.init = tda998x_cec_hook_init;
 	priv->cec_glue.exit = tda998x_cec_hook_exit;
@@ -1830,8 +1828,8 @@ static int tda998x_create(struct device *dev)
 
 		if (priv->audio_port[0].format != AFMT_UNUSED)
 			tda998x_audio_codec_init(priv, &client->dev);
-	} else if (client->dev.platform_data) {
-		tda998x_set_config(priv, client->dev.platform_data);
+	} else if (dev->platform_data) {
+		tda998x_set_config(priv, dev->platform_data);
 	}
 
 	priv->bridge.funcs = &tda998x_bridge_funcs;
-- 
2.7.4
