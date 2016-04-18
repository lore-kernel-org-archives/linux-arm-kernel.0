From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 18 Apr 2016 11:03:31 +0800
Subject: [PATCH] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
Message-ID: <1460948611-32259-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to take care of the vop status when use
rockchip_drm_crtc_mode_config, if vop is disabled,
the function would failed, that is terrible.

Save connector type and output mode on drm_display_mode->private_flags
at encoder mode_fixup, then we can configure the type and mode safely
on crtc mode_set.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |   37 +++++++---------
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c          |   44 ++++++++++---------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |    5 +--
 drivers/gpu/drm/rockchip/inno_hdmi.c            |    5 +--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |    2 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |   51 +++++++++--------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     |    6 +++
 7 files changed, 69 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index a1d94d8..0344e52 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -97,7 +97,21 @@ rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 				   const struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
 {
-	/* do nothing */
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
+	adjusted_mode->private_flags = ROCKCHIP_DSP_MODE(eDP, AAAA);
+
 	return true;
 }
 
@@ -114,27 +128,6 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder)
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
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 7975158..49c4c72 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -875,11 +875,34 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->pclk);
 }
 
+static bool dw_mipi_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
+					const struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
+
+	switch (dsi->format) {
+	case MIPI_DSI_FMT_RGB888:
+		adjusted_mode->private_flags = ROCKCHIP_DSP_MODE(DSI, P888);
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		adjusted_mode->private_flags = ROCKCHIP_DSP_MODE(DSI, P666);
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		adjusted_mode->private_flags = ROCKCHIP_DSP_MODE(DSI, P565);
+		break;
+	default:
+		WARN_ON(1);
+		return false;
+	}
+
+	return true;
+}
+
 static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
-	u32 interface_pix_fmt;
 	u32 val;
 
 	if (clk_prepare_enable(dsi->pclk)) {
@@ -895,24 +918,6 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 
 	clk_disable_unprepare(dsi->pclk);
 
-	switch (dsi->format) {
-	case MIPI_DSI_FMT_RGB888:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P888;
-		break;
-	case MIPI_DSI_FMT_RGB666:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P666;
-		break;
-	case MIPI_DSI_FMT_RGB565:
-		interface_pix_fmt = ROCKCHIP_OUT_MODE_P565;
-		break;
-	default:
-		WARN_ON(1);
-		return;
-	}
-
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_DSI,
-				      interface_pix_fmt);
-
 	if (mux)
 		val = DSI0_SEL_VOP_LIT | (DSI0_SEL_VOP_LIT << 16);
 	else
@@ -924,6 +929,7 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 
 static struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
+	.mode_fixup = dw_mipi_dsi_encoder_mode_fixup,
 	.commit = dw_mipi_dsi_encoder_commit,
 	.mode_set = dw_mipi_dsi_encoder_mode_set,
 	.disable = dw_mipi_dsi_encoder_disable,
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d5cfef7..a72af30 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -186,6 +186,8 @@ dw_hdmi_rockchip_encoder_mode_fixup(struct drm_encoder *encoder,
 				    const struct drm_display_mode *mode,
 				    struct drm_display_mode *adj_mode)
 {
+	adj_mode->private_flags = ROCKCHIP_DSP_MODE(HDMIA, AAAA);
+
 	return true;
 }
 
@@ -201,9 +203,6 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	u32 val;
 	int mux;
 
-	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_AAAA);
-
 	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
 	if (mux)
 		val = HDMI_SEL_VOP_LIT | (HDMI_SEL_VOP_LIT << 16);
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 10d62ff..ef6ad91 100644
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
 
@@ -517,6 +514,8 @@ static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
 					 const struct drm_display_mode *mode,
 					 struct drm_display_mode *adj_mode)
 {
+	adj_mode->private_flags = ROCKCHIP_DSP_MODE(HDMIA, P888);
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 00d17d7..683210b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -68,8 +68,6 @@ void rockchip_drm_atomic_work(struct work_struct *work);
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 				 const struct rockchip_crtc_funcs *crtc_funcs);
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
-int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int connector_type,
-				  int out_mode);
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 				   struct device *dev);
 void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a619f12..1a611cf 100644
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
@@ -943,6 +911,8 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	u16 vact_st = adjusted_mode->vtotal - adjusted_mode->vsync_start;
 	u16 vact_end = vact_st + vdisplay;
 	uint32_t val;
+	int type = ROCKCHIP_OUT_MODE_TYPE(adjusted_mode->private_flags);
+	int out_mode = ROCKCHIP_OUT_MODE(adjusted_mode->private_flags);
 
 	vop_enable(crtc);
 	/*
@@ -985,6 +955,23 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
 	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
 	VOP_CTRL_SET(vop, pin_pol, val);
+	switch (type) {
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
+		DRM_ERROR("unsupport connector_type[%d]\n", type);
+	}
+	VOP_CTRL_SET(vop, out_mode, out_mode);
 
 	VOP_CTRL_SET(vop, htotal_pw, (htotal << 16) | hsync_len);
 	val = hact_st << 16;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 071ff0b..4c63a66 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -183,6 +183,12 @@ struct vop_data {
 /* for use special outface */
 #define ROCKCHIP_OUT_MODE_AAAA	15
 
+#define ROCKCHIP_OUT_MODE_TYPE(x)	((x) >> 16)
+#define ROCKCHIP_OUT_MODE(x)		((x) & 0xffff)
+#define ROCKCHIP_DSP_MODE(type, mode) \
+		((DRM_MODE_CONNECTOR_##type << 16) | \
+		 (ROCKCHIP_OUT_MODE_##mode & 0xffff))
+
 enum alpha_mode {
 	ALPHA_STRAIGHT,
 	ALPHA_INVERSE,
-- 
1.7.9.5
