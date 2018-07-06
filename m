From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 06 Jul 2018 15:59:09 +0100
Subject: [PATCH 5/6] drm/i2c: tda998x: allocate tda998x_priv inside
 tda998x_create()
In-Reply-To: <20180706145748.GA17271@n2100.armlinux.org.uk>
References: <20180706145748.GA17271@n2100.armlinux.org.uk>
Message-ID: <E1fbSCT-00076w-SL@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the tda998x_priv allocation inside tda998x_create() and simplify
the tda998x_create()'s arguments.  Pass the same to tda998x_destroy().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 53f110e7d433..08ccaf8cf852 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1562,8 +1562,10 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.enable = tda998x_bridge_enable,
 };
 
-static void tda998x_destroy(struct tda998x_priv *priv)
+static void tda998x_destroy(struct device *dev)
 {
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+
 	drm_bridge_remove(&priv->bridge);
 
 	/* disable all IRQs and free the IRQ handler */
@@ -1648,13 +1650,21 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
+static int tda998x_create(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct device_node *np = client->dev.of_node;
 	struct i2c_board_info cec_info;
+	struct tda998x_priv *priv;
 	u32 video;
 	int rev_lo, rev_hi, ret;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
 	mutex_init(&priv->mutex);	/* protect the page access */
 	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
 	mutex_init(&priv->edid_mutex);
@@ -1831,7 +1841,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	return 0;
 
 fail:
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 err_irq:
 	return ret;
 }
@@ -1883,30 +1893,22 @@ static int tda998x_encoder_init(struct device *dev, struct drm_device *drm)
 
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct drm_device *drm = data;
-	struct tda998x_priv *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, priv);
-
-	ret = tda998x_create(client, priv);
+	ret = tda998x_create(dev);
 	if (ret)
 		return ret;
 
 	ret = tda998x_encoder_init(dev, drm);
 	if (ret) {
-		tda998x_destroy(priv);
+		tda998x_destroy(dev);
 		return ret;
 	}
 	return 0;
 
 err_encoder:
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 	return ret;
 }
 
@@ -1917,7 +1919,7 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 
 	drm_connector_cleanup(&priv->connector);
 	drm_encoder_cleanup(&priv->encoder);
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 }
 
 static const struct component_ops tda998x_ops = {
-- 
2.7.4
