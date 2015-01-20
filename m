From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:49 +0530
Subject: [PATCH V9 08/14] drm/bridge: ptn3460: use gpiod interface
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-9-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify driver to support gpiod interface.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/gpu/drm/bridge/ptn3460.c |   88 ++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index 9f800a1..826833e 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -42,8 +42,8 @@ struct ptn3460_bridge {
 	struct drm_bridge bridge;
 	struct edid *edid;
 	struct drm_panel *panel;
-	int gpio_pd_n;
-	int gpio_rst_n;
+	struct gpio_desc *gpio_pd_n;
+	struct gpio_desc *gpio_rst_n;
 	u32 edid_emulation;
 	bool enabled;
 };
@@ -132,14 +132,11 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 	if (ptn_bridge->enabled)
 		return;
 
-	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
-		gpio_set_value(ptn_bridge->gpio_pd_n, 1);
+	gpiod_set_value(ptn_bridge->gpio_pd_n, 1);
 
-	if (gpio_is_valid(ptn_bridge->gpio_rst_n)) {
-		gpio_set_value(ptn_bridge->gpio_rst_n, 0);
-		usleep_range(10, 20);
-		gpio_set_value(ptn_bridge->gpio_rst_n, 1);
-	}
+	gpiod_set_value(ptn_bridge->gpio_rst_n, 0);
+	usleep_range(10, 20);
+	gpiod_set_value(ptn_bridge->gpio_rst_n, 1);
 
 	if (drm_panel_prepare(ptn_bridge->panel)) {
 		DRM_ERROR("failed to prepare panel\n");
@@ -184,11 +181,8 @@ static void ptn3460_disable(struct drm_bridge *bridge)
 		return;
 	}
 
-	if (gpio_is_valid(ptn_bridge->gpio_rst_n))
-		gpio_set_value(ptn_bridge->gpio_rst_n, 1);
-
-	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
-		gpio_set_value(ptn_bridge->gpio_pd_n, 0);
+	gpiod_set_value(ptn_bridge->gpio_rst_n, 1);
+	gpiod_set_value(ptn_bridge->gpio_pd_n, 0);
 }
 
 static void ptn3460_post_disable(struct drm_bridge *bridge)
@@ -335,39 +329,41 @@ static int ptn3460_probe(struct i2c_client *client,
 	}
 
 	ptn_bridge->client = client;
-	ptn_bridge->gpio_pd_n = of_get_named_gpio(dev->of_node,
-							"powerdown-gpio", 0);
-	if (gpio_is_valid(ptn_bridge->gpio_pd_n)) {
-		ret = gpio_request_one(ptn_bridge->gpio_pd_n,
-				GPIOF_OUT_INIT_HIGH, "PTN3460_PD_N");
-		if (ret) {
-			dev_err(dev, "Request powerdown-gpio failed (%d)\n",
-									ret);
-			return ret;
-		}
+
+	ptn_bridge->gpio_pd_n = devm_gpiod_get(&client->dev, "powerdown");
+	if (IS_ERR(ptn_bridge->gpio_pd_n)) {
+		ret = PTR_ERR(ptn_bridge->gpio_pd_n);
+		dev_err(dev, "cannot get gpio_pd_n %d\n", ret);
+		return ret;
 	}
 
-	ptn_bridge->gpio_rst_n = of_get_named_gpio(dev->of_node,
-							"reset-gpio", 0);
-	if (gpio_is_valid(ptn_bridge->gpio_rst_n)) {
-		/*
-		 * Request the reset pin low to avoid the bridge being
-		 * initialized prematurely
-		 */
-		ret = gpio_request_one(ptn_bridge->gpio_rst_n,
-				GPIOF_OUT_INIT_LOW, "PTN3460_RST_N");
-		if (ret) {
-			dev_err(dev, "Request reset-gpio failed (%d)\n", ret);
-			gpio_free(ptn_bridge->gpio_pd_n);
-			return ret;
-		}
+	ret = gpiod_direction_output(ptn_bridge->gpio_pd_n, 1);
+	if (ret) {
+		DRM_ERROR("cannot configure gpio_pd_n\n");
+		return ret;
+	}
+
+	ptn_bridge->gpio_rst_n = devm_gpiod_get(&client->dev, "reset");
+	if (IS_ERR(ptn_bridge->gpio_rst_n)) {
+		ret = PTR_ERR(ptn_bridge->gpio_rst_n);
+		DRM_ERROR("cannot get gpio_rst_n %d\n", ret);
+		return ret;
+	}
+	/*
+	 * Request the reset pin low to avoid the bridge being
+	 * initialized prematurely
+	 */
+	ret = gpiod_direction_output(ptn_bridge->gpio_rst_n, 0);
+	if (ret) {
+		DRM_ERROR("cannot configure gpio_rst_n\n");
+		return ret;
 	}
 
 	ret = of_property_read_u32(dev->of_node, "edid-emulation",
 			&ptn_bridge->edid_emulation);
 	if (ret) {
 		dev_err(dev, "Can't read EDID emulation value\n");
-		goto err;
+		return ret;
 	}
 
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
@@ -375,19 +371,12 @@ static int ptn3460_probe(struct i2c_client *client,
 	ret = drm_bridge_add(&ptn_bridge->bridge);
 	if (ret) {
 		DRM_ERROR("Failed to add bridge\n");
-		goto err;
+		return ret;
 	}
 
 	i2c_set_clientdata(client, ptn_bridge);
 
 	return 0;
-
-err:
-	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
-		gpio_free(ptn_bridge->gpio_pd_n);
-	if (gpio_is_valid(ptn_bridge->gpio_rst_n))
-		gpio_free(ptn_bridge->gpio_rst_n);
-	return ret;
 }
 
 static int ptn3460_remove(struct i2c_client *client)
@@ -396,11 +385,6 @@ static int ptn3460_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&ptn_bridge->bridge);
 
-	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
-		gpio_free(ptn_bridge->gpio_pd_n);
-	if (gpio_is_valid(ptn_bridge->gpio_rst_n))
-		gpio_free(ptn_bridge->gpio_rst_n);
-
 	return 0;
 }
 
-- 
1.7.9.5
