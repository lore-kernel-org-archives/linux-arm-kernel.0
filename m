From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:28 -0500
Subject: [PATCH 13/41] drm/rockchip: pre dither down when output bpc is 8bit
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-14-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

Some encoder have a crc verification check, crc check fail if
input and output data is not equal.

That means encoder input and output need use same color depth,
vop can output 10bit data to encoder, but some panel only support
8bit depth, that would make crc check die.

So pre dither down vop data to 8bit if panel's bpc is 8.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     | 1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     | 4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h     | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c     | 6 ++++--
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index f44756029478..b6c6d6d09d7e 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -225,6 +225,7 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 {
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
 	struct rockchip_dp_device *dp = to_dp(encoder);
+	struct drm_display_info *di = &conn_state->connector->display_info;
 	int ret;
 
 	/*
@@ -248,6 +249,9 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 			s->output_mode = ROCKCHIP_OUT_MODE_P888;
 	}
 
+	s->output_bpc = di->bpc;
+	s->output_type = DRM_MODE_CONNECTOR_eDP;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 1844951118da..a966d1d37378 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -36,6 +36,7 @@ struct rockchip_crtc_state {
 	struct drm_crtc_state base;
 	int output_type;
 	int output_mode;
+	int output_bpc;
 };
 #define to_rockchip_crtc_state(s) \
 		container_of(s, struct rockchip_crtc_state, base)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index aa5c528c59fc..ea3fff4170d9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -968,6 +968,10 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		DRM_DEV_ERROR(vop->dev, "unsupported connector_type [%d]\n",
 			      s->output_type);
 	}
+	if (s->output_mode == ROCKCHIP_OUT_MODE_AAAA && s->output_bpc == 8)
+		VOP_CTRL_SET(vop, pre_dither_down, 1);
+	else
+		VOP_CTRL_SET(vop, pre_dither_down, 0);
 	VOP_CTRL_SET(vop, out_mode, s->output_mode);
 
 	VOP_CTRL_SET(vop, htotal_pw, (htotal << 16) | hsync_len);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 5a4faa85dbd2..9a1eb83271eb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -47,6 +47,7 @@ struct vop_ctrl {
 	struct vop_reg mipi_en;
 	struct vop_reg dp_en;
 	struct vop_reg out_mode;
+	struct vop_reg pre_dither_down;
 	struct vop_reg dither_down;
 	struct vop_reg dither_up;
 	struct vop_reg pin_pol;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 91fbc7b52147..e645a9621721 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -212,7 +212,8 @@ static const struct vop_ctrl rk3288_ctrl_data = {
 	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
 	.edp_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 14),
 	.mipi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 15),
-	.dither_down = VOP_REG(RK3288_DSP_CTRL1, 0xf, 1),
+	.pre_dither_down = VOP_REG(RK3288_DSP_CTRL1, 0x1, 1),
+	.dither_down = VOP_REG(RK3288_DSP_CTRL1, 0x7, 2),
 	.dither_up = VOP_REG(RK3288_DSP_CTRL1, 0x1, 6),
 	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
 	.out_mode = VOP_REG(RK3288_DSP_CTRL0, 0xf, 0),
@@ -289,7 +290,8 @@ static const struct vop_ctrl rk3399_ctrl_data = {
 	.hdmi_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 13),
 	.edp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 14),
 	.mipi_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 15),
-	.dither_down = VOP_REG(RK3399_DSP_CTRL1, 0xf, 1),
+	.pre_dither_down = VOP_REG(RK3399_DSP_CTRL1, 0x1, 1),
+	.dither_down = VOP_REG(RK3399_DSP_CTRL1, 0x7, 2),
 	.dither_up = VOP_REG(RK3399_DSP_CTRL1, 0x1, 6),
 	.data_blank = VOP_REG(RK3399_DSP_CTRL0, 0x1, 19),
 	.out_mode = VOP_REG(RK3399_DSP_CTRL0, 0xf, 0),
-- 
2.12.0.246.ga2ecc84866-goog
