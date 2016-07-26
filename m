From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 26 Jul 2016 15:46:34 +0800
Subject: [PATCH 3/3] drm/rockchip: vop: rk3288: add area plane
In-Reply-To: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
References: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1469519194-23133-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change-Id: Iac8fde019020d8f1a671d52c1a4d91ad2d050d43
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 52 ++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 919992c..0f53ebd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -103,7 +103,7 @@ static const struct vop_win_phy rk3288_win01_data = {
 static const struct vop_win_phy rk3288_win23_data = {
 	.data_formats = formats_win_lite,
 	.nformats = ARRAY_SIZE(formats_win_lite),
-	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 0),
+	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 4),
 	.format = VOP_REG(RK3288_WIN2_CTRL0, 0x7, 1),
 	.rb_swap = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 12),
 	.dsp_info = VOP_REG(RK3288_WIN2_DSP_INFO0, 0x0fff0fff, 0),
@@ -114,6 +114,36 @@ static const struct vop_win_phy rk3288_win23_data = {
 	.dst_alpha_ctl = VOP_REG(RK3288_WIN2_DST_ALPHA_CTRL, 0xff, 0),
 };
 
+static const struct vop_win_phy rk3288_area1_data = {
+	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 5),
+	.dsp_info = VOP_REG(RK3288_WIN2_DSP_INFO1, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN2_DSP_ST1, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN2_MST1, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN2_VIR0_1, 0x1fff, 16),
+};
+
+static const struct vop_win_phy rk3288_area2_data = {
+	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 6),
+	.dsp_info = VOP_REG(RK3288_WIN2_DSP_INFO2, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN2_DSP_ST2, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN2_MST2, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN2_VIR2_3, 0x1fff, 0),
+};
+
+static const struct vop_win_phy rk3288_area3_data = {
+	.enable = VOP_REG(RK3288_WIN2_CTRL0, 0x1, 7),
+	.dsp_info = VOP_REG(RK3288_WIN2_DSP_INFO3, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(RK3288_WIN2_DSP_ST3, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(RK3288_WIN2_MST3, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(RK3288_WIN2_VIR2_3, 0x1fff, 16),
+};
+
+static const struct vop_win_phy *rk3288_area_data[] = {
+	&rk3288_area1_data,
+	&rk3288_area2_data,
+	&rk3288_area3_data
+};
+
 static const struct vop_ctrl rk3288_ctrl_data = {
 	.standby = VOP_REG(RK3288_SYS_CTRL, 0x1, 22),
 	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
@@ -141,12 +171,14 @@ static const struct vop_reg_data rk3288_init_reg_table[] = {
 	{RK3288_DSP_CTRL0, 0x00000000},
 	{RK3288_WIN0_CTRL0, 0x00000080},
 	{RK3288_WIN1_CTRL0, 0x00000080},
-	/* TODO: Win2/3 support multiple area function, but we haven't found
-	 * a suitable way to use it yet, so let's just use them as other windows
-	 * with only area 0 enabled.
+	/*
+	 * Bit[0] is win2/3 gate en bit, there is no power consume with this
+	 * bit enable. the bit's function similar with area plane enable bit,
+	 * So default enable this bit, then We can control win2/3 area plane
+	 * with its enable bit.
 	 */
-	{RK3288_WIN2_CTRL0, 0x00000010},
-	{RK3288_WIN3_CTRL0, 0x00000010},
+	{RK3288_WIN2_CTRL0, 0x00000001},
+	{RK3288_WIN3_CTRL0, 0x00000001},
 };
 
 /*
@@ -161,9 +193,13 @@ static const struct vop_win_data rk3288_vop_win_data[] = {
 	{ .base = 0x40, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_OVERLAY },
 	{ .base = 0x00, .phy = &rk3288_win23_data,
-	  .type = DRM_PLANE_TYPE_OVERLAY },
+	  .type = DRM_PLANE_TYPE_OVERLAY,
+	  .area = rk3288_area_data,
+	  .area_size = ARRAY_SIZE(rk3288_area_data), },
 	{ .base = 0x50, .phy = &rk3288_win23_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_CURSOR,
+	  .area = rk3288_area_data,
+	  .area_size = ARRAY_SIZE(rk3288_area_data), },
 };
 
 static const int rk3288_vop_intrs[] = {
-- 
1.9.1
