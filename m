From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 30 Jul 2018 17:42:37 +0100
Subject: [PATCH v2 7/7] drm/i2c: tda998x: register bridge outside of component
 helper
In-Reply-To: <20180730164137.GD17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
Message-ID: <E1fkBFl-00049E-3F@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the bridge outside of the component helper as we have
drivers that wish to use the tda998x without its encoder.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index ea71602d1139..57a42269a7fb 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1893,18 +1893,8 @@ static int tda998x_encoder_init(struct device *dev, struct drm_device *drm)
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
-	int ret;
-
-	ret = tda998x_create(dev);
-	if (ret)
-		return ret;
 
-	ret = tda998x_encoder_init(dev, drm);
-	if (ret) {
-		tda998x_destroy(dev);
-		return ret;
-	}
-	return 0;
+	return tda998x_encoder_init(dev, drm);
 }
 
 static void tda998x_unbind(struct device *dev, struct device *master,
@@ -1913,7 +1903,6 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 
 	drm_encoder_cleanup(&priv->encoder);
-	tda998x_destroy(dev);
 }
 
 static const struct component_ops tda998x_ops = {
@@ -1924,16 +1913,27 @@ static const struct component_ops tda998x_ops = {
 static int
 tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	int ret;
+
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_warn(&client->dev, "adapter does not support I2C\n");
 		return -EIO;
 	}
-	return component_add(&client->dev, &tda998x_ops);
+
+	ret = tda998x_create(&client->dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(&client->dev, &tda998x_ops);
+	if (ret)
+		tda998x_destroy(&client->dev);
+	return ret;
 }
 
 static int tda998x_remove(struct i2c_client *client)
 {
 	component_del(&client->dev, &tda998x_ops);
+	tda998x_destroy(&client->dev);
 	return 0;
 }
 
-- 
2.7.4
