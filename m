From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 21:54:21 +0100
Subject: [PATCH v4 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
Message-ID: <402e596049beb3429faf5981682d902c70325274.1520974361.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers duplicate the logic to create a property to store a per-plane
alpha.

This is especially useful if we ever want to support extra protocols for
Wayland like:
https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html

Let's create a helper in order to move that to the core.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/drm_atomic.c        |  4 +++-
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++-
 drivers/gpu/drm/drm_blend.c         | 38 ++++++++++++++++++++++++++++++-
 include/drm/drm_blend.h             |  3 ++-
 include/drm/drm_plane.h             |  6 +++++-
 5 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 34b7d420e555..39204c88d2c5 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -753,6 +753,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_w = val;
 	} else if (property == config->prop_src_h) {
 		state->src_h = val;
+	} else if (property == plane->alpha_property) {
+		state->alpha = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
 			return -EINVAL;
@@ -818,6 +820,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = state->src_w;
 	} else if (property == config->prop_src_h) {
 		*val = state->src_h;
+	} else if (property == plane->alpha_property) {
+		*val = state->alpha;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 00c78c1c9681..ac4c3f18a0b1 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3484,6 +3484,10 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
 	if (plane->state) {
 		plane->state->plane = plane;
 		plane->state->rotation = DRM_MODE_ROTATE_0;
+
+		/* Reset the alpha value to fully opaque if it matters */
+		if (plane->alpha_property)
+			plane->state->alpha = plane->alpha_property->values[1];
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
index 5a81e1b4c076..05eda2d57c77 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -88,6 +88,12 @@
  * On top of this basic transformation additional properties can be exposed by
  * the driver:
  *
+ * alpha:
+ * 	Alpha is setup with drm_plane_create_alpha_property(). It controls the
+ * 	plane-wide opacity, from transparent (0) to opaque (0xffff). It can be
+ * 	combined with pixel alpha.
+ * 	The alpha value is represented as premultiplied alpha.
+ *
  * rotation:
  *	Rotation is set up with drm_plane_create_rotation_property(). It adds a
  *	rotation and reflection step between the source and destination rectangles.
@@ -106,6 +112,38 @@
  */
 
 /**
+ * drm_plane_create_alpha_property - create a new alpha property
+ * @plane: drm plane
+ *
+ * This function creates a generic, mutable, alpha property and enables support
+ * for it in the DRM core. It is attached to @plane.
+ *
+ * The alpha property will be allowed to be within the bounds of 0
+ * (transparent) to 0xffff (opaque).
+ *
+ * Returns:
+ * 0 on success, negative error code on failure.
+ */
+int drm_plane_create_alpha_property(struct drm_plane *plane)
+{
+	struct drm_property *prop;
+
+	prop = drm_property_create_range(plane->dev, 0, "alpha",
+					 0, DRM_BLEND_ALPHA_OPAQUE);
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&plane->base, prop, DRM_BLEND_ALPHA_OPAQUE);
+	plane->alpha_property = prop;
+
+	if (plane->state)
+		plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_plane_create_alpha_property);
+
+/**
  * drm_plane_create_rotation_property - create a new rotation property
  * @plane: drm plane
  * @rotation: initial value of the rotation property
diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
index 17606026590b..330c561c4c11 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -36,6 +36,9 @@ static inline bool drm_rotation_90_or_270(unsigned int rotation)
 	return rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
 }
 
+#define DRM_BLEND_ALPHA_OPAQUE		0xffff
+
+int drm_plane_create_alpha_property(struct drm_plane *plane);
 int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,
 				       unsigned int supported_rotations);
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index f7bf4a48b1c3..8af573615c5f 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -43,6 +43,7 @@ struct drm_modeset_acquire_ctx;
  *	plane (in 16.16)
  * @src_w: width of visible portion of plane (in 16.16)
  * @src_h: height of visible portion of plane (in 16.16)
+ * @alpha: opacity of the plane
  * @rotation: rotation of the plane
  * @zpos: priority of the given plane on crtc (optional)
  *	Note that multiple active planes on the same crtc can have an identical
@@ -106,6 +107,9 @@ struct drm_plane_state {
 	uint32_t src_x, src_y;
 	uint32_t src_h, src_w;
 
+	/* Plane opacity */
+	u16 alpha;
+
 	/* Plane rotation */
 	unsigned int rotation;
 
@@ -496,6 +500,7 @@ enum drm_plane_type {
  * @funcs: helper functions
  * @properties: property tracking for this plane
  * @type: type of plane (overlay, primary, cursor)
+ * @alpha_property: alpha property for this plane
  * @zpos_property: zpos property for this plane
  * @rotation_property: rotation property for this plane
  * @helper_private: mid-layer private data
@@ -571,6 +576,7 @@ struct drm_plane {
 	 */
 	struct drm_plane_state *state;
 
+	struct drm_property *alpha_property;
 	struct drm_property *zpos_property;
 	struct drm_property *rotation_property;
 
-- 
git-series 0.9.1
