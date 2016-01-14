From: john@metanate.com (John Keeping)
Date: Thu, 14 Jan 2016 14:39:40 +0000
Subject: [PATCH 1/3] drm/atomic-helper: Export framebuffer_changed()
In-Reply-To: <cover.1452782114.git.john@metanate.com>
References: <cover.1452782114.git.john@metanate.com>
Message-ID: <55e84a6ee82c0fbd796bb67a630781daa5bdcae0.1452782114.git.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rockchip driver cannot use drm_atomic_helper_wait_for_vblanks()
because it has hardware counters for neither vblanks nor scanlines.

In order to simplify re-implementing the functionality for this driver,
export the framebuffer_changed() helper so it can be reused.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 24 ++++++++++++++++++++----
 include/drm/drm_atomic_helper.h     |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 268d37f..7449293 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -948,9 +948,23 @@ static void wait_for_fences(struct drm_device *dev,
 	}
 }
 
-static bool framebuffer_changed(struct drm_device *dev,
-				struct drm_atomic_state *old_state,
-				struct drm_crtc *crtc)
+/**
+ * drm_atomic_helper_framebuffer_changed - check if framebuffer has changed
+ * @dev: DRM device
+ * @old_state: atomic state object with old state structures
+ * @crtc: DRM crtc
+ *
+ * Checks whether the framebuffer used for this CRTC changes as a result of
+ * the atomic update.  This is useful for drivers which cannot use
+ * drm_atomic_helper_wait_for_vblanks() and need to reimplement its
+ * functionality.
+ *
+ * Returns:
+ * true if the framebuffer changed.
+ */
+bool drm_atomic_helper_framebuffer_changed(struct drm_device *dev,
+					   struct drm_atomic_state *old_state,
+					   struct drm_crtc *crtc)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
@@ -967,6 +981,7 @@ static bool framebuffer_changed(struct drm_device *dev,
 
 	return false;
 }
+EXPORT_SYMBOL(drm_atomic_helper_framebuffer_changed);
 
 /**
  * drm_atomic_helper_wait_for_vblanks - wait for vblank on crtcs
@@ -1001,7 +1016,8 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 		if (old_state->legacy_cursor_update)
 			continue;
 
-		if (!framebuffer_changed(dev, old_state, crtc))
+		if (!drm_atomic_helper_framebuffer_changed(dev,
+				old_state, crtc))
 			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index a286cce..74fce78 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -42,6 +42,10 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 			     struct drm_atomic_state *state,
 			     bool async);
 
+bool drm_atomic_helper_framebuffer_changed(struct drm_device *dev,
+					   struct drm_atomic_state *old_state,
+					   struct drm_crtc *crtc);
+
 void drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 					struct drm_atomic_state *old_state);
 
-- 
2.7.0.226.gfe986fe
