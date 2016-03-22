From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 22 Mar 2016 16:08:04 +0100
Subject: [PATCH v2] drm/rockchip: vop: Disable planes when disabling CRTC
Message-ID: <1458659284-14039-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a VOP is re-enabled, it will start scanning right away the
framebuffers that were configured from the last time, even if those have
been destroyed already.

To prevent the VOP from trying to access freed memory, disable all its
windows when the CRTC is being disabled, then each window will get a
valid framebuffer address before it's enabled again.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Link: http://lkml.kernel.org/g/CAAObsKAv+05ih5U+=4kic_NsjGMhfxYheHR8xXXmacZs+p5SHw at mail.gmail.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5e57f5b2e4b0..e2118e62345b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -499,10 +499,25 @@ err_disable_hclk:
 static void vop_crtc_disable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
+	int i;
 
 	if (!vop->is_enabled)
 		return;
 
+	/*
+	 * We need to make sure that all windows are disabled before we
+	 * disable that crtc. Otherwise we might try to scan from a destroyed
+	 * buffer later.
+	 */
+	for (i = 0; i < vop->data->win_size; i++) {
+		struct vop_win *vop_win = &vop->win[i];
+		const struct vop_win_data *win = vop_win->data;
+
+		spin_lock(&vop->reg_lock);
+		VOP_WIN_SET(vop, win, enable, 0);
+		spin_unlock(&vop->reg_lock);
+	}
+
 	drm_crtc_vblank_off(crtc);
 
 	/*
-- 
2.5.0
