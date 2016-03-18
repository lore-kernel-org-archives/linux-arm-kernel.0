From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 18 Mar 2016 12:22:27 +0100
Subject: [PATCH] drm/rockchip: vop: Reset yrgb_mst when re-enabling
Message-ID: <1458300147-6472-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the VOP is re-enabled, it will start scanning right away the
framebuffers that were configured from the last time, even if those have
been destroyed already. To prevent the VOP from trying to access freed
memory, reset the registers that hold pointers to framebuffers right
after we can write to them, but before the VOP is awaken from standby.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Link: http://lkml.kernel.org/g/CAAObsKAv+05ih5U+=4kic_NsjGMhfxYheHR8xXXmacZs+p5SHw at mail.gmail.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5e57f5b2e4b0..0df91c28740b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -429,6 +429,7 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
 static void vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	int i;
 	int ret;
 
 	if (vop->is_enabled)
@@ -476,6 +477,18 @@ static void vop_enable(struct drm_crtc *crtc)
 	 */
 	vop->is_enabled = true;
 
+	/*
+	 * Before turning the VOP completely on, unset the registers
+	 * containing FB addresses to avoid the HW start scanning old FBs.
+	 */
+	for (i = 0; i < vop->data->win_size; i++) {
+		struct vop_win *vop_win = &vop->win[i];
+		const struct vop_win_data *win = vop_win->data;
+
+		VOP_WIN_SET(vop, win, yrgb_mst, 0x0);
+		VOP_WIN_SET(vop, win, uv_mst, 0x0);
+	}
+
 	spin_lock(&vop->reg_lock);
 
 	VOP_CTRL_SET(vop, standby, 0);
-- 
2.5.0
