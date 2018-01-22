From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:32 +0100
Subject: [PATCH v2 03/19] drm/atmel-exynos: Use the alpha format field in
 drm_format_info
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <cb1bdfbb481419a17cc4f6c8a1f07930136ac13f.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drm_format_info has a alpha field to tell if a format embeds
an alpha component in it, let's use it.

Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Acked-by: Inki Dae <inki.dae@samsung.com>
Reviewed-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index dc5d79465f9b..257299ec95c4 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -179,18 +179,6 @@ static const u8 filter_cr_horiz_tap4[] = {
 	70,	59,	48,	37,	27,	19,	11,	5,
 };
 
-static inline bool is_alpha_format(unsigned int pixel_format)
-{
-	switch (pixel_format) {
-	case DRM_FORMAT_ARGB8888:
-	case DRM_FORMAT_ARGB1555:
-	case DRM_FORMAT_ARGB4444:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static inline u32 vp_reg_read(struct mixer_context *ctx, u32 reg_id)
 {
 	return readl(ctx->vp_regs + reg_id);
@@ -625,7 +613,7 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_reg_write(ctx, MXR_GRAPHIC_BASE(win), dma_addr);
 
 	mixer_cfg_layer(ctx, win, priority, true);
-	mixer_cfg_gfx_blend(ctx, win, is_alpha_format(fb->format->format));
+	mixer_cfg_gfx_blend(ctx, win, fb->format->has_alpha);
 
 	/* layer update mandatory for mixer 16.0.33.0 */
 	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
-- 
git-series 0.9.1
