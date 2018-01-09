From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:34 +0100
Subject: [PATCH 15/19] drm/sun4i: backend: Check for the number of alpha planes
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7fd29069dc7f24cc0fee5f17b82cee36b1b1e74f.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the way the composition is done in hardware, we can only have a
single alpha-enabled plane active at a time, placed in the second (highest
priority) pipe.

Make sure of that in our atomic_check to not end up in an impossible
scenario.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 50 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h |  2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 23 +-------------
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index c4986054909b..dd995a6b8b12 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -329,6 +329,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	struct drm_atomic_state *state = crtc_state->state;
 	struct drm_device *drm = state->dev;
 	struct drm_plane *plane;
+	unsigned int num_planes = 0;
+	unsigned int num_alpha_planes = 0;
 	unsigned int num_frontend_planes = 0;
 
 	DRM_DEBUG_DRIVER("Starting checking our planes\n");
@@ -341,6 +343,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 			drm_atomic_get_plane_state(state, plane);
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
+		struct drm_framebuffer *fb = plane_state->fb;
 
 		if (sun4i_backend_plane_uses_frontend(plane_state)) {
 			DRM_DEBUG_DRIVER("Using the frontend for plane %d\n",
@@ -351,6 +354,50 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		} else {
 			layer_state->uses_frontend = false;
 		}
+
+		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
+				 drm_get_format_name(fb->format->format,
+						     &format_name));
+		if (drm_format_has_alpha(fb->format->format))
+			num_alpha_planes++;
+
+		num_planes++;
+	}
+
+	/*
+	 * The hardware is a bit unusual here.
+	 *
+	 * Even though it supports 4 layers, it does the composition
+	 * in two separate steps.
+	 *
+	 * The first one is assigning a layer to one of its two
+	 * pipes. If more that 1 layer is assigned to the same pipe,
+	 * and if pixels overlaps, the pipe will take the pixel from
+	 * the layer with the highest priority.
+	 *
+	 * The second step is the actual alpha blending, that takes
+	 * the two pipes as input, and uses the eventual alpha
+	 * component to do the transparency between the two.
+	 *
+	 * This two steps scenario makes us unable to guarantee a
+	 * robust alpha blending between the 4 layers in all
+	 * situations, since this means that we need to have one layer
+	 * with alpha at the lowest position of our two pipes.
+	 *
+	 * However, we cannot even do that, since the hardware has a
+	 * bug where the lowest plane of the lowest pipe (pipe 0,
+	 * priority 0), if it has any alpha, will discard the pixel
+	 * entirely and just display the pixels in the background
+	 * color (black by default).
+	 *
+	 * Since means that we effectively have only three valid
+	 * configurations with alpha, all of them with the alpha being
+	 * on pipe1 with the lowest position, which can be 1, 2 or 3
+	 * depending on the number of planes and their zpos.
+	 */
+	if (num_alpha_planes > SUN4I_BACKEND_NUM_ALPHA_LAYERS) {
+		DRM_DEBUG_DRIVER("Too many planes with alpha, rejecting...\n");
+		return -EINVAL;
 	}
 
 	if (num_frontend_planes > SUN4I_BACKEND_NUM_FRONTEND_LAYERS) {
@@ -358,6 +405,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		return -EINVAL;
 	}
 
+	DRM_DEBUG_DRIVER("State valid with %u planes, %u alpha, %u video\n",
+			 num_planes, num_alpha_planes, num_frontend_planes);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 04a4f11b87a8..52e77591186a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -146,6 +146,8 @@
 #define SUN4I_BACKEND_HWCCOLORTAB_OFF		0x4c00
 #define SUN4I_BACKEND_PIPE_OFF(p)		(0x5000 + (0x400 * (p)))
 
+#define SUN4I_BACKEND_NUM_LAYERS		4
+#define SUN4I_BACKEND_NUM_ALPHA_LAYERS		1
 #define SUN4I_BACKEND_NUM_FRONTEND_LAYERS	1
 
 struct sun4i_backend {
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index fbf25d59cf88..900e716443b8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -201,32 +201,11 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
 	int i;
 
-	planes = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes) + 1,
+	planes = devm_kcalloc(drm->dev, SUN4I_BACKEND_NUM_LAYERS,
 			      sizeof(*planes), GFP_KERNEL);
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * The hardware is a bit unusual here.
-	 *
-	 * Even though it supports 4 layers, it does the composition
-	 * in two separate steps.
-	 *
-	 * The first one is assigning a layer to one of its two
-	 * pipes. If more that 1 layer is assigned to the same pipe,
-	 * and if pixels overlaps, the pipe will take the pixel from
-	 * the layer with the highest priority.
-	 *
-	 * The second step is the actual alpha blending, that takes
-	 * the two pipes as input, and uses the eventual alpha
-	 * component to do the transparency between the two.
-	 *
-	 * This two steps scenario makes us unable to guarantee a
-	 * robust alpha blending between the 4 layers in all
-	 * situations. So we just expose two layers, one per pipe. On
-	 * SoCs that support it, sprites could fill the need for more
-	 * layers.
-	 */
 	for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
 		const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
 		struct sun4i_layer *layer;
-- 
git-series 0.9.1
