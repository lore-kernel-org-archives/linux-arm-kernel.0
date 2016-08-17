From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 17 Aug 2016 10:20:52 -0700
Subject: [PATCH v3 1/5] drm/rockchip: sort registers define by chip's number
In-Reply-To: <loom.20160602T084340-509@post.gmane.org>
References: <loom.20160602T084340-509@post.gmane.org>
Message-ID: <1471454452-2151-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

No functional changes, sort the vop registers to make
code more readable.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
[seanpaul resolved conflict with name change from _3066 to _3036]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v3:
	- Fix typo from _3066 _3036 (Tomasz Figa)

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 168 ++++++++++++++--------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 919992c..44caf14 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -50,6 +50,88 @@ static const uint32_t formats_win_lite[] = {
 	DRM_FORMAT_BGR565,
 };
 
+static const struct vop_scl_regs rk3036_win_scl = {
+	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy rk3036_win0_data = {
+	.scl = &rk3036_win_scl,
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
+	.uv_vir = VOP_REG(RK3036_WIN0_VIR, 0x1fff, 16),
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
@@ -190,93 +272,11 @@ static const struct vop_data rk3288_vop = {
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
 };
 
-static const struct vop_scl_regs rk3036_win_scl = {
-	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
-	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
-	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
-	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
-};
-
-static const struct vop_win_phy rk3036_win0_data = {
-	.scl = &rk3036_win_scl,
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
-	.uv_vir = VOP_REG(RK3036_WIN0_VIR, 0x1fff, 16),
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
-- 
2.8.0.rc3.226.g39d4020
