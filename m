From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Feb 2017 10:41:25 +0800
Subject: [PATCH 2/2] drm/rockchip: vop: verify pixelclock for hdmi and
 displayport
In-Reply-To: <1487644885-22492-1-git-send-email-mark.yao@rock-chips.com>
References: <1487644885-22492-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1487644885-22492-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hdmi or DisplayPort request a accurate clock,
reject the display mode if clock is not good.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7ec5d7f..a7c118e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -868,14 +868,24 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 {
 	struct vop *vop = to_vop(crtc);
 	const struct vop_data *vop_data = vop->data;
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
+	int clock;
 
 	if (mode->hdisplay > vop_data->max_output.width)
 		return false;
 	if (mode->vdisplay > vop_data->max_output.height)
 		return false;
 
-	adjusted_mode->clock =
-		clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
+	clock = clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
+	/*
+	 * Hdmi or DisplayPort request a Accurate clock.
+	 */
+	if (s->output_type == DRM_MODE_CONNECTOR_HDMIA ||
+	    s->output_type == DRM_MODE_CONNECTOR_DisplayPort)
+		if (clock != mode->clock)
+			return false;
+
+	adjusted_mode->clock = clock;
 
 	return true;
 }
-- 
1.9.1
