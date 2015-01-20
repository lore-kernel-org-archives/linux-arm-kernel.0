From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Jan 2015 22:08:43 +0530
Subject: [PATCH V9 02/14] drm/bridge: do not pass drm_bridge_funcs to
 drm_bridge_init
In-Reply-To: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1421771935-31618-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign the pointer to bridge ops structure(drm_bridge_funcs) in
the bridge driver itself, instead of passing it to drm_bridge_init.

This will allow bridge driver developer to pack bridge private
information inside the bridge object and pass only the drm-relevant
information to drm_bridge_init.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Tested-by: Rahul Sharma <rahul.sharma@samsung.com>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/gpu/drm/bridge/ptn3460.c       |    3 ++-
 drivers/gpu/drm/drm_crtc.c             |    5 +----
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |    3 ++-
 drivers/gpu/drm/sti/sti_hda.c          |    3 ++-
 drivers/gpu/drm/sti/sti_hdmi.c         |    3 ++-
 include/drm/drm_crtc.h                 |    3 +--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ptn3460.c b/drivers/gpu/drm/bridge/ptn3460.c
index 4db38e1..a2ddc8d 100644
--- a/drivers/gpu/drm/bridge/ptn3460.c
+++ b/drivers/gpu/drm/bridge/ptn3460.c
@@ -313,7 +313,8 @@ int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
 		goto err;
 	}
 
-	ret = drm_bridge_init(dev, &ptn_bridge->bridge, &ptn3460_bridge_funcs);
+	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
+	ret = drm_bridge_init(dev, &ptn_bridge->bridge);
 	if (ret) {
 		DRM_ERROR("Failed to initialize bridge with drm\n");
 		goto err;
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index caec5c3..4acd693 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -1030,7 +1030,6 @@ EXPORT_SYMBOL(drm_connector_unplug_all);
  * drm_bridge_init - initialize a drm transcoder/bridge
  * @dev: drm device
  * @bridge: transcoder/bridge to set up
- * @funcs: bridge function table
  *
  * Initialises a preallocated bridge. Bridges should be
  * subclassed as part of driver connector objects.
@@ -1038,8 +1037,7 @@ EXPORT_SYMBOL(drm_connector_unplug_all);
  * Returns:
  * Zero on success, error code on failure.
  */
-int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
-		const struct drm_bridge_funcs *funcs)
+int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge)
 {
 	int ret;
 
@@ -1050,7 +1048,6 @@ int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
 		goto out;
 
 	bridge->dev = dev;
-	bridge->funcs = funcs;
 
 	list_add_tail(&bridge->head, &dev->mode_config.bridge_list);
 	dev->mode_config.num_bridge++;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 6902ad6..52ed2b5 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -220,8 +220,9 @@ struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
 	hdmi_bridge->hdmi = hdmi;
 
 	bridge = &hdmi_bridge->base;
+	bridge->funcs = &hdmi_bridge_funcs;
 
-	drm_bridge_init(hdmi->dev, bridge, &hdmi_bridge_funcs);
+	drm_bridge_init(hdmi->dev, bridge);
 
 	return bridge;
 
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 2ae9a9b..6cf145d 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -664,7 +664,8 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 		return -ENOMEM;
 
 	bridge->driver_private = hda;
-	drm_bridge_init(drm_dev, bridge, &sti_hda_bridge_funcs);
+	bridge->funcs = &sti_hda_bridge_funcs;
+	drm_bridge_init(drm_dev, bridge);
 
 	encoder->bridge = bridge;
 	connector->encoder = encoder;
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index d032e02..74e943e 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -635,7 +635,8 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 		goto err_adapt;
 
 	bridge->driver_private = hdmi;
-	drm_bridge_init(drm_dev, bridge, &sti_hdmi_bridge_funcs);
+	bridge->funcs = &sti_hdmi_bridge_funcs;
+	drm_bridge_init(drm_dev, bridge);
 
 	encoder->bridge = bridge;
 	connector->encoder = encoder;
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index f444263..e43d9e5 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1209,8 +1209,7 @@ extern unsigned int drm_connector_index(struct drm_connector *connector);
 /* helper to unplug all connectors from sysfs for device */
 extern void drm_connector_unplug_all(struct drm_device *dev);
 
-extern int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
-			   const struct drm_bridge_funcs *funcs);
+extern int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge);
 extern void drm_bridge_cleanup(struct drm_bridge *bridge);
 
 extern int drm_encoder_init(struct drm_device *dev,
-- 
1.7.9.5
