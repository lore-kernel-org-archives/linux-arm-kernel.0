From: cakturk@gmail.com (Cihangir Akturk)
Date: Thu,  3 Aug 2017 14:58:29 +0300
Subject: [PATCH 14/29] drm/mediatek: switch to drm_*{get,put} helpers
In-Reply-To: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
References: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Message-ID: <1501761585-11757-15-git-send-email-cakturk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_*_reference() and drm_*_unreference() functions are just
compatibility alias for drm_*_get() and drm_*_put() adn should not be
used by new code. So convert all users of compatibility functions to use
the new APIs.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_fb.c  | 4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index d4246c9..0d8d506 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -58,7 +58,7 @@ static void mtk_drm_fb_destroy(struct drm_framebuffer *fb)
 
 	drm_framebuffer_cleanup(fb);
 
-	drm_gem_object_unreference_unlocked(mtk_fb->gem_obj);
+	drm_gem_object_put_unlocked(mtk_fb->gem_obj);
 
 	kfree(mtk_fb);
 }
@@ -160,6 +160,6 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 	return &mtk_fb->base;
 
 unreference:
-	drm_gem_object_unreference_unlocked(gem);
+	drm_gem_object_put_unlocked(gem);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 7abc550..961cbf5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -122,7 +122,7 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 		goto err_handle_create;
 
 	/* drop reference from allocate - handle holds it now. */
-	drm_gem_object_unreference_unlocked(&mtk_gem->base);
+	drm_gem_object_put_unlocked(&mtk_gem->base);
 
 	return 0;
 
@@ -152,7 +152,7 @@ int mtk_drm_gem_dumb_map_offset(struct drm_file *file_priv,
 	DRM_DEBUG_KMS("offset = 0x%llx\n", *offset);
 
 out:
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 	return ret;
 }
 
-- 
2.7.4
