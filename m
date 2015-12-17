From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:37:04 +0800
Subject: [PATCH 4/6] drm/rockchip: vop: spilt scale regsters
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450323426-32109-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two version scale control register found on vop,
scale full version found on rk3288, support extension registers.
and scale little version found on rk3036, only support common scale.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   46 ++++++++++++++++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   14 ++++++--
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |    5 ++-
 3 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index bbb781c..d83bf87 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -50,6 +50,8 @@
 		REG_SET(x, win->base, win->phy->name, v, RELAXED)
 #define VOP_SCL_SET(x, win, name, v) \
 		REG_SET(x, win->base, win->phy->scl->name, v, RELAXED)
+#define VOP_SCL_SET_EXT(x, win, name, v) \
+		REG_SET(x, win->base, win->phy->scl->ext->name, v, RELAXED)
 #define VOP_CTRL_SET(x, name, v) \
 		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
 
@@ -313,6 +315,20 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 		return;
 	}
 
+	if (!win->phy->scl->ext) {
+		VOP_SCL_SET(vop, win, scale_yrgb_x,
+			    scl_cal_scale2(src_w, dst_w));
+		VOP_SCL_SET(vop, win, scale_yrgb_y,
+			    scl_cal_scale2(src_h, dst_h));
+		if (is_yuv) {
+			VOP_SCL_SET(vop, win, scale_cbcr_x,
+				    scl_cal_scale2(src_w, dst_w));
+			VOP_SCL_SET(vop, win, scale_cbcr_y,
+				    scl_cal_scale2(src_h, dst_h));
+		}
+		return;
+	}
+
 	yrgb_hor_scl_mode = scl_get_scl_mode(src_w, dst_w);
 	yrgb_ver_scl_mode = scl_get_scl_mode(src_h, dst_h);
 
@@ -330,7 +346,7 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 			lb_mode = scl_vop_cal_lb_mode(src_w, false);
 	}
 
-	VOP_SCL_SET(vop, win, lb_mode, lb_mode);
+	VOP_SCL_SET_EXT(vop, win, lb_mode, lb_mode);
 	if (lb_mode == LB_RGB_3840X2) {
 		if (yrgb_ver_scl_mode != SCALE_NONE) {
 			DRM_ERROR("ERROR : not allow yrgb ver scale\n");
@@ -354,14 +370,14 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 				false, vsu_mode, &vskiplines);
 	VOP_SCL_SET(vop, win, scale_yrgb_y, val);
 
-	VOP_SCL_SET(vop, win, vsd_yrgb_gt4, vskiplines == 4);
-	VOP_SCL_SET(vop, win, vsd_yrgb_gt2, vskiplines == 2);
+	VOP_SCL_SET_EXT(vop, win, vsd_yrgb_gt4, vskiplines == 4);
+	VOP_SCL_SET_EXT(vop, win, vsd_yrgb_gt2, vskiplines == 2);
 
-	VOP_SCL_SET(vop, win, yrgb_hor_scl_mode, yrgb_hor_scl_mode);
-	VOP_SCL_SET(vop, win, yrgb_ver_scl_mode, yrgb_ver_scl_mode);
-	VOP_SCL_SET(vop, win, yrgb_hsd_mode, SCALE_DOWN_BIL);
-	VOP_SCL_SET(vop, win, yrgb_vsd_mode, SCALE_DOWN_BIL);
-	VOP_SCL_SET(vop, win, yrgb_vsu_mode, vsu_mode);
+	VOP_SCL_SET_EXT(vop, win, yrgb_hor_scl_mode, yrgb_hor_scl_mode);
+	VOP_SCL_SET_EXT(vop, win, yrgb_ver_scl_mode, yrgb_ver_scl_mode);
+	VOP_SCL_SET_EXT(vop, win, yrgb_hsd_mode, SCALE_DOWN_BIL);
+	VOP_SCL_SET_EXT(vop, win, yrgb_vsd_mode, SCALE_DOWN_BIL);
+	VOP_SCL_SET_EXT(vop, win, yrgb_vsu_mode, vsu_mode);
 	if (is_yuv) {
 		val = scl_vop_cal_scale(cbcr_hor_scl_mode, cbcr_src_w,
 					dst_w, true, 0, NULL);
@@ -370,13 +386,13 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 					dst_h, false, vsu_mode, &vskiplines);
 		VOP_SCL_SET(vop, win, scale_cbcr_y, val);
 
-		VOP_SCL_SET(vop, win, vsd_cbcr_gt4, vskiplines == 4);
-		VOP_SCL_SET(vop, win, vsd_cbcr_gt2, vskiplines == 2);
-		VOP_SCL_SET(vop, win, cbcr_hor_scl_mode, cbcr_hor_scl_mode);
-		VOP_SCL_SET(vop, win, cbcr_ver_scl_mode, cbcr_ver_scl_mode);
-		VOP_SCL_SET(vop, win, cbcr_hsd_mode, SCALE_DOWN_BIL);
-		VOP_SCL_SET(vop, win, cbcr_vsd_mode, SCALE_DOWN_BIL);
-		VOP_SCL_SET(vop, win, cbcr_vsu_mode, vsu_mode);
+		VOP_SCL_SET_EXT(vop, win, vsd_cbcr_gt4, vskiplines == 4);
+		VOP_SCL_SET_EXT(vop, win, vsd_cbcr_gt2, vskiplines == 2);
+		VOP_SCL_SET_EXT(vop, win, cbcr_hor_scl_mode, cbcr_hor_scl_mode);
+		VOP_SCL_SET_EXT(vop, win, cbcr_ver_scl_mode, cbcr_ver_scl_mode);
+		VOP_SCL_SET_EXT(vop, win, cbcr_hsd_mode, SCALE_DOWN_BIL);
+		VOP_SCL_SET_EXT(vop, win, cbcr_vsd_mode, SCALE_DOWN_BIL);
+		VOP_SCL_SET_EXT(vop, win, cbcr_vsu_mode, vsu_mode);
 	}
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index cbb114a..9a44153 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -66,7 +66,8 @@ struct vop_intr {
 	struct vop_reg clear;
 	struct vop_reg status;
 };
-struct vop_scl_regs {
+
+struct vop_scl_extension {
 	struct vop_reg cbcr_vsd_mode;
 	struct vop_reg cbcr_vsu_mode;
 	struct vop_reg cbcr_hsd_mode;
@@ -87,8 +88,12 @@ struct vop_scl_regs {
 	struct vop_reg bic_coe_sel;
 	struct vop_reg cbcr_axi_gather_en;
 	struct vop_reg yrgb_axi_gather_en;
-
 	struct vop_reg lb_mode;
+};
+
+struct vop_scl_regs {
+	const struct vop_scl_extension *ext;
+
 	struct vop_reg scale_yrgb_x;
 	struct vop_reg scale_yrgb_y;
 	struct vop_reg scale_cbcr_x;
@@ -242,6 +247,11 @@ static inline uint16_t scl_cal_scale(int src, int dst, int shift)
 	return ((src * 2 - 3) << (shift - 1)) / (dst - 1);
 }
 
+static inline uint16_t scl_cal_scale2(int src, int dst)
+{
+	return (src - 1) << 12 / (dst - 1);
+}
+
 #define GET_SCL_FT_BILI_DN(src, dst)	scl_cal_scale(src, dst, 12)
 #define GET_SCL_FT_BILI_UP(src, dst)	scl_cal_scale(src, dst, 16)
 #define GET_SCL_FT_BIC(src, dst)	scl_cal_scale(src, dst, 16)
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d47bfc3..6495114 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -50,7 +50,7 @@ static const uint32_t formats_234[] = {
 	DRM_FORMAT_BGR565,
 };
 
-static const struct vop_scl_regs win_full_scl = {
+static const struct vop_scl_extension win_full_ext = {
 	.cbcr_vsd_mode = VOP_REG(WIN0_CTRL1, 0x1, 31),
 	.cbcr_vsu_mode = VOP_REG(WIN0_CTRL1, 0x1, 30),
 	.cbcr_hsd_mode = VOP_REG(WIN0_CTRL1, 0x3, 28),
@@ -72,6 +72,9 @@ static const struct vop_scl_regs win_full_scl = {
 	.cbcr_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 1),
 	.yrgb_axi_gather_en = VOP_REG(WIN0_CTRL1, 0x1, 0),
 	.lb_mode = VOP_REG(WIN0_CTRL0, 0x7, 5),
+};
+
+static const struct vop_scl_regs win_full_scl = {
 	.scale_yrgb_x = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
 	.scale_cbcr_x = VOP_REG(WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
-- 
1.7.9.5
