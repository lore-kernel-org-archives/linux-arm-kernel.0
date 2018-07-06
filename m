From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 06 Jul 2018 15:59:15 +0100
Subject: [PATCH 6/6] drm/i2c: tda998x: cleanup from previous changes
In-Reply-To: <20180706145748.GA17271@n2100.armlinux.org.uk>
References: <20180706145748.GA17271@n2100.armlinux.org.uk>
Message-ID: <E1fbSCZ-000773-0U@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the code a little from the effects of the previous changes:
- Move tda998x_destroy() to be above tda998x_create()
- Use 'dev' directly in tda998x_create() where appropriate.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 76 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 08ccaf8cf852..6f74b3451567 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1562,31 +1562,6 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
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
@@ -1650,6 +1625,31 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1691,13 +1691,13 @@ static int tda998x_create(struct device *dev)
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
 
@@ -1708,20 +1708,19 @@ static int tda998x_create(struct device *dev)
 
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
 
@@ -1764,8 +1763,7 @@ static int tda998x_create(struct device *dev)
 					   tda998x_irq_thread, irq_flags,
 					   "tda998x", priv);
 		if (ret) {
-			dev_err(&client->dev,
-				"failed to request IRQ#%u: %d\n",
+			dev_err(dev, "failed to request IRQ#%u: %d\n",
 				client->irq, ret);
 			goto err_irq;
 		}
@@ -1774,13 +1772,13 @@ static int tda998x_create(struct device *dev)
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
@@ -1826,9 +1824,7 @@ static int tda998x_create(struct device *dev)
 		if (priv->audio_port[0].format != AFMT_UNUSED)
 			tda998x_audio_codec_init(priv, &client->dev);
 	} else {
-		struct tda998x_encoder_params *params;
-
-		params = client->dev.platform_data;
+		struct tda998x_encoder_params *params = dev->platform_data;
 		if (params)
 			tda998x_set_config(priv, params);
 	}
-- 
2.7.4
