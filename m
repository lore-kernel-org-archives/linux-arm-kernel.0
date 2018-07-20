From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:15:00 +0100
Subject: [PATCH 01/10] drm/atomic: Add  __drm_atomic_helper_plane_reset
In-Reply-To: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180720211509.23605-2-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a lot of drivers that subclass drm_plane_state, all of them
duplicate the code that links toghether the plane with plane_state.

On top of that, drivers that enable core properties also have to
duplicate the code for initializing the properties to their default
values, which in all cases are the same as the defaults from core.

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 32 +++++++++++++++++++++--------
 include/drm/drm_atomic_helper.h     |  2 ++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 8008a7de2e10..e1c6f101652e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3507,6 +3507,28 @@ void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_atomic_helper_crtc_destroy_state);
 
+/**
+ * __drm_atomic_helper_plane_reset - resets planes state to default values
+ * @plane: plane object
+ * @new_state: atomic plane state
+ *
+ * Initializes plane state to default. This is useful for drivers that subclass
+ * the plane state.
+ */
+void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
+				     struct drm_plane_state *state)
+{
+	if (state) {
+		state->plane = plane;
+		state->rotation = DRM_MODE_ROTATE_0;
+		/* Reset the alpha value to fully opaque if it matters */
+		if (plane->alpha_property)
+			state->alpha = plane->alpha_property->values[1];
+	}
+	plane->state = state;
+}
+EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
+
 /**
  * drm_atomic_helper_plane_reset - default &drm_plane_funcs.reset hook for planes
  * @plane: drm plane
@@ -3521,15 +3543,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
 
 	kfree(plane->state);
 	plane->state = kzalloc(sizeof(*plane->state), GFP_KERNEL);
-
-	if (plane->state) {
-		plane->state->plane = plane;
-		plane->state->rotation = DRM_MODE_ROTATE_0;
-
-		/* Reset the alpha value to fully opaque if it matters */
-		if (plane->alpha_property)
-			plane->state->alpha = plane->alpha_property->values[1];
-	}
+	__drm_atomic_helper_plane_reset(plane, plane->state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
 
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 26aaba58d6ce..2dd40c761dfd 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -155,6 +155,8 @@ void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state);
 void drm_atomic_helper_crtc_destroy_state(struct drm_crtc *crtc,
 					  struct drm_crtc_state *state);
 
+void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
+				     struct drm_plane_state *state);
 void drm_atomic_helper_plane_reset(struct drm_plane *plane);
 void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 					       struct drm_plane_state *state);
-- 
2.18.0
