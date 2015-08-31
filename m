From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Mon, 31 Aug 2015 16:53:35 +0800
Subject: [PATCH] drm/fsl-dcu: Add multi layers support
Message-ID: <1441011215-3769-1-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For DCU support atmost 16 layers(on ls1021a) or 64 layers(on vf610),
add (total_layer - 1) overlay planes.

Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 8787920..1195568 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -236,7 +236,10 @@ static const u32 fsl_dcu_drm_plane_formats[] = {
 
 struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
 {
+	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_plane *primary;
+	struct drm_plane *overlay;
+	unsigned int total_layer, formats_size, i;
 	int ret;
 
 	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
@@ -245,11 +248,12 @@ struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
 		return NULL;
 	}
 
+	formats_size = ARRAY_SIZE(fsl_dcu_drm_plane_formats);
 	/* possible_crtc's will be filled in later by crtc_init */
 	ret = drm_universal_plane_init(dev, primary, 0,
 				       &fsl_dcu_drm_plane_funcs,
 				       fsl_dcu_drm_plane_formats,
-				       ARRAY_SIZE(fsl_dcu_drm_plane_formats),
+				       formats_size,
 				       DRM_PLANE_TYPE_PRIMARY);
 	if (ret) {
 		kfree(primary);
@@ -257,5 +261,26 @@ struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
 	}
 	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);
 
+	total_layer = fsl_dev->soc->total_layer;
+	for (i = 0; i < total_layer - 1; i++) {
+		overlay = kzalloc(sizeof(*overlay), GFP_KERNEL);
+		if (!overlay) {
+			DRM_DEBUG_KMS("Failed to allocate overlay plane\n");
+			goto out;
+		}
+
+		ret = drm_universal_plane_init(dev, overlay, 1,
+					       &fsl_dcu_drm_plane_funcs,
+					       fsl_dcu_drm_plane_formats,
+					       formats_size,
+					       DRM_PLANE_TYPE_OVERLAY);
+		if (ret) {
+			kfree(overlay);
+			goto out;
+		}
+		drm_plane_helper_add(overlay, &fsl_dcu_drm_plane_helper_funcs);
+	}
+
+out:
 	return primary;
 }
-- 
2.1.0.27.g96db324
