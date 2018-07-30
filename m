From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 30 Jul 2018 17:42:26 +0100
Subject: [PATCH v2 5/7] drm/i2c: tda998x: allocate tda998x_priv inside
 tda998x_create()
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <E1fkBFa-00048z-Rr@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the tda998x_priv allocation inside tda998x_create() and simplify
the tda998x_create()'s arguments.  Pass the same to tda998x_destroy().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 1ea62052f3e0..476161967742 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1567,8 +1567,10 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.enable = tda998x_bridge_enable,
 };
 
-static void tda998x_destroy(struct tda998x_priv *priv)
+static void tda998x_destroy(struct device *dev)
 {
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+
 	drm_bridge_remove(&priv->bridge);
 
 	/* disable all IRQs and free the IRQ handler */
@@ -1653,13 +1655,21 @@ static void tda998x_set_config(struct tda998x_priv *priv,
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
@@ -1832,7 +1842,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	return 0;
 
 fail:
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 err_irq:
 	return ret;
 }
@@ -1884,24 +1894,16 @@ static int tda998x_encoder_init(struct device *dev, struct drm_device *drm)
 
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
@@ -1913,7 +1915,7 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
 	drm_encoder_cleanup(&priv->encoder);
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 }
 
 static const struct component_ops tda998x_ops = {
-- 
2.7.4
