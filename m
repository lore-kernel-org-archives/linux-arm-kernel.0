From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:33:27 +0100
Subject: [PATCH 3/8] drm/sun4i: sun4i_layer: Add a custom plane state
In-Reply-To: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8ecbf0bda89d11539dbf9357f0fe77561ebdd4c3.1513178989.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will need to store some additional data in the future to the state.
Create a custom plane state that will embed those data, in order to store
the pipe or whether or not that plane should use the frontend.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 48 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_layer.h | 10 ++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 7bddf12548d3..c3afcf888906 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -25,6 +25,48 @@ struct sun4i_plane_desc {
 	       uint32_t                nformats;
 };
 
+static void sun4i_backend_layer_reset(struct drm_plane *plane)
+{
+	struct sun4i_layer_state *state;
+
+	if (plane->state) {
+		state = state_to_sun4i_layer_state(plane->state);
+
+		__drm_atomic_helper_plane_destroy_state(&state->state);
+		kfree(state);
+		plane->state = NULL;
+	}
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state) {
+		plane->state = &state->state;
+		plane->state->plane = plane;
+	}
+}
+
+static struct drm_plane_state *
+sun4i_backend_layer_duplicate_state(struct drm_plane *plane)
+{
+	struct sun4i_layer_state *copy;
+
+	copy = kzalloc(sizeof(*copy), GFP_KERNEL);
+	if (!copy)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
+
+	return &copy->state;
+}
+
+static void sun4i_backend_layer_destroy_state(struct drm_plane *plane,
+					      struct drm_plane_state *state)
+{
+	struct sun4i_layer_state *s_state = state_to_sun4i_layer_state(state);
+
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(s_state);
+}
+
 static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
@@ -52,11 +94,11 @@ static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
 };
 
 static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= sun4i_backend_layer_destroy_state,
+	.atomic_duplicate_state	= sun4i_backend_layer_duplicate_state,
 	.destroy		= drm_plane_cleanup,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
+	.reset			= sun4i_backend_layer_reset,
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index 4e84f438b346..d2c19348d1b0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -22,12 +22,22 @@ struct sun4i_layer {
 	int			id;
 };
 
+struct sun4i_layer_state {
+	struct drm_plane_state	state;
+};
+
 static inline struct sun4i_layer *
 plane_to_sun4i_layer(struct drm_plane *plane)
 {
 	return container_of(plane, struct sun4i_layer, plane);
 }
 
+static inline struct sun4i_layer_state *
+state_to_sun4i_layer_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct sun4i_layer_state, state);
+}
+
 struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 				     struct sunxi_engine *engine);
 
-- 
git-series 0.9.1
