From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:43 +0200
Subject: [PATCH RFC v2 09/12] drm/rockchip: enable rgb output of vops for all
 other connectors
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-10-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The socs itself contains encoders for a lot of different outputs. But every
unsupported connector will be routed through the lvds, as it controls the
pins in question.
Therefore enable the lvds output for all of those.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c0387f7..3844b12 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -862,20 +862,16 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	clk_disable(vop->dclk);
 
 	switch (vop->connector_type) {
-	case DRM_MODE_CONNECTOR_LVDS:
-		VOP_CTRL_SET(vop, rgb_en, 1);
-		break;
 	case DRM_MODE_CONNECTOR_eDP:
 		VOP_CTRL_SET(vop, edp_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_HDMIA:
 		VOP_CTRL_SET(vop, hdmi_en, 1);
 		break;
+	case DRM_MODE_CONNECTOR_LVDS:
 	default:
-		DRM_ERROR("unsupport connector_type[%d]\n",
-			  vop->connector_type);
-		ret = -EINVAL;
-		goto out;
+		VOP_CTRL_SET(vop, rgb_en, 1);
+		break;
 	};
 	VOP_CTRL_SET(vop, out_mode, vop->connector_out_mode);
 
-- 
2.1.4
