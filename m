From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:35 +0100
Subject: [PATCH v2 06/19] drm/blend: Add a generic alpha property
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6a2988f34d6444febd637127a5c2474acb0a8c55.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers duplicate the logic to create a property to store a per-plane
alpha.

This is especially useful if we ever want to support extra protocols for
Wayland like:
https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html

Let's create a helper in order to move that to the core.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/gpu/kms-properties.csv |  2 +-
 drivers/gpu/drm/drm_atomic.c         |  4 ++++-
 drivers/gpu/drm/drm_atomic_helper.c  |  4 ++++-
 drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++++++++-
 include/drm/drm_blend.h              |  1 +-
 include/drm/drm_plane.h              |  6 +++++-
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
index 927b65e14219..25ad3503d663 100644
--- a/Documentation/gpu/kms-properties.csv
+++ b/Documentation/gpu/kms-properties.csv
@@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
 ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
 ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
 ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
-rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
+,,"""alpha""",RANGE,"Min=0, Max=Driver dependant",Plane,Opacity of the plane from transparent (0) to fully opaque (MAX). If this property is set to a value different than max, and that the pixel will define an alpha component, the property will have precendance and the pixel value will be ignored. The alpha value is represented as straight alpha, ie the colors haven't been pre-adjusted for their opacity by multiplication. Therefore, the equation to get a color value for one pixel, assuming two planes A and B, will be (color_a * alpha_a + color_b * alpha_b * (MAX - alpha_a) / MAX) / (alpha_a + alpha_b * (MAX - alpha_a) / MAX)
 ,,"""colorkey""",RANGE,"Min=0, Max=0x01ffffff",Plane,TBD
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index c2da5585e201..ade18cf62c89 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -749,6 +749,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->src_w = val;
 	} else if (property == config->prop_src_h) {
 		state->src_h = val;
+	} else if (property == plane->alpha_property) {
+		state->alpha = val;
 	} else if (property == plane->rotation_property) {
 		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
 			return -EINVAL;
@@ -810,6 +812,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = state->src_w;
 	} else if (property == config->prop_src_h) {
 		*val = state->src_h;
+	} else if (property == plane->alpha_property) {
+		*val = state->alpha;
 	} else if (property == plane->rotation_property) {
 		*val = state->rotation;
 	} else if (property == plane->zpos_property) {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 71d712f1b56a..bad0af053384 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3373,6 +3373,10 @@ void drm_atomic_helper_plane_reset(struct drm_plane *plane)
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
index 2e5e089dd912..e6bfa618e902 100644
--- a/drivers/gpu/drm/drm_blend.c
+++ b/drivers/gpu/drm/drm_blend.c
@@ -104,6 +104,38 @@
  */
 
 /**
+ * drm_plane_create_alpha_property - create a new alpha property
+ * @plane: drm plane
+ * @max_alpha: maximum value of alpha
+ *
+ * This function initializes a generic, mutable, alpha property and
+ * enables support for it in the DRM core.
+ *
+ * The alpha property will be allowed to be within the bounds of 0
+ * (transparent) to @max_alpha (opaque)
+ *
+ * Returns:
+ * 0 on success, negative error code on failure.
+ */
+int drm_plane_create_alpha_property(struct drm_plane *plane, u16 max_alpha)
+{
+	struct drm_property *prop;
+
+	prop = drm_property_create_range(plane->dev, 0, "alpha", 0, max_alpha);
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&plane->base, prop, max_alpha);
+	plane->alpha_property = prop;
+
+	if (plane->state)
+		plane->state->alpha = max_alpha;
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
index 17606026590b..e5affba6ebde 100644
--- a/include/drm/drm_blend.h
+++ b/include/drm/drm_blend.h
@@ -36,6 +36,7 @@ static inline bool drm_rotation_90_or_270(unsigned int rotation)
 	return rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
 }
 
+int drm_plane_create_alpha_property(struct drm_plane *plane, u16 alpha);
 int drm_plane_create_rotation_property(struct drm_plane *plane,
 				       unsigned int rotation,
 				       unsigned int supported_rotations);
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 571615079230..a5e26064b132 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -42,6 +42,7 @@ struct drm_modeset_acquire_ctx;
  *	plane (in 16.16)
  * @src_w: width of visible portion of plane (in 16.16)
  * @src_h: height of visible portion of plane (in 16.16)
+ * @alpha: opacity of the plane
  * @rotation: rotation of the plane
  * @zpos: priority of the given plane on crtc (optional)
  *	Note that multiple active planes on the same crtc can have an identical
@@ -105,6 +106,9 @@ struct drm_plane_state {
 	uint32_t src_x, src_y;
 	uint32_t src_h, src_w;
 
+	/* Plane opacity */
+	u8 alpha;
+
 	/* Plane rotation */
 	unsigned int rotation;
 
@@ -481,6 +485,7 @@ enum drm_plane_type {
  * @funcs: helper functions
  * @properties: property tracking for this plane
  * @type: type of plane (overlay, primary, cursor)
+ * @alpha_property: alpha property for this plane
  * @zpos_property: zpos property for this plane
  * @rotation_property: rotation property for this plane
  * @helper_private: mid-layer private data
@@ -546,6 +551,7 @@ struct drm_plane {
 	 */
 	struct drm_plane_state *state;
 
+	struct drm_property *alpha_property;
 	struct drm_property *zpos_property;
 	struct drm_property *rotation_property;
 };
-- 
git-series 0.9.1
