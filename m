From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 26 Jul 2016 15:46:33 +0800
Subject: [PATCH 2/3] drm/rockchip: vop: support multi area plane
In-Reply-To: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
References: <1469519194-23133-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1469519194-23133-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series vop of VOP_FULL framework support area plane, such as
RK3288 and RK3399, one group of area planes share same hardware,
reuse the hardware on different scanout time, this design is
useful to support mulit planes with low hardware consume.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 191 +++++++++++++++++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   4 +-
 2 files changed, 123 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 91305eb..bd084c0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -41,17 +41,19 @@
 #define __REG_SET_NORMAL(x, off, mask, shift, v) \
 		vop_mask_write(x, off, (mask) << shift, (v) << shift)
 
-#define REG_SET(x, base, reg, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, reg.mask, reg.shift, v)
-#define REG_SET_MASK(x, base, reg, mask, v, mode) \
-		__REG_SET_##mode(x, base + reg.offset, mask, reg.shift, v)
+#define REG_SET(x, off, reg, v, mode) \
+		__REG_SET_##mode(x, off + reg.offset, \
+				 reg.mask, reg.shift, v)
+#define REG_SET_MASK(x, off, reg, mask, v, mode) \
+		__REG_SET_##mode(x, off + reg.offset, mask, reg.shift, v)
 
 #define VOP_WIN_SET(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->name, v, RELAXED)
+		REG_SET(x, win->offset, VOP_WIN_NAME(win, name), v, RELAXED)
 #define VOP_SCL_SET(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->scl->name, v, RELAXED)
+		REG_SET(x, win->offset, win->phy->scl->name, v, RELAXED)
 #define VOP_SCL_SET_EXT(x, win, name, v) \
-		REG_SET(x, win->base, win->phy->scl->ext->name, v, RELAXED)
+		REG_SET(x, win->offset, win->phy->scl->ext->name, v, RELAXED)
+
 #define VOP_CTRL_SET(x, name, v) \
 		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
 
@@ -75,10 +77,13 @@
 		vop_get_intr_type(vop, &vop->data->intr->name, type)
 
 #define VOP_WIN_GET(x, win, name) \
-		vop_read_reg(x, win->base, &win->phy->name)
+		vop_read_reg(x, win->offset, &VOP_WIN_NAME(win, name))
+
+#define VOP_WIN_NAME(win, name) \
+		(vop_get_win_phy(win, &win->phy->name)->name)
 
 #define VOP_WIN_GET_YRGBADDR(vop, win) \
-		vop_readl(vop, win->base + win->phy->yrgb_mst.offset)
+		vop_readl(vop, win->offset + VOP_WIN_NAME(win, yrgb_mst).offset)
 
 #define to_vop(x) container_of(x, struct vop, crtc)
 #define to_vop_win(x) container_of(x, struct vop_win, base)
@@ -94,8 +99,14 @@ struct vop_plane_state {
 };
 
 struct vop_win {
+	struct vop_win *parent;
 	struct drm_plane base;
-	const struct vop_win_data *data;
+
+	uint32_t offset;
+	enum drm_plane_type type;
+	const struct vop_win_phy *phy;
+	const uint32_t *data_formats;
+	uint32_t nformats;
 	struct vop *vop;
 
 	/* protected by dev->event_lock */
@@ -119,6 +130,7 @@ struct vop {
 	struct drm_pending_vblank_event *event;
 
 	const struct vop_data *data;
+	int num_wins;
 
 	uint32_t *regsbak;
 	void __iomem *regs;
@@ -187,6 +199,15 @@ static inline void vop_mask_write_relaxed(struct vop *vop, uint32_t offset,
 	}
 }
 
+static inline const struct vop_win_phy *
+vop_get_win_phy(struct vop_win *win, const struct vop_reg *reg)
+{
+	if (!reg->mask && win->parent)
+		return win->parent->phy;
+
+	return win->phy;
+}
+
 static inline uint32_t vop_get_intr_type(struct vop *vop,
 					 const struct vop_reg *reg, int type)
 {
@@ -299,9 +320,9 @@ static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
 	return val;
 }
 
-static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
-			     uint32_t src_w, uint32_t src_h, uint32_t dst_w,
-			     uint32_t dst_h, uint32_t pixel_format)
+static void scl_vop_cal_scl_fac(struct vop *vop, struct vop_win *win,
+				uint32_t src_w, uint32_t src_h, uint32_t dst_w,
+				uint32_t dst_h, uint32_t pixel_format)
 {
 	uint16_t yrgb_hor_scl_mode, yrgb_ver_scl_mode;
 	uint16_t cbcr_hor_scl_mode = SCALE_NONE;
@@ -316,6 +337,9 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
 	uint32_t val;
 	int vskiplines = 0;
 
+	if (!win->phy->scl)
+		return;
+
 	if (dst_w > 3840) {
 		DRM_ERROR("Maximum destination width (3840) exceeded\n");
 		return;
@@ -509,9 +533,8 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
 	 * buffer later.
 	 */
-	for (i = 0; i < vop->data->win_size; i++) {
-		struct vop_win *vop_win = &vop->win[i];
-		const struct vop_win_data *win = vop_win->data;
+	for (i = 0; i < vop->num_wins; i++) {
+		struct vop_win *win = &vop->win[i];
 
 		spin_lock(&vop->reg_lock);
 		VOP_WIN_SET(vop, win, enable, 0);
@@ -590,9 +613,8 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
 	struct drm_crtc *crtc = state->crtc;
 	struct drm_crtc_state *crtc_state;
 	struct drm_framebuffer *fb = state->fb;
-	struct vop_win *vop_win = to_vop_win(plane);
+	struct vop_win *win = to_vop_win(plane);
 	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
-	const struct vop_win_data *win = vop_win->data;
 	bool visible;
 	int ret;
 	struct drm_rect *dest = &vop_plane_state->dest;
@@ -660,16 +682,15 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
 	struct vop_plane_state *vop_plane_state = to_vop_plane_state(old_state);
-	struct vop_win *vop_win = to_vop_win(plane);
-	const struct vop_win_data *win = vop_win->data;
+	struct vop_win *win = to_vop_win(plane);
 	struct vop *vop = to_vop(old_state->crtc);
 
 	if (!old_state->crtc)
 		return;
 
 	spin_lock_irq(&plane->dev->event_lock);
-	vop_win->enable = false;
-	vop_win->yrgb_mst = 0;
+	win->enable = false;
+	win->yrgb_mst = 0;
 	spin_unlock_irq(&plane->dev->event_lock);
 
 	spin_lock(&vop->reg_lock);
@@ -686,9 +707,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_crtc *crtc = state->crtc;
-	struct vop_win *vop_win = to_vop_win(plane);
+	struct vop_win *win = to_vop_win(plane);
 	struct vop_plane_state *vop_plane_state = to_vop_plane_state(state);
-	const struct vop_win_data *win = vop_win->data;
 	struct vop *vop = to_vop(state->crtc);
 	struct drm_framebuffer *fb = state->fb;
 	unsigned int actual_w, actual_h;
@@ -736,8 +756,8 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	vop_plane_state->yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
 
 	spin_lock_irq(&plane->dev->event_lock);
-	vop_win->enable = true;
-	vop_win->yrgb_mst = vop_plane_state->yrgb_mst;
+	win->enable = true;
+	win->yrgb_mst = vop_plane_state->yrgb_mst;
 	spin_unlock_irq(&plane->dev->event_lock);
 
 	spin_lock(&vop->reg_lock);
@@ -761,10 +781,9 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, uv_mst, dma_addr);
 	}
 
-	if (win->phy->scl)
-		scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
-				    drm_rect_width(dest), drm_rect_height(dest),
-				    fb->pixel_format);
+	scl_vop_cal_scl_fac(vop, win, actual_w, actual_h,
+			    drm_rect_width(dest), drm_rect_height(dest),
+			    fb->pixel_format);
 
 	VOP_WIN_SET(vop, win, act_info, act_info);
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
@@ -1098,9 +1117,9 @@ static bool vop_win_pending_is_complete(struct vop_win *vop_win)
 	dma_addr_t yrgb_mst;
 
 	if (!vop_win->enable)
-		return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
+		return VOP_WIN_GET(vop_win->vop, vop_win, enable) == 0;
 
-	yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
+	yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win);
 
 	return yrgb_mst == vop_win->yrgb_mst;
 }
@@ -1112,7 +1131,7 @@ static void vop_handle_vblank(struct vop *vop)
 	unsigned long flags;
 	int i;
 
-	for (i = 0; i < vop->data->win_size; i++) {
+	for (i = 0; i < vop->num_wins; i++) {
 		if (!vop_win_pending_is_complete(&vop->win[i]))
 			return;
 	}
@@ -1176,15 +1195,35 @@ static irqreturn_t vop_isr(int irq, void *data)
 	return ret;
 }
 
+static int vop_plane_init(struct vop *vop, struct vop_win *win,
+			  unsigned long possible_crtcs)
+{
+	struct drm_plane *share = NULL;
+	int ret;
+
+	if (win->parent)
+		share = &win->parent->base;
+
+	ret = drm_share_plane_init(vop->drm_dev, &win->base, share,
+				   possible_crtcs, &vop_plane_funcs,
+				   win->data_formats, win->nformats, win->type);
+	if (ret) {
+		DRM_ERROR("failed to initialize plane\n");
+		return ret;
+	}
+	drm_plane_helper_add(&win->base, &plane_helper_funcs);
+
+	return 0;
+}
+
 static int vop_create_crtc(struct vop *vop)
 {
-	const struct vop_data *vop_data = vop->data;
 	struct device *dev = vop->dev;
 	struct drm_device *drm_dev = vop->drm_dev;
 	struct drm_plane *primary = NULL, *cursor = NULL, *plane, *tmp;
 	struct drm_crtc *crtc = &vop->crtc;
 	struct device_node *port;
-	int ret;
+	int ret = 0;
 	int i;
 
 	/*
@@ -1192,30 +1231,22 @@ static int vop_create_crtc(struct vop *vop)
 	 * to pass them to drm_crtc_init_with_planes, which sets the
 	 * "possible_crtcs" to the newly initialized crtc.
 	 */
-	for (i = 0; i < vop_data->win_size; i++) {
-		struct vop_win *vop_win = &vop->win[i];
-		const struct vop_win_data *win_data = vop_win->data;
+	for (i = 0; i < vop->num_wins; i++) {
+		struct vop_win *win = &vop->win[i];
 
-		if (win_data->type != DRM_PLANE_TYPE_PRIMARY &&
-		    win_data->type != DRM_PLANE_TYPE_CURSOR)
+		if (win->type != DRM_PLANE_TYPE_PRIMARY &&
+		    win->type != DRM_PLANE_TYPE_CURSOR)
 			continue;
 
-		ret = drm_universal_plane_init(vop->drm_dev, &vop_win->base,
-					       0, &vop_plane_funcs,
-					       win_data->phy->data_formats,
-					       win_data->phy->nformats,
-					       win_data->type, NULL);
-		if (ret) {
-			DRM_ERROR("failed to initialize plane\n");
+		if (vop_plane_init(vop, win, 0))
 			goto err_cleanup_planes;
-		}
 
-		plane = &vop_win->base;
-		drm_plane_helper_add(plane, &plane_helper_funcs);
+		plane = &win->base;
 		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
 			primary = plane;
 		else if (plane->type == DRM_PLANE_TYPE_CURSOR)
 			cursor = plane;
+
 	}
 
 	ret = drm_crtc_init_with_planes(drm_dev, crtc, primary, cursor,
@@ -1229,25 +1260,15 @@ static int vop_create_crtc(struct vop *vop)
 	 * Create drm_planes for overlay windows with possible_crtcs restricted
 	 * to the newly created crtc.
 	 */
-	for (i = 0; i < vop_data->win_size; i++) {
-		struct vop_win *vop_win = &vop->win[i];
-		const struct vop_win_data *win_data = vop_win->data;
+	for (i = 0; i < vop->num_wins; i++) {
+		struct vop_win *win = &vop->win[i];
 		unsigned long possible_crtcs = 1 << drm_crtc_index(crtc);
 
-		if (win_data->type != DRM_PLANE_TYPE_OVERLAY)
+		if (win->type != DRM_PLANE_TYPE_OVERLAY)
 			continue;
 
-		ret = drm_universal_plane_init(vop->drm_dev, &vop_win->base,
-					       possible_crtcs,
-					       &vop_plane_funcs,
-					       win_data->phy->data_formats,
-					       win_data->phy->nformats,
-					       win_data->type, NULL);
-		if (ret) {
-			DRM_ERROR("failed to initialize overlay plane\n");
+		if (vop_plane_init(vop, win, possible_crtcs))
 			goto err_cleanup_crtc;
-		}
-		drm_plane_helper_add(&vop_win->base, &plane_helper_funcs);
 	}
 
 	port = of_get_child_by_name(dev->of_node, "port");
@@ -1362,8 +1383,8 @@ static int vop_initial(struct vop *vop)
 	for (i = 0; i < vop_data->table_size; i++)
 		vop_writel(vop, init_table[i].offset, init_table[i].value);
 
-	for (i = 0; i < vop_data->win_size; i++) {
-		const struct vop_win_data *win = &vop_data->win[i];
+	for (i = 0; i < vop->num_wins; i++) {
+		struct vop_win *win = &vop->win[i];
 
 		VOP_WIN_SET(vop, win, enable, 0);
 	}
@@ -1405,14 +1426,34 @@ err_unprepare_dclk:
 static void vop_win_init(struct vop *vop)
 {
 	const struct vop_data *vop_data = vop->data;
-	unsigned int i;
+	unsigned int i, j;
+	unsigned int num_wins = 0;
 
 	for (i = 0; i < vop_data->win_size; i++) {
-		struct vop_win *vop_win = &vop->win[i];
+		struct vop_win *vop_win = &vop->win[num_wins];
 		const struct vop_win_data *win_data = &vop_data->win[i];
 
-		vop_win->data = win_data;
+		vop_win->phy = win_data->phy;
+		vop_win->offset = win_data->base;
+		vop_win->type = win_data->type;
+		vop_win->data_formats = win_data->phy->data_formats;
+		vop_win->nformats = win_data->phy->nformats;
 		vop_win->vop = vop;
+		num_wins++;
+
+		for (j = 0; j < win_data->area_size; j++) {
+			struct vop_win *vop_area = &vop->win[num_wins];
+			const struct vop_win_phy *area = win_data->area[j];
+
+			vop_area->parent = vop_win;
+			vop_area->offset = vop_win->offset;
+			vop_area->phy = area;
+			vop_area->type = DRM_PLANE_TYPE_OVERLAY;
+			vop_area->data_formats = vop_win->data_formats;
+			vop_area->nformats = vop_win->nformats;
+			vop_area->vop = vop;
+			num_wins++;
+		}
 	}
 }
 
@@ -1424,14 +1465,21 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	struct vop *vop;
 	struct resource *res;
 	size_t alloc_size;
-	int ret, irq;
+	int ret, irq, i;
+	int num_wins = 0;
 
 	vop_data = of_device_get_match_data(dev);
 	if (!vop_data)
 		return -ENODEV;
 
+	for (i = 0; i < vop_data->win_size; i++) {
+		const struct vop_win_data *win_data = &vop_data->win[i];
+
+		num_wins += win_data->area_size + 1;
+	}
+
 	/* Allocate vop struct and its vop_win array */
-	alloc_size = sizeof(*vop) + sizeof(*vop->win) * vop_data->win_size;
+	alloc_size = sizeof(*vop) + sizeof(*vop->win) * num_wins;
 	vop = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
 	if (!vop)
 		return -ENOMEM;
@@ -1439,6 +1487,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	vop->dev = dev;
 	vop->data = vop_data;
 	vop->drm_dev = drm_dev;
+	vop->num_wins = num_wins;
 	dev_set_drvdata(dev, vop);
 
 	vop_win_init(vop);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 071ff0b..def5afa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -122,8 +122,10 @@ struct vop_win_phy {
 
 struct vop_win_data {
 	uint32_t base;
-	const struct vop_win_phy *phy;
 	enum drm_plane_type type;
+	const struct vop_win_phy *phy;
+	const struct vop_win_phy **area;
+	unsigned int area_size;
 };
 
 struct vop_data {
-- 
1.9.1
