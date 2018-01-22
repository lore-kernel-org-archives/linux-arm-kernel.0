From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:33 +0100
Subject: [PATCH v2 04/19] drm/rockchip: Use the alpha format field in
 drm_format_info
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <5a217e8c93eea6f0a7f6bc5883424b47dbb6c664.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drm_format_info has a alpha field to tell if a format embeds
an alpha component in it, let's use it.

Acked-by: Sandy huang <hjc@rock-chips.com>
Reviewed-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 19128b4dea54..db6a0662be5a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -253,17 +253,6 @@ static bool is_yuv_support(uint32_t format)
 	}
 }
 
-static bool is_alpha_support(uint32_t format)
-{
-	switch (format) {
-	case DRM_FORMAT_ARGB8888:
-	case DRM_FORMAT_ABGR8888:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 				  uint32_t dst, bool is_horizontal,
 				  int vsu_mode, int *vskiplines)
@@ -790,7 +779,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	rb_swap = has_rb_swapped(fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
-	if (is_alpha_support(fb->format->format)) {
+	if (fb->format->has_alpha) {
 		VOP_WIN_SET(vop, win, dst_alpha_ctl,
 			    DST_FACTOR_M0(ALPHA_SRC_INVERSE));
 		val = SRC_ALPHA_EN(1) | SRC_COLOR_M0(ALPHA_SRC_PRE_MUL) |
-- 
git-series 0.9.1
