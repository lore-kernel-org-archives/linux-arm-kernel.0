From: zourongrong@gmail.com (Rongrong Zou)
Date: Tue, 18 Oct 2016 12:01:22 +0800
Subject: [PATCH v4 7/9] drm/hisilicon/hibmc: Add connector for VDAC
In-Reply-To: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
References: <1476763284-100508-1-git-send-email-zourongrong@gmail.com>
Message-ID: <1476763284-100508-8-git-send-email-zourongrong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add connector funcs and helper funcs for VDAC.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  8 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 76 ++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index f51e5a209..2ade5a8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -142,6 +142,14 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
 		return ret;
 	}
 
+	ret = hibmc_connector_init(hidev);
+	if (ret) {
+		DRM_ERROR("failed to init connector\n");
+		return ret;
+	}
+
+	drm_mode_connector_attach_encoder(&hidev->connector,
+					  &hidev->encoder);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index c45449b..e328fb3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -49,6 +49,7 @@ struct hibmc_drm_device {
 	struct drm_plane plane;
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
+	struct drm_connector connector;
 	bool mode_config_initialized;
 
 	/* ttm */
@@ -90,6 +91,7 @@ static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
 int hibmc_plane_init(struct hibmc_drm_device *hidev);
 int hibmc_crtc_init(struct hibmc_drm_device *hidev);
 int hibmc_encoder_init(struct hibmc_drm_device *hidev);
+int hibmc_connector_init(struct hibmc_drm_device *hidev);
 int hibmc_fbdev_init(struct hibmc_drm_device *hidev);
 void hibmc_fbdev_fini(struct hibmc_drm_device *hidev);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 3cdd634..ca6448b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -88,3 +88,79 @@ int hibmc_encoder_init(struct hibmc_drm_device *hidev)
 	return 0;
 }
 
+static int hibmc_connector_get_modes(struct drm_connector *connector)
+{
+	int count;
+
+	count = drm_add_modes_noedid(connector, 800, 600);
+	drm_set_preferred_mode(connector, defx, defy);
+	return count;
+}
+
+static int hibmc_connector_mode_valid(struct drm_connector *connector,
+				      struct drm_display_mode *mode)
+{
+	struct hibmc_drm_device *hiprivate =
+	 container_of(connector, struct hibmc_drm_device, connector);
+	unsigned long size = mode->hdisplay * mode->vdisplay * 4;
+
+	if (size * 2 > hiprivate->fb_size)
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
+static struct drm_encoder *
+hibmc_connector_best_encoder(struct drm_connector *connector)
+{
+	int enc_id = connector->encoder_ids[0];
+
+	/* pick the encoder ids */
+	if (enc_id)
+		return drm_encoder_find(connector->dev, enc_id);
+
+	return NULL;
+}
+
+static enum drm_connector_status hibmc_connector_detect(struct drm_connector
+						 *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static const struct drm_connector_helper_funcs
+	hibmc_connector_connector_helper_funcs = {
+	.get_modes = hibmc_connector_get_modes,
+	.mode_valid = hibmc_connector_mode_valid,
+	.best_encoder = hibmc_connector_best_encoder,
+};
+
+static const struct drm_connector_funcs hibmc_connector_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.detect = hibmc_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+int hibmc_connector_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_connector *connector = &hidev->connector;
+	int ret;
+
+	ret = drm_connector_init(dev, connector,
+				 &hibmc_connector_connector_funcs,
+				 DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		DRM_ERROR("failed to init connector\n");
+		return ret;
+	}
+	drm_connector_helper_add(connector,
+				 &hibmc_connector_connector_helper_funcs);
+
+	return 0;
+}
+
-- 
1.9.1
