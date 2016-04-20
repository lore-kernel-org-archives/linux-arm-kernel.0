From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 10:41:42 +0800
Subject: [PATCH v3] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
In-Reply-To: <1461119505-27076-1-git-send-email-mark.yao@rock-chips.com>
References: <1461119505-27076-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461120102-32054-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to take care of the vop status when use
rockchip_drm_crtc_mode_config, if vop is disabled,
the function would failed, that is terrible.

Save output_type and output_mode into rockchip_crtc_state,
it's nice to make them into atomic.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3:
- foget remove rockchip_drm_crtc_mode_config function in v2, remove it in v3.
 
Changes in v2:
Advised by John Keeping
- use atomic crtc state to transmit output_type and output_mode
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |   48 ++++++++-------
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c          |   38 +++++++-----
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |   17 ++++-
 drivers/gpu/drm/rockchip/inno_hdmi.c            |   17 ++++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |   10 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |   75 +++++++++++++----------
 6 files changed, 128 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index a1d94d8..50e558d 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -114,27 +114,6 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder)
 	int ret;
 	u32 val;
 
-	/*
-	 * FIXME(Yakir): driver should configure the CRTC output video
-	 * mode with the display information which indicated the monitor
-	 * support colorimetry.
-	 *
-	 * But don't know why the CRTC driver seems could only output the
-	 * RGBaaa rightly. For example, if connect the "innolux,n116bge"
-	 * eDP screen, EDID would indicated that screen only accepted the
-	 * 6bpc mode. But if I configure CRTC to RGB666 output, then eDP
-	 * screen would show a blue picture (RGB888 show a green picture).
-	 * But if I configure CTRC to RGBaaa, and eDP driver still keep
-	 * RGB666 input video mode, then screen would works prefect.
-	 */
-	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
-					    DRM_MODE_CONNECTOR_eDP,
-					    ROCKCHIP_OUT_MODE_AAAA);
-	if (ret < 0) {
-		dev_err(dp->dev, "Could not set crtc mode config (%d)\n", ret);
-		return;
-	}
-
 	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
 	if (ret < 0)
 		return;
@@ -158,11 +137,38 @@ static void rockchip_dp_drm_encoder_nop(struct drm_encoder *encoder)
 	/* do nothing */
 }
 
+static int
+rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	/*
+	 * FIXME(Yakir): driver should configure the CRTC output video
+	 * mode with the display information which indicated the monitor
+	 * support colorimetry.
+	 *
+	 * But don't know why the CRTC driver seems could only output the
+	 * RGBaaa rightly. For example, if connect the "innolux,n116bge"
+	 * eDP screen, EDID would indicated that screen only accepted the
+	 * 6bpc mode. But if I configure CRTC to RGB666 output, then eDP
+	 * screen would show a blue picture (RGB888 show a green picture).
+	 * But if I configure CTRC to RGBaaa, and eDP driver still keep
+	 * RGB666 input video mode, then screen would works prefect.
+	 */
+	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
 static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
 	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
 	.mode_set = rockchip_dp_drm_encoder_mode_set,
 	.enable = rockchip_dp_drm_encoder_enable,
 	.disable = rockchip_dp_drm_encoder_nop,
+	.atomic_check = rockchip_dp_drm_encoder_atomic_check,
 };
 
 static void rockchip_dp_drm_encoder_destroy(struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 7975158..dedc65b 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -879,7 +879,6 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
-	u32 interface_pix_fmt;
 	u32 val;
 
 	if (clk_prepare_enable(dsi->pclk)) {
@@ -895,31 +894,41 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 
 	clk_disable_unprepare(dsi->pclk);
 
+	if (mux)
+		val = DSI0_SEL_VOP_LIT | (DSI0_SEL_VOP_LIT << 16);
+	else
+		val = DSI0_SEL_VOP_LIT << 16;
+
+	regmap_write(dsi->grf_regmap, GRF_SOC_CON6, val);
+	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
+}
+
+static int
+dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
+
 	switch (dsi->format) {
 	case MIPI_DSI_FMT_RGB888:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P888;
+		s->output_mode = ROCKCHIP_OUT_MODE_P888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P666;
+		s->output_mode = ROCKCHIP_OUT_MODE_P666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P565;
+		s->output_mode = ROCKCHIP_OUT_MODE_P565;
 		break;
 	default:
 		WARN_ON(1);
-		return;
+		return -EINVAL;
 	}
 
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_DSI,
-				      interface_pix_fmt);
+	s->output_type = DRM_MODE_CONNECTOR_DSI;
 
-	if (mux)
-		val = DSI0_SEL_VOP_LIT | (DSI0_SEL_VOP_LIT << 16);
-	else
-		val = DSI0_SEL_VOP_LIT << 16;
-
-	regmap_write(dsi->grf_regmap, GRF_SOC_CON6, val);
-	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
+	return 0;
 }
 
 static struct drm_encoder_helper_funcs
@@ -927,6 +936,7 @@ dw_mipi_dsi_encoder_helper_funcs = {
 	.commit = dw_mipi_dsi_encoder_commit,
 	.mode_set = dw_mipi_dsi_encoder_mode_set,
 	.disable = dw_mipi_dsi_encoder_disable,
+	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
 };
 
 static struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d5cfef7..801110f 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -201,9 +201,6 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	u32 val;
 	int mux;
 
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_AAAA);
-
 	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
 	if (mux)
 		val = HDMI_SEL_VOP_LIT | (HDMI_SEL_VOP_LIT << 16);
@@ -215,11 +212,25 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 		(mux) ? "LIT" : "BIG");
 }
 
+static int
+dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
 static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
 	.mode_fixup = dw_hdmi_rockchip_encoder_mode_fixup,
 	.mode_set   = dw_hdmi_rockchip_encoder_mode_set,
 	.enable     = dw_hdmi_rockchip_encoder_enable,
 	.disable    = dw_hdmi_rockchip_encoder_disable,
+	.atomic_check = dw_hdmi_rockchip_encoder_atomic_check,
 };
 
 static const struct dw_hdmi_plat_data rockchip_hdmi_drv_data = {
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 10d62ff..6aca6b2 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -500,9 +500,6 @@ static void inno_hdmi_encoder_enable(struct drm_encoder *encoder)
 {
 	struct inno_hdmi *hdmi = to_inno_hdmi(encoder);
 
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_P888);
-
 	inno_hdmi_set_pwr_mode(hdmi, NORMAL);
 }
 
@@ -520,11 +517,25 @@ static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
 	return true;
 }
 
+static int
+inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+			       struct drm_crtc_state *crtc_state,
+			       struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_P888;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.enable     = inno_hdmi_encoder_enable,
 	.disable    = inno_hdmi_encoder_disable,
 	.mode_fixup = inno_hdmi_encoder_mode_fixup,
 	.mode_set   = inno_hdmi_encoder_mode_set,
+	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
 
 static struct drm_encoder_funcs inno_hdmi_encoder_funcs = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 00d17d7..56f43a3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -50,6 +50,14 @@ struct rockchip_atomic_commit {
 	struct mutex lock;
 };
 
+struct rockchip_crtc_state {
+	struct drm_crtc_state base;
+	int output_type;
+	int output_mode;
+};
+#define to_rockchip_crtc_state(s) \
+		container_of(s, struct rockchip_crtc_state, base)
+
 /*
  * Rockchip drm private structure.
  *
@@ -68,8 +76,6 @@ void rockchip_drm_atomic_work(struct work_struct *work);
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 				 const struct rockchip_crtc_funcs *crtc_funcs);
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
-int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
-				  int out_mode);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a619f12..28596e7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -818,38 +818,6 @@ static const struct drm_plane_funcs vop_plane_funcs = {
 	.atomic_destroy_state = vop_atomic_plane_destroy_state,
 };
 
-int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc,
-				  int connector_type,
-				  int out_mode)
-{
-	struct vop *vop = to_vop(crtc);
-
-	if (WARN_ON(!vop->is_enabled))
-		return -EINVAL;
-
-	switch (connector_type) {
-	case DRM_MODE_CONNECTOR_LVDS:
-		VOP_CTRL_SET(vop, rgb_en, 1);
-		break;
-	case DRM_MODE_CONNECTOR_eDP:
-		VOP_CTRL_SET(vop, edp_en, 1);
-		break;
-	case DRM_MODE_CONNECTOR_HDMIA:
-		VOP_CTRL_SET(vop, hdmi_en, 1);
-		break;
-	case DRM_MODE_CONNECTOR_DSI:
-		VOP_CTRL_SET(vop, mipi_en, 1);
-		break;
-	default:
-		DRM_ERROR("unsupport connector_type[%d]\n", connector_type);
-		return -EINVAL;
-	};
-	VOP_CTRL_SET(vop, out_mode, out_mode);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rockchip_drm_crtc_mode_config);
-
 static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
@@ -931,6 +899,7 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 static void vop_crtc_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	u16 hsync_len = adjusted_mode->hsync_end - adjusted_mode->hsync_start;
 	u16 hdisplay = adjusted_mode->hdisplay;
@@ -985,6 +954,23 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
 	VOP_CTRL_SET(vop, pin_pol, val);
+	switch (s->output_type) {
+	case DRM_MODE_CONNECTOR_LVDS:
+		VOP_CTRL_SET(vop, rgb_en, 1);
+		break;
+	case DRM_MODE_CONNECTOR_eDP:
+		VOP_CTRL_SET(vop, edp_en, 1);
+		break;
+	case DRM_MODE_CONNECTOR_HDMIA:
+		VOP_CTRL_SET(vop, hdmi_en, 1);
+		break;
+	case DRM_MODE_CONNECTOR_DSI:
+		VOP_CTRL_SET(vop, mipi_en, 1);
+		break;
+	default:
+		DRM_ERROR("unsupport connector_type[%d]\n", s->output_type);
+	}
+	VOP_CTRL_SET(vop, out_mode, s->output_mode);
 
 	VOP_CTRL_SET(vop, htotal_pw, (htotal << 16) | hsync_len);
 	val = hact_st << 16;
@@ -1044,13 +1030,34 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
 	drm_crtc_cleanup(crtc);
 }
 
+static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct rockchip_crtc_state *rockchip_state;
+
+	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	if (!rockchip_state)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &rockchip_state->base);
+	return &rockchip_state->base;
+}
+
+static void vop_crtc_destroy_state(struct drm_crtc *crtc,
+				   struct drm_crtc_state *state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(state);
+
+	__drm_atomic_helper_crtc_destroy_state(crtc, &s->base);
+	kfree(s);
+}
+
 static const struct drm_crtc_funcs vop_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.destroy = vop_crtc_destroy,
 	.reset = drm_atomic_helper_crtc_reset,
-	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = vop_crtc_duplicate_state,
+	.atomic_destroy_state = vop_crtc_destroy_state,
 };
 
 static bool vop_win_pending_is_complete(struct vop_win *vop_win)
-- 
1.7.9.5
