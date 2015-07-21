From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Jul 2015 16:28:52 +0800
Subject: [PATCH v3 6/6] drm/rockchip: vop: support plane scale
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1437467332-14006-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Win_full support 1/8 to 8 scale down/up engine, support
all format scale.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3:
Adviced by Tomasz Figa
- remove unused code and unnecessary scale path.
- use static inline funcion instead "#define", let gcc check the cast
- move same call into helper, make code clean.

Changes in v2:
- Fix scale dest info. 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  196 ++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   87 ++++++++++++
 2 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4dfad065..8257e98 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -49,6 +49,8 @@
 
 #define VOP_WIN_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
+#define VOP_SCL_SET(x, win, name, v) \
+		REG_SET(x, win->base, win->phy->scl->name, v, RELAXED)
 #define VOP_CTRL_SET(x, name, v) \
 		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
 
@@ -163,7 +165,37 @@ struct vop_ctrl {
 	struct vop_reg vpost_st_end;
 };
 
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
 struct vop_win_phy {
+	const struct vop_scl_regs *scl;
 	const uint32_t *data_formats;
 	uint32_t nformats;
 
@@ -212,7 +244,36 @@ static const uint32_t formats_234[] = {
 	DRM_FORMAT_RGB565,
 };
 
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
 static const struct vop_win_phy win01_data = {
+	.scl = &win_full_scl,
 	.data_formats = formats_01,
 	.nformats = ARRAY_SIZE(formats_01),
 	.enable = VOP_REG(WIN0_CTRL0, 0x1, 0),
@@ -401,6 +462,126 @@ static bool is_alpha_support(uint32_t format)
 	}
 }
 
+static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
+				  uint32_t dst, int scan_type,
+				  int vsu_mode, int *vskiplines)
+{
+	uint16_t val = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
+
+	if (scan_type == 0) {
+		if (mode == SCALE_UP)
+			val = GET_SCL_FT_BIC(src, dst);
+		else if (mode == SCALE_DOWN)
+			val = GET_SCL_FT_BILI_DN(src, dst);
+	} else {
+		if (mode == SCALE_UP) {
+			if (vsu_mode == SCALE_UP_BIL)
+				val = GET_SCL_FT_BILI_UP(src, dst);
+			else
+				val = GET_SCL_FT_BIC(src, dst);
+		} else if (mode == SCALE_DOWN) {
+			if (vskiplines) {
+				*vskiplines = scl_get_vskiplines(src, dst);
+				val = scl_get_bili_dn_vskip(src, dst,
+							    *vskiplines);
+			} else {
+				val = GET_SCL_FT_BILI_DN(src, dst);
+			}
+		}
+	}
+
+	return val;
+}
+
+static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
+			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
+			     uint32_t dst_h, uint32_t pixel_format)
+{
+	uint16_t yrgb_hor_scl_mode, yrgb_ver_scl_mode;
+	uint16_t cbcr_hor_scl_mode = SCALE_NONE;
+	uint16_t cbcr_ver_scl_mode = SCALE_NONE;
+	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
+	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
+	bool is_yuv = is_yuv_support(pixel_format);
+	uint16_t cbcr_src_w = src_w / hsub;
+	uint16_t cbcr_src_h = src_h / vsub;
+	uint16_t vsu_mode;
+	uint16_t lb_mode;
+	uint32_t val;
+	int vskiplines;
+
+	if (dst_w > 3840) {
+		DRM_ERROR("yrgb scale exceed 8,src[%dx%d] dst[%dx%d]\n",
+			  src_w, src_h, dst_w, dst_h);
+		return;
+	}
+
+	yrgb_hor_scl_mode = scl_get_scl_mode(src_w, dst_w);
+	yrgb_ver_scl_mode = scl_get_scl_mode(src_h, dst_h);
+
+	if (is_yuv) {
+		cbcr_hor_scl_mode = scl_get_scl_mode(cbcr_src_w, dst_w);
+		cbcr_ver_scl_mode = scl_get_scl_mode(cbcr_src_h, dst_h);
+		if (cbcr_hor_scl_mode == SCALE_DOWN)
+			lb_mode = scl_vop_cal_lb_mode(dst_w, true);
+		else
+			lb_mode = scl_vop_cal_lb_mode(cbcr_src_w, true);
+	} else {
+		if (yrgb_hor_scl_mode == SCALE_DOWN)
+			lb_mode = scl_vop_cal_lb_mode(dst_w, false);
+		else
+			lb_mode = scl_vop_cal_lb_mode(src_w, false);
+	}
+
+	VOP_SCL_SET(vop, win, lb_mode, lb_mode);
+	if (lb_mode == LB_RGB_3840X2) {
+		if (yrgb_ver_scl_mode != SCALE_NONE) {
+			DRM_ERROR("ERROR : not allow yrgb ver scale\n");
+			return;
+		}
+		if (cbcr_ver_scl_mode != SCALE_NONE) {
+			DRM_ERROR("ERROR : not allow cbcr ver scale\n");
+			return;
+		}
+		vsu_mode = SCALE_UP_BIL;
+	} else if (lb_mode == LB_RGB_2560X4) {
+		vsu_mode = SCALE_UP_BIL;
+	} else {
+		vsu_mode = SCALE_UP_BIC;
+	}
+
+	val = scl_vop_cal_scale(yrgb_hor_scl_mode, src_w, dst_w, 0, 0, NULL);
+	VOP_SCL_SET(vop, win, scale_yrgb_x, val);
+	val = scl_vop_cal_scale(yrgb_ver_scl_mode, src_h, dst_h,
+				1, vsu_mode, &vskiplines);
+	VOP_SCL_SET(vop, win, scale_yrgb_y, val);
+
+	VOP_SCL_SET(vop, win, vsd_yrgb_gt4, vskiplines == 4);
+	VOP_SCL_SET(vop, win, vsd_yrgb_gt2, vskiplines == 2);
+
+	VOP_SCL_SET(vop, win, yrgb_hor_scl_mode, yrgb_hor_scl_mode);
+	VOP_SCL_SET(vop, win, yrgb_ver_scl_mode, yrgb_ver_scl_mode);
+	VOP_SCL_SET(vop, win, yrgb_hsd_mode, SCALE_DOWN_BIL);
+	VOP_SCL_SET(vop, win, yrgb_vsd_mode, SCALE_DOWN_BIL);
+	VOP_SCL_SET(vop, win, yrgb_vsu_mode, vsu_mode);
+	if (is_yuv) {
+		val = scl_vop_cal_scale(cbcr_hor_scl_mode, cbcr_src_w,
+					dst_w, 0, 0, NULL);
+		VOP_SCL_SET(vop, win, scale_cbcr_x, val);
+		val = scl_vop_cal_scale(cbcr_ver_scl_mode, cbcr_src_h,
+					dst_h, 1, vsu_mode, &vskiplines);
+		VOP_SCL_SET(vop, win, scale_cbcr_y, val);
+
+		VOP_SCL_SET(vop, win, vsd_cbcr_gt4, vskiplines == 4);
+		VOP_SCL_SET(vop, win, vsd_cbcr_gt2, vskiplines == 2);
+		VOP_SCL_SET(vop, win, cbcr_hor_scl_mode, cbcr_hor_scl_mode);
+		VOP_SCL_SET(vop, win, cbcr_ver_scl_mode, cbcr_ver_scl_mode);
+		VOP_SCL_SET(vop, win, cbcr_hsd_mode, SCALE_DOWN_BIL);
+		VOP_SCL_SET(vop, win, cbcr_vsd_mode, SCALE_DOWN_BIL);
+		VOP_SCL_SET(vop, win, cbcr_vsu_mode, vsu_mode);
+	}
+}
+
 static void vop_dsp_hold_valid_irq_enable(struct vop *vop)
 {
 	unsigned long flags;
@@ -631,11 +812,13 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		.y2 = crtc->mode.vdisplay,
 	};
 	bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
+	int min_scale = win->phy->scl ? 0x02000 : DRM_PLANE_HELPER_NO_SCALING;
+	int max_scale = win->phy->scl ? 0x80000 : DRM_PLANE_HELPER_NO_SCALING;
 
 	ret = drm_plane_helper_check_update(plane, crtc, fb,
 					    &src, &dest, &clip,
-					    DRM_PLANE_HELPER_NO_SCALING,
-					    DRM_PLANE_HELPER_NO_SCALING,
+					    min_scale,
+					    max_scale,
 					    can_position, false, &visible);
 	if (ret)
 		return ret;
@@ -738,9 +921,18 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, uv_vir, uv_vir_stride);
 		VOP_WIN_SET(vop, win, uv_mst, uv_mst);
 	}
+
+	if (win->phy->scl)
+		scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
+				    dest.x2 - dest.x1, dest.y2 - dest.y1,
+				    fb->pixel_format);
+
 	val = (actual_h - 1) << 16;
 	val |= (actual_w - 1) & 0xffff;
 	VOP_WIN_SET(vop, win, act_info, val);
+
+	val = (dest.y2 - dest.y1 - 1) << 16;
+	val |= (dest.x2 - dest.x1 - 1) & 0xffff;
 	VOP_WIN_SET(vop, win, dsp_info, val);
 	val = (dsp_sty - 1) << 16;
 	val |= (dsp_stx - 1) & 0xffff;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 63e9b3a..78cd321 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -198,4 +198,91 @@ enum factor_mode {
 	ALPHA_SRC_GLOBAL,
 };
 
+enum scale_mode {
+	SCALE_NONE = 0x0,
+	SCALE_UP   = 0x1,
+	SCALE_DOWN = 0x2
+};
+
+enum lb_mode {
+	LB_YUV_3840X5 = 0x0,
+	LB_YUV_2560X8 = 0x1,
+	LB_RGB_3840X2 = 0x2,
+	LB_RGB_2560X4 = 0x3,
+	LB_RGB_1920X5 = 0x4,
+	LB_RGB_1280X8 = 0x5
+};
+
+enum sacle_up_mode {
+	SCALE_UP_BIL = 0x0,
+	SCALE_UP_BIC = 0x1
+};
+
+enum scale_down_mode {
+	SCALE_DOWN_BIL = 0x0,
+	SCALE_DOWN_AVG = 0x1
+};
+
+#define SCL_FT_DEFAULT_FIXPOINT_SHIFT	12
+#define SCL_MAX_VSKIPLINES		4
+#define MIN_SCL_FT_AFTER_VSKIP		1
+
+static inline uint16_t scl_cal_scale(int src, int dst, int shift)
+{
+	return ((src * 2 - 3) << (shift - 1)) / (dst - 1);
+}
+
+#define GET_SCL_FT_BILI_DN(src, dst)	scl_cal_scale(src, dst, 12)
+#define GET_SCL_FT_BILI_UP(src, dst)	scl_cal_scale(src, dst, 16)
+#define GET_SCL_FT_BIC(src, dst)	scl_cal_scale(src, dst, 16)
+
+static inline uint16_t scl_get_bili_dn_vskip(int src_h, int dst_h,
+					     int vskiplines)
+{
+	int act_height;
+
+	act_height = (src_h + vskiplines - 1) / vskiplines;
+
+	return GET_SCL_FT_BILI_DN(act_height, dst_h);
+}
+
+static inline enum scale_mode scl_get_scl_mode(int src, int dst)
+{
+	if (src < dst)
+		return SCALE_UP;
+	else if (src > dst)
+		return SCALE_DOWN;
+
+	return SCALE_NONE;
+}
+
+static inline int scl_get_vskiplines(uint32_t srch, uint32_t dsth)
+{
+	uint32_t vskiplines;
+
+	for (vskiplines = SCL_MAX_VSKIPLINES; vskiplines > 1; vskiplines /= 2)
+		if (srch >= vskiplines * dsth * MIN_SCL_FT_AFTER_VSKIP)
+			break;
+
+	return vskiplines;
+}
+
+static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
+{
+	int lb_mode;
+
+	if (width > 2560)
+		lb_mode = LB_RGB_3840X2;
+	else if (width > 1920)
+		lb_mode = LB_RGB_2560X4;
+	else if (!is_yuv)
+		lb_mode = LB_RGB_1920X5;
+	else if (width > 1280)
+		lb_mode = LB_YUV_3840X5;
+	else
+		lb_mode = LB_YUV_2560X8;
+
+	return lb_mode;
+}
+
 #endif /* _ROCKCHIP_DRM_VOP_H */
-- 
1.7.9.5
