From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed,  6 Apr 2016 12:14:46 +0200
Subject: [PATCH 2/2] drm/rockchip: vop: Wait for pending events when disabling
 a CRTC
In-Reply-To: <1459937686-9142-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1459937686-9142-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1459937686-9142-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a VOP is disabled, it will stop raising interrupts. If we had a
pending pageflip when the VOP is disabled, userspace won't get that
event until the corresponding CRTC is enabled again.

So let's wait for any pending events that may be right before disabling
a CRTC.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f46b1fd1887b..6dc87fa96f29 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -142,6 +142,8 @@ struct vop {
 	struct vop_win win[];
 };
 
+static void vop_crtc_wait_for_update(struct drm_crtc *crtc);
+
 static inline void vop_writel(struct vop *vop, uint32_t offset, uint32_t v)
 {
 	writel(v, vop->regs + offset);
@@ -504,6 +506,9 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 	if (!vop->is_enabled)
 		return;
 
+	if (crtc->state->event || vop->event)
+		vop_crtc_wait_for_update(crtc);
+
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
-- 
2.5.5
