From: zyw@rock-chips.com (Chris Zhong)
Date: Sun,  5 Feb 2017 15:55:02 +0800
Subject: [PATCH v17 7/7] drm/rockchip: cdn-dp: don't configure hardware in
 mode_set
In-Reply-To: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
References: <1486281302-28200-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1486281302-28200-8-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With atomic modesetting the hardware will be powered off when the
mode_set function is called.  We should configure the hardware in the
enable function.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v17: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 49 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a630b0d..9ab67a6 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -568,9 +568,7 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
 	struct drm_display_info *display_info = &dp->connector.display_info;
-	struct rockchip_crtc_state *state;
 	struct video_info *video = &dp->video_info;
-	int ret, val;
 
 	switch (display_info->bpc) {
 	case 10:
@@ -585,31 +583,9 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 	}
 
 	video->color_fmt = PXL_RGB;
-
 	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
 	video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
-	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
-		return;
-	}
-
-	DRM_DEV_DEBUG_KMS(dp->dev, "vop %s output to cdn-dp\n",
-			  (ret) ? "LIT" : "BIG");
-	state = to_rockchip_crtc_state(encoder->crtc->state);
-	if (ret) {
-		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
-		state->output_mode = ROCKCHIP_OUT_MODE_P888;
-	} else {
-		val = DP_SEL_VOP_LIT << 16;
-		state->output_mode = ROCKCHIP_OUT_MODE_AAAA;
-	}
-
-	ret = cdn_dp_grf_write(dp, GRF_SOC_CON9, val);
-	if (ret)
-		return;
-
 	memcpy(&dp->mode, adjusted, sizeof(*mode));
 }
 
@@ -635,9 +611,32 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
-	int ret;
+	int ret, val;
+	struct rockchip_crtc_state *state;
+
+	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
+		return;
+	}
+
+	DRM_DEV_DEBUG_KMS(dp->dev, "vop %s output to cdn-dp\n",
+			  (ret) ? "LIT" : "BIG");
+	state = to_rockchip_crtc_state(encoder->crtc->state);
+	if (ret) {
+		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
+		state->output_mode = ROCKCHIP_OUT_MODE_P888;
+	} else {
+		val = DP_SEL_VOP_LIT << 16;
+		state->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	}
+
+	ret = cdn_dp_grf_write(dp, GRF_SOC_CON9, val);
+	if (ret)
+		return;
 
 	mutex_lock(&dp->lock);
+
 	ret = cdn_dp_enable(dp);
 	if (ret) {
 		DRM_DEV_ERROR(dp->dev, "Failed to enable encoder %d\n",
-- 
2.6.3
