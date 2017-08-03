From: cakturk@gmail.com (Cihangir Akturk)
Date: Thu,  3 Aug 2017 14:58:36 +0300
Subject: [PATCH 21/29] drm/rockchip: switch to drm_*{get,put} helpers
In-Reply-To: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
References: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Message-ID: <1501761585-11757-22-git-send-email-cakturk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_*_reference() and drm_*_unreference() functions are just
compatibility alias for drm_*_get() and drm_*_put() adn should not be
used by new code. So convert all users of compatibility functions to use
the new APIs.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    | 6 +++---
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   | 4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 81f9548..a933b58 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -48,7 +48,7 @@ static void rockchip_drm_fb_destroy(struct drm_framebuffer *fb)
 	int i;
 
 	for (i = 0; i < ROCKCHIP_MAX_FB_BUFFER; i++)
-		drm_gem_object_unreference_unlocked(rockchip_fb->obj[i]);
+		drm_gem_object_put_unlocked(rockchip_fb->obj[i]);
 
 	drm_framebuffer_cleanup(fb);
 	kfree(rockchip_fb);
@@ -144,7 +144,7 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 			width * drm_format_plane_cpp(mode_cmd->pixel_format, i);
 
 		if (obj->size < min_size) {
-			drm_gem_object_unreference_unlocked(obj);
+			drm_gem_object_put_unlocked(obj);
 			ret = -EINVAL;
 			goto err_gem_object_unreference;
 		}
@@ -161,7 +161,7 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 
 err_gem_object_unreference:
 	for (i--; i >= 0; i--)
-		drm_gem_object_unreference_unlocked(objs[i]);
+		drm_gem_object_put_unlocked(objs[i]);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index ce946b9..724579e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -173,7 +173,7 @@ void rockchip_drm_fbdev_fini(struct drm_device *dev)
 	drm_fb_helper_unregister_fbi(helper);
 
 	if (helper->fb)
-		drm_framebuffer_unreference(helper->fb);
+		drm_framebuffer_put(helper->fb);
 
 	drm_fb_helper_fini(helper);
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index b74ac71..9f880d0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -383,7 +383,7 @@ rockchip_gem_create_with_handle(struct drm_file *file_priv,
 		goto err_handle_create;
 
 	/* drop reference from allocate - handle holds it now. */
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 
 	return rk_obj;
 
@@ -414,7 +414,7 @@ int rockchip_gem_dumb_map_offset(struct drm_file *file_priv,
 	DRM_DEBUG_KMS("offset = 0x%llx\n", *offset);
 
 out:
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 5d45033..12e17e6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1065,7 +1065,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 		if (old_plane_state->fb == plane->state->fb)
 			continue;
 
-		drm_framebuffer_reference(old_plane_state->fb);
+		drm_framebuffer_get(old_plane_state->fb);
 		drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
 		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
 		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
@@ -1189,7 +1189,7 @@ static void vop_fb_unref_worker(struct drm_flip_work *work, void *val)
 	struct drm_framebuffer *fb = val;
 
 	drm_crtc_vblank_put(&vop->crtc);
-	drm_framebuffer_unreference(fb);
+	drm_framebuffer_put(fb);
 }
 
 static void vop_handle_vblank(struct vop *vop)
-- 
2.7.4
