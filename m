From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri, 26 Jun 2015 18:07:27 +0800
Subject: [PATCH v2 3/5] drm/rockchip: vop: support plane scale
In-Reply-To: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1435313249-4549-4-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Win_full support 1/8 to 8 scale down/up engine, support
all format scale.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v2:
- Fix scale dest info. 

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  389 ++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   96 +++++++
 2 files changed, 483 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 6ca08f8..f6ef634 100644
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
+	struct vop_reg cbr_vsd_mode;
+	struct vop_reg cbr_vsu_mode;
+	struct vop_reg cbr_hsd_mode;
+	struct vop_reg cbr_ver_scl_mode;
+	struct vop_reg cbr_hor_scl_mode;
+	struct vop_reg yrgb_vsd_mode;
+	struct vop_reg yrgb_vsu_mode;
+	struct vop_reg yrgb_hsd_mode;
+	struct vop_reg yrgb_ver_scl_mode;
+	struct vop_reg yrgb_hor_scl_mode;
+	struct vop_reg line_load_mode;
+	struct vop_reg cbr_axi_gather_num;
+	struct vop_reg yrgb_axi_gather_num;
+	struct vop_reg vsd_cbr_gt2;
+	struct vop_reg vsd_cbr_gt4;
+	struct vop_reg vsd_yrgb_gt2;
+	struct vop_reg vsd_yrgb_gt4;
+	struct vop_reg bic_coe_sel;
+	struct vop_reg cbr_axi_gather_en;
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
+	.cbr_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 31),
+	.cbr_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 30),
+	.cbr_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 28),
+	.cbr_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 26),
+	.cbr_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 24),
+	.yrgb_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 23),
+	.yrgb_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 22),
+	.yrgb_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 20),
+	.yrgb_ver_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 18),
+	.yrgb_hor_scl_mode = VOP_REG(WIN0_CTRL1, 0x3, 16),
+	.line_load_mode = VOP_REG(WIN0_CTRL1, 0x1, 15),
+	.cbr_axi_gather_num = VOP_REG(WIN0_CTRL1, 0x7, 12),
+	.yrgb_axi_gather_num = VOP_REG(WIN0_CTRL1, 0xf, 8),
+	.vsd_cbr_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 7),
+	.vsd_cbr_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 6),
+	.vsd_yrgb_gt2 = VOP_REG(WIN0_CTRL1, 0x1, 5),
+	.vsd_yrgb_gt4 = VOP_REG(WIN0_CTRL1, 0x1, 4),
+	.bic_coe_sel = VOP_REG(WIN0_CTRL1, 0x3, 2),
+	.cbr_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 1),
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
@@ -351,6 +412,15 @@ static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
 	}
 }
 
+static inline int _get_vskiplines(uint32_t srch, uint32_t dsth)
+{
+	if (srch >= (uint32_t)(4 * dsth * MIN_SCL_FT_AFTER_VSKIP))
+		return 4;
+	else if (srch >= (uint32_t)(2 * dsth * MIN_SCL_FT_AFTER_VSKIP))
+		return 2;
+	return 1;
+}
+
 static enum vop_data_format vop_convert_format(uint32_t format)
 {
 	switch (format) {
@@ -538,6 +608,310 @@ static void vop_disable(struct drm_crtc *crtc)
 	pm_runtime_put(vop->dev);
 }
 
+static int _vop_cal_yrgb_lb_mode(int width)
+{
+	int lb_mode = LB_RGB_1920X5;
+
+	if (width > 2560)
+		lb_mode = LB_RGB_3840X2;
+	else if (width > 1920)
+		lb_mode = LB_RGB_2560X4;
+
+	return lb_mode;
+}
+
+static int _vop_cal_cbcr_lb_mode(int width)
+{
+	int lb_mode = LB_YUV_2560X8;
+
+	if (width > 2560)
+		lb_mode = LB_RGB_3840X2;
+	else if (width > 1920)
+		lb_mode = LB_RGB_2560X4;
+	else if (width > 1280)
+		lb_mode = LB_YUV_3840X5;
+
+	return lb_mode;
+}
+
+static void _vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
+			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
+			     uint32_t dst_h, uint32_t pixel_format)
+{
+	uint16_t yrgb_hor_scl_mode = SCALE_NONE;
+	uint16_t yrgb_ver_scl_mode = SCALE_NONE;
+	uint16_t cbr_hor_scl_mode = SCALE_NONE;
+	uint16_t cbr_ver_scl_mode = SCALE_NONE;
+	uint16_t yrgb_hsd_mode = SCALE_DOWN_BIL;
+	uint16_t cbr_hsd_mode = SCALE_DOWN_BIL;
+	uint16_t yrgb_vsd_mode = SCALE_DOWN_BIL;
+	uint16_t cbr_vsd_mode = SCALE_DOWN_BIL;
+	uint16_t yrgb_vsu_mode = SCALE_UP_BIL;
+	uint16_t cbr_vsu_mode = SCALE_UP_BIL;
+	uint16_t scale_yrgb_x = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
+	uint16_t scale_yrgb_y = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
+	uint16_t scale_cbcr_x = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
+	uint16_t scale_cbcr_y = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
+	int hsub = drm_format_horz_chroma_subsampling(pixel_format);
+	int vsub = drm_format_vert_chroma_subsampling(pixel_format);
+	bool is_yuv = is_yuv_support(pixel_format);
+	uint16_t vsd_yrgb_gt4 = 0;
+	uint16_t vsd_yrgb_gt2 = 0;
+	uint16_t vsd_cbr_gt4 = 0;
+	uint16_t vsd_cbr_gt2 = 0;
+	uint16_t yrgb_src_w = src_w;
+	uint16_t yrgb_src_h = src_h;
+	uint16_t yrgb_dst_w = dst_w;
+	uint16_t yrgb_dst_h = dst_h;
+	uint16_t cbcr_src_w;
+	uint16_t cbcr_src_h;
+	uint16_t cbcr_dst_w;
+	uint16_t cbcr_dst_h;
+	uint32_t vdmult;
+	uint16_t lb_mode;
+
+	if (((yrgb_dst_w << 3) <= yrgb_src_w) ||
+	    ((yrgb_dst_h << 3) <= yrgb_src_h) ||
+	    yrgb_dst_w > 3840) {
+		DRM_ERROR("yrgb scale exceed 8,src[%dx%d] dst[%dx%d]\n",
+			  yrgb_src_w, yrgb_src_h, yrgb_dst_w, yrgb_dst_h);
+		return;
+	}
+
+	if (yrgb_src_w < yrgb_dst_w)
+		yrgb_hor_scl_mode = SCALE_UP;
+	else if (yrgb_src_w > yrgb_dst_w)
+		yrgb_hor_scl_mode = SCALE_DOWN;
+	else
+		yrgb_hor_scl_mode = SCALE_NONE;
+
+	if (yrgb_src_h < yrgb_dst_h)
+		yrgb_ver_scl_mode = SCALE_UP;
+	else if (yrgb_src_h  > yrgb_dst_h)
+		yrgb_ver_scl_mode = SCALE_DOWN;
+	else
+		yrgb_ver_scl_mode = SCALE_NONE;
+
+	if (is_yuv) {
+		cbcr_src_w = src_w / hsub;
+		cbcr_src_h = src_h / vsub;
+		cbcr_dst_w = dst_w;
+		cbcr_dst_h = dst_h;
+		if ((cbcr_dst_w << 3) <= cbcr_src_w ||
+		    (cbcr_dst_h << 3) <= cbcr_src_h ||
+		    cbcr_src_w > 3840 ||
+		    cbcr_src_w == 0)
+			DRM_ERROR("cbcr scale failed,src[%dx%d] dst[%dx%d]\n",
+				  cbcr_src_w, cbcr_src_h,
+				  cbcr_dst_w, cbcr_dst_h);
+		if (cbcr_src_w < cbcr_dst_w)
+			cbr_hor_scl_mode = SCALE_UP;
+		else if (cbcr_src_w > cbcr_dst_w)
+			cbr_hor_scl_mode = SCALE_DOWN;
+
+		if (cbcr_src_h < cbcr_dst_h)
+			cbr_ver_scl_mode = SCALE_UP;
+		else if (cbcr_src_h > cbcr_dst_h)
+			cbr_ver_scl_mode = SCALE_DOWN;
+	}
+	/*
+	 * line buffer mode
+	 */
+	if (is_yuv) {
+		if (yrgb_hor_scl_mode == SCALE_DOWN && yrgb_dst_w > 2560)
+			lb_mode = LB_RGB_3840X2;
+		else if (cbr_hor_scl_mode == SCALE_DOWN)
+			lb_mode = _vop_cal_cbcr_lb_mode(cbcr_dst_w);
+		else
+			lb_mode = _vop_cal_cbcr_lb_mode(cbcr_src_w);
+	} else {
+		if (yrgb_hor_scl_mode == SCALE_DOWN)
+			lb_mode = _vop_cal_yrgb_lb_mode(yrgb_dst_w);
+		else
+			lb_mode = _vop_cal_yrgb_lb_mode(yrgb_src_w);
+	}
+
+	switch (lb_mode) {
+	case LB_YUV_3840X5:
+	case LB_YUV_2560X8:
+	case LB_RGB_1920X5:
+	case LB_RGB_1280X8:
+		yrgb_vsu_mode = SCALE_UP_BIC;
+		cbr_vsu_mode  = SCALE_UP_BIC;
+		break;
+	case LB_RGB_3840X2:
+		if (yrgb_ver_scl_mode != SCALE_NONE)
+			DRM_ERROR("ERROR : not allow yrgb ver scale\n");
+		if (cbr_ver_scl_mode != SCALE_NONE)
+			DRM_ERROR("ERROR : not allow cbcr ver scale\n");
+		break;
+	case LB_RGB_2560X4:
+		yrgb_vsu_mode = SCALE_UP_BIL;
+		cbr_vsu_mode  = SCALE_UP_BIL;
+		break;
+	default:
+		DRM_ERROR("unsupport lb_mode:%d\n", lb_mode);
+		break;
+	}
+	/*
+	 * (1.1)YRGB HOR SCALE FACTOR
+	 */
+	switch (yrgb_hor_scl_mode) {
+	case SCALE_UP:
+		scale_yrgb_x = GET_SCL_FT_BIC(yrgb_src_w, yrgb_dst_w);
+		break;
+	case SCALE_DOWN:
+		switch (yrgb_hsd_mode) {
+		case SCALE_DOWN_BIL:
+			scale_yrgb_x = GET_SCL_FT_BILI_DN(yrgb_src_w,
+							  yrgb_dst_w);
+			break;
+		case SCALE_DOWN_AVG:
+			scale_yrgb_x = GET_SCL_FT_AVRG(yrgb_src_w, yrgb_dst_w);
+			break;
+		default:
+			DRM_ERROR("unsupport yrgb_hsd_mode:%d\n",
+				  yrgb_hsd_mode);
+			break;
+		}
+		break;
+	}
+
+	/*
+	 * (1.2)YRGB VER SCALE FACTOR
+	 */
+	switch (yrgb_ver_scl_mode) {
+	case SCALE_UP:
+		switch (yrgb_vsu_mode) {
+		case SCALE_UP_BIL:
+			scale_yrgb_y = GET_SCL_FT_BILI_UP(yrgb_src_h,
+							  yrgb_dst_h);
+			break;
+		case SCALE_UP_BIC:
+			if (yrgb_src_h < 3)
+				DRM_ERROR("yrgb_src_h should greater than 3\n");
+			scale_yrgb_y = GET_SCL_FT_BIC(yrgb_src_h, yrgb_dst_h);
+			break;
+		default:
+			DRM_ERROR("unsupport yrgb_vsu_mode:%d\n",
+				  yrgb_vsu_mode);
+			break;
+		}
+		break;
+	case SCALE_DOWN:
+		switch (yrgb_vsd_mode) {
+		case SCALE_DOWN_BIL:
+			vdmult = _get_vskiplines(yrgb_src_h, yrgb_dst_h);
+			scale_yrgb_y = GET_SCL_FT_BILI_DN_VSKIP(yrgb_src_h,
+								yrgb_dst_h,
+								vdmult);
+			if (vdmult == 4) {
+				vsd_yrgb_gt4 = 1;
+				vsd_yrgb_gt2 = 0;
+			} else if (vdmult == 2) {
+				vsd_yrgb_gt4 = 0;
+				vsd_yrgb_gt2 = 1;
+			}
+			break;
+		case SCALE_DOWN_AVG:
+			scale_yrgb_y = GET_SCL_FT_AVRG(yrgb_src_h, yrgb_dst_h);
+			break;
+		default:
+			DRM_ERROR("unsupport yrgb_vsd_mode:%d\n",
+				  yrgb_vsd_mode);
+			break;
+		}
+		break;
+	}
+	/*
+	 * (2.1)CBCR HOR SCALE FACTOR
+	 */
+	switch (cbr_hor_scl_mode) {
+	case SCALE_UP:
+		scale_cbcr_x = GET_SCL_FT_BIC(cbcr_src_w, cbcr_dst_w);
+		break;
+	case SCALE_DOWN:
+		switch (cbr_hsd_mode) {
+		case SCALE_DOWN_BIL:
+			scale_cbcr_x = GET_SCL_FT_BILI_DN(cbcr_src_w,
+							  cbcr_dst_w);
+			break;
+		case SCALE_DOWN_AVG:
+			scale_cbcr_x = GET_SCL_FT_AVRG(cbcr_src_w, cbcr_dst_w);
+			break;
+		default:
+			DRM_ERROR("unsupport cbr_hsd_mode:%d\n", cbr_hsd_mode);
+			break;
+		}
+		break;
+	}
+
+	/*
+	 * (2.2)CBCR VER SCALE FACTOR
+	 */
+	switch (cbr_ver_scl_mode) {
+	case SCALE_UP:
+		switch (cbr_vsu_mode) {
+		case SCALE_UP_BIL:
+			scale_cbcr_y = GET_SCL_FT_BILI_UP(cbcr_src_h,
+							  cbcr_dst_h);
+			break;
+		case SCALE_UP_BIC:
+			if (cbcr_src_h < 3)
+				DRM_ERROR("cbcr_src_h need greater than 3 !\n");
+			scale_cbcr_y = GET_SCL_FT_BIC(cbcr_src_h, cbcr_dst_h);
+			break;
+		default:
+			DRM_ERROR("unsupport cbr_vsu_mode:%d\n", cbr_vsu_mode);
+			break;
+		}
+		break;
+	case SCALE_DOWN:
+		switch (cbr_vsd_mode) {
+		case SCALE_DOWN_BIL:
+			vdmult = _get_vskiplines(cbcr_src_h, cbcr_dst_h);
+			scale_cbcr_y = GET_SCL_FT_BILI_DN_VSKIP(cbcr_src_h,
+								cbcr_dst_h,
+								vdmult);
+			if (vdmult == 4) {
+				vsd_cbr_gt4 = 1;
+				vsd_cbr_gt2 = 0;
+			} else if (vdmult == 2) {
+				vsd_cbr_gt4 = 0;
+				vsd_cbr_gt2 = 1;
+			}
+			break;
+		case SCALE_DOWN_AVG:
+			scale_cbcr_y = GET_SCL_FT_AVRG(cbcr_src_h, cbcr_dst_h);
+			break;
+		default:
+			DRM_ERROR("unsupport cbr_vsd_mode:%d\n", cbr_vsd_mode);
+			break;
+		}
+		break;
+	}
+
+	VOP_SCL_SET(vop, win, yrgb_hor_scl_mode, yrgb_hor_scl_mode);
+	VOP_SCL_SET(vop, win, yrgb_ver_scl_mode, yrgb_ver_scl_mode);
+	VOP_SCL_SET(vop, win, cbr_hor_scl_mode, cbr_hor_scl_mode);
+	VOP_SCL_SET(vop, win, cbr_ver_scl_mode, cbr_ver_scl_mode);
+	VOP_SCL_SET(vop, win, lb_mode, lb_mode);
+	VOP_SCL_SET(vop, win, yrgb_hsd_mode, yrgb_hsd_mode);
+	VOP_SCL_SET(vop, win, cbr_hsd_mode, cbr_hsd_mode);
+	VOP_SCL_SET(vop, win, yrgb_vsd_mode, yrgb_vsd_mode);
+	VOP_SCL_SET(vop, win, cbr_vsd_mode, cbr_vsd_mode);
+	VOP_SCL_SET(vop, win, yrgb_vsu_mode, yrgb_vsu_mode);
+	VOP_SCL_SET(vop, win, cbr_vsu_mode, cbr_vsu_mode);
+	VOP_SCL_SET(vop, win, scale_yrgb_x, scale_yrgb_x);
+	VOP_SCL_SET(vop, win, scale_yrgb_y, scale_yrgb_y);
+	VOP_SCL_SET(vop, win, vsd_yrgb_gt4, vsd_yrgb_gt4);
+	VOP_SCL_SET(vop, win, vsd_yrgb_gt2, vsd_yrgb_gt2);
+	VOP_SCL_SET(vop, win, scale_cbcr_x, scale_cbcr_x);
+	VOP_SCL_SET(vop, win, scale_cbcr_y, scale_cbcr_y);
+	VOP_SCL_SET(vop, win, vsd_cbr_gt4, vsd_cbr_gt4);
+	VOP_SCL_SET(vop, win, vsd_cbr_gt2, vsd_cbr_gt2);
+}
+
 /*
  * Caller must hold vsync_mutex.
  */
@@ -624,6 +998,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		.y2 = crtc->mode.vdisplay,
 	};
 	bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
+	int min_scale = win->phy->scl ? 0x02000 : DRM_PLANE_HELPER_NO_SCALING;
+	int max_scale = win->phy->scl ? 0x80000 : DRM_PLANE_HELPER_NO_SCALING;
 
 	if (drm_format_num_planes(fb->pixel_format) > 2) {
 		DRM_ERROR("unsupport more than 2 plane format[%08x]\n",
@@ -633,8 +1009,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
 
 	ret = drm_plane_helper_check_update(plane, crtc, fb,
 					    &src, &dest, &clip,
-					    DRM_PLANE_HELPER_NO_SCALING,
-					    DRM_PLANE_HELPER_NO_SCALING,
+					    min_scale,
+					    max_scale,
 					    can_position, false, &visible);
 	if (ret)
 		return ret;
@@ -732,9 +1108,18 @@ static int vop_update_plane_event(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, uv_vir, uv_vir_stride);
 		VOP_WIN_SET(vop, win, uv_mst, uv_mst);
 	}
+
+	if (win->phy->scl)
+		_vop_cal_scl_fac(vop, win, actual_w, actual_h,
+				 dest.x2 - dest.x1, dest.y2 - dest.y1,
+				 fb->pixel_format);
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
index 63e9b3a..edacdee 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -198,4 +198,100 @@ enum factor_mode {
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
+#define CUBIC_PRECISE  0
+#define CUBIC_SPLINE   1
+#define CUBIC_CATROM   2
+#define CUBIC_MITCHELL 3
+
+#define CUBIC_MODE_SELETION      CUBIC_PRECISE
+
+#define SCL_FT_BILI_DN_FIXPOINT_SHIFT	12
+#define SCL_FT_BILI_DN_FIXPOINT(x) \
+		((INT32)((x)*(1 << SCL_FT_BILI_DN_FIXPOINT_SHIFT)))
+
+#define SCL_FT_BILI_UP_FIXPOINT_SHIFT	16
+
+#define SCL_FT_AVRG_FIXPOINT_SHIFT	16
+#define SCL_FT_AVRG_FIXPOINT(x) \
+		((INT32)((x) * (1 << SCL_FT_AVRG_FIXPOINT_SHIFT)))
+
+#define SCL_FT_BIC_FIXPOINT_SHIFT	16
+#define SCL_FT_BIC_FIXPOINT(x) \
+		((INT32)((x)*(1 << SCL_FT_BIC_FIXPOINT_SHIFT)))
+
+#define SCL_FT_DEFAULT_FIXPOINT_SHIFT    12
+#define SCL_FT_VSDBIL_FIXPOINT_SHIFT     12
+
+#define SCL_CAL(src, dst, shift) \
+		((((src) * 2 - 3) << ((shift) - 1)) / ((dst) - 1))
+#define GET_SCL_FT_BILI_DN(src, dst) \
+		SCL_CAL(src, dst, SCL_FT_BILI_DN_FIXPOINT_SHIFT)
+#define GET_SCL_FT_BILI_UP(src, dst) \
+		SCL_CAL(src, dst, SCL_FT_BILI_UP_FIXPOINT_SHIFT)
+#define GET_SCL_FT_BIC(src, dst) \
+		SCL_CAL(src, dst, SCL_FT_BIC_FIXPOINT_SHIFT)
+
+#define GET_SCL_DN_ACT_HEIGHT(src_h, vdmult) \
+		(((src_h) + (vdmult) - 1) / (vdmult))
+
+#define MIN_SCL_FT_AFTER_VSKIP	1
+#define GET_SCL_FT_BILI_DN_VSKIP(src_h, dst_h, vdmult) \
+		((GET_SCL_DN_ACT_HEIGHT((src_h), (vdmult)) == (dst_h)) \
+			? (GET_SCL_FT_BILI_DN((src_h), (dst_h))/(vdmult)) \
+			: GET_SCL_FT_BILI_DN(GET_SCL_DN_ACT_HEIGHT((src_h), \
+					     (vdmult)), (dst_h)))
+
+#define GET_SCL_FT_AVRG(src, dst) \
+		(((dst) << ((SCL_FT_AVRG_FIXPOINT_SHIFT) + 1)) \
+		 / (2 * (src) - 1))
+
+#define SCL_COOR_ACC_FIXPOINT_SHIFT	16
+#define SCL_COOR_ACC_FIXPOINT_ONE	(1 << SCL_COOR_ACC_FIXPOINT_SHIFT)
+#define SCL_COOR_ACC_FIXPOINT(x) \
+		((INT32)((x)*(1 << SCL_COOR_ACC_FIXPOINT_SHIFT)))
+#define SCL_COOR_ACC_FIXPOINT_REVERT(x)	\
+		((((x) >> (SCL_COOR_ACC_FIXPOINT_SHIFT-1)) + 1) >> 1)
+
+#define SCL_GET_COOR_ACC_FIXPOINT(scale, shift)  \
+		((scale) << (SCL_COOR_ACC_FIXPOINT_SHIFT - (shift)))
+#define SCL_FILTER_FT_FIXPOINT_SHIFT	8
+#define SCL_FILTER_FT_FIXPOINT_ONE	(1 << SCL_FILTER_FT_FIXPOINT_SHIFT)
+#define SCL_FILTER_FT_FIXPOINT(x) \
+		((INT32)((x) * (1 << SCL_FILTER_FT_FIXPOINT_SHIFT)))
+#define SCL_FILTER_FT_FIXPOINT_REVERT(x) \
+		((((x) >> (SCL_FILTER_FT_FIXPOINT_SHIFT - 1)) + 1) >> 1)
+
+#define SCL_GET_FILTER_FT_FIXPOINT(ca, shift) \
+		(((ca) >> ((shift)-SCL_FILTER_FT_FIXPOINT_SHIFT)) & \
+		 (SCL_FILTER_FT_FIXPOINT_ONE - 1))
+
+#define SCL_OFFSET_FIXPOINT_SHIFT	8
+#define SCL_OFFSET_FIXPOINT(x) \
+		((INT32)((x) * (1 << SCL_OFFSET_FIXPOINT_SHIFT)))
+
 #endif /* _ROCKCHIP_DRM_VOP_H */
-- 
1.7.9.5
