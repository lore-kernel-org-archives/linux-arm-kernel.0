From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:45 +0530
Subject: [PATCH V9 04/14] drm/bridge: ptn3460: Convert to i2c driver model
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-5-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use drm_bridge helpers to modify the driver to support
i2c driver model.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/gpu/drm/bridge/Kconfig          |    2 +
 drivers/gpu/drm/bridge/ptn3460.c        |  124 +++++++++++++++++++++----------
 drivers/gpu/drm/exynos/exynos_dp_core.c |   22 ------
 3 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 884923f..4254c2b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -1,5 +1,7 @@
 config DRM_PTN3460
 	tristate "PTN3460 DP/LVDS bridge"
 	depends on DRM
+	depends on OF && I2C
 	select DRM_KMS_HELPER
 	---help---
+	  ptn3460 eDP-LVDS bridge chip driver.
diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index 4a818c1..7adeb60 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -36,7 +36,6 @@
 struct ptn3460_bridge {
 	struct drm_connector connector;
 	struct i2c_client *client;
-	struct drm_encoder *encoder;
 	struct drm_bridge bridge;
 	struct edid *edid;
 	int gpio_pd_n;
@@ -176,13 +175,6 @@ static void ptn3460_post_disable(struct drm_bridge *bridge)
 {
 }
 
-static struct drm_bridge_funcs ptn3460_bridge_funcs = {
-	.pre_enable = ptn3460_pre_enable,
-	.enable = ptn3460_enable,
-	.disable = ptn3460_disable,
-	.post_disable = ptn3460_post_disable,
-};
-
 static int ptn3460_get_modes(struct drm_connector *connector)
 {
 	struct ptn3460_bridge *ptn_bridge;
@@ -227,7 +219,7 @@ static struct drm_encoder *ptn3460_best_encoder(struct drm_connector *connector)
 {
 	struct ptn3460_bridge *ptn_bridge = connector_to_ptn3460(connector);
 
-	return ptn_bridge->encoder;
+	return ptn_bridge->bridge.encoder;
 }
 
 static struct drm_connector_helper_funcs ptn3460_connector_helper_funcs = {
@@ -253,31 +245,66 @@ static struct drm_connector_funcs ptn3460_connector_funcs = {
 	.destroy = ptn3460_connector_destroy,
 };
 
-int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
-		struct i2c_client *client, struct device_node *node)
+int ptn3460_bridge_attach(struct drm_bridge *bridge)
 {
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
 	int ret;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Parent encoder object not found");
+		return -ENODEV;
+	}
+
+	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
+			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector with drm\n");
+		return ret;
+	}
+	drm_connector_helper_add(&ptn_bridge->connector,
+					&ptn3460_connector_helper_funcs);
+	drm_connector_register(&ptn_bridge->connector);
+	drm_mode_connector_attach_encoder(&ptn_bridge->connector,
+							bridge->encoder);
+
+	return ret;
+}
+
+static struct drm_bridge_funcs ptn3460_bridge_funcs = {
+	.pre_enable = ptn3460_pre_enable,
+	.enable = ptn3460_enable,
+	.disable = ptn3460_disable,
+	.post_disable = ptn3460_post_disable,
+	.attach = ptn3460_bridge_attach,
+};
+
+static int ptn3460_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
 	struct ptn3460_bridge *ptn_bridge;
+	int ret;
 
-	ptn_bridge = devm_kzalloc(dev->dev, sizeof(*ptn_bridge), GFP_KERNEL);
+	ptn_bridge = devm_kzalloc(dev, sizeof(*ptn_bridge), GFP_KERNEL);
 	if (!ptn_bridge) {
 		return -ENOMEM;
 	}
 
 	ptn_bridge->client = client;
-	ptn_bridge->encoder = encoder;
-	ptn_bridge->gpio_pd_n = of_get_named_gpio(node, "powerdown-gpio", 0);
+	ptn_bridge->gpio_pd_n = of_get_named_gpio(dev->of_node,
+							"powerdown-gpio", 0);
 	if (gpio_is_valid(ptn_bridge->gpio_pd_n)) {
 		ret = gpio_request_one(ptn_bridge->gpio_pd_n,
 				GPIOF_OUT_INIT_HIGH, "PTN3460_PD_N");
 		if (ret) {
-			dev_err(&client->dev,
-				"Request powerdown-gpio failed (%d)\n", ret);
+			dev_err(dev, "Request powerdown-gpio failed (%d)\n",
+									ret);
 			return ret;
 		}
 	}
 
-	ptn_bridge->gpio_rst_n = of_get_named_gpio(node, "reset-gpio", 0);
+	ptn_bridge->gpio_rst_n = of_get_named_gpio(dev->of_node,
+							"reset-gpio", 0);
 	if (gpio_is_valid(ptn_bridge->gpio_rst_n)) {
 		/*
 		 * Request the reset pin low to avoid the bridge being
@@ -286,39 +313,27 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
 		ret = gpio_request_one(ptn_bridge->gpio_rst_n,
 				GPIOF_OUT_INIT_LOW, "PTN3460_RST_N");
 		if (ret) {
-			dev_err(&client->dev,
-				"Request reset-gpio failed (%d)\n", ret);
+			dev_err(dev, "Request reset-gpio failed (%d)\n", ret);
 			gpio_free(ptn_bridge->gpio_pd_n);
 			return ret;
 		}
 	}
 
-	ret = of_property_read_u32(node, "edid-emulation",
+	ret = of_property_read_u32(dev->of_node, "edid-emulation",
 			&ptn_bridge->edid_emulation);
 	if (ret) {
-		dev_err(&client->dev, "Can't read EDID emulation value\n");
+		dev_err(dev, "Can't read EDID emulation value\n");
 		goto err;
 	}
 
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
-	ret = drm_bridge_attach(dev, &ptn_bridge->bridge);
+	ret = drm_bridge_add(&ptn_bridge->bridge);
 	if (ret) {
-		DRM_ERROR("Failed to initialize bridge with drm\n");
+		DRM_ERROR("Failed to add bridge\n");
 		goto err;
 	}
 
-	encoder->bridge = &ptn_bridge->bridge;
-
-	ret = drm_connector_init(dev, &ptn_bridge->connector,
-			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
-	if (ret) {
-		DRM_ERROR("Failed to initialize connector with drm\n");
-		goto err;
-	}
-	drm_connector_helper_add(&ptn_bridge->connector,
-			&ptn3460_connector_helper_funcs);
-	drm_connector_register(&ptn_bridge->connector);
-	drm_mode_connector_attach_encoder(&ptn_bridge->connector, encoder);
+	i2c_set_clientdata(client, ptn_bridge);
 
 	return 0;
 
@@ -329,16 +344,45 @@ err:
 		gpio_free(ptn_bridge->gpio_rst_n);
 	return ret;
 }
-EXPORT_SYMBOL(ptn3460_init);
 
-void ptn3460_destroy(struct drm_bridge *bridge)
+static int ptn3460_remove(struct i2c_client *client)
 {
-	struct ptn3460_bridge *ptn_bridge = bridge->driver_private;
+	struct ptn3460_bridge *ptn_bridge = i2c_get_clientdata(client);
+
+	drm_bridge_remove(&ptn_bridge->bridge);
 
 	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
 		gpio_free(ptn_bridge->gpio_pd_n);
 	if (gpio_is_valid(ptn_bridge->gpio_rst_n))
 		gpio_free(ptn_bridge->gpio_rst_n);
-	/* Nothing else to free, we've got devm allocated memory */
+
+	return 0;
 }
-EXPORT_SYMBOL(ptn3460_destroy);
+
+static const struct i2c_device_id ptn3460_i2c_table[] = {
+	{"nxp,ptn3460", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ptn3460_i2c_table);
+
+static const struct of_device_id ptn3460_match[] = {
+	{ .compatible = "nxp,ptn3460" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ptn3460_match);
+
+static struct i2c_driver ptn3460_driver = {
+	.id_table	= ptn3460_i2c_table,
+	.probe		= ptn3460_probe,
+	.remove		= ptn3460_remove,
+	.driver		= {
+		.name	= "nxp,ptn3460",
+		.owner	= THIS_MODULE,
+		.of_match_table = ptn3460_match,
+	},
+};
+module_i2c_driver(ptn3460_driver);
+
+MODULE_AUTHOR("Sean Paul <seanpaul@chromium.org>");
+MODULE_DESCRIPTION("NXP ptn3460 eDP-LVDS converter driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index 34d46aa..27e3d27 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -993,32 +993,10 @@ static struct drm_connector_helper_funcs exynos_dp_connector_helper_funcs = {
 	.best_encoder = exynos_dp_best_encoder,
 };
 
-static bool find_bridge(const char *compat, struct bridge_init *bridge)
-{
-	bridge->client = NULL;
-	bridge->node = of_find_compatible_node(NULL, NULL, compat);
-	if (!bridge->node)
-		return false;
-
-	bridge->client = of_find_i2c_device_by_node(bridge->node);
-	if (!bridge->client)
-		return false;
-
-	return true;
-}
-
 /* returns the number of bridges attached */
 static int exynos_drm_attach_lcd_bridge(struct drm_device *dev,
 		struct drm_encoder *encoder)
 {
-	struct bridge_init bridge;
-	int ret;
-
-	if (find_bridge("nxp,ptn3460", &bridge)) {
-		ret = ptn3460_init(dev, encoder, bridge.client, bridge.node);
-		if (!ret)
-			return 1;
-	}
 	return 0;
 }
 
-- 
1.7.9.5
