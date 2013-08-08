From: broonie@kernel.org (Mark Brown)
Date: Thu,  8 Aug 2013 11:20:42 +0100
Subject: [PATCH] drm/agp: Fix build for non-AGP platforms
Message-ID: <1375957242-18444-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Commit 28ec711 (drm/agp: move AGP cleanup paths to drm_agpsupport.c)
broke the build for platforms which do not have AGP since it moved the
AGP cleanup code inside an #ifdef __OS_HAS_AGP which are referenced
unconditionally in drm_drv.c.  This causes build failures for embedded
SoCs which use DRM but do not have AGP.

Fix this by providing stub static inlines in the header.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/drm/drmP.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index fba5473..e7f7da0 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1453,6 +1453,7 @@ extern int drm_modeset_ctl(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv);
 
 				/* AGP/GART support (drm_agpsupport.h) */
+#if __OS_HAS_AGP
 extern struct drm_agp_head *drm_agp_init(struct drm_device *dev);
 extern void drm_agp_destroy(struct drm_agp_head *agp);
 extern void drm_agp_clear(struct drm_device *dev);
@@ -1480,6 +1481,10 @@ extern int drm_agp_unbind_ioctl(struct drm_device *dev, void *data,
 extern int drm_agp_bind(struct drm_device *dev, struct drm_agp_binding *request);
 extern int drm_agp_bind_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file_priv);
+#else
+static inline void drm_agp_destroy(struct drm_agp_head *agp) { }
+static inline void drm_agp_clear(struct drm_device *dev) { }
+#endif
 
 				/* Stub support (drm_stub.h) */
 extern int drm_setmaster_ioctl(struct drm_device *dev, void *data,
-- 
1.8.4.rc1
