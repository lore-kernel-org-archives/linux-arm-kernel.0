From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:23 +0100
Subject: [PATCH 04/19] drm/rockchip: Use the alpha format helper
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <a8b8fe38a8659744fae6fe75fbb4ab2ce42a37e6.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core has a drm format helper to tell if a format embeds an
alpha component in it, let's use it.

Cc: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 19128b4dea54..cfc4d4909185 100644
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
+	if (drm_format_has_alpha(fb->format->format)) {
 		VOP_WIN_SET(vop, win, dst_alpha_ctl,
 			    DST_FACTOR_M0(ALPHA_SRC_INVERSE));
 		val = SRC_ALPHA_EN(1) | SRC_COLOR_M0(ALPHA_SRC_PRE_MUL) |
-- 
git-series 0.9.1
