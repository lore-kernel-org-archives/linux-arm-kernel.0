From: mark.yao@rock-chips.com (Mark Yao)
Date: Sun,  5 Feb 2017 15:36:37 +0800
Subject: [PATCH 2/2] drm/rockchip: dw_hdmi: check display mode with crtc mode
 valid
In-Reply-To: <1486280197-1585-1-git-send-email-mark.yao@rock-chips.com>
References: <1486280197-1585-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1486280197-1585-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 47 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index a6d4a02..64408bc 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -158,18 +158,59 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 			    struct drm_display_mode *mode)
 {
 	const struct dw_hdmi_mpll_config *mpll_cfg = rockchip_mpll_cfg;
+	struct drm_device *dev = connector->dev;
+	struct drm_encoder *encoder = connector->encoder;
+	struct rockchip_drm_private *priv = dev->dev_private;
 	int pclk = mode->clock * 1000;
-	bool valid = false;
+	enum drm_mode_status status = MODE_BAD;
+	struct drm_crtc *crtc;
 	int i;
 
 	for (i = 0; mpll_cfg[i].mpixelclock != (~0UL); i++) {
 		if (pclk == mpll_cfg[i].mpixelclock) {
-			valid = true;
+			status = MODE_OK;
 			break;
 		}
 	}
 
-	return (valid) ? MODE_OK : MODE_BAD;
+
+	if (status != MODE_OK)
+		return status;
+
+	if (!encoder) {
+		const struct drm_connector_helper_funcs *funcs;
+
+		funcs = connector->helper_private;
+		if (funcs->atomic_best_encoder)
+			encoder = funcs->atomic_best_encoder(connector,
+							     connector->state);
+		else
+			encoder = funcs->best_encoder(connector);
+	}
+
+	if (!encoder || !encoder->possible_crtcs)
+		return MODE_BAD;
+	/*
+	 * ensure all drm display mode can work, if someone want support more
+	 * resolutions, please limit the possible_crtc, only connect to
+	 * needed crtc.
+	 */
+	drm_for_each_crtc(crtc, connector->dev) {
+		int pipe = drm_crtc_index(crtc);
+		const struct rockchip_crtc_funcs *funcs =
+						priv->crtc_funcs[pipe];
+
+		if (!(encoder->possible_crtcs & drm_crtc_mask(crtc)))
+			continue;
+		if (!funcs || !funcs->mode_valid)
+			continue;
+
+		status = funcs->mode_valid(crtc, mode);
+		if (status != MODE_OK)
+			return status;
+	}
+
+	return status;
 }
 
 static const struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
-- 
1.9.1
