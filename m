From: mark.yao@rock-chips.com (Mark Yao)
Date: Sat, 27 May 2017 19:43:36 +0800
Subject: [PATCH] drm/rockchip: Correct vop out_mode configure
Message-ID: <1495885416-22216-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Force vop output mode on encoder driver seem not a good idea,

EDP, HDMI, DisplayPort all have 10bit input on rk3399,
On non-10bit vop, vop 8bit output bit[0-7] connect to the
encoder high 8bit [2-9].

So force RGB10 to RGB888 on vop driver would be better.

And another problem, EDP check crtc id on atomic_check,
but encoder maybe NULL, so out_mode configure would fail,
it cause edp no display.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 12 ------------
 drivers/gpu/drm/rockchip/cdn-dp-core.c          |  9 ++-------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  8 ++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     |  3 +++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c     |  2 ++
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 1bccd82..9606121 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -237,8 +237,6 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_connector_state *conn_state)
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
-	struct rockchip_dp_device *dp = to_dp(encoder);
-	int ret;
 
 	/*
 	 * The hardware IC designed that VOP must output the RGB10 video
@@ -250,16 +248,6 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 
 	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 	s->output_type = DRM_MODE_CONNECTOR_eDP;
-	if (dp->data->chip_type == RK3399_EDP) {
-		/*
-		 * For RK3399, VOP Lit must code the out mode to RGB888,
-		 * VOP Big must code the out mode to RGB10.
-		 */
-		ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node,
-							encoder);
-		if (ret > 0)
-			s->output_mode = ROCKCHIP_OUT_MODE_P888;
-	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a2169dd..14fa1f8 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -615,7 +615,6 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
 	int ret, val;
-	struct rockchip_crtc_state *state;
 
 	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
 	if (ret < 0) {
@@ -625,14 +624,10 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEV_DEBUG_KMS(dp->dev, "vop %s output to cdn-dp\n",
 			  (ret) ? "LIT" : "BIG");
-	state = to_rockchip_crtc_state(encoder->crtc->state);
-	if (ret) {
+	if (ret)
 		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
-		state->output_mode = ROCKCHIP_OUT_MODE_P888;
-	} else {
+	else
 		val = DP_SEL_VOP_LIT << 16;
-		state->output_mode = ROCKCHIP_OUT_MODE_AAAA;
-	}
 
 	ret = cdn_dp_grf_write(dp, GRF_SOC_CON9, val);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 40a5e6e..c83f481 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -874,6 +874,7 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 static void vop_crtc_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	const struct vop_data *vop_data = vop->data;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	u16 hsync_len = adjusted_mode->hsync_end - adjusted_mode->hsync_start;
@@ -966,6 +967,13 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		DRM_DEV_ERROR(vop->dev, "unsupported connector_type [%d]\n",
 			      s->output_type);
 	}
+
+	/*
+	 * if vop is not support RGB10 output, need force RGB10 to RGB888.
+	 */
+	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
+	    !(vop_data->feature & VOP_FEATURE_OUTPUT_RGB10))
+		s->output_mode = ROCKCHIP_OUT_MODE_P888;
 	VOP_CTRL_SET(vop, out_mode, s->output_mode);
 
 	VOP_CTRL_SET(vop, htotal_pw, (htotal << 16) | hsync_len);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 5a4faa85..9979fd0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -142,6 +142,9 @@ struct vop_data {
 	const struct vop_intr *intr;
 	const struct vop_win_data *win;
 	unsigned int win_size;
+
+#define VOP_FEATURE_OUTPUT_RGB10	BIT(0)
+	u64 feature;
 };
 
 /* interrupt define */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 0da4444..bafd698 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -275,6 +275,7 @@ static const struct vop_intr rk3288_vop_intr = {
 static const struct vop_data rk3288_vop = {
 	.init_table = rk3288_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3288_init_reg_table),
+	.feature = VOP_FEATURE_OUTPUT_RGB10,
 	.intr = &rk3288_vop_intr,
 	.ctrl = &rk3288_ctrl_data,
 	.win = rk3288_vop_win_data,
@@ -343,6 +344,7 @@ static const struct vop_reg_data rk3399_init_reg_table[] = {
 static const struct vop_data rk3399_vop_big = {
 	.init_table = rk3399_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
+	.feature = VOP_FEATURE_OUTPUT_RGB10,
 	.intr = &rk3399_vop_intr,
 	.ctrl = &rk3399_ctrl_data,
 	/*
-- 
2.7.4
