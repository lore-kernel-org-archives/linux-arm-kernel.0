From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:01:09 +0800
Subject: [PATCH v3 2/8] drm/rockchip: vop: replace dpms with enable/disable
In-Reply-To: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450321275-31154-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For vop, power by enable/disable is more suitable then legacy dpms
function, and enable/disable more closely to the new atomic API.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   37 +++------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f82c7ba..1e60ddd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -632,7 +632,7 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
-static void vop_enable(struct drm_crtc *crtc)
+static void vop_crtc_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 	int ret;
@@ -702,7 +702,7 @@ err_disable_hclk:
 	clk_disable(vop->hclk);
 }
 
-static void vop_disable(struct drm_crtc *crtc)
+static void vop_crtc_disable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
 
@@ -1107,30 +1107,6 @@ static const struct rockchip_crtc_funcs private_crtc_funcs = {
 	.disable_vblank = vop_crtc_disable_vblank,
 };
 
-static void vop_crtc_dpms(struct drm_crtc *crtc, int mode)
-{
-	DRM_DEBUG_KMS("crtc[%d] mode[%d]\n", crtc->base.id, mode);
-
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
-		vop_enable(crtc);
-		break;
-	case DRM_MODE_DPMS_STANDBY:
-	case DRM_MODE_DPMS_SUSPEND:
-	case DRM_MODE_DPMS_OFF:
-		vop_disable(crtc);
-		break;
-	default:
-		DRM_DEBUG_KMS("unspecified mode %d\n", mode);
-		break;
-	}
-}
-
-static void vop_crtc_prepare(struct drm_crtc *crtc)
-{
-	vop_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
-}
-
 static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 				const struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
@@ -1241,17 +1217,12 @@ out:
 	return ret;
 }
 
-static void vop_crtc_commit(struct drm_crtc *crtc)
-{
-}
-
 static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
-	.dpms = vop_crtc_dpms,
-	.prepare = vop_crtc_prepare,
+	.enable = vop_crtc_enable,
+	.disable = vop_crtc_disable,
 	.mode_fixup = vop_crtc_mode_fixup,
 	.mode_set = vop_crtc_mode_set,
 	.mode_set_base = vop_crtc_mode_set_base,
-	.commit = vop_crtc_commit,
 };
 
 static int vop_crtc_page_flip(struct drm_crtc *crtc,
-- 
1.7.9.5
