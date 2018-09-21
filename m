From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Fri, 21 Sep 2018 14:24:37 +0200
Subject: [PATCH 2/3] drm/exynos: mixer: Make pixel blend mode configurable
In-Reply-To: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
References: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
 <CGME20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540@eucas1p1.samsung.com>
Message-ID: <20180921122617eucas1p1c167a8ea2aeca02fb3927aa3660ff540~WaeojFnZu1309513095eucas1p1G@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mixer hardware supports both premultiplied alpha and
non-premultiplied alpha. Currently premultiplied alpha is default, make
this configurable.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20180913
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c |  7 +++++++
 drivers/gpu/drm/exynos/exynos_mixer.c     | 27 +++++++++++++++++++++------
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index c737c4bd2c19..1cb26d8c66f9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -92,6 +92,7 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_SCALE	(1 << 1)
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
 #define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
+#define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
 
 /*
  * Exynos DRM plane configuration structure.
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 755ca0e9ead2..236408906f1f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -298,6 +298,10 @@ int exynos_plane_init(struct drm_device *dev,
 		      const struct exynos_drm_plane_config *config)
 {
 	int err;
+	unsigned int supported_modes = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+				       BIT(DRM_MODE_BLEND_PREMULTI) |
+				       BIT(DRM_MODE_BLEND_COVERAGE);
+	struct drm_plane *plane = &exynos_plane->base;
 
 	err = drm_universal_plane_init(dev, &exynos_plane->base,
 				       1 << dev->mode_config.num_crtc,
@@ -318,5 +322,8 @@ int exynos_plane_init(struct drm_device *dev,
 	exynos_plane_attach_zpos_property(&exynos_plane->base, config->zpos,
 			   !(config->capabilities & EXYNOS_DRM_PLANE_CAP_ZPOS));
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_PIX_BLEND)
+		drm_plane_create_blend_mode_property(plane, supported_modes);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index ffbf4a950f69..721b63e92b28 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -131,14 +131,16 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.pixel_formats = mixer_formats,
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
-				EXYNOS_DRM_PLANE_CAP_ZPOS,
+				EXYNOS_DRM_PLANE_CAP_ZPOS |
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 	}, {
 		.zpos = 1,
 		.type = DRM_PLANE_TYPE_CURSOR,
 		.pixel_formats = mixer_formats,
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
-				EXYNOS_DRM_PLANE_CAP_ZPOS,
+				EXYNOS_DRM_PLANE_CAP_ZPOS |
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
 	}, {
 		.zpos = 2,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -309,15 +311,22 @@ static void vp_default_filter(struct mixer_context *ctx)
 }
 
 static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
-				bool alpha)
+				unsigned int pixel_alpha)
 {
 	u32 val;
 
 	val  = MXR_GRP_CFG_COLOR_KEY_DISABLE; /* no blank key */
-	if (alpha) {
-		/* blending based on pixel alpha */
+	switch (pixel_alpha) {
+	case DRM_MODE_BLEND_PIXEL_NONE:
+		break;
+	case DRM_MODE_BLEND_COVERAGE:
+		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
+		break;
+	case DRM_MODE_BLEND_PREMULTI:
+	default:
 		val |= MXR_GRP_CFG_BLEND_PRE_MUL;
 		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
+		break;
 	}
 	mixer_reg_writemask(ctx, MXR_GRAPHIC_CFG(win),
 			    val, MXR_GRP_CFG_MISC_MASK);
@@ -553,10 +562,16 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	unsigned int win = plane->index;
 	unsigned int x_ratio = 0, y_ratio = 0;
 	unsigned int dst_x_offset, dst_y_offset;
+	unsigned int pixel_alpha;
 	dma_addr_t dma_addr;
 	unsigned int fmt;
 	u32 val;
 
+	if (fb->format->has_alpha)
+		pixel_alpha = state->base.pixel_blend_mode;
+	else
+		pixel_alpha = DRM_MODE_BLEND_PIXEL_NONE;
+
 	switch (fb->format->format) {
 	case DRM_FORMAT_XRGB4444:
 	case DRM_FORMAT_ARGB4444:
@@ -616,7 +631,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
 
 	mixer_cfg_layer(ctx, win, priority, true);
-	mixer_cfg_gfx_blend(ctx, win, fb->format->has_alpha);
+	mixer_cfg_gfx_blend(ctx, win, pixel_alpha);
 
 	/* layer update mandatory for mixer 16.0.33.0 */
 	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
-- 
2.7.4
