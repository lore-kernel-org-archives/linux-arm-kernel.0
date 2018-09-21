From: c.manszewski@samsung.com (Christoph Manszewski)
Date: Fri, 21 Sep 2018 14:24:38 +0200
Subject: [PATCH 3/3] drm/exynos: mixer: Make plane alpha configurable
In-Reply-To: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
References: <1537532678-4276-1-git-send-email-c.manszewski@samsung.com>
 <CGME20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401@eucas1p2.samsung.com>
Message-ID: <20180921122619eucas1p24ab7008bf55e7dbe3eb01e5ad85fc401~Waeq06DpV1393813938eucas1p2k@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mixer hardware supports variable plane alpha. Currently planes are
opaque, make this configurable.

Tested on Odroid-U3 with Exynos 4412 CPU, kernel next-20180913
using modetest.

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c |  3 +++
 drivers/gpu/drm/exynos/exynos_mixer.c     | 37 ++++++++++++++++++-------------
 drivers/gpu/drm/exynos/regs-mixer.h       |  5 ++++-
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 1cb26d8c66f9..ec1d5bcac61a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -93,6 +93,7 @@ struct exynos_drm_plane {
 #define EXYNOS_DRM_PLANE_CAP_ZPOS	(1 << 2)
 #define EXYNOS_DRM_PLANE_CAP_TILE	(1 << 3)
 #define EXYNOS_DRM_PLANE_CAP_PIX_BLEND	(1 << 4)
+#define EXYNOS_DRM_PLANE_CAP_WIN_BLEND	(1 << 5)
 
 /*
  * Exynos DRM plane configuration structure.
diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index 236408906f1f..df0508e0e49e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -325,5 +325,8 @@ int exynos_plane_init(struct drm_device *dev,
 	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_PIX_BLEND)
 		drm_plane_create_blend_mode_property(plane, supported_modes);
 
+	if (config->capabilities & EXYNOS_DRM_PLANE_CAP_WIN_BLEND)
+		drm_plane_create_alpha_property(plane);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 721b63e92b28..e3a4ecbc503b 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -132,7 +132,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	}, {
 		.zpos = 1,
 		.type = DRM_PLANE_TYPE_CURSOR,
@@ -140,7 +141,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(mixer_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_DOUBLE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_PIX_BLEND,
+				EXYNOS_DRM_PLANE_CAP_PIX_BLEND |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	}, {
 		.zpos = 2,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -148,7 +150,8 @@ static const struct exynos_drm_plane_config plane_configs[MIXER_WIN_NR] = {
 		.num_pixel_formats = ARRAY_SIZE(vp_formats),
 		.capabilities = EXYNOS_DRM_PLANE_CAP_SCALE |
 				EXYNOS_DRM_PLANE_CAP_ZPOS |
-				EXYNOS_DRM_PLANE_CAP_TILE,
+				EXYNOS_DRM_PLANE_CAP_TILE |
+				EXYNOS_DRM_PLANE_CAP_WIN_BLEND,
 	},
 };
 
@@ -311,8 +314,9 @@ static void vp_default_filter(struct mixer_context *ctx)
 }
 
 static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
-				unsigned int pixel_alpha)
+				unsigned int pixel_alpha, unsigned int alpha)
 {
+	u32 win_alpha = alpha >> 8;
 	u32 val;
 
 	val  = MXR_GRP_CFG_COLOR_KEY_DISABLE; /* no blank key */
@@ -328,21 +332,24 @@ static void mixer_cfg_gfx_blend(struct mixer_context *ctx, unsigned int win,
 		val |= MXR_GRP_CFG_PIXEL_BLEND_EN;
 		break;
 	}
+
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val |= MXR_GRP_CFG_WIN_BLEND_EN;
+		val |= win_alpha;
+	}
 	mixer_reg_writemask(ctx, MXR_GRAPHIC_CFG(win),
 			    val, MXR_GRP_CFG_MISC_MASK);
 }
 
-static void mixer_cfg_vp_blend(struct mixer_context *ctx)
+static void mixer_cfg_vp_blend(struct mixer_context *ctx, unsigned int alpha)
 {
-	u32 val;
+	u32 win_alpha = alpha >> 8;
+	u32 val = 0;
 
-	/*
-	 * No blending at the moment since the NV12/NV21 pixelformats don't
-	 * have an alpha channel. However the mixer supports a global alpha
-	 * value for a layer. Once this functionality is exposed, we can
-	 * support blending of the video layer through this.
-	 */
-	val = 0;
+	if (alpha != DRM_BLEND_ALPHA_OPAQUE) {
+		val |= MXR_VID_CFG_BLEND_EN;
+		val |= win_alpha;
+	}
 	mixer_reg_write(ctx, MXR_VIDEO_CFG, val);
 }
 
@@ -538,7 +545,7 @@ static void vp_video_buffer(struct mixer_context *ctx,
 	vp_reg_write(ctx, VP_BOT_C_PTR, chroma_addr[1]);
 
 	mixer_cfg_layer(ctx, plane->index, priority, true);
-	mixer_cfg_vp_blend(ctx);
+	mixer_cfg_vp_blend(ctx, state->base.alpha);
 
 	spin_unlock_irqrestore(&ctx->reg_slock, flags);
 
@@ -631,7 +638,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
 
 	mixer_cfg_layer(ctx, win, priority, true);
-	mixer_cfg_gfx_blend(ctx, win, pixel_alpha);
+	mixer_cfg_gfx_blend(ctx, win, pixel_alpha, state->base.alpha);
 
 	/* layer update mandatory for mixer 16.0.33.0 */
 	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
diff --git a/drivers/gpu/drm/exynos/regs-mixer.h b/drivers/gpu/drm/exynos/regs-mixer.h
index 189cfa2470a8..d2b8194a07bf 100644
--- a/drivers/gpu/drm/exynos/regs-mixer.h
+++ b/drivers/gpu/drm/exynos/regs-mixer.h
@@ -109,12 +109,15 @@
 #define MXR_CFG_SCAN_HD			(1 << 0)
 #define MXR_CFG_SCAN_MASK		0x47
 
+/* bits for MXR_VIDEO_CFG */
+#define MXR_VID_CFG_BLEND_EN		(1 << 16)
+
 /* bits for MXR_GRAPHICn_CFG */
 #define MXR_GRP_CFG_COLOR_KEY_DISABLE	(1 << 21)
 #define MXR_GRP_CFG_BLEND_PRE_MUL	(1 << 20)
 #define MXR_GRP_CFG_WIN_BLEND_EN	(1 << 17)
 #define MXR_GRP_CFG_PIXEL_BLEND_EN	(1 << 16)
-#define MXR_GRP_CFG_MISC_MASK		((3 << 16) | (3 << 20))
+#define MXR_GRP_CFG_MISC_MASK		((3 << 16) | (3 << 20) | 0xff)
 #define MXR_GRP_CFG_FORMAT_VAL(x)	MXR_MASK_VAL(x, 11, 8)
 #define MXR_GRP_CFG_FORMAT_MASK		MXR_GRP_CFG_FORMAT_VAL(~0)
 #define MXR_GRP_CFG_ALPHA_VAL(x)	MXR_MASK_VAL(x, 7, 0)
-- 
2.7.4
