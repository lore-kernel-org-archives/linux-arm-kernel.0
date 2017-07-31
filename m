From: djmk@chromium.org (Joe Kniss)
Date: Mon, 31 Jul 2017 11:29:13 -0700
Subject: [PATCH] Add drm ioctl DRM_IOCTL_MODE_GETFB2 & associated helpers.
In-Reply-To: <CAOvnNvYKXsy9dvOB0ge1WxQbwubPpzKofd=OGagKyft-yQJ1xw@mail.gmail.com>
References: <CAOvnNvYKXsy9dvOB0ge1WxQbwubPpzKofd=OGagKyft-yQJ1xw@mail.gmail.com>
Message-ID: <20170731182913.136758-1-djmk@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New getfb2 functionality uses drm_mode_fb_cmd2 struct to be symmetric
with addfb2.   Also modifies *_fb_create_handle() calls to accept a
format_plane_index so that handles for each plane can be generated.
Previously, many *_fb_create_handle() calls simply defaulted to plane 0 only.

Signed-off-by: Joe Kniss <djmk@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  5 +-
 drivers/gpu/drm/armada/armada_fb.c          |  1 +
 drivers/gpu/drm/drm_crtc_internal.h         |  2 +
 drivers/gpu/drm/drm_fb_cma_helper.c         | 11 ++--
 drivers/gpu/drm/drm_framebuffer.c           | 79 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/drm_ioctl.c                 |  1 +
 drivers/gpu/drm/exynos/exynos_drm_fb.c      |  7 ++-
 drivers/gpu/drm/gma500/framebuffer.c        |  2 +
 drivers/gpu/drm/i915/intel_display.c        |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_fb.c       |  1 +
 drivers/gpu/drm/msm/msm_fb.c                |  5 +-
 drivers/gpu/drm/nouveau/nouveau_display.c   |  1 +
 drivers/gpu/drm/omapdrm/omap_fb.c           |  5 +-
 drivers/gpu/drm/radeon/radeon_display.c     |  5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |  6 ++-
 drivers/gpu/drm/tegra/fb.c                  |  9 +++-
 include/drm/drm_framebuffer.h               |  1 +
 include/uapi/drm/drm.h                      |  2 +
 18 files changed, 127 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 39fc388f222a..c77c1cd265a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -566,8 +566,9 @@ static void amdgpu_user_framebuffer_destroy(struct drm_framebuffer *fb)
 }
 
 static int amdgpu_user_framebuffer_create_handle(struct drm_framebuffer *fb,
-						  struct drm_file *file_priv,
-						  unsigned int *handle)
+						 unsigned int plane_index,
+						 struct drm_file *file_priv,
+						 unsigned int *handle)
 {
 	struct amdgpu_framebuffer *amdgpu_fb = to_amdgpu_framebuffer(fb);
 
diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
index 2a7eb6817c36..9f237544f6c5 100644
--- a/drivers/gpu/drm/armada/armada_fb.c
+++ b/drivers/gpu/drm/armada/armada_fb.c
@@ -23,6 +23,7 @@ static void armada_fb_destroy(struct drm_framebuffer *fb)
 }
 
 static int armada_fb_create_handle(struct drm_framebuffer *fb,
+	unsigned int format_plane_index,
 	struct drm_file *dfile, unsigned int *handle)
 {
 	struct armada_framebuffer *dfb = drm_fb_to_armada_fb(fb);
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 955c5690bf64..ec8d913240fe 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -170,6 +170,8 @@ int drm_mode_rmfb(struct drm_device *dev,
 		  void *data, struct drm_file *file_priv);
 int drm_mode_getfb(struct drm_device *dev,
 		   void *data, struct drm_file *file_priv);
+int drm_mode_getfb2(struct drm_device *dev,
+		   void *data, struct drm_file *file_priv);
 int drm_mode_dirtyfb_ioctl(struct drm_device *dev,
 			   void *data, struct drm_file *file_priv);
 
diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index 596fabf18c3e..5fd7bcc2c6d1 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -110,13 +110,16 @@ void drm_fb_cma_destroy(struct drm_framebuffer *fb)
 }
 EXPORT_SYMBOL(drm_fb_cma_destroy);
 
-int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
-	struct drm_file *file_priv, unsigned int *handle)
+static int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
+				    unsigned int format_plane_index,
+				    struct drm_file *file_priv,
+				    unsigned int *handle)
 {
 	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
-
+	if (format_plane_index >= 4 || !fb_dma->obj[format_plane_index])
+		return -ENOENT;
 	return drm_gem_handle_create(file_priv,
-			&fb_cma->obj[0]->base, handle);
+			&fb_cma->obj[format_plane_index]->base, handle);
 }
 EXPORT_SYMBOL(drm_fb_cma_create_handle);
 
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 28a0108a1ab8..67b3be1bedbc 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -24,6 +24,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_auth.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_gem.h>
 
 #include "drm_crtc_internal.h"
 
@@ -438,7 +439,7 @@ int drm_mode_getfb(struct drm_device *dev,
 	if (fb->funcs->create_handle) {
 		if (drm_is_current_master(file_priv) || capable(CAP_SYS_ADMIN) ||
 		    drm_is_control_client(file_priv)) {
-			ret = fb->funcs->create_handle(fb, file_priv,
+			ret = fb->funcs->create_handle(fb, 0, file_priv,
 						       &r->handle);
 		} else {
 			/* GET_FB() is an unprivileged ioctl so we must not
@@ -458,6 +459,82 @@ int drm_mode_getfb(struct drm_device *dev,
 	return ret;
 }
 
+/**
+ * drm_mode_getfb2 - get FB info
+ * @dev: drm device for the ioctl
+ * @data: data pointer for the ioctl
+ * @file_priv: drm file for the ioctl call
+ *
+ * Lookup the FB given its ID and return info about it.
+ *
+ * Called by the user via ioctl.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_mode_getfb2(struct drm_device *dev,
+		   void *data, struct drm_file *file_priv)
+{
+	struct drm_mode_fb_cmd2 *r = data;
+	struct drm_framebuffer *fb;
+	int ret, i;
+
+	if (!drm_core_check_feature(dev, DRIVER_MODESET))
+		return -EINVAL;
+
+	fb = drm_framebuffer_lookup(dev, r->fb_id);
+	if (!fb)
+		return -ENOENT;
+
+	r->height = fb->height;
+	r->width = fb->width;
+	r->pixel_format = fb->format->format;
+	for (i = 0; i < 4; ++i) {
+		r->pitches[i] = fb->pitches[i];
+		r->offsets[i] = fb->offsets[i];
+		r->modifier[i] = fb->modifier;
+		r->handles[i] = 0;
+	}
+
+	for (i = 0; i < fb->format->num_planes; ++i) {
+		if (fb->funcs->create_handle) {
+			if (drm_is_current_master(file_priv) ||
+			    capable(CAP_SYS_ADMIN) ||
+			    drm_is_control_client(file_priv)) {
+				ret = fb->funcs->create_handle(fb, i, file_priv,
+							       &r->handles[i]);
+				if (ret)
+					break;
+			} else {
+				/* GET_FB() is an unprivileged ioctl so we must
+				 * not return a buffer-handle to non-master
+				 * processes! For backwards-compatibility
+				 * reasons, we cannot make GET_FB() privileged,
+				 * so just return an invalid handle for
+				 * non-masters. */
+				r->handles[i] = 0;
+				ret = 0;
+			}
+		} else {
+			ret = -ENODEV;
+			break;
+		}
+	}
+
+	/* If handle creation failed, delete/dereference any that were made. */
+	if (ret) {
+		for (i = 0; i < 4; ++i) {
+			if (r->handles[i])
+				drm_gem_handle_delete(file_priv, r->handles[i]);
+			r->handles[i] = 0;
+		}
+	}
+
+	drm_framebuffer_unreference(fb);
+
+	return ret;
+}
+
 /**
  * drm_mode_dirtyfb_ioctl - flush frontbuffer rendering on an FB
  * @dev: drm device for the ioctl
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index a7c61c23685a..a9b578dc5d17 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -627,6 +627,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_SETPROPERTY, drm_mode_connector_property_set_ioctl, DRM_MASTER|DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETPROPBLOB, drm_mode_getblob_ioctl, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETFB, drm_mode_getfb, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETFB2, drm_mode_getfb2, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB, drm_mode_addfb, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb, DRM_CONTROL_ALLOW|DRM_UNLOCKED),
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index c77a5aced81a..5e8b774dc1af 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -88,13 +88,16 @@ static void exynos_drm_fb_destroy(struct drm_framebuffer *fb)
 }
 
 static int exynos_drm_fb_create_handle(struct drm_framebuffer *fb,
+				       unsigned int format_plane_index,
 					struct drm_file *file_priv,
 					unsigned int *handle)
 {
 	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
-
+	if (format_plane_index >= MAX_FB_BUFFER ||
+	    !exynos_fb->exynos_gem[format_plane_index])
+		return -ENOENT;
 	return drm_gem_handle_create(file_priv,
-				     &exynos_fb->exynos_gem[0]->base, handle);
+		     &exynos_fb->exynos_gem[format_plane_index]->base, handle);
 }
 
 static const struct drm_framebuffer_funcs exynos_drm_fb_funcs = {
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index ffe6b4ffa1a8..c221544b4c6a 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -42,6 +42,7 @@
 
 static void psb_user_framebuffer_destroy(struct drm_framebuffer *fb);
 static int psb_user_framebuffer_create_handle(struct drm_framebuffer *fb,
+					      unsigned int format_plane_index,
 					      struct drm_file *file_priv,
 					      unsigned int *handle);
 
@@ -619,6 +620,7 @@ static void psbfb_output_poll_changed(struct drm_device *dev)
  *	the work for us
  */
 static int psb_user_framebuffer_create_handle(struct drm_framebuffer *fb,
+					      unsigned int plane_index,
 					      struct drm_file *file_priv,
 					      unsigned int *handle)
 {
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 3282b0f4b134..54fdd30b0598 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -15853,6 +15853,7 @@ static void intel_user_framebuffer_destroy(struct drm_framebuffer *fb)
 }
 
 static int intel_user_framebuffer_create_handle(struct drm_framebuffer *fb,
+						unsigned int format_plane_index,
 						struct drm_file *file,
 						unsigned int *handle)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index d4246c9dceae..8343144ba1cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -44,6 +44,7 @@ struct drm_gem_object *mtk_fb_get_gem_obj(struct drm_framebuffer *fb)
 }
 
 static int mtk_drm_fb_create_handle(struct drm_framebuffer *fb,
+				    unsigned int format_plane_index,
 				    struct drm_file *file_priv,
 				    unsigned int *handle)
 {
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 5cf165c9c3a9..de92fc8a7a1c 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -30,12 +30,15 @@ struct msm_framebuffer {
 
 
 static int msm_framebuffer_create_handle(struct drm_framebuffer *fb,
+		unsigned int format_plane_index,
 		struct drm_file *file_priv,
 		unsigned int *handle)
 {
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
+	if (format_plane_index >= MAX_PLANE)
+		return -ENOENT;
 	return drm_gem_handle_create(file_priv,
-			msm_fb->planes[0], handle);
+			msm_fb->planes[format_plane_index], handle);
 }
 
 static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 72fdba1a1c5d..bc30c0d3d9cd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -237,6 +237,7 @@ nouveau_user_framebuffer_destroy(struct drm_framebuffer *drm_fb)
 
 static int
 nouveau_user_framebuffer_create_handle(struct drm_framebuffer *drm_fb,
+				       unsigned int format_plane_index,
 				       struct drm_file *file_priv,
 				       unsigned int *handle)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 29dc677dd4d3..a982c72a773e 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -90,12 +90,15 @@ struct omap_framebuffer {
 };
 
 static int omap_framebuffer_create_handle(struct drm_framebuffer *fb,
+		unsigned int format_plane_index,
 		struct drm_file *file_priv,
 		unsigned int *handle)
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
+	if (format_plane_index >= 4 || !omap_fb->planes[format_plane_index])
+		return -ENOENT;
 	return drm_gem_handle_create(file_priv,
-			omap_fb->planes[0].bo, handle);
+			omap_fb->planes[format_plane_index].bo, handle);
 }
 
 static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aea8b62835a4..2188e6341cd9 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1306,8 +1306,9 @@ static void radeon_user_framebuffer_destroy(struct drm_framebuffer *fb)
 }
 
 static int radeon_user_framebuffer_create_handle(struct drm_framebuffer *fb,
-						  struct drm_file *file_priv,
-						  unsigned int *handle)
+						 unsigned int plane_index,
+						 struct drm_file *file_priv,
+						 unsigned int *handle)
 {
 	struct radeon_framebuffer *radeon_fb = to_radeon_framebuffer(fb);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index c9ccdf8f44bb..206d93249519 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -55,13 +55,15 @@ static void rockchip_drm_fb_destroy(struct drm_framebuffer *fb)
 }
 
 static int rockchip_drm_fb_create_handle(struct drm_framebuffer *fb,
+					 unsigned int format_plane_index,
 					 struct drm_file *file_priv,
 					 unsigned int *handle)
 {
 	struct rockchip_drm_fb *rockchip_fb = to_rockchip_fb(fb);
-
+	if (format_plane_index >= ROCKCHIP_MAX_FB_BUFFER)
+		return -ENOENT;
 	return drm_gem_handle_create(file_priv,
-				     rockchip_fb->obj[0], handle);
+				  rockchip_fb->obj[format_plane_index], handle);
 }
 
 static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index f142f6a4db25..ff206b143503 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -81,11 +81,16 @@ static void tegra_fb_destroy(struct drm_framebuffer *framebuffer)
 }
 
 static int tegra_fb_create_handle(struct drm_framebuffer *framebuffer,
+				  unsigned int format_plane_index,
 				  struct drm_file *file, unsigned int *handle)
 {
 	struct tegra_fb *fb = to_tegra_fb(framebuffer);
-
-	return drm_gem_handle_create(file, &fb->planes[0]->gem, handle);
+	if (format_plane_index >= fb->num_planes ||
+	    !fb->planes[format_plane_index])
+		return -ENOENT;
+	return drm_gem_handle_create(file,
+				     &fb->planes[format_plane_index]->gem,
+				     handle);
 }
 
 static const struct drm_framebuffer_funcs tegra_fb_funcs = {
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index dd1e3e99dcff..2fb398cb4646 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -66,6 +66,7 @@ struct drm_framebuffer_funcs {
 	 * 0 on success or a negative error code on failure.
 	 */
 	int (*create_handle)(struct drm_framebuffer *fb,
+			     unsigned int plane_index,
 			     struct drm_file *file_priv,
 			     unsigned int *handle);
 	/**
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index b2c52843bc70..c81c75335cca 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -814,6 +814,8 @@ extern "C" {
 #define DRM_IOCTL_MODE_CREATEPROPBLOB	DRM_IOWR(0xBD, struct drm_mode_create_blob)
 #define DRM_IOCTL_MODE_DESTROYPROPBLOB	DRM_IOWR(0xBE, struct drm_mode_destroy_blob)
 
+#define DRM_IOCTL_MODE_GETFB2  DRM_IOWR(0xC4, struct drm_mode_fb_cmd2)
+
 /**
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
-- 
2.14.0.rc0.400.g1c36432dff-goog
