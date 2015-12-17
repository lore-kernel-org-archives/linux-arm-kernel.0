From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:43:31 +0800
Subject: [PATCH 5/6] drm/rockchip: vop: add rk3036 vop support
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323811-32177-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3036 registers layout is quite difference with rk3288 layout,
The IC design with different framework, rk3036 vop is VOP LITE,
and rk3288 is VOP FULL.

RK3036 support two overlay plane and one hwc plane, max output
resolution is 1080p. it support IOMMU, and its IOMMU same as
rk3288's.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  296 +++++++++++++++++----------
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  243 +++++++++++++---------
 2 files changed, 336 insertions(+), 203 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 6495114..3166b46 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -25,7 +25,7 @@
 		 .mask = _mask, \
 		 .shift = s,}
 
-static const uint32_t formats_01[] = {
+static const uint32_t formats_win_full[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XBGR8888,
@@ -39,7 +39,7 @@ static const uint32_t formats_01[] = {
 	DRM_FORMAT_NV24,
 };
 
-static const uint32_t formats_234[] = {
+static const uint32_t formats_win_lite[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XBGR8888,
@@ -50,102 +50,103 @@ static const uint32_t formats_234[] = {
 	DRM_FORMAT_BGR565,
 };
 
-static const struct vop_scl_extension win_full_ext = {
-	.cbcr_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 31),
-	.cbcr_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 30),
-	.cbcr_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 28),
-	.cbcr_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 26),
-	.cbcr_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 24),
-	.yrgb_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 23),
-	.yrgb_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 22),
-	.yrgb_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 20),
-	.yrgb_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 18),
-	.yrgb_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 16),
-	.line_load_mode = VOP_REG(WIN0_CTRL1, 0x1, 15),
-	.cbcr_axi_gather_num = VOP_REG(WIN0_CTRL1, 0x7, 12),
-	.yrgb_axi_gather_num = VOP_REG(WIN0_CTRL1, 0xf, 8),
-	.vsd_cbcr_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 7),
-	.vsd_cbcr_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 6),
-	.vsd_yrgb_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 5),
-	.vsd_yrgb_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 4),
-	.bic_coe_sel = VOP_REG(WIN0_CTRL1, 0x3, 2),
-	.cbcr_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 1),
-	.yrgb_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 0),
-	.lb_mode = VOP_REG(WIN0_CTRL0, 0x7, 5),
-};
-
-static const struct vop_scl_regs win_full_scl = {
-	.scale_yrgb_x = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
-	.scale_yrgb_y = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
-	.scale_cbcr_x = VOP_REG(WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
-	.scale_cbcr_y = VOP_REG(WIN0_SCL_FACTOR_CBR, 0xffff, 16),
-};
-
-static const struct vop_win_phy win01_data = {
-	.scl = &win_full_scl,
-	.data_formats = formats_01,
-	.nformats = ARRAY_SIZE(formats_01),
-	.enable = VOP_REG(WIN0_CTRL0, 0x1, 0),
-	.format = VOP_REG(WIN0_CTRL0, 0x7, 1),
-	.rb_swap = VOP_REG(WIN0_CTRL0, 0x1, 12),
-	.act_info = VOP_REG(WIN0_ACT_INFO, 0x1fff1fff, 0),
-	.dsp_info = VOP_REG(WIN0_DSP_INFO, 0x0fff0fff, 0),
-	.dsp_st = VOP_REG(WIN0_DSP_ST, 0x1fff1fff, 0),
-	.yrgb_mst = VOP_REG(WIN0_YRGB_MST, 0xffffffff, 0),
-	.uv_mst = VOP_REG(WIN0_CBR_MST, 0xffffffff, 0),
-	.yrgb_vir = VOP_REG(WIN0_VIR, 0x3fff, 0),
-	.uv_vir = VOP_REG(WIN0_VIR, 0x3fff, 16),
-	.src_alpha_ctl = VOP_REG(WIN0_SRC_ALPHA_CTRL, 0xff, 0),
-	.dst_alpha_ctl = VOP_REG(WIN0_DST_ALPHA_CTRL, 0xff, 0),
-};
-
-static const struct vop_win_phy win23_data = {
-	.data_formats = formats_234,
-	.nformats = ARRAY_SIZE(formats_234),
-	.enable = VOP_REG(WIN2_CTRL0, 0x1, 0),
-	.format = VOP_REG(WIN2_CTRL0, 0x7, 1),
-	.rb_swap = VOP_REG(WIN2_CTRL0, 0x1, 12),
-	.dsp_info = VOP_REG(WIN2_DSP_INFO0, 0x0fff0fff, 0),
-	.dsp_st = VOP_REG(WIN2_DSP_ST0, 0x1fff1fff, 0),
-	.yrgb_mst = VOP_REG(WIN2_MST0, 0xffffffff, 0),
-	.yrgb_vir = VOP_REG(WIN2_VIR0_1, 0x1fff, 0),
-	.src_alpha_ctl = VOP_REG(WIN2_SRC_ALPHA_CTRL, 0xff, 0),
-	.dst_alpha_ctl = VOP_REG(WIN2_DST_ALPHA_CTRL, 0xff, 0),
-};
-
-static const struct vop_ctrl ctrl_data = {
-	.standby = VOP_REG(SYS_CTRL, 0x1, 22),
-	.gate_en = VOP_REG(SYS_CTRL, 0x1, 23),
-	.mmu_en = VOP_REG(SYS_CTRL, 0x1, 20),
-	.rgb_en = VOP_REG(SYS_CTRL, 0x1, 12),
-	.hdmi_en = VOP_REG(SYS_CTRL, 0x1, 13),
-	.edp_en = VOP_REG(SYS_CTRL, 0x1, 14),
-	.mipi_en = VOP_REG(SYS_CTRL, 0x1, 15),
-	.dither_down = VOP_REG(DSP_CTRL1, 0xf, 1),
-	.dither_up = VOP_REG(DSP_CTRL1, 0x1, 6),
-	.data_blank = VOP_REG(DSP_CTRL0, 0x1, 19),
-	.out_mode = VOP_REG(DSP_CTRL0, 0xf, 0),
-	.pin_pol = VOP_REG(DSP_CTRL0, 0xf, 4),
-	.htotal_pw = VOP_REG(DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
-	.hact_st_end = VOP_REG(DSP_HACT_ST_END, 0x1fff1fff, 0),
-	.vtotal_pw = VOP_REG(DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
-	.vact_st_end = VOP_REG(DSP_VACT_ST_END, 0x1fff1fff, 0),
-	.hpost_st_end = VOP_REG(POST_DSP_HACT_INFO, 0x1fff1fff, 0),
-	.vpost_st_end = VOP_REG(POST_DSP_VACT_INFO, 0x1fff1fff, 0),
-	.cfg_done = VOP_REG(REG_CFG_DONE, 0x1, 0),
-};
-
-static const struct vop_reg_data vop_init_reg_table[] = {
-	{SYS_CTRL, 0x00c00000},
-	{DSP_CTRL0, 0x00000000},
-	{WIN0_CTRL0, 0x00000080},
-	{WIN1_CTRL0, 0x00000080},
+static const struct vop_scl_extension rk3288_win_full_scl_ext = {
+	.cbcr_vsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 31),
+	.cbcr_vsu_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 30),
+	.cbcr_hsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 28),
+	.cbcr_ver_scl_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 26),
+	.cbcr_hor_scl_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 24),
+	.yrgb_vsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 23),
+	.yrgb_vsu_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 22),
+	.yrgb_hsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 20),
+	.yrgb_ver_scl_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 18),
+	.yrgb_hor_scl_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 16),
+	.line_load_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 15),
+	.cbcr_axi_gather_num = VOP_REG(RK3288_WIN0_CTRL1, 0x7, 12),
+	.yrgb_axi_gather_num = VOP_REG(RK3288_WIN0_CTRL1, 0xf, 8),
+	.vsd_cbcr_gt2 = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 7),
+	.vsd_cbcr_gt4 = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 6),
+	.vsd_yrgb_gt2 = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 5),
+	.vsd_yrgb_gt4 = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 4),
+	.bic_coe_sel = VOP_REG(RK3288_WIN0_CTRL1, 0x3, 2),
+	.cbcr_axi_gather_en = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 1),
+	.yrgb_axi_gather_en = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 0),
+	.lb_mode = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 5),
+};
+
+static const struct vop_scl_regs rk3288_win_full_scl = {
+	.ext = &rk3288_win_full_scl_ext,
+	.scale_yrgb_x = VOP_REG(RK3288_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3288_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(RK3288_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(RK3288_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy rk3288_win01_data = {
+	.scl = &rk3288_win_full_scl,
+	.data_formats = formats_win_full,
+	.nformats = ARRAY_SIZE(formats_win_full),
+	.enable = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3288_WIN0_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(RK3288_WIN0_CTRL0, 0x1, 12),
+	.act_info = VOP_REG(RK3288_WIN0_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(RK3288_WIN0_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN0_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN0_YRGB_MST, 0xffffffff, 0),
+	.uv_mst = VOP_REG(RK3288_WIN0_CBR_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN0_VIR, 0x3fff, 0),
+	.uv_vir = VOP_REG(RK3288_WIN0_VIR, 0x3fff, 16),
+	.src_alpha_ctl = VOP_REG(RK3288_WIN0_SRC_ALPHA_CTRL, 0xff, 0),
+	.dst_alpha_ctl = VOP_REG(RK3288_WIN0_DST_ALPHA_CTRL, 0xff, 0),
+};
+
+static const struct vop_win_phy rk3288_win23_data = {
+	.data_formats = formats_win_lite,
+	.nformats = ARRAY_SIZE(formats_win_lite),
+	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 0),
+	.format = VOP_REG(RK3288_WIN2_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 12),
+	.dsp_info = VOP_REG(RK3288_WIN2_DSP_INFO0, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN2_DSP_ST0, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN2_MST0, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN2_VIR0_1, 0x1fff, 0),
+	.src_alpha_ctl = VOP_REG(RK3288_WIN2_SRC_ALPHA_CTRL, 0xff, 0),
+	.dst_alpha_ctl = VOP_REG(RK3288_WIN2_DST_ALPHA_CTRL, 0xff, 0),
+};
+
+static const struct vop_ctrl rk3288_ctrl_data = {
+	.standby = VOP_REG(RK3288_SYS_CTRL, 0x1, 22),
+	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
+	.mmu_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 20),
+	.rgb_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 12),
+	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
+	.edp_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 14),
+	.mipi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 15),
+	.dither_down = VOP_REG(RK3288_DSP_CTRL1, 0xf, 1),
+	.dither_up = VOP_REG(RK3288_DSP_CTRL1, 0x1, 6),
+	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
+	.out_mode = VOP_REG(RK3288_DSP_CTRL0, 0xf, 0),
+	.pin_pol = VOP_REG(RK3288_DSP_CTRL0, 0xf, 4),
+	.htotal_pw = VOP_REG(RK3288_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
+	.hact_st_end = VOP_REG(RK3288_DSP_HACT_ST_END, 0x1fff1fff, 0),
+	.vtotal_pw = VOP_REG(RK3288_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
+	.vact_st_end = VOP_REG(RK3288_DSP_VACT_ST_END, 0x1fff1fff, 0),
+	.hpost_st_end = VOP_REG(RK3288_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
+	.vpost_st_end = VOP_REG(RK3288_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
+	.cfg_done = VOP_REG(RK3288_REG_CFG_DONE, 0x1, 0),
+};
+
+static const struct vop_reg_data rk3288_init_reg_table[] = {
+	{RK3288_SYS_CTRL, 0x00c00000},
+	{RK3288_DSP_CTRL0, 0x00000000},
+	{RK3288_WIN0_CTRL0, 0x00000080},
+	{RK3288_WIN1_CTRL0, 0x00000080},
 	/* TODO: Win2/3 support multiple area function, but we haven't found
 	 * a suitable way to use it yet, so let's just use them as other windows
 	 * with only area 0 enabled.
 	 */
-	{WIN2_CTRL0, 0x00000010},
-	{WIN3_CTRL0, 0x00000010},
+	{RK3288_WIN2_CTRL0, 0x00000010},
+	{RK3288_WIN3_CTRL0, 0x00000010},
 };
 
 /*
@@ -155,10 +156,14 @@ static const struct vop_reg_data vop_init_reg_table[] = {
  *
  */
 static const struct vop_win_data rk3288_vop_win_data[] = {
-	{ .base = 0x00, .phy = &win01_data, .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x00, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR },
+	{ .base = 0x00, .phy = &rk3288_win01_data,
+	  .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x40, .phy = &rk3288_win01_data,
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &rk3288_win23_data,
+	  .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x50, .phy = &rk3288_win23_data,
+	  .type = DRM_PLANE_TYPE_CURSOR },
 };
 
 static const int rk3288_vop_intrs[] = {
@@ -171,23 +176,106 @@ static const int rk3288_vop_intrs[] = {
 static const struct vop_intr rk3288_vop_intr = {
 	.intrs = rk3288_vop_intrs,
 	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
-	.status = VOP_REG(INTR_CTRL0, 0xf, 0),
-	.enable = VOP_REG(INTR_CTRL0, 0xf, 4),
-	.clear = VOP_REG(INTR_CTRL0, 0xf, 8),
+	.status = VOP_REG(RK3288_INTR_CTRL0, 0xf, 0),
+	.enable = VOP_REG(RK3288_INTR_CTRL0, 0xf, 4),
+	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
 };
 
 static const struct vop_data rk3288_vop = {
-	.init_table = vop_init_reg_table,
+	.init_table = rk3288_init_reg_table,
+	.table_size = ARRAY_SIZE(rk3288_init_reg_table),
 	.intr = &rk3288_vop_intr,
-	.table_size = ARRAY_SIZE(vop_init_reg_table),
-	.ctrl = &ctrl_data,
+	.ctrl = &rk3288_ctrl_data,
 	.win = rk3288_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
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
 static const struct of_device_id vop_driver_dt_match[] = {
 	{ .compatible = "rockchip,rk3288-vop",
 	  .data = &rk3288_vop },
+	{ .compatible = "rockchip,rk3036-vop",
+	  .data = &rk3036_vop },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index b0fa35d..d4b46cb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -15,110 +15,155 @@
 #ifndef _ROCKCHIP_VOP_REG_H
 #define _ROCKCHIP_VOP_REG_H
 
-/* register definition */
-#define REG_CFG_DONE			0x0000
-#define VERSION_INFO			0x0004
-#define SYS_CTRL				0x0008
-#define SYS_CTRL1			0x000c
-#define DSP_CTRL0			0x0010
-#define DSP_CTRL1			0x0014
-#define DSP_BG				0x0018
-#define MCU_CTRL				0x001c
-#define INTR_CTRL0			0x0020
-#define INTR_CTRL1			0x0024
-#define WIN0_CTRL0			0x0030
-#define WIN0_CTRL1			0x0034
-#define WIN0_COLOR_KEY			0x0038
-#define WIN0_VIR				0x003c
-#define WIN0_YRGB_MST			0x0040
-#define WIN0_CBR_MST			0x0044
-#define WIN0_ACT_INFO			0x0048
-#define WIN0_DSP_INFO			0x004c
-#define WIN0_DSP_ST			0x0050
-#define WIN0_SCL_FACTOR_YRGB		0x0054
-#define WIN0_SCL_FACTOR_CBR		0x0058
-#define WIN0_SCL_OFFSET			0x005c
-#define WIN0_SRC_ALPHA_CTRL		0x0060
-#define WIN0_DST_ALPHA_CTRL		0x0064
-#define WIN0_FADING_CTRL			0x0068
+/* rk3288 register definition */
+#define RK3288_REG_CFG_DONE			0x0000
+#define RK3288_VERSION_INFO			0x0004
+#define RK3288_SYS_CTRL				0x0008
+#define RK3288_SYS_CTRL1			0x000c
+#define RK3288_DSP_CTRL0			0x0010
+#define RK3288_DSP_CTRL1			0x0014
+#define RK3288_DSP_BG				0x0018
+#define RK3288_MCU_CTRL				0x001c
+#define RK3288_INTR_CTRL0			0x0020
+#define RK3288_INTR_CTRL1			0x0024
+#define RK3288_WIN0_CTRL0			0x0030
+#define RK3288_WIN0_CTRL1			0x0034
+#define RK3288_WIN0_COLOR_KEY			0x0038
+#define RK3288_WIN0_VIR				0x003c
+#define RK3288_WIN0_YRGB_MST			0x0040
+#define RK3288_WIN0_CBR_MST			0x0044
+#define RK3288_WIN0_ACT_INFO			0x0048
+#define RK3288_WIN0_DSP_INFO			0x004c
+#define RK3288_WIN0_DSP_ST			0x0050
+#define RK3288_WIN0_SCL_FACTOR_YRGB		0x0054
+#define RK3288_WIN0_SCL_FACTOR_CBR		0x0058
+#define RK3288_WIN0_SCL_OFFSET			0x005c
+#define RK3288_WIN0_SRC_ALPHA_CTRL		0x0060
+#define RK3288_WIN0_DST_ALPHA_CTRL		0x0064
+#define RK3288_WIN0_FADING_CTRL			0x0068
+
 /* win1 register */
-#define WIN1_CTRL0			0x0070
-#define WIN1_CTRL1			0x0074
-#define WIN1_COLOR_KEY			0x0078
-#define WIN1_VIR				0x007c
-#define WIN1_YRGB_MST			0x0080
-#define WIN1_CBR_MST			0x0084
-#define WIN1_ACT_INFO			0x0088
-#define WIN1_DSP_INFO			0x008c
-#define WIN1_DSP_ST			0x0090
-#define WIN1_SCL_FACTOR_YRGB		0x0094
-#define WIN1_SCL_FACTOR_CBR		0x0098
-#define WIN1_SCL_OFFSET			0x009c
-#define WIN1_SRC_ALPHA_CTRL		0x00a0
-#define WIN1_DST_ALPHA_CTRL		0x00a4
-#define WIN1_FADING_CTRL			0x00a8
+#define RK3288_WIN1_CTRL0			0x0070
+#define RK3288_WIN1_CTRL1			0x0074
+#define RK3288_WIN1_COLOR_KEY			0x0078
+#define RK3288_WIN1_VIR				0x007c
+#define RK3288_WIN1_YRGB_MST			0x0080
+#define RK3288_WIN1_CBR_MST			0x0084
+#define RK3288_WIN1_ACT_INFO			0x0088
+#define RK3288_WIN1_DSP_INFO			0x008c
+#define RK3288_WIN1_DSP_ST			0x0090
+#define RK3288_WIN1_SCL_FACTOR_YRGB		0x0094
+#define RK3288_WIN1_SCL_FACTOR_CBR		0x0098
+#define RK3288_WIN1_SCL_OFFSET			0x009c
+#define RK3288_WIN1_SRC_ALPHA_CTRL		0x00a0
+#define RK3288_WIN1_DST_ALPHA_CTRL		0x00a4
+#define RK3288_WIN1_FADING_CTRL			0x00a8
 /* win2 register */
-#define WIN2_CTRL0			0x00b0
-#define WIN2_CTRL1			0x00b4
-#define WIN2_VIR0_1			0x00b8
-#define WIN2_VIR2_3			0x00bc
-#define WIN2_MST0			0x00c0
-#define WIN2_DSP_INFO0			0x00c4
-#define WIN2_DSP_ST0			0x00c8
-#define WIN2_COLOR_KEY			0x00cc
-#define WIN2_MST1			0x00d0
-#define WIN2_DSP_INFO1			0x00d4
-#define WIN2_DSP_ST1			0x00d8
-#define WIN2_SRC_ALPHA_CTRL		0x00dc
-#define WIN2_MST2			0x00e0
-#define WIN2_DSP_INFO2			0x00e4
-#define WIN2_DSP_ST2			0x00e8
-#define WIN2_DST_ALPHA_CTRL		0x00ec
-#define WIN2_MST3			0x00f0
-#define WIN2_DSP_INFO3			0x00f4
-#define WIN2_DSP_ST3			0x00f8
-#define WIN2_FADING_CTRL			0x00fc
+#define RK3288_WIN2_CTRL0			0x00b0
+#define RK3288_WIN2_CTRL1			0x00b4
+#define RK3288_WIN2_VIR0_1			0x00b8
+#define RK3288_WIN2_VIR2_3			0x00bc
+#define RK3288_WIN2_MST0			0x00c0
+#define RK3288_WIN2_DSP_INFO0			0x00c4
+#define RK3288_WIN2_DSP_ST0			0x00c8
+#define RK3288_WIN2_COLOR_KEY			0x00cc
+#define RK3288_WIN2_MST1			0x00d0
+#define RK3288_WIN2_DSP_INFO1			0x00d4
+#define RK3288_WIN2_DSP_ST1			0x00d8
+#define RK3288_WIN2_SRC_ALPHA_CTRL		0x00dc
+#define RK3288_WIN2_MST2			0x00e0
+#define RK3288_WIN2_DSP_INFO2			0x00e4
+#define RK3288_WIN2_DSP_ST2			0x00e8
+#define RK3288_WIN2_DST_ALPHA_CTRL		0x00ec
+#define RK3288_WIN2_MST3			0x00f0
+#define RK3288_WIN2_DSP_INFO3			0x00f4
+#define RK3288_WIN2_DSP_ST3			0x00f8
+#define RK3288_WIN2_FADING_CTRL			0x00fc
 /* win3 register */
-#define WIN3_CTRL0			0x0100
-#define WIN3_CTRL1			0x0104
-#define WIN3_VIR0_1			0x0108
-#define WIN3_VIR2_3			0x010c
-#define WIN3_MST0			0x0110
-#define WIN3_DSP_INFO0			0x0114
-#define WIN3_DSP_ST0			0x0118
-#define WIN3_COLOR_KEY			0x011c
-#define WIN3_MST1			0x0120
-#define WIN3_DSP_INFO1			0x0124
-#define WIN3_DSP_ST1			0x0128
-#define WIN3_SRC_ALPHA_CTRL		0x012c
-#define WIN3_MST2			0x0130
-#define WIN3_DSP_INFO2			0x0134
-#define WIN3_DSP_ST2			0x0138
-#define WIN3_DST_ALPHA_CTRL		0x013c
-#define WIN3_MST3			0x0140
-#define WIN3_DSP_INFO3			0x0144
-#define WIN3_DSP_ST3			0x0148
-#define WIN3_FADING_CTRL			0x014c
+#define RK3288_WIN3_CTRL0			0x0100
+#define RK3288_WIN3_CTRL1			0x0104
+#define RK3288_WIN3_VIR0_1			0x0108
+#define RK3288_WIN3_VIR2_3			0x010c
+#define RK3288_WIN3_MST0			0x0110
+#define RK3288_WIN3_DSP_INFO0			0x0114
+#define RK3288_WIN3_DSP_ST0			0x0118
+#define RK3288_WIN3_COLOR_KEY			0x011c
+#define RK3288_WIN3_MST1			0x0120
+#define RK3288_WIN3_DSP_INFO1			0x0124
+#define RK3288_WIN3_DSP_ST1			0x0128
+#define RK3288_WIN3_SRC_ALPHA_CTRL		0x012c
+#define RK3288_WIN3_MST2			0x0130
+#define RK3288_WIN3_DSP_INFO2			0x0134
+#define RK3288_WIN3_DSP_ST2			0x0138
+#define RK3288_WIN3_DST_ALPHA_CTRL		0x013c
+#define RK3288_WIN3_MST3			0x0140
+#define RK3288_WIN3_DSP_INFO3			0x0144
+#define RK3288_WIN3_DSP_ST3			0x0148
+#define RK3288_WIN3_FADING_CTRL			0x014c
 /* hwc register */
-#define HWC_CTRL0			0x0150
-#define HWC_CTRL1			0x0154
-#define HWC_MST				0x0158
-#define HWC_DSP_ST			0x015c
-#define HWC_SRC_ALPHA_CTRL		0x0160
-#define HWC_DST_ALPHA_CTRL		0x0164
-#define HWC_FADING_CTRL			0x0168
+#define RK3288_HWC_CTRL0			0x0150
+#define RK3288_HWC_CTRL1			0x0154
+#define RK3288_HWC_MST				0x0158
+#define RK3288_HWC_DSP_ST			0x015c
+#define RK3288_HWC_SRC_ALPHA_CTRL		0x0160
+#define RK3288_HWC_DST_ALPHA_CTRL		0x0164
+#define RK3288_HWC_FADING_CTRL			0x0168
 /* post process register */
-#define POST_DSP_HACT_INFO		0x0170
-#define POST_DSP_VACT_INFO		0x0174
-#define POST_SCL_FACTOR_YRGB		0x0178
-#define POST_SCL_CTRL			0x0180
-#define POST_DSP_VACT_INFO_F1		0x0184
-#define DSP_HTOTAL_HS_END		0x0188
-#define DSP_HACT_ST_END			0x018c
-#define DSP_VTOTAL_VS_END		0x0190
-#define DSP_VACT_ST_END			0x0194
-#define DSP_VS_ST_END_F1			0x0198
-#define DSP_VACT_ST_END_F1		0x019c
+#define RK3288_POST_DSP_HACT_INFO		0x0170
+#define RK3288_POST_DSP_VACT_INFO		0x0174
+#define RK3288_POST_SCL_FACTOR_YRGB		0x0178
+#define RK3288_POST_SCL_CTRL			0x0180
+#define RK3288_POST_DSP_VACT_INFO_F1		0x0184
+#define RK3288_DSP_HTOTAL_HS_END		0x0188
+#define RK3288_DSP_HACT_ST_END			0x018c
+#define RK3288_DSP_VTOTAL_VS_END		0x0190
+#define RK3288_DSP_VACT_ST_END			0x0194
+#define RK3288_DSP_VS_ST_END_F1			0x0198
+#define RK3288_DSP_VACT_ST_END_F1		0x019c
 /* register definition end */
 
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
 #endif /* _ROCKCHIP_VOP_REG_H */
-- 
1.7.9.5
