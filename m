From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:37:03 +0800
Subject: [PATCH 3/6] drm/rockchip: vop: spilt register related into
 rockchip_reg_vop.c
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323426-32109-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional updates. Spilt register related into another file
would be nice to multi vop driver,

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/Makefile           |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  325 +--------------------------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  220 +++++++++---------
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  225 +++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  124 ++++++++++
 5 files changed, 468 insertions(+), 429 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_vop_reg.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_vop_reg.h

diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index f3d8a19..a9d380f 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -7,4 +7,5 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o rockchip_drm_fbdev.o \
 
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 
-obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o
+obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o \
+				rockchip_vop_reg.o
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7674bdc..bbb781c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -36,11 +36,6 @@
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_vop.h"
 
-#define VOP_REG(off, _mask, s) \
-		{.offset = off, \
-		 .mask = _mask, \
-		 .shift = s,}
-
 #define __REG_SET_RELAXED(x, off, mask, shift, v) \
 		vop_mask_write_relaxed(x, off, (mask) << shift, (v) << shift)
 #define __REG_SET_NORMAL(x, off, mask, shift, v) \
@@ -143,285 +138,6 @@ struct vop {
 	struct vop_win win[];
 };
 
-enum vop_data_format {
-	VOP_FMT_ARGB8888 = 0,
-	VOP_FMT_RGB888,
-	VOP_FMT_RGB565,
-	VOP_FMT_YUV420SP = 4,
-	VOP_FMT_YUV422SP,
-	VOP_FMT_YUV444SP,
-};
-
-struct vop_reg_data {
-	uint32_t offset;
-	uint32_t value;
-};
-
-struct vop_reg {
-	uint32_t offset;
-	uint32_t shift;
-	uint32_t mask;
-};
-
-struct vop_ctrl {
-	struct vop_reg standby;
-	struct vop_reg data_blank;
-	struct vop_reg gate_en;
-	struct vop_reg mmu_en;
-	struct vop_reg rgb_en;
-	struct vop_reg edp_en;
-	struct vop_reg hdmi_en;
-	struct vop_reg mipi_en;
-	struct vop_reg out_mode;
-	struct vop_reg dither_down;
-	struct vop_reg dither_up;
-	struct vop_reg pin_pol;
-
-	struct vop_reg htotal_pw;
-	struct vop_reg hact_st_end;
-	struct vop_reg vtotal_pw;
-	struct vop_reg vact_st_end;
-	struct vop_reg hpost_st_end;
-	struct vop_reg vpost_st_end;
-
-	struct vop_reg cfg_done;
-};
-
-struct vop_intr {
-	const int *intrs;
-	uint32_t nintrs;
-	struct vop_reg enable;
-	struct vop_reg clear;
-	struct vop_reg status;
-};
-struct vop_scl_regs {
-	struct vop_reg cbcr_vsd_mode;
-	struct vop_reg cbcr_vsu_mode;
-	struct vop_reg cbcr_hsd_mode;
-	struct vop_reg cbcr_ver_scl_mode;
-	struct vop_reg cbcr_hor_scl_mode;
-	struct vop_reg yrgb_vsd_mode;
-	struct vop_reg yrgb_vsu_mode;
-	struct vop_reg yrgb_hsd_mode;
-	struct vop_reg yrgb_ver_scl_mode;
-	struct vop_reg yrgb_hor_scl_mode;
-	struct vop_reg line_load_mode;
-	struct vop_reg cbcr_axi_gather_num;
-	struct vop_reg yrgb_axi_gather_num;
-	struct vop_reg vsd_cbcr_gt2;
-	struct vop_reg vsd_cbcr_gt4;
-	struct vop_reg vsd_yrgb_gt2;
-	struct vop_reg vsd_yrgb_gt4;
-	struct vop_reg bic_coe_sel;
-	struct vop_reg cbcr_axi_gather_en;
-	struct vop_reg yrgb_axi_gather_en;
-
-	struct vop_reg lb_mode;
-	struct vop_reg scale_yrgb_x;
-	struct vop_reg scale_yrgb_y;
-	struct vop_reg scale_cbcr_x;
-	struct vop_reg scale_cbcr_y;
-};
-
-struct vop_win_phy {
-	const struct vop_scl_regs *scl;
-	const uint32_t *data_formats;
-	uint32_t nformats;
-
-	struct vop_reg enable;
-	struct vop_reg format;
-	struct vop_reg rb_swap;
-	struct vop_reg act_info;
-	struct vop_reg dsp_info;
-	struct vop_reg dsp_st;
-	struct vop_reg yrgb_mst;
-	struct vop_reg uv_mst;
-	struct vop_reg yrgb_vir;
-	struct vop_reg uv_vir;
-
-	struct vop_reg dst_alpha_ctl;
-	struct vop_reg src_alpha_ctl;
-};
-
-struct vop_win_data {
-	uint32_t base;
-	const struct vop_win_phy *phy;
-	enum drm_plane_type type;
-};
-
-struct vop_data {
-	const struct vop_reg_data *init_table;
-	unsigned int table_size;
-	const struct vop_ctrl *ctrl;
-	const struct vop_intr *intr;
-	const struct vop_win_data *win;
-	unsigned int win_size;
-};
-
-static const uint32_t formats_01[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_NV12,
-	DRM_FORMAT_NV16,
-	DRM_FORMAT_NV24,
-};
-
-static const uint32_t formats_234[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-};
-
-static const struct vop_scl_regs win_full_scl = {
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
-	/* TODO: Win2/3 support multiple area function, but we haven't found
-	 * a suitable way to use it yet, so let's just use them as other windows
-	 * with only area 0 enabled.
-	 */
-	{WIN2_CTRL0, 0x00000010},
-	{WIN3_CTRL0, 0x00000010},
-};
-
-/*
- * Note: rk3288 has a dedicated 'cursor' window, however, that window requires
- * special support to get alpha blending working.  For now, just use overlay
- * window 3 for the drm cursor.
- *
- */
-static const struct vop_win_data rk3288_vop_win_data[] = {
-	{ .base = 0x00, .phy = &win01_data, .type = DRM_PLANE_TYPE_PRIMARY },
-	{ .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x00, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY },
-	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR },
-};
-
-static const int rk3288_vop_intrs[] = {
-	DSP_HOLD_VALID_INTR,
-	FS_INTR,
-	LINE_FLAG_INTR,
-	BUS_ERROR_INTR,
-};
-
-static const struct vop_intr rk3288_vop_intr = {
-	.intrs = rk3288_vop_intrs,
-	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
-	.status = VOP_REG(INTR_CTRL0, 0xf, 0),
-	.enable = VOP_REG(INTR_CTRL0, 0xf, 4),
-	.clear = VOP_REG(INTR_CTRL0, 0xf, 8),
-};
-
-static const struct vop_data rk3288_vop = {
-	.init_table = vop_init_reg_table,
-	.intr = &rk3288_vop_intr,
-	.table_size = ARRAY_SIZE(vop_init_reg_table),
-	.ctrl = &ctrl_data,
-	.win = rk3288_vop_win_data,
-	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
-};
-
-static const struct of_device_id vop_driver_dt_match[] = {
-	{ .compatible = "rockchip,rk3288-vop",
-	  .data = &rk3288_vop },
-	{},
-};
-MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
-
 static inline void vop_writel(struct vop *vop, uint32_t offset, uint32_t v)
 {
 	writel(v, vop->regs + offset);
@@ -1583,7 +1299,6 @@ static void vop_win_init(struct vop *vop)
 static int vop_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	const struct of_device_id *of_id;
 	const struct vop_data *vop_data;
 	struct drm_device *drm_dev = data;
 	struct vop *vop;
@@ -1591,8 +1306,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	size_t alloc_size;
 	int ret, irq;
 
-	of_id = of_match_device(vop_driver_dt_match, dev);
-	vop_data = of_id->data;
+	vop_data = of_device_get_match_data(dev);
 	if (!vop_data)
 		return -ENODEV;
 
@@ -1661,42 +1375,7 @@ static void vop_unbind(struct device *dev, struct device *master, void *data)
 	vop_destroy_crtc(vop);
 }
 
-static const struct component_ops vop_component_ops = {
+const struct component_ops vop_component_ops = {
 	.bind = vop_bind,
 	.unbind = vop_unbind,
 };
-
-static int vop_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	if (!dev->of_node) {
-		dev_err(dev, "can't find vop devices\n");
-		return -ENODEV;
-	}
-
-	return component_add(dev, &vop_component_ops);
-}
-
-static int vop_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &vop_component_ops);
-
-	return 0;
-}
-
-struct platform_driver vop_platform_driver = {
-	.probe = vop_probe,
-	.remove = vop_remove,
-	.driver = {
-		.name = "rockchip-vop",
-		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(vop_driver_dt_match),
-	},
-};
-
-module_platform_driver(vop_platform_driver);
-
-MODULE_AUTHOR("Mark Yao <mark.yao@rock-chips.com>");
-MODULE_DESCRIPTION("ROCKCHIP VOP Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index a2d4ddb..cbb114a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -15,111 +15,120 @@
 #ifndef _ROCKCHIP_DRM_VOP_H
 #define _ROCKCHIP_DRM_VOP_H
 
-/* register definition */
-#define REG_CFG_DONE			0x0000
-#define VERSION_INFO			0x0004
-#define SYS_CTRL			0x0008
-#define SYS_CTRL1			0x000c
-#define DSP_CTRL0			0x0010
-#define DSP_CTRL1			0x0014
-#define DSP_BG				0x0018
-#define MCU_CTRL			0x001c
-#define INTR_CTRL0			0x0020
-#define INTR_CTRL1			0x0024
-#define WIN0_CTRL0			0x0030
-#define WIN0_CTRL1			0x0034
-#define WIN0_COLOR_KEY			0x0038
-#define WIN0_VIR			0x003c
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
-#define WIN0_FADING_CTRL		0x0068
-/* win1 register */
-#define WIN1_CTRL0			0x0070
-#define WIN1_CTRL1			0x0074
-#define WIN1_COLOR_KEY			0x0078
-#define WIN1_VIR			0x007c
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
-#define WIN1_FADING_CTRL		0x00a8
-/* win2 register */
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
-#define WIN2_FADING_CTRL		0x00fc
-/* win3 register */
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
-#define WIN3_FADING_CTRL		0x014c
-/* hwc register */
-#define HWC_CTRL0			0x0150
-#define HWC_CTRL1			0x0154
-#define HWC_MST				0x0158
-#define HWC_DSP_ST			0x015c
-#define HWC_SRC_ALPHA_CTRL		0x0160
-#define HWC_DST_ALPHA_CTRL		0x0164
-#define HWC_FADING_CTRL			0x0168
-/* post process register */
-#define POST_DSP_HACT_INFO		0x0170
-#define POST_DSP_VACT_INFO		0x0174
-#define POST_SCL_FACTOR_YRGB		0x0178
-#define POST_SCL_CTRL			0x0180
-#define POST_DSP_VACT_INFO_F1		0x0184
-#define DSP_HTOTAL_HS_END		0x0188
-#define DSP_HACT_ST_END			0x018c
-#define DSP_VTOTAL_VS_END		0x0190
-#define DSP_VACT_ST_END			0x0194
-#define DSP_VS_ST_END_F1		0x0198
-#define DSP_VACT_ST_END_F1		0x019c
-/* register definition end */
+enum vop_data_format {
+	VOP_FMT_ARGB8888 = 0,
+	VOP_FMT_RGB888,
+	VOP_FMT_RGB565,
+	VOP_FMT_YUV420SP = 4,
+	VOP_FMT_YUV422SP,
+	VOP_FMT_YUV444SP,
+};
+
+struct vop_reg_data {
+	uint32_t offset;
+	uint32_t value;
+};
+
+struct vop_reg {
+	uint32_t offset;
+	uint32_t shift;
+	uint32_t mask;
+};
+
+struct vop_ctrl {
+	struct vop_reg standby;
+	struct vop_reg data_blank;
+	struct vop_reg gate_en;
+	struct vop_reg mmu_en;
+	struct vop_reg rgb_en;
+	struct vop_reg edp_en;
+	struct vop_reg hdmi_en;
+	struct vop_reg mipi_en;
+	struct vop_reg out_mode;
+	struct vop_reg dither_down;
+	struct vop_reg dither_up;
+	struct vop_reg pin_pol;
+
+	struct vop_reg htotal_pw;
+	struct vop_reg hact_st_end;
+	struct vop_reg vtotal_pw;
+	struct vop_reg vact_st_end;
+	struct vop_reg hpost_st_end;
+	struct vop_reg vpost_st_end;
+
+	struct vop_reg cfg_done;
+};
+
+struct vop_intr {
+	const int *intrs;
+	uint32_t nintrs;
+	struct vop_reg enable;
+	struct vop_reg clear;
+	struct vop_reg status;
+};
+struct vop_scl_regs {
+	struct vop_reg cbcr_vsd_mode;
+	struct vop_reg cbcr_vsu_mode;
+	struct vop_reg cbcr_hsd_mode;
+	struct vop_reg cbcr_ver_scl_mode;
+	struct vop_reg cbcr_hor_scl_mode;
+	struct vop_reg yrgb_vsd_mode;
+	struct vop_reg yrgb_vsu_mode;
+	struct vop_reg yrgb_hsd_mode;
+	struct vop_reg yrgb_ver_scl_mode;
+	struct vop_reg yrgb_hor_scl_mode;
+	struct vop_reg line_load_mode;
+	struct vop_reg cbcr_axi_gather_num;
+	struct vop_reg yrgb_axi_gather_num;
+	struct vop_reg vsd_cbcr_gt2;
+	struct vop_reg vsd_cbcr_gt4;
+	struct vop_reg vsd_yrgb_gt2;
+	struct vop_reg vsd_yrgb_gt4;
+	struct vop_reg bic_coe_sel;
+	struct vop_reg cbcr_axi_gather_en;
+	struct vop_reg yrgb_axi_gather_en;
+
+	struct vop_reg lb_mode;
+	struct vop_reg scale_yrgb_x;
+	struct vop_reg scale_yrgb_y;
+	struct vop_reg scale_cbcr_x;
+	struct vop_reg scale_cbcr_y;
+};
+
+struct vop_win_phy {
+	const struct vop_scl_regs *scl;
+	const uint32_t *data_formats;
+	uint32_t nformats;
+
+	struct vop_reg enable;
+	struct vop_reg format;
+	struct vop_reg rb_swap;
+	struct vop_reg act_info;
+	struct vop_reg dsp_info;
+	struct vop_reg dsp_st;
+	struct vop_reg yrgb_mst;
+	struct vop_reg uv_mst;
+	struct vop_reg yrgb_vir;
+	struct vop_reg uv_vir;
+
+	struct vop_reg dst_alpha_ctl;
+	struct vop_reg src_alpha_ctl;
+};
+
+struct vop_win_data {
+	uint32_t base;
+	const struct vop_win_phy *phy;
+	enum drm_plane_type type;
+};
+
+struct vop_data {
+	const struct vop_reg_data *init_table;
+	unsigned int table_size;
+	const struct vop_ctrl *ctrl;
+	const struct vop_intr *intr;
+	const struct vop_win_data *win;
+	unsigned int win_size;
+};
 
 /* interrupt define */
 #define DSP_HOLD_VALID_INTR		(1 << 0)
@@ -286,4 +295,5 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 	return lb_mode;
 }
 
+extern const struct component_ops vop_component_ops;
 #endif /* _ROCKCHIP_DRM_VOP_H */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
new file mode 100644
index 0000000..d47bfc3
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -0,0 +1,225 @@
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author:Mark Yao <mark.yao@rock-chips.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <drm/drmP.h>
+
+#include <linux/kernel.h>
+#include <linux/component.h>
+
+#include "rockchip_drm_vop.h"
+#include "rockchip_vop_reg.h"
+
+#define VOP_REG(off, _mask, s) \
+		{.offset = off, \
+		 .mask = _mask, \
+		 .shift = s,}
+
+static const uint32_t formats_01[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV24,
+};
+
+static const uint32_t formats_234[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+};
+
+static const struct vop_scl_regs win_full_scl = {
+	.cbcr_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 31),
+	.cbcr_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 30),
+	.cbcr_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 28),
+	.cbcr_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 26),
+	.cbcr_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 24),
+	.yrgb_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 23),
+	.yrgb_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 22),
+	.yrgb_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 20),
+	.yrgb_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 18),
+	.yrgb_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 16),
+	.line_load_mode = VOP_REG(WIN0_CTRL1, 0x1, 15),
+	.cbcr_axi_gather_num = VOP_REG(WIN0_CTRL1, 0x7, 12),
+	.yrgb_axi_gather_num = VOP_REG(WIN0_CTRL1, 0xf, 8),
+	.vsd_cbcr_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 7),
+	.vsd_cbcr_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 6),
+	.vsd_yrgb_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 5),
+	.vsd_yrgb_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 4),
+	.bic_coe_sel = VOP_REG(WIN0_CTRL1, 0x3, 2),
+	.cbcr_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 1),
+	.yrgb_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 0),
+	.lb_mode = VOP_REG(WIN0_CTRL0, 0x7, 5),
+	.scale_yrgb_x = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
+	.scale_cbcr_x = VOP_REG(WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
+	.scale_cbcr_y = VOP_REG(WIN0_SCL_FACTOR_CBR, 0xffff, 16),
+};
+
+static const struct vop_win_phy win01_data = {
+	.scl = &win_full_scl,
+	.data_formats = formats_01,
+	.nformats = ARRAY_SIZE(formats_01),
+	.enable = VOP_REG(WIN0_CTRL0, 0x1, 0),
+	.format = VOP_REG(WIN0_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(WIN0_CTRL0, 0x1, 12),
+	.act_info = VOP_REG(WIN0_ACT_INFO, 0x1fff1fff, 0),
+	.dsp_info = VOP_REG(WIN0_DSP_INFO, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(WIN0_DSP_ST, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(WIN0_YRGB_MST, 0xffffffff, 0),
+	.uv_mst = VOP_REG(WIN0_CBR_MST, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(WIN0_VIR, 0x3fff, 0),
+	.uv_vir = VOP_REG(WIN0_VIR, 0x3fff, 16),
+	.src_alpha_ctl = VOP_REG(WIN0_SRC_ALPHA_CTRL, 0xff, 0),
+	.dst_alpha_ctl = VOP_REG(WIN0_DST_ALPHA_CTRL, 0xff, 0),
+};
+
+static const struct vop_win_phy win23_data = {
+	.data_formats = formats_234,
+	.nformats = ARRAY_SIZE(formats_234),
+	.enable = VOP_REG(WIN2_CTRL0, 0x1, 0),
+	.format = VOP_REG(WIN2_CTRL0, 0x7, 1),
+	.rb_swap = VOP_REG(WIN2_CTRL0, 0x1, 12),
+	.dsp_info = VOP_REG(WIN2_DSP_INFO0, 0x0fff0fff, 0),
+	.dsp_st = VOP_REG(WIN2_DSP_ST0, 0x1fff1fff, 0),
+	.yrgb_mst = VOP_REG(WIN2_MST0, 0xffffffff, 0),
+	.yrgb_vir = VOP_REG(WIN2_VIR0_1, 0x1fff, 0),
+	.src_alpha_ctl = VOP_REG(WIN2_SRC_ALPHA_CTRL, 0xff, 0),
+	.dst_alpha_ctl = VOP_REG(WIN2_DST_ALPHA_CTRL, 0xff, 0),
+};
+
+static const struct vop_ctrl ctrl_data = {
+	.standby = VOP_REG(SYS_CTRL, 0x1, 22),
+	.gate_en = VOP_REG(SYS_CTRL, 0x1, 23),
+	.mmu_en = VOP_REG(SYS_CTRL, 0x1, 20),
+	.rgb_en = VOP_REG(SYS_CTRL, 0x1, 12),
+	.hdmi_en = VOP_REG(SYS_CTRL, 0x1, 13),
+	.edp_en = VOP_REG(SYS_CTRL, 0x1, 14),
+	.mipi_en = VOP_REG(SYS_CTRL, 0x1, 15),
+	.dither_down = VOP_REG(DSP_CTRL1, 0xf, 1),
+	.dither_up = VOP_REG(DSP_CTRL1, 0x1, 6),
+	.data_blank = VOP_REG(DSP_CTRL0, 0x1, 19),
+	.out_mode = VOP_REG(DSP_CTRL0, 0xf, 0),
+	.pin_pol = VOP_REG(DSP_CTRL0, 0xf, 4),
+	.htotal_pw = VOP_REG(DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
+	.hact_st_end = VOP_REG(DSP_HACT_ST_END, 0x1fff1fff, 0),
+	.vtotal_pw = VOP_REG(DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
+	.vact_st_end = VOP_REG(DSP_VACT_ST_END, 0x1fff1fff, 0),
+	.hpost_st_end = VOP_REG(POST_DSP_HACT_INFO, 0x1fff1fff, 0),
+	.vpost_st_end = VOP_REG(POST_DSP_VACT_INFO, 0x1fff1fff, 0),
+	.cfg_done = VOP_REG(REG_CFG_DONE, 0x1, 0),
+};
+
+static const struct vop_reg_data vop_init_reg_table[] = {
+	{SYS_CTRL, 0x00c00000},
+	{DSP_CTRL0, 0x00000000},
+	{WIN0_CTRL0, 0x00000080},
+	{WIN1_CTRL0, 0x00000080},
+	/* TODO: Win2/3 support multiple area function, but we haven't found
+	 * a suitable way to use it yet, so let's just use them as other windows
+	 * with only area 0 enabled.
+	 */
+	{WIN2_CTRL0, 0x00000010},
+	{WIN3_CTRL0, 0x00000010},
+};
+
+/*
+ * Note: rk3288 has a dedicated 'cursor' window, however, that window requires
+ * special support to get alpha blending working.  For now, just use overlay
+ * window 3 for the drm cursor.
+ *
+ */
+static const struct vop_win_data rk3288_vop_win_data[] = {
+	{ .base = 0x00, .phy = &win01_data, .type = DRM_PLANE_TYPE_PRIMARY },
+	{ .base = 0x40, .phy = &win01_data, .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x00, .phy = &win23_data, .type = DRM_PLANE_TYPE_OVERLAY },
+	{ .base = 0x50, .phy = &win23_data, .type = DRM_PLANE_TYPE_CURSOR },
+};
+
+static const int rk3288_vop_intrs[] = {
+	DSP_HOLD_VALID_INTR,
+	FS_INTR,
+	LINE_FLAG_INTR,
+	BUS_ERROR_INTR,
+};
+
+static const struct vop_intr rk3288_vop_intr = {
+	.intrs = rk3288_vop_intrs,
+	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
+	.status = VOP_REG(INTR_CTRL0, 0xf, 0),
+	.enable = VOP_REG(INTR_CTRL0, 0xf, 4),
+	.clear = VOP_REG(INTR_CTRL0, 0xf, 8),
+};
+
+static const struct vop_data rk3288_vop = {
+	.init_table = vop_init_reg_table,
+	.intr = &rk3288_vop_intr,
+	.table_size = ARRAY_SIZE(vop_init_reg_table),
+	.ctrl = &ctrl_data,
+	.win = rk3288_vop_win_data,
+	.win_size = ARRAY_SIZE(rk3288_vop_win_data),
+};
+
+static const struct of_device_id vop_driver_dt_match[] = {
+	{ .compatible = "rockchip,rk3288-vop",
+	  .data = &rk3288_vop },
+	{},
+};
+MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
+
+static int vop_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	if (!dev->of_node) {
+		dev_err(dev, "can't find vop devices\n");
+		return -ENODEV;
+	}
+
+	return component_add(dev, &vop_component_ops);
+}
+
+static int vop_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &vop_component_ops);
+
+	return 0;
+}
+
+struct platform_driver vop_platform_driver = {
+	.probe = vop_probe,
+	.remove = vop_remove,
+	.driver = {
+		.name = "rockchip-vop",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(vop_driver_dt_match),
+	},
+};
+
+module_platform_driver(vop_platform_driver);
+
+MODULE_AUTHOR("Mark Yao <mark.yao@rock-chips.com>");
+MODULE_DESCRIPTION("ROCKCHIP VOP Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
new file mode 100644
index 0000000..b0fa35d
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author:Mark Yao <mark.yao@rock-chips.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ROCKCHIP_VOP_REG_H
+#define _ROCKCHIP_VOP_REG_H
+
+/* register definition */
+#define REG_CFG_DONE			0x0000
+#define VERSION_INFO			0x0004
+#define SYS_CTRL				0x0008
+#define SYS_CTRL1			0x000c
+#define DSP_CTRL0			0x0010
+#define DSP_CTRL1			0x0014
+#define DSP_BG				0x0018
+#define MCU_CTRL				0x001c
+#define INTR_CTRL0			0x0020
+#define INTR_CTRL1			0x0024
+#define WIN0_CTRL0			0x0030
+#define WIN0_CTRL1			0x0034
+#define WIN0_COLOR_KEY			0x0038
+#define WIN0_VIR				0x003c
+#define WIN0_YRGB_MST			0x0040
+#define WIN0_CBR_MST			0x0044
+#define WIN0_ACT_INFO			0x0048
+#define WIN0_DSP_INFO			0x004c
+#define WIN0_DSP_ST			0x0050
+#define WIN0_SCL_FACTOR_YRGB		0x0054
+#define WIN0_SCL_FACTOR_CBR		0x0058
+#define WIN0_SCL_OFFSET			0x005c
+#define WIN0_SRC_ALPHA_CTRL		0x0060
+#define WIN0_DST_ALPHA_CTRL		0x0064
+#define WIN0_FADING_CTRL			0x0068
+/* win1 register */
+#define WIN1_CTRL0			0x0070
+#define WIN1_CTRL1			0x0074
+#define WIN1_COLOR_KEY			0x0078
+#define WIN1_VIR				0x007c
+#define WIN1_YRGB_MST			0x0080
+#define WIN1_CBR_MST			0x0084
+#define WIN1_ACT_INFO			0x0088
+#define WIN1_DSP_INFO			0x008c
+#define WIN1_DSP_ST			0x0090
+#define WIN1_SCL_FACTOR_YRGB		0x0094
+#define WIN1_SCL_FACTOR_CBR		0x0098
+#define WIN1_SCL_OFFSET			0x009c
+#define WIN1_SRC_ALPHA_CTRL		0x00a0
+#define WIN1_DST_ALPHA_CTRL		0x00a4
+#define WIN1_FADING_CTRL			0x00a8
+/* win2 register */
+#define WIN2_CTRL0			0x00b0
+#define WIN2_CTRL1			0x00b4
+#define WIN2_VIR0_1			0x00b8
+#define WIN2_VIR2_3			0x00bc
+#define WIN2_MST0			0x00c0
+#define WIN2_DSP_INFO0			0x00c4
+#define WIN2_DSP_ST0			0x00c8
+#define WIN2_COLOR_KEY			0x00cc
+#define WIN2_MST1			0x00d0
+#define WIN2_DSP_INFO1			0x00d4
+#define WIN2_DSP_ST1			0x00d8
+#define WIN2_SRC_ALPHA_CTRL		0x00dc
+#define WIN2_MST2			0x00e0
+#define WIN2_DSP_INFO2			0x00e4
+#define WIN2_DSP_ST2			0x00e8
+#define WIN2_DST_ALPHA_CTRL		0x00ec
+#define WIN2_MST3			0x00f0
+#define WIN2_DSP_INFO3			0x00f4
+#define WIN2_DSP_ST3			0x00f8
+#define WIN2_FADING_CTRL			0x00fc
+/* win3 register */
+#define WIN3_CTRL0			0x0100
+#define WIN3_CTRL1			0x0104
+#define WIN3_VIR0_1			0x0108
+#define WIN3_VIR2_3			0x010c
+#define WIN3_MST0			0x0110
+#define WIN3_DSP_INFO0			0x0114
+#define WIN3_DSP_ST0			0x0118
+#define WIN3_COLOR_KEY			0x011c
+#define WIN3_MST1			0x0120
+#define WIN3_DSP_INFO1			0x0124
+#define WIN3_DSP_ST1			0x0128
+#define WIN3_SRC_ALPHA_CTRL		0x012c
+#define WIN3_MST2			0x0130
+#define WIN3_DSP_INFO2			0x0134
+#define WIN3_DSP_ST2			0x0138
+#define WIN3_DST_ALPHA_CTRL		0x013c
+#define WIN3_MST3			0x0140
+#define WIN3_DSP_INFO3			0x0144
+#define WIN3_DSP_ST3			0x0148
+#define WIN3_FADING_CTRL			0x014c
+/* hwc register */
+#define HWC_CTRL0			0x0150
+#define HWC_CTRL1			0x0154
+#define HWC_MST				0x0158
+#define HWC_DSP_ST			0x015c
+#define HWC_SRC_ALPHA_CTRL		0x0160
+#define HWC_DST_ALPHA_CTRL		0x0164
+#define HWC_FADING_CTRL			0x0168
+/* post process register */
+#define POST_DSP_HACT_INFO		0x0170
+#define POST_DSP_VACT_INFO		0x0174
+#define POST_SCL_FACTOR_YRGB		0x0178
+#define POST_SCL_CTRL			0x0180
+#define POST_DSP_VACT_INFO_F1		0x0184
+#define DSP_HTOTAL_HS_END		0x0188
+#define DSP_HACT_ST_END			0x018c
+#define DSP_VTOTAL_VS_END		0x0190
+#define DSP_VACT_ST_END			0x0194
+#define DSP_VS_ST_END_F1			0x0198
+#define DSP_VACT_ST_END_F1		0x019c
+/* register definition end */
+
+#endif /* _ROCKCHIP_VOP_REG_H */
-- 
1.7.9.5
