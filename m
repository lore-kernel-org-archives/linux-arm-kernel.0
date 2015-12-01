From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 11:37:13 +0800
Subject: [RFC PATCH 9/9] drm/rockchip: dw_hdmi: use encoder enable function
In-Reply-To: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1448941034-23645-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

encoder.enable is more compatible to atomic api than encoder.prepare/commit

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 80d6fc8..cfe052c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -195,12 +195,15 @@ static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
 {
 }
 
-static void dw_hdmi_rockchip_encoder_commit(struct drm_encoder *encoder)
+static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
 	u32 val;
 	int mux;
 
+	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
+				      ROCKCHIP_OUT_MODE_AAAA);
+
 	mux = rockchip_drm_encoder_get_mux_id(hdmi->dev->of_node, encoder);
 	if (mux)
 		val = HDMI_SEL_VOP_LIT | (HDMI_SEL_VOP_LIT << 16);
@@ -212,17 +215,10 @@ static void dw_hdmi_rockchip_encoder_commit(struct drm_encoder *encoder)
 		(mux) ? "LIT" : "BIG");
 }
 
-static void dw_hdmi_rockchip_encoder_prepare(struct drm_encoder *encoder)
-{
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_AAAA);
-}
-
 static struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
 	.mode_fixup = dw_hdmi_rockchip_encoder_mode_fixup,
 	.mode_set   = dw_hdmi_rockchip_encoder_mode_set,
-	.prepare    = dw_hdmi_rockchip_encoder_prepare,
-	.commit     = dw_hdmi_rockchip_encoder_commit,
+	.enable     = dw_hdmi_rockchip_encoder_enable,
 	.disable    = dw_hdmi_rockchip_encoder_disable,
 };
 
-- 
1.7.9.5
