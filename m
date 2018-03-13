From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 21:54:24 +0100
Subject: [PATCH v4 4/5] drm/sun4i: Add support for plane alpha
In-Reply-To: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
Message-ID: <7d9d81363e23bd5d8a312b443f9080b52923f7e1.1520974361.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our backend supports a per-plane alpha property. Support it through our new
helper.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 16 +++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h |  3 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 092ade4ff6a5..98cd4a8a93ed 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -186,6 +186,15 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	DRM_DEBUG_DRIVER("Switching display backend interlaced mode %s\n",
 			 interlaced ? "on" : "off");
 
+	val = SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA(state->alpha >> 8);
+	if (state->alpha != DRM_BLEND_ALPHA_OPAQUE)
+		val |= SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN;
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_MASK |
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
+			   val);
+
 	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
@@ -359,7 +368,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
 				 drm_get_format_name(fb->format->format,
 						     &format_name));
-		if (fb->format->has_alpha)
+		if (fb->format->has_alpha || (plane_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			num_alpha_planes++;
 
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
@@ -412,7 +421,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	}
 
 	/* We can't have an alpha plane at the lowest position */
-	if (plane_states[0]->fb->format->has_alpha)
+	if (plane_states[0]->fb->format->has_alpha ||
+	    (plane_states[0]->alpha != DRM_BLEND_ALPHA_OPAQUE))
 		return -EINVAL;
 
 	for (i = 1; i < num_planes; i++) {
@@ -424,7 +434,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		 * The only alpha position is the lowest plane of the
 		 * second pipe.
 		 */
-		if (fb->format->has_alpha)
+		if (fb->format->has_alpha || (p_state->alpha != DRM_BLEND_ALPHA_OPAQUE))
 			current_pipe++;
 
 		s_state->pipe = current_pipe;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 52e77591186a..03294d5dd1a2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -68,11 +68,14 @@
 #define SUN4I_BACKEND_CKMIN_REG			0x884
 #define SUN4I_BACKEND_CKCFG_REG			0x888
 #define SUN4I_BACKEND_ATTCTL_REG0(l)		(0x890 + (0x4 * (l)))
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_MASK	GENMASK(31, 24)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA(x)		((x) << 24)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK	BIT(15)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)		((x) << 15)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK	GENMASK(11, 10)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)			((x) << 10)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN		BIT(1)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN	BIT(0)
 
 #define SUN4I_BACKEND_ATTCTL_REG1(l)		(0x8a0 + (0x4 * (l)))
 #define SUN4I_BACKEND_ATTCTL_REG1_LAY_HSCAFCT		GENMASK(15, 14)
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 33ad377569ec..cf7857b8ac5c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -37,6 +37,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 	if (state) {
 		plane->state = &state->state;
 		plane->state->plane = plane;
+		plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
 		plane->state->zpos = layer->id;
 	}
 }
@@ -163,6 +164,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 			     &sun4i_backend_layer_helper_funcs);
 	layer->backend = backend;
 
+	drm_plane_create_alpha_property(&layer->plane);
 	drm_plane_create_zpos_property(&layer->plane, 0, 0,
 				       SUN4I_BACKEND_NUM_LAYERS - 1);
 
-- 
git-series 0.9.1
