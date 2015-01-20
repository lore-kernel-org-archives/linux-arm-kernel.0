From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:42 +0530
Subject: [PATCH V9 01/14] drm/bridge: ptn3460: Few trivial cleanups
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-2-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following changes:
	-- Use usleep_range instead of udelay.
	-- Remove driver_private member from ptn3460 structure.
	-- Make all possible functions and structures static.
	-- Use dev_err for non-DRM errors.
	-- Arrange header files alphabetically.
	-- s/edid/EDID in all error messages.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/gpu/drm/bridge/ptn3460.c |   95 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/
gpu/drm/bridge/ptn3460.c
index d466696..4db38e1 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -13,19 +13,19 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
 
-#include "drmP.h"
-#include "drm_edid.h"
+#include "bridge/ptn3460.h"
+
 #include "drm_crtc.h"
 #include "drm_crtc_helper.h"
-
-#include "bridge/ptn3460.h"
+#include "drm_edid.h"
+#include "drmP.h"
 
 #define PTN3460_EDID_ADDR			0x0
 #define PTN3460_EDID_EMULATION_ADDR		0x84
@@ -37,7 +37,7 @@ struct ptn3460_bridge {
 	struct drm_connector connector;
 	struct i2c_client *client;
 	struct drm_encoder *encoder;
-	struct drm_bridge *bridge;
+	struct drm_bridge bridge;
 	struct edid *edid;
 	int gpio_pd_n;
 	int gpio_rst_n;
@@ -45,6 +45,18 @@ struct ptn3460_bridge {
 	bool enabled;
 };
 
+static inline struct ptn3460_bridge *
+		bridge_to_ptn3460(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct ptn3460_bridge, bridge);
+}
+
+static inline struct ptn3460_bridge *
+		connector_to_ptn3460(struct drm_connector *connector)
+{
+	return container_of(connector, struct ptn3460_bridge, connector);
+}
+
 static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 		u8 *buf, int len)
 {
@@ -92,7 +104,7 @@ static int ptn3460_select_edid(struct ptn3460_bridge *ptn_bridge)
 	ret = ptn3460_write_byte(ptn_bridge, PTN3460_EDID_SRAM_LOAD_ADDR,
 			ptn_bridge->edid_emulation);
 	if (ret) {
-		DRM_ERROR("Failed to transfer edid to sram, ret=%d\n", ret);
+		DRM_ERROR("Failed to transfer EDID to sram, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -102,7 +114,7 @@ static int ptn3460_select_edid(struct ptn3460_bridge *ptn_bridge)
 
 	ret = ptn3460_write_byte(ptn_bridge, PTN3460_EDID_EMULATION_ADDR, val);
 	if (ret) {
-		DRM_ERROR("Failed to write edid value, ret=%d\n", ret);
+		DRM_ERROR("Failed to write EDID value, ret=%d\n", ret);
 		return ret;
 	}
 
@@ -111,7 +123,7 @@ static int ptn3460_select_edid(struct ptn3460_bridge *ptn_bridge)
 
 static void ptn3460_pre_enable(struct drm_bridge *bridge)
 {
-	struct ptn3460_bridge *ptn_bridge = bridge->driver_private;
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
 	int ret;
 
 	if (ptn_bridge->enabled)
@@ -122,7 +134,7 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 
 	if (gpio_is_valid(ptn_bridge->gpio_rst_n)) {
 		gpio_set_value(ptn_bridge->gpio_rst_n, 0);
-		udelay(10);
+		usleep_range(10, 20);
 		gpio_set_value(ptn_bridge->gpio_rst_n, 1);
 	}
 
@@ -135,7 +147,7 @@ static void ptn3460_pre_enable(struct drm_bridge *bridge)
 
 	ret = ptn3460_select_edid(ptn_bridge);
 	if (ret)
-		DRM_ERROR("Select edid failed ret=%d\n", ret);
+		DRM_ERROR("Select EDID failed ret=%d\n", ret);
 
 	ptn_bridge->enabled = true;
 }
@@ -146,7 +158,7 @@ static void ptn3460_enable(struct drm_bridge *bridge)
 
 static void ptn3460_disable(struct drm_bridge *bridge)
 {
-	struct ptn3460_bridge *ptn_bridge = bridge->driver_private;
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
 
 	if (!ptn_bridge->enabled)
 		return;
@@ -164,9 +176,9 @@ static void ptn3460_post_disable(struct drm_bridge *bridge)
 {
 }
 
-void ptn3460_bridge_destroy(struct drm_bridge *bridge)
+static void ptn3460_bridge_destroy(struct drm_bridge *bridge)
 {
-	struct ptn3460_bridge *ptn_bridge = bridge->driver_private;
+	struct ptn3460_bridge *ptn_bridge = bridge_to_ptn3460(bridge);
 
 	drm_bridge_cleanup(bridge);
 	if (gpio_is_valid(ptn_bridge->gpio_pd_n))
@@ -176,7 +188,7 @@ void ptn3460_bridge_destroy(struct drm_bridge *bridge)
 	/* Nothing else to free, we've got devm allocated memory */
 }
 
-struct drm_bridge_funcs ptn3460_bridge_funcs = {
+static struct drm_bridge_funcs ptn3460_bridge_funcs = {
 	.pre_enable = ptn3460_pre_enable,
 	.enable = ptn3460_enable,
 	.disable = ptn3460_disable,
@@ -184,24 +196,24 @@ struct drm_bridge_funcs ptn3460_bridge_funcs = {
 	.destroy = ptn3460_bridge_destroy,
 };
 
-int ptn3460_get_modes(struct drm_connector *connector)
+static int ptn3460_get_modes(struct drm_connector *connector)
 {
 	struct ptn3460_bridge *ptn_bridge;
 	u8 *edid;
-	int ret, num_modes;
+	int ret, num_modes = 0;
 	bool power_off;
 
-	ptn_bridge = container_of(connector, struct ptn3460_bridge, connector);
+	ptn_bridge = connector_to_ptn3460(connector);
 
 	if (ptn_bridge->edid)
 		return drm_add_edid_modes(connector, ptn_bridge->edid);
 
 	power_off = !ptn_bridge->enabled;
-	ptn3460_pre_enable(ptn_bridge->bridge);
+	ptn3460_pre_enable(&ptn_bridge->bridge);
 
 	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!edid) {
-		DRM_ERROR("Failed to allocate edid\n");
+		DRM_ERROR("Failed to allocate EDID\n");
 		return 0;
 	}
 
@@ -209,7 +221,6 @@ int ptn3460_get_modes(struct drm_connector *connector)
 			EDID_LENGTH);
 	if (ret) {
 		kfree(edid);
-		num_modes = 0;
 		goto out;
 	}
 
@@ -220,37 +231,35 @@ int ptn3460_get_modes(struct drm_connector *connector)
 
 out:
 	if (power_off)
-		ptn3460_disable(ptn_bridge->bridge);
+		ptn3460_disable(&ptn_bridge->bridge);
 
 	return num_modes;
 }
 
-struct drm_encoder *ptn3460_best_encoder(struct drm_connector *connector)
+static struct drm_encoder *ptn3460_best_encoder(struct drm_connector *connector)
 {
-	struct ptn3460_bridge *ptn_bridge;
-
-	ptn_bridge = container_of(connector, struct ptn3460_bridge, connector);
+	struct ptn3460_bridge *ptn_bridge = connector_to_ptn3460(connector);
 
 	return ptn_bridge->encoder;
 }
 
-struct drm_connector_helper_funcs ptn3460_connector_helper_funcs = {
+static struct drm_connector_helper_funcs ptn3460_connector_helper_funcs = {
 	.get_modes = ptn3460_get_modes,
 	.best_encoder = ptn3460_best_encoder,
 };
 
-enum drm_connector_status ptn3460_detect(struct drm_connector *connector,
+static enum drm_connector_status ptn3460_detect(struct drm_connector *connector,
 		bool force)
 {
 	return connector_status_connected;
 }
 
-void ptn3460_connector_destroy(struct drm_connector *connector)
+static void ptn3460_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_cleanup(connector);
 }
 
-struct drm_connector_funcs ptn3460_connector_funcs = {
+static struct drm_connector_funcs ptn3460_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = ptn3460_detect,
@@ -261,30 +270,22 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
 		struct i2c_client *client, struct device_node *node)
 {
 	int ret;
-	struct drm_bridge *bridge;
 	struct ptn3460_bridge *ptn_bridge;
 
-	bridge = devm_kzalloc(dev->dev, sizeof(*bridge), GFP_KERNEL);
-	if (!bridge) {
-		DRM_ERROR("Failed to allocate drm bridge\n");
-		return -ENOMEM;
-	}
-
 	ptn_bridge = devm_kzalloc(dev->dev, sizeof(*ptn_bridge), GFP_KERNEL);
 	if (!ptn_bridge) {
-		DRM_ERROR("Failed to allocate ptn bridge\n");
 		return -ENOMEM;
 	}
 
 	ptn_bridge->client = client;
 	ptn_bridge->encoder = encoder;
-	ptn_bridge->bridge = bridge;
 	ptn_bridge->gpio_pd_n = of_get_named_gpio(node, "powerdown-gpio", 0);
 	if (gpio_is_valid(ptn_bridge->gpio_pd_n)) {
 		ret = gpio_request_one(ptn_bridge->gpio_pd_n,
 				GPIOF_OUT_INIT_HIGH, "PTN3460_PD_N");
 		if (ret) {
-			DRM_ERROR("Request powerdown-gpio failed (%d)\n", ret);
+			dev_err(&client->dev,
+				"Request powerdown-gpio failed (%d)\n", ret);
 			return ret;
 		}
 	}
@@ -298,7 +299,8 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
 		ret = gpio_request_one(ptn_bridge->gpio_rst_n,
 				GPIOF_OUT_INIT_LOW, "PTN3460_RST_N");
 		if (ret) {
-			DRM_ERROR("Request reset-gpio failed (%d)\n", ret);
+			dev_err(&client->dev,
+				"Request reset-gpio failed (%d)\n", ret);
 			gpio_free(ptn_bridge->gpio_pd_n);
 			return ret;
 		}
@@ -307,18 +309,17 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
 	ret = of_property_read_u32(node, "edid-emulation",
 			&ptn_bridge->edid_emulation);
 	if (ret) {
-		DRM_ERROR("Can't read edid emulation value\n");
+		dev_err(&client->dev, "Can't read EDID emulation value\n");
 		goto err;
 	}
 
-	ret = drm_bridge_init(dev, bridge, &ptn3460_bridge_funcs);
+	ret = drm_bridge_init(dev, &ptn_bridge->bridge, &ptn3460_bridge_funcs);
 	if (ret) {
 		DRM_ERROR("Failed to initialize bridge with drm\n");
 		goto err;
 	}
 
-	bridge->driver_private = ptn_bridge;
-	encoder->bridge = bridge;
+	encoder->bridge = &ptn_bridge->bridge;
 
 	ret = drm_connector_init(dev, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
-- 
1.7.9.5
