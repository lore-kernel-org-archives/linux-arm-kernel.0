From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 14 Sep 2016 21:54:55 +0900
Subject: [PATCH 2/8] drm/rockchip: Get rid of some unnecessary code
In-Reply-To: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
References: <1473857701-9250-1-git-send-email-tfiga@chromium.org>
Message-ID: <1473857701-9250-3-git-send-email-tfiga@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code implements prepare_fb and cleanup_fb callbacks only to
grab/release fb references, which is already done by atomic framework
when creating/destryoing plane state. Let's remove these
unused bits.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7e811cf..68988c6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -641,22 +641,6 @@ static void vop_plane_destroy(struct drm_plane *plane)
 	drm_plane_cleanup(plane);
 }
 
-static int vop_plane_prepare_fb(struct drm_plane *plane,
-				struct drm_plane_state *new_state)
-{
-	if (plane->state->fb)
-		drm_framebuffer_reference(plane->state->fb);
-
-	return 0;
-}
-
-static void vop_plane_cleanup_fb(struct drm_plane *plane,
-				 struct drm_plane_state *old_state)
-{
-	if (old_state->fb)
-		drm_framebuffer_unreference(old_state->fb);
-}
-
 static int vop_plane_atomic_check(struct drm_plane *plane,
 			   struct drm_plane_state *state)
 {
@@ -849,8 +833,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 }
 
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
-	.prepare_fb = vop_plane_prepare_fb,
-	.cleanup_fb = vop_plane_cleanup_fb,
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
-- 
2.8.0.rc3.226.g39d4020
