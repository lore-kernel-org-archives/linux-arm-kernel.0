From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:47 +0530
Subject: [PATCH V9 06/14] drm/bridge: ptn3460: support drm_panel
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-7-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add drm_panel calls to the driver to make the panel and
bridge work together in tandem.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 .../devicetree/bindings/drm/bridge/ptn3460.txt     |   12 ++++++
 drivers/gpu/drm/bridge/Kconfig                     |    1 +
 drivers/gpu/drm/bridge/ptn3460.c                   |   42 ++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt b/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
index 52b93b2..663fe6c 100644
--- a/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
+++ b/Documentation/devicetree/bindings/drm/bridge/ptn3460.txt
@@ -17,6 +17,11 @@ Required properties:
 		|   6   |  1600x900  | ChiMei M215HGE   |
 		+-------+------------+------------------+
 
+	- video interfaces: Device node can contain video interface port
+			    nodes for panel according to [1].
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
 Example:
 	lvds-bridge at 20 {
 		compatible = "nxp,ptn3460";
@@ -24,4 +29,11 @@ Example:
 		powerdown-gpio = <&gpy2 5 1 0 0>;
 		reset-gpio = <&gpx1 5 1 0 0>;
 		edid-emulation = <5>;
+		ports {
+			port at 0 {
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
 	};
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4254c2b..8b426e2 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -3,5 +3,6 @@ config DRM_PTN3460
 	depends on DRM
 	depends on OF && I2C
 	select DRM_KMS_HELPER
+	select DRM_PANEL
 	---help---
 	  ptn3460 eDP-LVDS bridge chip driver.
diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index 7adeb60..e6d5ae7 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -19,6 +19,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/of_graph.h>
+
+#include <drm/drm_panel.h>
 
 #include "bridge/ptn3460.h"
 
@@ -38,6 +41,7 @@ struct ptn3460_bridge {
 	struct i2c_client *client;
 	struct drm_bridge bridge;
 	struct edid *edid;
+	struct drm_panel *panel;
 	int gpio_pd_n;
 	int gpio_rst_n;
 	u32 edid_emulation;
@@ -137,6 +141,11 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 		gpio_set_value(ptn_bridge->gpio_rst_n, 1);
 	}
 
+	if (drm_panel_prepare(ptn_bridge->panel)) {
+		DRM_ERROR("failed to prepare panel\n");
+		return;
+	}
+
 	/*
 	 * There's a bug in the PTN chip where it falsely asserts hotplug before
 	 * it is fully functional. We're forced to wait for the maximum start up
@@ -153,6 +162,12 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 
 static void ptn3460_enable(struct drm_bridge *bridge)
 {
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
+
+	if (drm_panel_enable(ptn_bridge->panel)) {
+		DRM_ERROR("failed to enable panel\n");
+		return;
+	}
 }
 
 static void ptn3460_disable(struct drm_bridge *bridge)
@@ -164,6 +179,11 @@ static void ptn3460_disable(struct drm_bridge *bridge)
 
 	ptn_bridge->enabled = false;
 
+	if (drm_panel_disable(ptn_bridge->panel)) {
+		DRM_ERROR("failed to disable panel\n");
+		return;
+	}
+
 	if (gpio_is_valid(ptn_bridge->gpio_rst_n))
 		gpio_set_value(ptn_bridge->gpio_rst_n, 1);
 
@@ -173,6 +193,12 @@ static void ptn3460_disable(struct drm_bridge *bridge)
 
 static void ptn3460_post_disable(struct drm_bridge *bridge)
 {
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
+
+	if (drm_panel_unprepare(ptn_bridge->panel)) {
+		DRM_ERROR("failed to unprepare panel\n");
+		return;
+	}
 }
 
 static int ptn3460_get_modes(struct drm_connector *connector)
@@ -267,6 +293,9 @@ int ptn3460_bridge_attach(struct drm_bridge *bridge)
 	drm_mode_connector_attach_encoder(&ptn_bridge->connector,
 							bridge->encoder);
 
+	if (ptn_bridge->panel)
+		drm_panel_attach(ptn_bridge->panel, &ptn_bridge->connector);
+
 	return ret;
 }
 
@@ -283,6 +312,7 @@ static int ptn3460_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct ptn3460_bridge *ptn_bridge;
+	struct device_node *endpoint, *panel_node;
 	int ret;
 
 	ptn_bridge = devm_kzalloc(dev, sizeof(*ptn_bridge), GFP_KERNEL);
@@ -290,6 +320,17 @@ static int ptn3460_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
+	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
+	if (endpoint) {
+		panel_node = of_graph_get_remote_port_parent(endpoint);
+		if (panel_node) {
+			ptn_bridge->panel = of_drm_find_panel(panel_node);
+			of_node_put(panel_node);
+			if (!ptn_bridge->panel)
+				return -EPROBE_DEFER;
+		}
+	}
+
 	ptn_bridge->client = client;
 	ptn_bridge->gpio_pd_n = of_get_named_gpio(dev->of_node,
 							"powerdown-gpio", 0);
@@ -327,6 +368,7 @@ static int ptn3460_probe(struct i2c_client *client,
 	}
 
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
+	ptn_bridge->bridge.of_node = dev->of_node;
 	ret = drm_bridge_add(&ptn_bridge->bridge);
 	if (ret) {
 		DRM_ERROR("Failed to add bridge\n");
-- 
1.7.9.5
