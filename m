From: mark.yao@rock-chips.com (Mark Yao)
Date: Sat, 10 Sep 2016 10:29:04 +0800
Subject: [PATCH 3/3] drm/rockchip: vop: support afdc for rk3399 vop
In-Reply-To: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
References: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1473474544-16248-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rk3399 vop big can support one afbc decoder, the afbdc decoder
can select which overlay window use it.

afbdc window has some limit:
  1, not support offset on source buffer.
  2, if feed non-afbc buffer to afbc decoder, afbc decoder hardware
     would die, we need take care of using it.

AFBC is a compressed format, means lower bandwidth consume,
it's useful to improve performance.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  6 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 89 +++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 13 +++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  7 +++
 4 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index ea39329..1e07fd6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -44,6 +44,12 @@ struct rockchip_crtc_funcs {
 
 struct rockchip_crtc_state {
 	struct drm_crtc_state base;
+	int afbdc_win_format;
+	int afbdc_win_width;
+	int afbdc_win_height;
+	int afbdc_win_ptr;
+	int afbdc_win_id;
+	int afbdc_en;
 	int output_type;
 	int output_mode;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 834456f..6918223 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -99,6 +99,7 @@ struct vop_win {
 	struct drm_plane base;
 	const struct vop_win_data *data;
 	struct vop *vop;
+	int id;
 
 	/* protected by dev->event_lock */
 	bool enable;
@@ -514,6 +515,7 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 		VOP_WIN_SET(vop, win, enable, 0);
 		spin_unlock(&vop->reg_lock);
 	}
+	VOP_CTRL_SET(vop, afbdc_en, 0);
 
 	drm_crtc_vblank_off(crtc);
 
@@ -1007,9 +1009,81 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	VOP_CTRL_SET(vop, standby, 0);
 }
 
+static int vop_afbdc_atomic_check(struct drm_crtc *crtc,
+				  struct drm_crtc_state *crtc_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct drm_atomic_state *state = crtc_state->state;
+	struct drm_plane *plane;
+	struct drm_plane_state *pstate;
+	struct vop_plane_state *plane_state;
+	struct vop_win *win;
+	int afbdc_format;
+	int i;
+
+	s->afbdc_en = 0;
+
+	for_each_plane_in_state(state, plane, pstate, i) {
+		struct drm_framebuffer *fb = pstate->fb;
+		struct drm_rect *src;
+
+		win = to_vop_win(plane);
+		plane_state = to_vop_plane_state(pstate);
+
+		if (pstate->crtc != crtc || !fb)
+			continue;
+
+		if (fb->modifier[0] != DRM_FORMAT_MOD_ARM_AFBC)
+			continue;
+
+		switch (plane_state->format) {
+		case VOP_FMT_ARGB8888:
+			afbdc_format = AFBDC_FMT_U8U8U8U8;
+			break;
+		case VOP_FMT_RGB888:
+			afbdc_format = AFBDC_FMT_U8U8U8;
+			break;
+		case VOP_FMT_RGB565:
+			afbdc_format = AFBDC_FMT_RGB565;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (s->afbdc_en) {
+			DRM_ERROR("vop only support one afbc layer\n");
+			return -EINVAL;
+		}
+
+		src = &pstate->src;
+		if (src->x1 || src->y1 || fb->offsets[0]) {
+			DRM_ERROR("win[%d] afbdc not support offset display\n",
+				  win->id);
+			DRM_ERROR("xpos=%d, ypos=%d, offset=%d\n",
+				  src->x1, src->y1, fb->offsets[0]);
+			return -EINVAL;
+		}
+		s->afbdc_win_format = afbdc_format;
+		s->afbdc_win_width = pstate->fb->width - 1;
+		s->afbdc_win_height = (drm_rect_height(src) >> 16) - 1;
+		s->afbdc_win_id = win->id;
+		s->afbdc_win_ptr = plane_state->yrgb_mst;
+		s->afbdc_en = 1;
+	}
+
+	return 0;
+}
+
+static int vop_crtc_atomic_check(struct drm_crtc *crtc,
+				 struct drm_crtc_state *crtc_state)
+{
+	return vop_afbdc_atomic_check(crtc, crtc_state);
+}
+
 static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc->state);
 	struct vop *vop = to_vop(crtc);
 
 	if (WARN_ON(!vop->is_enabled))
@@ -1017,6 +1091,19 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	spin_lock(&vop->reg_lock);
 
+	if (s->afbdc_en) {
+		uint32_t pic_size;
+
+		VOP_CTRL_SET(vop, afbdc_format, s->afbdc_win_format | 1 << 4);
+		VOP_CTRL_SET(vop, afbdc_hreg_block_split, 0);
+		VOP_CTRL_SET(vop, afbdc_sel, s->afbdc_win_id);
+		VOP_CTRL_SET(vop, afbdc_hdr_ptr, s->afbdc_win_ptr);
+		pic_size = (s->afbdc_win_width & 0xffff);
+		pic_size |= s->afbdc_win_height << 16;
+		VOP_CTRL_SET(vop, afbdc_pic_size, pic_size);
+	}
+
+	VOP_CTRL_SET(vop, afbdc_en, s->afbdc_en);
 	vop_cfg_done(vop);
 
 	spin_unlock(&vop->reg_lock);
@@ -1042,6 +1129,7 @@ static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
 	.enable = vop_crtc_enable,
 	.disable = vop_crtc_disable,
 	.mode_fixup = vop_crtc_mode_fixup,
+	.atomic_check = vop_crtc_atomic_check,
 	.atomic_flush = vop_crtc_atomic_flush,
 	.atomic_begin = vop_crtc_atomic_begin,
 };
@@ -1413,6 +1501,7 @@ static void vop_win_init(struct vop *vop)
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win_data = &vop_data->win[i];
 
+		vop_win->id = i;
 		vop_win->data = win_data;
 		vop_win->vop = vop;
 	}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index ff4f52e..b9b120e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -15,6 +15,10 @@
 #ifndef _ROCKCHIP_DRM_VOP_H
 #define _ROCKCHIP_DRM_VOP_H
 
+#define AFBDC_FMT_RGB565	0x0
+#define AFBDC_FMT_U8U8U8U8	0x5
+#define AFBDC_FMT_U8U8U8	0x4
+
 enum vop_data_format {
 	VOP_FMT_ARGB8888 = 0,
 	VOP_FMT_RGB888,
@@ -61,6 +65,15 @@ struct vop_ctrl {
 	struct vop_reg hpost_st_end;
 	struct vop_reg vpost_st_end;
 
+	/* AFBDC */
+	struct vop_reg afbdc_en;
+	struct vop_reg afbdc_sel;
+	struct vop_reg afbdc_format;
+	struct vop_reg afbdc_hreg_block_split;
+	struct vop_reg afbdc_pic_size;
+	struct vop_reg afbdc_hdr_ptr;
+	struct vop_reg afbdc_rstn;
+
 	struct vop_reg cfg_done;
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index f1a1688..a09437c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -300,6 +300,13 @@ static const struct vop_ctrl rk3399_ctrl_data = {
 	.vact_st_end = VOP_REG(RK3399_DSP_VACT_ST_END, 0x1fff1fff, 0),
 	.hpost_st_end = VOP_REG(RK3399_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
 	.vpost_st_end = VOP_REG(RK3399_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
+	.afbdc_rstn = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 3),
+	.afbdc_en = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 0),
+	.afbdc_sel = VOP_REG(RK3399_AFBCD0_CTRL, 0x3, 1),
+	.afbdc_format = VOP_REG(RK3399_AFBCD0_CTRL, 0x1f, 16),
+	.afbdc_hreg_block_split = VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 21),
+	.afbdc_hdr_ptr = VOP_REG(RK3399_AFBCD0_HDR_PTR, 0xffffffff, 0),
+	.afbdc_pic_size = VOP_REG(RK3399_AFBCD0_PIC_SIZE, 0xffffffff, 0),
 	.cfg_done = VOP_REG_MASK(RK3399_REG_CFG_DONE, 0x1, 0),
 };
 
-- 
1.9.1
