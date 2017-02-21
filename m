From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue, 21 Feb 2017 10:41:24 +0800
Subject: [PATCH 1/2] drm/rockchip: vop: verify display mode with vop max_output
Message-ID: <1487644885-22492-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  6 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  7 +++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 8dab2af..7ec5d7f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -867,6 +867,12 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 				struct drm_display_mode *adjusted_mode)
 {
 	struct vop *vop = to_vop(crtc);
+	const struct vop_data *vop_data = vop->data;
+
+	if (mode->hdisplay > vop_data->max_output.width)
+		return false;
+	if (mode->vdisplay > vop_data->max_output.height)
+		return false;
 
 	adjusted_mode->clock =
 		clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 5a4faa85..de5a714 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -135,6 +135,11 @@ struct vop_win_data {
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
@@ -142,6 +147,8 @@ struct vop_data {
 	const struct vop_intr *intr;
 	const struct vop_win_data *win;
 	unsigned int win_size;
+	struct vop_rect max_input;
+	struct vop_rect max_output;
 };
 
 /* interrupt define */
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 91fbc7b..f4ffb677 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -132,6 +132,8 @@
 };
 
 static const struct vop_data rk3036_vop = {
+	.max_input = {1920, 1080},
+	.max_output = {1920, 1080},
 	.init_table = rk3036_vop_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3036_vop_init_reg_table),
 	.ctrl = &rk3036_ctrl_data,
@@ -273,6 +275,13 @@
 };
 
 static const struct vop_data rk3288_vop = {
+	.max_input = {4096, 8192},
+	/*
+	 * TODO: rk3288 have two vop, big one support 3840x2160,
+	 * little one only support 2560x1600.
+	 * Now force use 3840x2160.
+	 */
+	.max_output = {3840, 2160},
 	.init_table = rk3288_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3288_init_reg_table),
 	.intr = &rk3288_vop_intr,
@@ -341,6 +350,8 @@
 };
 
 static const struct vop_data rk3399_vop_big = {
+	.max_input = {4096, 8192},
+	.max_output = {4096, 2160},
 	.init_table = rk3399_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
 	.intr = &rk3399_vop_intr,
@@ -360,6 +371,8 @@
 };
 
 static const struct vop_data rk3399_vop_lit = {
+	.max_input = {4096, 8192},
+	.max_output = {2560, 1600},
 	.init_table = rk3399_init_reg_table,
 	.table_size = ARRAY_SIZE(rk3399_init_reg_table),
 	.intr = &rk3399_vop_intr,
-- 
1.9.1
