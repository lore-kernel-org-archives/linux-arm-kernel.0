From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed,  6 Apr 2016 12:14:45 +0200
Subject: [PATCH 1/2] drm/rockchip: vop: Do check if an update is pending
 during disable
Message-ID: <1459937686-9142-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a plane is being disabled but it's still enabled, do check if the
previous update has been completed by reading yrgb_mst back.

Otherwise, pending pageflips would remain pending after a CRTC is
disabled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a9b1e8b5ac85..f46b1fd1887b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1064,8 +1064,9 @@ static bool vop_win_pending_is_complete(struct vop_win *vop_win)
 	struct vop_plane_state *state = to_vop_plane_state(plane->state);
 	dma_addr_t yrgb_mst;
 
-	if (!state->enable)
-		return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
+	if (!state->enable &&
+	    VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0)
+		return true;
 
 	yrgb_mst = VOP_WIN_GET_YRGBADDR(vop_win->vop, vop_win->data);
 
-- 
2.5.5
