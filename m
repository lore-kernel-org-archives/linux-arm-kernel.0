From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 18:39:35 +0100
Subject: [PATCH v3 7/8] drm/sun4i: Add support for plane alpha
In-Reply-To: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <76eeabd20aeff78f2cd434eb25a0d2a37528ea57.1518802627.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our backend supports a per-plane alpha property. Support it through our new
helper.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 16 +++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h |  3 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 ++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f387420bda8d..0ec00600eace 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -191,6 +191,15 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	DRM_DEBUG_DRIVER("Switching display backend interlaced mode %s\n",
 			 interlaced ? "on" : "off");
 
+	val = SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA(state->alpha);
+	if (state->alpha != 255)
+		val |= SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN;
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_MASK |
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
+			   val);
+
 	ret = sun4i_backend_drm_format_to_layer(plane, fb->format->format,
 						&val);
 	if (ret) {
@@ -365,7 +374,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
 				 drm_get_format_name(fb->format->format,
 						     &format_name));
-		if (fb->format->has_alpha)
+		if (fb->format->has_alpha || (plane_state->alpha != 255))
 			num_alpha_planes++;
 
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
@@ -418,7 +427,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	}
 
 	/* We can't have an alpha plane at the lowest position */
-	if (plane_states[0]->fb->format->has_alpha)
+	if (plane_states[0]->fb->format->has_alpha ||
+	    (plane_states[0]->alpha != 255))
 		return -EINVAL;
 
 	for (i = 1; i < num_planes; i++) {
@@ -430,7 +440,7 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		 * The only alpha position is the lowest plane of the
 		 * second pipe.
 		 */
-		if (fb->format->has_alpha)
+		if (fb->format->has_alpha || (p_state->alpha != 255))
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
index 33ad377569ec..f491fd963534 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -37,6 +37,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 	if (state) {
 		plane->state = &state->state;
 		plane->state->plane = plane;
+		plane->state->alpha = 255;
 		plane->state->zpos = layer->id;
 	}
 }
@@ -163,6 +164,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 			     &sun4i_backend_layer_helper_funcs);
 	layer->backend = backend;
 
+	drm_plane_create_alpha_property(&layer->plane, 255);
 	drm_plane_create_zpos_property(&layer->plane, 0, 0,
 				       SUN4I_BACKEND_NUM_LAYERS - 1);
 
-- 
git-series 0.9.1
