From: mark.yao@rock-chips.com (Mark Yao)
Date: Sun,  5 Feb 2017 15:36:36 +0800
Subject: [PATCH 1/2] drm/rockchip: support mode_valid for crtc
Message-ID: <1486280197-1585-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm crtc already has mode_fixup callback to can do mode check, but
We actually want to valid display mode on connector getmode time,
mode_fixup can't do it.

So add a private mode_valid callback to rockchip crtc, connectors can
check mode with this mode_valid callback.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  2 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 15 +++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  7 +++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 13 +++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index fb6226c..d10b15c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -39,6 +39,8 @@
 struct rockchip_crtc_funcs {
 	int (*enable_vblank)(struct drm_crtc *crtc);
 	void (*disable_vblank)(struct drm_crtc *crtc);
+	enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
+					   const struct drm_display_mode *mode);
 };
 
 struct rockchip_crtc_state {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb5f001..256fe73 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -853,9 +853,24 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
 	spin_unlock_irqrestore(&vop->irq_lock, flags);
 }
 
+static enum drm_mode_status
+vop_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
+{
+	struct vop *vop = to_vop(crtc);
+	const struct vop_data *vop_data = vop->data;
+
+	if (mode->hdisplay > vop_data->max_output.width)
+		return MODE_BAD_HVALUE;
+	if (mode->vdisplay > vop_data->max_output.height)
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
 static const struct rockchip_crtc_funcs private_crtc_funcs = {
 	.enable_vblank = vop_crtc_enable_vblank,
 	.disable_vblank = vop_crtc_disable_vblank,
+	.mode_valid = vop_crtc_mode_valid,
 };
 
 static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 1dbc526..9e9dba1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -133,6 +133,11 @@ struct vop_win_data {
 	enum drm_plane_type type;
 };
 
+struct vop_rect {
+	int width;
+	int height;
+};
+
 struct vop_data {
 	const struct vop_reg_data *init_table;
 	unsigned int table_size;
@@ -140,6 +145,8 @@ struct vop_data {
 	const struct vop_intr *intr;
 	const struct vop_win_data *win;
 	unsigned int win_size;
+	struct vop_rect max_input;
+	struct vop_rect max_output;
 };
 
 /* interrupt define */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 35c51f3..0c72361 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -132,6 +132,8 @@
 };
 
 static const struct vop_data rk3036_vop = {
+	.max_input = { 1920, 1080},
+	.max_output = { 1920, 1080},
 	.init_table = rk3036_vop_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3036_vop_init_reg_table),
 	.ctrl = &rk3036_ctrl_data,
@@ -273,6 +275,13 @@
 };
 
 static const struct vop_data rk3288_vop = {
+	.max_input = { 4096, 8192},
+	/*
+	 * TODO: rk3288 have two vop, big one support 3840x2160,
+	 * little one only support 2560x1600.
+	 * Now force use 3840x2160.
+	 */
+	.max_output = { 3840, 2160},
 	.init_table = rk3288_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3288_init_reg_table),
 	.intr = &rk3288_vop_intr,
@@ -339,6 +348,8 @@
 };
 
 static const struct vop_data rk3399_vop_big = {
+	.max_input = { 4096, 8192},
+	.max_output = { 4096, 2160},
 	.init_table = rk3399_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
 	.intr = &rk3399_vop_intr,
@@ -358,6 +369,8 @@
 };
 
 static const struct vop_data rk3399_vop_lit = {
+	.max_input = { 4096, 8192},
+	.max_output = { 2560, 1600},
 	.init_table = rk3399_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
 	.intr = &rk3399_vop_intr,
-- 
1.9.1
