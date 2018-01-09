From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:37 +0100
Subject: [PATCH 18/19] drm/sun4i: Add support for plane alpha
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <44c9e74546fcb9be347c5c373392e8a719c0b11c.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our backend supports a per-plane alpha property. Support it through our new
helper.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 18 +++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h |  3 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index ad370ce66b4d..ec47098bfdb2 100644
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
@@ -366,7 +375,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		DRM_DEBUG_DRIVER("Plane FB format is %s\n",
 				 drm_get_format_name(fb->format->format,
 						     &format_name));
-		if (drm_format_has_alpha(fb->format->format))
+		if (drm_format_has_alpha(fb->format->format) ||
+		    (plane_state->alpha != 255))
 			num_alpha_planes++;
 
 		DRM_DEBUG_DRIVER("Plane zpos is %d\n",
@@ -419,7 +429,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	}
 
 	/* We can't have an alpha plane at the lowest position */
-	if (drm_format_has_alpha(plane_states[0]->fb->format->format))
+	if (drm_format_has_alpha(plane_states[0]->fb->format->format) ||
+	    (plane_states[0]->alpha != 255))
 		return -EINVAL;
 
 	for (i = 1; i < num_planes; i++) {
@@ -431,7 +442,8 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		 * The only alpha position is the lowest plane of the
 		 * second pipe.
 		 */
-		if (drm_format_has_alpha(fb->format->format))
+		if (drm_format_has_alpha(fb->format->format) ||
+		    (p_state->alpha != 255))
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
index 9e538f761dcb..d5598de92f85 100644
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
