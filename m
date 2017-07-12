From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Wed, 12 Jul 2017 10:13:37 +0200
Subject: [PATCH 09/16] drm/rockchip: Use for_each_oldnew_plane_in_state in
 vop_crtc_atomic_flush
In-Reply-To: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
References: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
Message-ID: <20170712081344.25495-10-maarten.lankhorst@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for_each_obj_in_state is about to be removed, so use the new atomic
iterator macros.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Mark Yao <mark.yao@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ee876a9631f0..f90088b1a247 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1029,7 +1029,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
 	struct drm_atomic_state *old_state = old_crtc_state->state;
-	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct vop *vop = to_vop(crtc);
 	struct drm_plane *plane;
 	int i;
@@ -1060,11 +1060,12 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
-	for_each_plane_in_state(old_state, plane, old_plane_state, i) {
+	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state,
+				       new_plane_state, i) {
 		if (!old_plane_state->fb)
 			continue;
 
-		if (old_plane_state->fb == plane->state->fb)
+		if (old_plane_state->fb == new_plane_state->fb)
 			continue;
 
 		drm_framebuffer_reference(old_plane_state->fb);
-- 
2.11.0
