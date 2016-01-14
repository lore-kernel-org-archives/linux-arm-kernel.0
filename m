From: john@metanate.com (John Keeping)
Date: Thu, 14 Jan 2016 14:39:41 +0000
Subject: [PATCH 2/3] drm/rockchip: don't wait for vblank if fb hasn't changed
In-Reply-To: <cover.1452782114.git.john@metanate.com>
References: <cover.1452782114.git.john@metanate.com>
Message-ID: <2c23f18b4704d4f7126a0300d8875222502deb99.1452782114.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As commented in drm_atomic_helper_wait_for_vblanks(), userspace relies
on cursor ioctls being unsynced.  Converting the rockchip driver to
atomic has significantly impacted cursor performance by making every
cursor update wait for vblank.

By skipping the vblank sync when the framebuffer has not changed (as is
done in drm_atomic_helper_wait_for_vblanks()) we can avoid this for the
common case of moving the cursor and only need to delay the cursor ioctl
when the cursor icon changes.

We cannot add the check on legacy_cursor_update since that results in
the cursor bo being unreferenced while the hardware may still be reading
it.  Fully supporting unsynced cursor updates is left for the future
when the atomic helper framework supports async updates.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index f784488..679d23a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -178,7 +178,7 @@ static void rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
 }
 
 static void
-rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
+rockchip_atomic_wait_for_complete(struct drm_device *dev, struct drm_atomic_state *old_state)
 {
 	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc *crtc;
@@ -194,6 +194,10 @@ rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
 		if (!crtc->state->active)
 			continue;
 
+		if (!drm_atomic_helper_framebuffer_changed(dev,
+				old_state, crtc))
+			continue;
+
 		ret = drm_crtc_vblank_get(crtc);
 		if (ret != 0)
 			continue;
@@ -241,7 +245,7 @@ rockchip_atomic_commit_complete(struct rockchip_atomic_commit *commit)
 
 	drm_atomic_helper_commit_planes(dev, state, true);
 
-	rockchip_atomic_wait_for_complete(state);
+	rockchip_atomic_wait_for_complete(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
-- 
2.7.0.226.gfe986fe
