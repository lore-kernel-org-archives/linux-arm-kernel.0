From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 18 Apr 2016 11:17:57 +0800
Subject: [PATCH 1/2] drm/rockchip: vop: add rk3399 vop support
Message-ID: <1460949478-2236-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two VOP in rk3399 chip, respectively VOP_BIG and VOP_LIT.
most registers layout of this two vop is same, their framework are both
VOP_FULL, the Major differences of this two is that:

VOP_BIG max output resolution is 4096x2160.
VOP_LIT max output resolution is 2560x1600

VOP_BIG support four windows.
VOP_LIT only support two windows.

RK3399 vop register layout is similar with rk3288, so some feature
can reuse with rk3288.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   60 +++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |    5 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  100 +++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  193 +++++++++++++++++++++++++++
 4 files changed, 330 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 1a611cf..d20309b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -36,15 +36,18 @@
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_vop.h"
 
-#define __REG_SET_RELAXED(x, off, mask, shift, v) \
-		vop_mask_write_relaxed(x, off, (mask) << shift, (v) << shift)
-#define __REG_SET_NORMAL(x, off, mask, shift, v) \
-		vop_mask_write(x, off, (mask) << shift, (v) << shift)
+#define __REG_SET_RELAXED(x, off, mask, shift, v, write_mask) \
+		vop_mask_write(x, off, mask, shift, v, write_mask, true)
+
+#define __REG_SET_NORMAL(x, off, mask, shift, v, write_mask) \
+		vop_mask_write(x, off, mask, shift, v, write_mask, false)
 
 #define REG_SET(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
+		__REG_SET_##mode(x, base + reg.offset, \
+				 reg.mask, reg.shift, v, reg.write_mask)
 #define REG_SET_MASK(x, base, reg, mask, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, mask, reg.shift, v)
+		__REG_SET_##mode(x, base + reg.offset, \
+				 mask, reg.shift, v, reg.write_mask)
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
@@ -160,27 +163,25 @@ static inline uint32_t vop_read_reg(struct vop *vop, uint32_t base,
 }
 
 static inline void vop_mask_write(struct vop *vop, uint32_t offset,
-				  uint32_t mask, uint32_t v)
+				  uint32_t mask, uint32_t shift, uint32_t v,
+				  bool write_mask, bool relaxed)
 {
-	if (mask) {
-		uint32_t cached_val = vop->regsbak[offset >> 2];
-
-		cached_val = (cached_val & ~mask) | v;
-		writel(cached_val, vop->regs + offset);
-		vop->regsbak[offset >> 2] = cached_val;
-	}
-}
+	if (!mask)
+		return;
 
-static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
-					  uint32_t mask, uint32_t v)
-{
-	if (mask) {
+	if (write_mask) {
+		v = (v << shift) | (mask << (shift + 16));
+	} else {
 		uint32_t cached_val = vop->regsbak[offset >> 2];
 
-		cached_val = (cached_val & ~mask) | v;
-		writel_relaxed(cached_val, vop->regs + offset);
-		vop->regsbak[offset >> 2] = cached_val;
+		v = (cached_val & ~(mask << shift)) | (v << shift);
+		vop->regsbak[offset >> 2] = v;
 	}
+
+	if (relaxed)
+		writel_relaxed(v, vop->regs + offset);
+	else
+		writel(v, vop->regs + offset);
 }
 
 static inline uint32_t vop_get_intr_type(struct vop *vop,
@@ -910,7 +911,7 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	u16 vsync_len = adjusted_mode->vsync_end - adjusted_mode->vsync_start;
 	u16 vact_st = adjusted_mode->vtotal - adjusted_mode->vsync_start;
 	u16 vact_end = vact_st + vdisplay;
-	uint32_t val;
+	uint32_t pin_pol, val;
 	int type = ROCKCHIP_OUT_MODE_TYPE(adjusted_mode->private_flags);
 	int out_mode = ROCKCHIP_OUT_MODE(adjusted_mode->private_flags);
 
@@ -951,21 +952,26 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 		vop_dsp_hold_valid_irq_disable(vop);
 	}
 
-	val = 0x8;
-	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
-	val |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
-	VOP_CTRL_SET(vop, pin_pol, val);
+	pin_pol = 0x8;
+	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
+	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
+	VOP_CTRL_SET(vop, pin_pol, pin_pol);
+
 	switch (type) {
 	case DRM_MODE_CONNECTOR_LVDS:
 		VOP_CTRL_SET(vop, rgb_en, 1);
+		VOP_CTRL_SET(vop, rgb_pin_pol, pin_pol);
 		break;
 	case DRM_MODE_CONNECTOR_eDP:
+		VOP_CTRL_SET(vop, edp_pin_pol, pin_pol);
 		VOP_CTRL_SET(vop, edp_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_HDMIA:
+		VOP_CTRL_SET(vop, hdmi_pin_pol, pin_pol);
 		VOP_CTRL_SET(vop, hdmi_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_DSI:
+		VOP_CTRL_SET(vop, mipi_pin_pol, pin_pol);
 		VOP_CTRL_SET(vop, mipi_en, 1);
 		break;
 	default:
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 4c63a66..4d240ed 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -33,6 +33,7 @@ struct vop_reg {
 	uint32_t offset;
 	uint32_t shift;
 	uint32_t mask;
+	bool write_mask;
 };
 
 struct vop_ctrl {
@@ -48,6 +49,10 @@ struct vop_ctrl {
 	struct vop_reg dither_down;
 	struct vop_reg dither_up;
 	struct vop_reg pin_pol;
+	struct vop_reg rgb_pin_pol;
+	struct vop_reg hdmi_pin_pol;
+	struct vop_reg edp_pin_pol;
+	struct vop_reg mipi_pin_pol;
 
 	struct vop_reg htotal_pw;
 	struct vop_reg hact_st_end;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 3166b46..0b0eb69 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -23,7 +23,14 @@
 #define VOP_REG(off, _mask, s) \
 		{.offset = off, \
 		 .mask = _mask, \
-		 .shift = s,}
+		 .shift = s, \
+		 .write_mask = false,}
+
+#define VOP_REG_MASK(off, _mask, s) \
+		{.offset = off, \
+		 .mask = _mask, \
+		 .shift = s, \
+		 .write_mask = true,}
 
 static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_XRGB8888,
@@ -190,6 +197,93 @@ static const struct vop_data rk3288_vop = {
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
 };
 
+static const struct vop_ctrl rk3399_ctrl_data = {
+	.standby = VOP_REG(RK3399_SYS_CTRL, 0x1, 22),
+	.gate_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 23),
+	.rgb_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 12),
+	.hdmi_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 13),
+	.edp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 14),
+	.mipi_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 15),
+	.dither_down = VOP_REG(RK3399_DSP_CTRL1, 0xf, 1),
+	.dither_up = VOP_REG(RK3399_DSP_CTRL1, 0x1, 6),
+	.data_blank = VOP_REG(RK3399_DSP_CTRL0, 0x1, 19),
+	.out_mode = VOP_REG(RK3399_DSP_CTRL0, 0xf, 0),
+	.rgb_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
+	.hdmi_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 20),
+	.edp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 24),
+	.mipi_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 28),
+	.htotal_pw = VOP_REG(RK3399_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
+	.hact_st_end = VOP_REG(RK3399_DSP_HACT_ST_END, 0x1fff1fff, 0),
+	.vtotal_pw = VOP_REG(RK3399_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
+	.vact_st_end = VOP_REG(RK3399_DSP_VACT_ST_END, 0x1fff1fff, 0),
+	.hpost_st_end = VOP_REG(RK3399_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
+	.vpost_st_end = VOP_REG(RK3399_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
+	.cfg_done = VOP_REG_MASK(RK3399_REG_CFG_DONE, 0x1, 0),
+};
+
+static const int rk3399_vop_intrs[] = {
+	FS_INTR,
+	0, 0,
+	LINE_FLAG_INTR,
+	0,
+	BUS_ERROR_INTR,
+	0, 0, 0, 0, 0, 0, 0,
+	DSP_HOLD_VALID_INTR,
+};
+
+static const struct vop_intr rk3399_vop_intr = {
+	.intrs = rk3399_vop_intrs,
+	.nintrs = ARRAY_SIZE(rk3399_vop_intrs),
+	.status = VOP_REG_MASK(RK3399_INTR_STATUS0, 0xffff, 0),
+	.enable = VOP_REG_MASK(RK3399_INTR_EN0, 0xffff, 0),
+	.clear = VOP_REG_MASK(RK3399_INTR_CLEAR0, 0xffff, 0),
+};
+
+static const struct vop_reg_data rk3399_init_reg_table[] = {
+	{RK3399_SYS_CTRL, 0x2000f800},
+	{RK3399_DSP_CTRL0, 0x00000000},
+	{RK3399_WIN0_CTRL0, 0x00000080},
+	{RK3399_WIN1_CTRL0, 0x00000080},
+	/* TODO: Win2/3 support multiple area function, but we haven't found
+	 * a suitable way to use it yet, so let's just use them as other windows
+	 * with only area 0 enabled.
+	 */
+	{RK3399_WIN2_CTRL0, 0x00000010},
+	{RK3399_WIN3_CTRL0, 0x00000010},
+};
+
+static const struct vop_data rk3399_vop_big = {
+	.init_table = rk3399_init_reg_table,
+	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
+	.intr = &rk3399_vop_intr,
+	.ctrl = &rk3399_ctrl_data,
+	/*
+	 * rk3399 vop big windows register layout is same as rk3288.
+	 */
+	.win = rk3288_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
+};
+
+static const struct vop_win_data rk3399_vop_lit_win_data[] = {
+	{ .base = 0x00, .phy = &rk3288_win01_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x00, .phy = &rk3288_win23_data,
+	  .type = DRM_PLANE_TYPE_CURSOR},
+};
+
+static const struct vop_data rk3399_vop_lit = {
+	.init_table = rk3399_init_reg_table,
+	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
+	.intr = &rk3399_vop_intr,
+	.ctrl = &rk3399_ctrl_data,
+	/*
+	 * rk3399 vop lit windows register layout is same as rk3288,
+	 * but cut off the win1 and win3 windows.
+	 */
+	.win = rk3399_vop_lit_win_data,
+	.win_size = ARRAY_SIZE(rk3399_vop_lit_win_data),
+};
+
 static const struct vop_scl_regs rk3066_win_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
@@ -276,6 +370,10 @@ static const struct of_device_id vop_driver_dt_match[] = {
 	  .data = &rk3288_vop },
 	{ .compatible = "rockchip,rk3036-vop",
 	  .data = &rk3036_vop },
+	{ .compatible = "rockchip,rk3399-vop-big",
+	  .data = &rk3399_vop_big },
+	{ .compatible = "rockchip,rk3399-vop-lit",
+	  .data = &rk3399_vop_lit },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index d4b46cb..5416819 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -122,6 +122,199 @@
 #define RK3288_DSP_VACT_ST_END_F1		0x019c
 /* register definition end */
 
+/* rk3399 register definition */
+#define RK3399_REG_CFG_DONE		0x00000
+#define RK3399_VERSION_INFO		0x00004
+#define RK3399_SYS_CTRL			0x00008
+#define RK3399_SYS_CTRL1		0x0000c
+#define RK3399_DSP_CTRL0		0x00010
+#define RK3399_DSP_CTRL1		0x00014
+#define RK3399_DSP_BG			0x00018
+#define RK3399_MCU_CTRL			0x0001c
+#define RK3399_WB_CTRL0			0x00020
+#define RK3399_WB_CTRL1			0x00024
+#define RK3399_WB_YRGB_MST		0x00028
+#define RK3399_WB_CBR_MST		0x0002c
+#define RK3399_WIN0_CTRL0		0x00030
+#define RK3399_WIN0_CTRL1		0x00034
+#define RK3399_WIN0_COLOR_KEY		0x00038
+#define RK3399_WIN0_VIR			0x0003c
+#define RK3399_WIN0_YRGB_MST		0x00040
+#define RK3399_WIN0_CBR_MST		0x00044
+#define RK3399_WIN0_ACT_INFO		0x00048
+#define RK3399_WIN0_DSP_INFO		0x0004c
+#define RK3399_WIN0_DSP_ST		0x00050
+#define RK3399_WIN0_SCL_FACTOR_YRGB	0x00054
+#define RK3399_WIN0_SCL_FACTOR_CBR	0x00058
+#define RK3399_WIN0_SCL_OFFSET		0x0005c
+#define RK3399_WIN0_SRC_ALPHA_CTRL	0x00060
+#define RK3399_WIN0_DST_ALPHA_CTRL	0x00064
+#define RK3399_WIN0_FADING_CTRL		0x00068
+#define RK3399_WIN0_CTRL2		0x0006c
+#define RK3399_WIN1_CTRL0		0x00070
+#define RK3399_WIN1_CTRL1		0x00074
+#define RK3399_WIN1_COLOR_KEY		0x00078
+#define RK3399_WIN1_VIR			0x0007c
+#define RK3399_WIN1_YRGB_MST		0x00080
+#define RK3399_WIN1_CBR_MST		0x00084
+#define RK3399_WIN1_ACT_INFO		0x00088
+#define RK3399_WIN1_DSP_INFO		0x0008c
+#define RK3399_WIN1_DSP_ST		0x00090
+#define RK3399_WIN1_SCL_FACTOR_YRGB	0x00094
+#define RK3399_WIN1_SCL_FACTOR_CBR	0x00098
+#define RK3399_WIN1_SCL_OFFSET		0x0009c
+#define RK3399_WIN1_SRC_ALPHA_CTRL	0x000a0
+#define RK3399_WIN1_DST_ALPHA_CTRL	0x000a4
+#define RK3399_WIN1_FADING_CTRL		0x000a8
+#define RK3399_WIN1_CTRL2		0x000ac
+#define RK3399_WIN2_CTRL0		0x000b0
+#define RK3399_WIN2_CTRL1		0x000b4
+#define RK3399_WIN2_VIR0_1		0x000b8
+#define RK3399_WIN2_VIR2_3		0x000bc
+#define RK3399_WIN2_MST0		0x000c0
+#define RK3399_WIN2_DSP_INFO0		0x000c4
+#define RK3399_WIN2_DSP_ST0		0x000c8
+#define RK3399_WIN2_COLOR_KEY		0x000cc
+#define RK3399_WIN2_MST1		0x000d0
+#define RK3399_WIN2_DSP_INFO1		0x000d4
+#define RK3399_WIN2_DSP_ST1		0x000d8
+#define RK3399_WIN2_SRC_ALPHA_CTRL	0x000dc
+#define RK3399_WIN2_MST2		0x000e0
+#define RK3399_WIN2_DSP_INFO2		0x000e4
+#define RK3399_WIN2_DSP_ST2		0x000e8
+#define RK3399_WIN2_DST_ALPHA_CTRL	0x000ec
+#define RK3399_WIN2_MST3		0x000f0
+#define RK3399_WIN2_DSP_INFO3		0x000f4
+#define RK3399_WIN2_DSP_ST3		0x000f8
+#define RK3399_WIN2_FADING_CTRL		0x000fc
+#define RK3399_WIN3_CTRL0		0x00100
+#define RK3399_WIN3_CTRL1		0x00104
+#define RK3399_WIN3_VIR0_1		0x00108
+#define RK3399_WIN3_VIR2_3		0x0010c
+#define RK3399_WIN3_MST0		0x00110
+#define RK3399_WIN3_DSP_INFO0		0x00114
+#define RK3399_WIN3_DSP_ST0		0x00118
+#define RK3399_WIN3_COLOR_KEY		0x0011c
+#define RK3399_WIN3_MST1		0x00120
+#define RK3399_WIN3_DSP_INFO1		0x00124
+#define RK3399_WIN3_DSP_ST1		0x00128
+#define RK3399_WIN3_SRC_ALPHA_CTRL	0x0012c
+#define RK3399_WIN3_MST2		0x00130
+#define RK3399_WIN3_DSP_INFO2		0x00134
+#define RK3399_WIN3_DSP_ST2		0x00138
+#define RK3399_WIN3_DST_ALPHA_CTRL	0x0013c
+#define RK3399_WIN3_MST3		0x00140
+#define RK3399_WIN3_DSP_INFO3		0x00144
+#define RK3399_WIN3_DSP_ST3		0x00148
+#define RK3399_WIN3_FADING_CTRL		0x0014c
+#define RK3399_HWC_CTRL0		0x00150
+#define RK3399_HWC_CTRL1		0x00154
+#define RK3399_HWC_MST			0x00158
+#define RK3399_HWC_DSP_ST		0x0015c
+#define RK3399_HWC_SRC_ALPHA_CTRL	0x00160
+#define RK3399_HWC_DST_ALPHA_CTRL	0x00164
+#define RK3399_HWC_FADING_CTRL		0x00168
+#define RK3399_HWC_RESERVED1		0x0016c
+#define RK3399_POST_DSP_HACT_INFO	0x00170
+#define RK3399_POST_DSP_VACT_INFO	0x00174
+#define RK3399_POST_SCL_FACTOR_YRGB	0x00178
+#define RK3399_POST_RESERVED		0x0017c
+#define RK3399_POST_SCL_CTRL		0x00180
+#define RK3399_POST_DSP_VACT_INFO_F1	0x00184
+#define RK3399_DSP_HTOTAL_HS_END	0x00188
+#define RK3399_DSP_HACT_ST_END		0x0018c
+#define RK3399_DSP_VTOTAL_VS_END	0x00190
+#define RK3399_DSP_VACT_ST_END		0x00194
+#define RK3399_DSP_VS_ST_END_F1		0x00198
+#define RK3399_DSP_VACT_ST_END_F1	0x0019c
+#define RK3399_PWM_CTRL			0x001a0
+#define RK3399_PWM_PERIOD_HPR		0x001a4
+#define RK3399_PWM_DUTY_LPR		0x001a8
+#define RK3399_PWM_CNT			0x001ac
+#define RK3399_BCSH_COLOR_BAR		0x001b0
+#define RK3399_BCSH_BCS			0x001b4
+#define RK3399_BCSH_H			0x001b8
+#define RK3399_BCSH_CTRL		0x001bc
+#define RK3399_CABC_CTRL0		0x001c0
+#define RK3399_CABC_CTRL1		0x001c4
+#define RK3399_CABC_CTRL2		0x001c8
+#define RK3399_CABC_CTRL3		0x001cc
+#define RK3399_CABC_GAUSS_LINE0_0	0x001d0
+#define RK3399_CABC_GAUSS_LINE0_1	0x001d4
+#define RK3399_CABC_GAUSS_LINE1_0	0x001d8
+#define RK3399_CABC_GAUSS_LINE1_1	0x001dc
+#define RK3399_CABC_GAUSS_LINE2_0	0x001e0
+#define RK3399_CABC_GAUSS_LINE2_1	0x001e4
+#define RK3399_FRC_LOWER01_0		0x001e8
+#define RK3399_FRC_LOWER01_1		0x001ec
+#define RK3399_FRC_LOWER10_0		0x001f0
+#define RK3399_FRC_LOWER10_1		0x001f4
+#define RK3399_FRC_LOWER11_0		0x001f8
+#define RK3399_FRC_LOWER11_1		0x001fc
+#define RK3399_AFBCD0_CTRL		0x00200
+#define RK3399_AFBCD0_HDR_PTR		0x00204
+#define RK3399_AFBCD0_PIC_SIZE		0x00208
+#define RK3399_AFBCD0_STATUS		0x0020c
+#define RK3399_AFBCD1_CTRL		0x00220
+#define RK3399_AFBCD1_HDR_PTR		0x00224
+#define RK3399_AFBCD1_PIC_SIZE		0x00228
+#define RK3399_AFBCD1_STATUS		0x0022c
+#define RK3399_AFBCD2_CTRL		0x00240
+#define RK3399_AFBCD2_HDR_PTR		0x00244
+#define RK3399_AFBCD2_PIC_SIZE		0x00248
+#define RK3399_AFBCD2_STATUS		0x0024c
+#define RK3399_AFBCD3_CTRL		0x00260
+#define RK3399_AFBCD3_HDR_PTR		0x00264
+#define RK3399_AFBCD3_PIC_SIZE		0x00268
+#define RK3399_AFBCD3_STATUS		0x0026c
+#define RK3399_INTR_EN0			0x00280
+#define RK3399_INTR_CLEAR0		0x00284
+#define RK3399_INTR_STATUS0		0x00288
+#define RK3399_INTR_RAW_STATUS0		0x0028c
+#define RK3399_INTR_EN1			0x00290
+#define RK3399_INTR_CLEAR1		0x00294
+#define RK3399_INTR_STATUS1		0x00298
+#define RK3399_INTR_RAW_STATUS1		0x0029c
+#define RK3399_LINE_FLAG		0x002a0
+#define RK3399_VOP_STATUS		0x002a4
+#define RK3399_BLANKING_VALUE		0x002a8
+#define RK3399_MCU_BYPASS_PORT		0x002ac
+#define RK3399_WIN0_DSP_BG		0x002b0
+#define RK3399_WIN1_DSP_BG		0x002b4
+#define RK3399_WIN2_DSP_BG		0x002b8
+#define RK3399_WIN3_DSP_BG		0x002bc
+#define RK3399_YUV2YUV_WIN		0x002c0
+#define RK3399_YUV2YUV_POST		0x002c4
+#define RK3399_AUTO_GATING_EN		0x002cc
+#define RK3399_WIN0_CSC_COE		0x003a0
+#define RK3399_WIN1_CSC_COE		0x003c0
+#define RK3399_WIN2_CSC_COE		0x003e0
+#define RK3399_WIN3_CSC_COE		0x00400
+#define RK3399_HWC_CSC_COE		0x00420
+#define RK3399_BCSH_R2Y_CSC_COE		0x00440
+#define RK3399_BCSH_Y2R_CSC_COE		0x00460
+#define RK3399_POST_YUV2YUV_Y2R_COE	0x00480
+#define RK3399_POST_YUV2YUV_3X3_COE	0x004a0
+#define RK3399_POST_YUV2YUV_R2Y_COE	0x004c0
+#define RK3399_WIN0_YUV2YUV_Y2R		0x004e0
+#define RK3399_WIN0_YUV2YUV_3X3		0x00500
+#define RK3399_WIN0_YUV2YUV_R2Y		0x00520
+#define RK3399_WIN1_YUV2YUV_Y2R		0x00540
+#define RK3399_WIN1_YUV2YUV_3X3		0x00560
+#define RK3399_WIN1_YUV2YUV_R2Y		0x00580
+#define RK3399_WIN2_YUV2YUV_Y2R		0x005a0
+#define RK3399_WIN2_YUV2YUV_3X3		0x005c0
+#define RK3399_WIN2_YUV2YUV_R2Y		0x005e0
+#define RK3399_WIN3_YUV2YUV_Y2R		0x00600
+#define RK3399_WIN3_YUV2YUV_3X3		0x00620
+#define RK3399_WIN3_YUV2YUV_R2Y		0x00640
+#define RK3399_WIN2_LUT_ADDR		0x01000
+#define RK3399_WIN3_LUT_ADDR		0x01400
+#define RK3399_HWC_LUT_ADDR		0x01800
+#define RK3399_CABC_GAMMA_LUT_ADDR	0x01c00
+#define RK3399_GAMMA_LUT_ADDR		0x02000
+/* rk3399 register definition end */
+
 /* rk3036 register definition */
 #define RK3036_SYS_CTRL			0x00
 #define RK3036_DSP_CTRL0		0x04
-- 
1.7.9.5
