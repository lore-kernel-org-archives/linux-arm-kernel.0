From: mark.yao@rock-chips.com (Mark Yao)
Date: Wed, 20 Apr 2016 14:18:13 +0800
Subject: [PATCH v2 1/5] drm/rockchip: sort registers define by chip's number
In-Reply-To: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
References: <1461133097-1478-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1461133097-1478-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional changes, sort the vop registers to make
code more readable.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  166 +++++++++++++--------------
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |   88 +++++++-------
 2 files changed, 127 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 3166b46..e75b2b8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -50,6 +50,87 @@ static const uint32_t formats_win_lite[] = {
 	DRM_FORMAT_BGR565,
 };
 
+static const struct vop_scl_regs rk3066_win_scl = {
+	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy rk3036_win0_data = {
+	.scl = &rk3066_win_scl,
+	.data_formats = formats_win_full,
+	.nformats = ARRAY_SIZE(formats_win_full),
+	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 0),
+	.format = VOP_REG(RK3036_SYS_CTRL, 0x7, 3),
+	.rb_swap = VOP_REG(RK3036_SYS_CTRL, 0x1, 15),
+	.act_info = VOP_REG(RK3036_WIN0_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3036_WIN0_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3036_WIN0_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3036_WIN0_YRGB_MST, 0xffffffff, 0),
+	.uv_mst = VOP_REG(RK3036_WIN0_CBR_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3036_WIN0_VIR, 0xffff, 0),
+};
+
+static const struct vop_win_phy rk3036_win1_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 1),
+	.format = VOP_REG(RK3036_SYS_CTRL, 0x7, 6),
+	.rb_swap = VOP_REG(RK3036_SYS_CTRL, 0x1, 19),
+	.act_info = VOP_REG(RK3036_WIN1_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3036_WIN1_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3036_WIN1_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3036_WIN1_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3036_WIN1_VIR, 0xffff, 0),
+};
+
+static const struct vop_win_data rk3036_vop_win_data[] = {
+	{ .base = 0x00, .phy = &rk3036_win0_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x00, .phy = &rk3036_win1_data,
+	  .type = DRM_PLANE_TYPE_CURSOR },
+};
+
+static const int rk3036_vop_intrs[] = {
+	DSP_HOLD_VALID_INTR,
+	FS_INTR,
+	LINE_FLAG_INTR,
+	BUS_ERROR_INTR,
+};
+
+static const struct vop_intr rk3036_intr = {
+	.intrs = rk3036_vop_intrs,
+	.nintrs = ARRAY_SIZE(rk3036_vop_intrs),
+	.status = VOP_REG(RK3036_INT_STATUS, 0xf, 0),
+	.enable = VOP_REG(RK3036_INT_STATUS, 0xf, 4),
+	.clear = VOP_REG(RK3036_INT_STATUS, 0xf, 8),
+};
+
+static const struct vop_ctrl rk3036_ctrl_data = {
+	.standby = VOP_REG(RK3036_SYS_CTRL, 0x1, 30),
+	.out_mode = VOP_REG(RK3036_DSP_CTRL0, 0xf, 0),
+	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
+	.htotal_pw = VOP_REG(RK3036_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
+	.hact_st_end = VOP_REG(RK3036_DSP_HACT_ST_END, 0x1fff1fff, 0),
+	.vtotal_pw = VOP_REG(RK3036_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
+	.vact_st_end = VOP_REG(RK3036_DSP_VACT_ST_END, 0x1fff1fff, 0),
+	.cfg_done = VOP_REG(RK3036_REG_CFG_DONE, 0x1, 0),
+};
+
+static const struct vop_reg_data rk3036_vop_init_reg_table[] = {
+	{RK3036_DSP_CTRL1, 0x00000000},
+};
+
+static const struct vop_data rk3036_vop = {
+	.init_table = rk3036_vop_init_reg_table,
+	.table_size = ARRAY_SIZE(rk3036_vop_init_reg_table),
+	.ctrl = &rk3036_ctrl_data,
+	.intr = &rk3036_intr,
+	.win = rk3036_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3036_vop_win_data),
+};
+
 static const struct vop_scl_extension rk3288_win_full_scl_ext = {
 	.cbcr_vsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 31),
 	.cbcr_vsu_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 30),
@@ -190,92 +271,11 @@ static const struct vop_data rk3288_vop = {
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
 };
 
-static const struct vop_scl_regs rk3066_win_scl = {
-	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
-	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
-	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
-	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
-};
-
-static const struct vop_win_phy rk3036_win0_data = {
-	.scl = &rk3066_win_scl,
-	.data_formats = formats_win_full,
-	.nformats = ARRAY_SIZE(formats_win_full),
-	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 0),
-	.format = VOP_REG(RK3036_SYS_CTRL, 0x7, 3),
-	.rb_swap = VOP_REG(RK3036_SYS_CTRL, 0x1, 15),
-	.act_info = VOP_REG(RK3036_WIN0_ACT_INFO, 0x1fff1fff, 0),
-	.dsp_info = VOP_REG(RK3036_WIN0_DSP_INFO, 0x0fff0fff, 0),
-	.dsp_st = VOP_REG(RK3036_WIN0_DSP_ST, 0x1fff1fff, 0),
-	.yrgb_mst = VOP_REG(RK3036_WIN0_YRGB_MST, 0xffffffff, 0),
-	.uv_mst = VOP_REG(RK3036_WIN0_CBR_MST, 0xffffffff, 0),
-	.yrgb_vir = VOP_REG(RK3036_WIN0_VIR, 0xffff, 0),
-};
-
-static const struct vop_win_phy rk3036_win1_data = {
-	.data_formats = formats_win_lite,
-	.nformats = ARRAY_SIZE(formats_win_lite),
-	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 1),
-	.format = VOP_REG(RK3036_SYS_CTRL, 0x7, 6),
-	.rb_swap = VOP_REG(RK3036_SYS_CTRL, 0x1, 19),
-	.act_info = VOP_REG(RK3036_WIN1_ACT_INFO, 0x1fff1fff, 0),
-	.dsp_info = VOP_REG(RK3036_WIN1_DSP_INFO, 0x0fff0fff, 0),
-	.dsp_st = VOP_REG(RK3036_WIN1_DSP_ST, 0x1fff1fff, 0),
-	.yrgb_mst = VOP_REG(RK3036_WIN1_MST, 0xffffffff, 0),
-	.yrgb_vir = VOP_REG(RK3036_WIN1_VIR, 0xffff, 0),
-};
-
-static const struct vop_win_data rk3036_vop_win_data[] = {
-	{ .base = 0x00, .phy = &rk3036_win0_data,
-	  .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x00, .phy = &rk3036_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
-};
-
-static const int rk3036_vop_intrs[] = {
-	DSP_HOLD_VALID_INTR,
-	FS_INTR,
-	LINE_FLAG_INTR,
-	BUS_ERROR_INTR,
-};
-
-static const struct vop_intr rk3036_intr = {
-	.intrs = rk3036_vop_intrs,
-	.nintrs = ARRAY_SIZE(rk3036_vop_intrs),
-	.status = VOP_REG(RK3036_INT_STATUS, 0xf, 0),
-	.enable = VOP_REG(RK3036_INT_STATUS, 0xf, 4),
-	.clear = VOP_REG(RK3036_INT_STATUS, 0xf, 8),
-};
-
-static const struct vop_ctrl rk3036_ctrl_data = {
-	.standby = VOP_REG(RK3036_SYS_CTRL, 0x1, 30),
-	.out_mode = VOP_REG(RK3036_DSP_CTRL0, 0xf, 0),
-	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
-	.htotal_pw = VOP_REG(RK3036_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
-	.hact_st_end = VOP_REG(RK3036_DSP_HACT_ST_END, 0x1fff1fff, 0),
-	.vtotal_pw = VOP_REG(RK3036_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
-	.vact_st_end = VOP_REG(RK3036_DSP_VACT_ST_END, 0x1fff1fff, 0),
-	.cfg_done = VOP_REG(RK3036_REG_CFG_DONE, 0x1, 0),
-};
-
-static const struct vop_reg_data rk3036_vop_init_reg_table[] = {
-	{RK3036_DSP_CTRL1, 0x00000000},
-};
-
-static const struct vop_data rk3036_vop = {
-	.init_table = rk3036_vop_init_reg_table,
-	.table_size = ARRAY_SIZE(rk3036_vop_init_reg_table),
-	.ctrl = &rk3036_ctrl_data,
-	.intr = &rk3036_intr,
-	.win = rk3036_vop_win_data,
-	.win_size = ARRAY_SIZE(rk3036_vop_win_data),
-};
-
 static const struct of_device_id vop_driver_dt_match[] = {
-	{ .compatible = "rockchip,rk3288-vop",
-	  .data = &rk3288_vop },
 	{ .compatible = "rockchip,rk3036-vop",
 	  .data = &rk3036_vop },
+	{ .compatible = "rockchip,rk3288-vop",
+	  .data = &rk3288_vop },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index d4b46cb..43903e0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -15,6 +15,50 @@
 #ifndef _ROCKCHIP_VOP_REG_H
 #define _ROCKCHIP_VOP_REG_H
 
+/* rk3036 register definition */
+#define RK3036_SYS_CTRL			0x00
+#define RK3036_DSP_CTRL0		0x04
+#define RK3036_DSP_CTRL1		0x08
+#define RK3036_INT_STATUS		0x10
+#define RK3036_ALPHA_CTRL		0x14
+#define RK3036_WIN0_COLOR_KEY		0x18
+#define RK3036_WIN1_COLOR_KEY		0x1c
+#define RK3036_WIN0_YRGB_MST		0x20
+#define RK3036_WIN0_CBR_MST		0x24
+#define RK3036_WIN1_VIR			0x28
+#define RK3036_AXI_BUS_CTRL		0x2c
+#define RK3036_WIN0_VIR			0x30
+#define RK3036_WIN0_ACT_INFO		0x34
+#define RK3036_WIN0_DSP_INFO		0x38
+#define RK3036_WIN0_DSP_ST		0x3c
+#define RK3036_WIN0_SCL_FACTOR_YRGB	0x40
+#define RK3036_WIN0_SCL_FACTOR_CBR	0x44
+#define RK3036_WIN0_SCL_OFFSET		0x48
+#define RK3036_HWC_MST			0x58
+#define RK3036_HWC_DSP_ST		0x5c
+#define RK3036_DSP_HTOTAL_HS_END	0x6c
+#define RK3036_DSP_HACT_ST_END		0x70
+#define RK3036_DSP_VTOTAL_VS_END	0x74
+#define RK3036_DSP_VACT_ST_END		0x78
+#define RK3036_DSP_VS_ST_END_F1		0x7c
+#define RK3036_DSP_VACT_ST_END_F1	0x80
+#define RK3036_GATHER_TRANSFER		0x84
+#define RK3036_VERSION_INFO		0x94
+#define RK3036_REG_CFG_DONE		0x90
+#define RK3036_WIN1_MST			0xa0
+#define RK3036_WIN1_ACT_INFO		0xb4
+#define RK3036_WIN1_DSP_INFO		0xb8
+#define RK3036_WIN1_DSP_ST		0xbc
+#define RK3036_WIN1_SCL_FACTOR_YRGB	0xc0
+#define RK3036_WIN1_SCL_OFFSET		0xc8
+#define RK3036_BCSH_CTRL		0xd0
+#define RK3036_BCSH_COLOR_BAR		0xd4
+#define RK3036_BCSH_BCS			0xd8
+#define RK3036_BCSH_H			0xdc
+#define RK3036_WIN1_LUT_ADDR		0x400
+#define RK3036_HWC_LUT_ADDR		0x800
+/* rk3036 register definition end */
+
 /* rk3288 register definition */
 #define RK3288_REG_CFG_DONE			0x0000
 #define RK3288_VERSION_INFO			0x0004
@@ -122,48 +166,4 @@
 #define RK3288_DSP_VACT_ST_END_F1		0x019c
 /* register definition end */
 
-/* rk3036 register definition */
-#define RK3036_SYS_CTRL			0x00
-#define RK3036_DSP_CTRL0		0x04
-#define RK3036_DSP_CTRL1		0x08
-#define RK3036_INT_STATUS		0x10
-#define RK3036_ALPHA_CTRL		0x14
-#define RK3036_WIN0_COLOR_KEY		0x18
-#define RK3036_WIN1_COLOR_KEY		0x1c
-#define RK3036_WIN0_YRGB_MST		0x20
-#define RK3036_WIN0_CBR_MST		0x24
-#define RK3036_WIN1_VIR			0x28
-#define RK3036_AXI_BUS_CTRL		0x2c
-#define RK3036_WIN0_VIR			0x30
-#define RK3036_WIN0_ACT_INFO		0x34
-#define RK3036_WIN0_DSP_INFO		0x38
-#define RK3036_WIN0_DSP_ST		0x3c
-#define RK3036_WIN0_SCL_FACTOR_YRGB	0x40
-#define RK3036_WIN0_SCL_FACTOR_CBR	0x44
-#define RK3036_WIN0_SCL_OFFSET		0x48
-#define RK3036_HWC_MST			0x58
-#define RK3036_HWC_DSP_ST		0x5c
-#define RK3036_DSP_HTOTAL_HS_END	0x6c
-#define RK3036_DSP_HACT_ST_END		0x70
-#define RK3036_DSP_VTOTAL_VS_END	0x74
-#define RK3036_DSP_VACT_ST_END		0x78
-#define RK3036_DSP_VS_ST_END_F1		0x7c
-#define RK3036_DSP_VACT_ST_END_F1	0x80
-#define RK3036_GATHER_TRANSFER		0x84
-#define RK3036_VERSION_INFO		0x94
-#define RK3036_REG_CFG_DONE		0x90
-#define RK3036_WIN1_MST			0xa0
-#define RK3036_WIN1_ACT_INFO		0xb4
-#define RK3036_WIN1_DSP_INFO		0xb8
-#define RK3036_WIN1_DSP_ST		0xbc
-#define RK3036_WIN1_SCL_FACTOR_YRGB	0xc0
-#define RK3036_WIN1_SCL_OFFSET		0xc8
-#define RK3036_BCSH_CTRL		0xd0
-#define RK3036_BCSH_COLOR_BAR		0xd4
-#define RK3036_BCSH_BCS			0xd8
-#define RK3036_BCSH_H			0xdc
-#define RK3036_WIN1_LUT_ADDR		0x400
-#define RK3036_HWC_LUT_ADDR		0x800
-/* rk3036 register definition end */
-
 #endif /* _ROCKCHIP_VOP_REG_H */
-- 
1.7.9.5
