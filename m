From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:35 +0100
Subject: [PATCH 16/19] drm/sun4i: backend: Assign the pipes automatically
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <6bec53786132c34587af3d9f45c371ca2800493e.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now have a way to enforce the zpos, check for the number of alpha
planes, the only missing part is to assign our pipe automatically instead
of hardcoding it.

The algorithm is quite simple, but requires two iterations over the list of
planes.

In the first one (which is the same one that we've had to check for alpha,
the frontend usage, and so on), we order the planes by their zpos.

We can then do a second iteration over that array by ascending zpos
starting with the pipe 0. When and if we encounter our alpha plane, we put
it and all the other subsequent planes in the second pipe.

And since we have runtime checks and pipe assignments now, we can just
remove the static declaration of the planes we used to have.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 41 +++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 50 ++++------------------------
 drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +-
 3 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index dd995a6b8b12..ad370ce66b4d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -276,12 +276,16 @@ int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend, int layer,
 				    struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
+	struct sun4i_layer_state *p_state = state_to_sun4i_layer_state(state);
 	unsigned int priority = state->normalized_zpos;
+	unsigned int pipe = p_state->pipe;
 
-	DRM_DEBUG_DRIVER("Setting layer %d priority to %d\n", layer, priority);
-
+	DRM_DEBUG_DRIVER("Setting layer %d priority to %d and pipe %d\n",
+			 layer, priority, pipe);
 	regmap_update_bits(backend->engine.regs, SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK |
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK,
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(p_state->pipe) |
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(priority));
 
 	return 0;
@@ -326,12 +330,15 @@ static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
 static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 				      struct drm_crtc_state *crtc_state)
 {
+	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };
 	struct drm_atomic_state *state = crtc_state->state;
 	struct drm_device *drm = state->dev;
 	struct drm_plane *plane;
 	unsigned int num_planes = 0;
 	unsigned int num_alpha_planes = 0;
 	unsigned int num_frontend_planes = 0;
+	unsigned int current_pipe = 0;
+	unsigned int i;
 
 	DRM_DEBUG_DRIVER("Starting checking our planes\n");
 
@@ -344,6 +351,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
 		struct drm_framebuffer *fb = plane_state->fb;
+		struct drm_format_name_buf format_name;
 
 		if (sun4i_backend_plane_uses_frontend(plane_state)) {
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
@@ -361,9 +369,19 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		if (drm_format_has_alpha(fb->format->format))
 			num_alpha_planes++;
 
+		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
+				 plane_state->normalized_zpos);
+
+		/* Sort our planes by Zpos */
+		plane_states[plane_state->normalized_zpos] = plane_state;
+
 		num_planes++;
 	}
 
+	/* All our planes were disabled, bail out */
+	if (!num_planes)
+		return 0;
+
 	/*
 	 * The hardware is a bit unusual here.
 	 *
@@ -400,6 +418,25 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		return -EINVAL;
 	}
 
+	/* We can't have an alpha plane at the lowest position */
+	if (drm_format_has_alpha(plane_states[0]->fb->format->format))
+		return -EINVAL;
+
+	for (i = 1; i < num_planes; i++) {
+		struct drm_plane_state *p_state = plane_states[i];
+		struct drm_framebuffer *fb = p_state->fb;
+		struct sun4i_layer_state *s_state = state_to_sun4i_layer_state(p_state);
+
+		/*
+		 * The only alpha position is the lowest plane of the
+		 * second pipe.
+		 */
+		if (drm_format_has_alpha(fb->format->format))
+			current_pipe++;
+
+		s_state->pipe = current_pipe;
+	}
+
 	if (num_frontend_planes > SUN4I_BACKEND_NUM_FRONTEND_LAYERS) {
 		DRM_DEBUG_DRIVER("Too many planes going through the frontend, rejecting\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 900e716443b8..ec7b906dbb84 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -19,13 +19,6 @@
 #include "sun4i_layer.h"
 #include "sunxi_engine.h"
 
-struct sun4i_plane_desc {
-	enum drm_plane_type     type;
-	u8                      pipe;
-	const uint32_t          *formats;
-	uint32_t                nformats;
-};
-
 static void sun4i_backend_layer_reset(struct drm_plane *plane)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
@@ -133,14 +126,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-static const uint32_t sun4i_backend_layer_formats_primary[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_XRGB8888,
-};
-
-static const uint32_t sun4i_backend_layer_formats_overlay[] = {
+static const uint32_t sun4i_backend_layer_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
@@ -151,24 +137,9 @@ static const uint32_t sun4i_backend_layer_formats_overlay[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-static const struct sun4i_plane_desc sun4i_backend_planes[] = {
-	{
-		.type = DRM_PLANE_TYPE_PRIMARY,
-		.pipe = 0,
-		.formats = sun4i_backend_layer_formats_primary,
-		.nformats = ARRAY_SIZE(sun4i_backend_layer_formats_primary),
-	},
-	{
-		.type = DRM_PLANE_TYPE_OVERLAY,
-		.pipe = 1,
-		.formats = sun4i_backend_layer_formats_overlay,
-		.nformats = ARRAY_SIZE(sun4i_backend_layer_formats_overlay),
-	},
-};
-
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
-						const struct sun4i_plane_desc *plane)
+						enum drm_plane_type type)
 {
 	struct sun4i_layer *layer;
 	int ret;
@@ -180,8 +151,9 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
-				       plane->formats, plane->nformats,
-				       NULL, plane->type, NULL);
+				       sun4i_backend_layer_formats,
+				       ARRAY_SIZE(sun4i_backend_layer_formats),
+				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
@@ -206,11 +178,11 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
-		const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
+	for (i = 0; i < SUN4I_BACKEND_NUM_LAYERS; i++) {
+		enum drm_plane_type type = i ? DRM_PLANE_TYPE_OVERLAY : DRM_PLANE_TYPE_PRIMARY;
 		struct sun4i_layer *layer;
 
-		layer = sun4i_layer_init_one(drm, backend, plane);
+		layer = sun4i_layer_init_one(drm, backend, type);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
@@ -219,12 +191,6 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 
 		drm_plane_create_zpos_immutable_property(&layer->plane, i);
 
-		DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
-				 i ? "overlay" : "primary", plane->pipe);
-		regmap_update_bits(engine->regs, SUN4I_BACKEND_ATTCTL_REG0(i),
-				   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK,
-				   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(plane->pipe));
-
 		layer->id = i;
 		planes[i] = &layer->plane;
 	};
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index 75b4868ba87c..36b20265bd31 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -24,6 +24,7 @@ struct sun4i_layer {
 
 struct sun4i_layer_state {
 	struct drm_plane_state	state;
+	unsigned int		pipe;
 	bool			uses_frontend;
 };
 
-- 
git-series 0.9.1
