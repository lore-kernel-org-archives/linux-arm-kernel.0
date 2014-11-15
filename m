From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Sat, 15 Nov 2014 15:24:57 +0530
Subject: [PATCH V8 02/14] drm/bridge: do not pass drm_bridge_funcs to
 drm_bridge_init
In-Reply-To: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1416045309-13359-3-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign the pointer to bridge ops structure(drm_bridge_funcs) in
the bridge driver itself, instead of passing it to drm_bridge_init.

This will allow bridge driver developer to pack bridge private
information inside the bridge object and pass only the drm-relevant
information to drm_bridge_init.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
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
index e79c8d3..408c053 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -1011,7 +1011,6 @@ EXPORT_SYMBOL(drm_connector_unplug_all);
  * drm_bridge_init - initialize a drm transcoder/bridge
  * @dev: drm device
  * @bridge: transcoder/bridge to set up
- * @funcs: bridge function table
  *
  * Initialises a preallocated bridge. Bridges should be
  * subclassed as part of driver connector objects.
@@ -1019,8 +1018,7 @@ EXPORT_SYMBOL(drm_connector_unplug_all);
  * Returns:
  * Zero on success, error code on failure.
  */
-int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
-		const struct drm_bridge_funcs *funcs)
+int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge)
 {
 	int ret;
 
@@ -1031,7 +1029,6 @@ int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
 		goto out;
 
 	bridge->dev = dev;
-	bridge->funcs = funcs;
 
 	list_add_tail(&bridge->head, &dev->mode_config.bridge_list);
 	dev->mode_config.num_bridge++;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index f6cf745..0309539 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -221,8 +221,9 @@ struct drm_bridge *hdmi_bridge_init(struct hdmi *hdmi)
 	hdmi_bridge->hdmi = hdmi_reference(hdmi);
 
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
index b22968c..285f723 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -628,7 +628,8 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 		return -ENOMEM;
 
 	bridge->driver_private = hdmi;
-	drm_bridge_init(drm_dev, bridge, &sti_hdmi_bridge_funcs);
+	bridge->funcs = &sti_hdmi_bridge_funcs;
+	drm_bridge_init(drm_dev, bridge);
 
 	encoder->bridge = bridge;
 	connector->encoder = encoder;
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index c40070a..5a3bce17 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -912,8 +912,7 @@ extern unsigned int drm_connector_index(struct drm_connector *connector);
 /* helper to unplug all connectors from sysfs for device */
 extern void drm_connector_unplug_all(struct drm_device *dev);
 
-extern int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge,
-			   const struct drm_bridge_funcs *funcs);
+extern int drm_bridge_init(struct drm_device *dev, struct drm_bridge *bridge);
 extern void drm_bridge_cleanup(struct drm_bridge *bridge);
 
 extern int drm_encoder_init(struct drm_device *dev,
-- 
1.7.9.5
