From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:55 +0100
Subject: [PATCH v2 08/12] drm/sun4i: backend: Wire in the frontend
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9e8c0ce7192dc9ec59da6906e8f6e8f282ac3809.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver, we can make use of it. This is done by
adding a flag to our custom plane state that will trigger whether we should
use the frontend on that particular plane or not.

The rest is just plumbing to set up the backend to not perform the DMA but
receive its data from the frontend.

Note that we're still not making any use of the frontend itself, as no one
is setting the flag yet.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 90 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h |  8 ++-
 drivers/gpu/drm/sun4i/sun4i_crtc.c    |  1 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 33 +++++++++-
 drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +-
 5 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f971d3fb5ee4..29e1ca7e01fe 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -26,6 +26,7 @@
 
 #include "sun4i_backend.h"
 #include "sun4i_drv.h"
+#include "sun4i_frontend.h"
 #include "sun4i_layer.h"
 #include "sunxi_engine.h"
 
@@ -203,6 +204,30 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 	return 0;
 }
 
+int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
+					int layer, uint32_t fmt)
+{
+	u32 val;
+	int ret;
+
+	ret = sun4i_backend_drm_format_to_layer(NULL, fmt, &val);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid format\n");
+		return ret;
+	}
+
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN,
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN);
+
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG1(layer),
+			   SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT, val);
+
+	return 0;
+}
+
 int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane)
 {
@@ -246,6 +271,36 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	return 0;
 }
 
+static void sun4i_backend_vblank_quirk(struct sunxi_engine *engine)
+{
+	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
+	struct sun4i_frontend *frontend = backend->frontend;
+
+	if (!frontend)
+		return;
+
+	/*
+	 * In a teardown scenario with the frontend involved, we have
+	 * to keep the frontend enabled until the next vblank, and
+	 * only then disable it.
+	 *
+	 * This is due to the fact that the backend will not take into
+	 * account the new configuration (with the plane that used to
+	 * be fed by the frontend now disabled) until we write to the
+	 * commit bit and the hardware fetches the new configuration
+	 * during the next vblank.
+	 *
+	 * So we keep the frontend around in order to prevent any
+	 * visual artifacts.
+	 */
+	spin_lock(&backend->frontend_lock);
+	if (backend->frontend_teardown) {
+		sun4i_frontend_exit(frontend);
+		backend->frontend_teardown = false;
+	}
+	spin_unlock(&backend->frontend_lock);
+};
+
 static int sun4i_backend_init_sat(struct device *dev) {
 	struct sun4i_backend *backend = dev_get_drvdata(dev);
 	int ret;
@@ -330,11 +385,40 @@ static int sun4i_backend_of_get_id(struct device_node *node)
 	return ret;
 }
 
+static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
+							  struct device_node *node)
+{
+	struct device_node *port, *ep, *remote;
+	struct sun4i_frontend *frontend;
+
+	port = of_graph_get_port_by_id(node, 0);
+	if (!port)
+		return ERR_PTR(-EINVAL);
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote)
+			continue;
+
+		/* does this node match any registered engines? */
+		list_for_each_entry(frontend, &drv->frontend_list, list) {
+			if (remote == frontend->node) {
+				of_node_put(remote);
+				of_node_put(port);
+				return frontend;
+			}
+		}
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
 	.commit				= sun4i_backend_commit,
 	.layers_init			= sun4i_layers_init,
 	.apply_color_correction		= sun4i_backend_apply_color_correction,
 	.disable_color_correction	= sun4i_backend_disable_color_correction,
+	.vblank_quirk			= sun4i_backend_vblank_quirk,
 };
 
 static struct regmap_config sun4i_backend_regmap_config = {
@@ -360,6 +444,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	if (!backend)
 		return -ENOMEM;
 	dev_set_drvdata(dev, backend);
+	spin_lock_init(&backend->frontend_lock);
 
 	backend->engine.node = dev->of_node;
 	backend->engine.ops = &sun4i_backend_engine_ops;
@@ -367,6 +452,11 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	if (backend->engine.id < 0)
 		return backend->engine.id;
 
+	backend->frontend = sun4i_backend_find_frontend(drv, dev->of_node);
+	if (IS_ERR(backend->frontend)) {
+		dev_warn(dev, "Couldn't find matching frontend, frontend features disabled\n");
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index ac3cc029f5cd..350a2dbde31a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -72,6 +72,7 @@
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)		((x) << 15)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK	GENMASK(11, 10)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)			((x) << 10)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN		BIT(1)
 
 #define SUN4I_BACKEND_ATTCTL_REG1(l)		(0x8a0 + (0x4 * (l)))
 #define SUN4I_BACKEND_ATTCTL_REG1_LAY_HSCAFCT		GENMASK(15, 14)
@@ -145,6 +146,7 @@
 
 struct sun4i_backend {
 	struct sunxi_engine	engine;
+	struct sun4i_frontend	*frontend;
 
 	struct reset_control	*reset;
 
@@ -154,6 +156,10 @@ struct sun4i_backend {
 
 	struct clk		*sat_clk;
 	struct reset_control	*sat_reset;
+
+	/* Protects against races in the frontend teardown */
+	spinlock_t		frontend_lock;
+	bool			frontend_teardown;
 };
 
 static inline struct sun4i_backend *
@@ -170,5 +176,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 				       int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane);
+int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
+					int layer, uint32_t in_fmt);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index f549f2874353..3b2d11b675e8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -25,6 +25,7 @@
 
 #include <video/videomode.h>
 
+#include "sun4i_backend.h"
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sunxi_engine.h"
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index b85a9a02d166..4652b25be0d2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -15,6 +15,7 @@
 #include <drm/drmP.h>
 
 #include "sun4i_backend.h"
+#include "sun4i_frontend.h"
 #include "sun4i_layer.h"
 #include "sunxi_engine.h"
 
@@ -48,6 +49,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 static struct drm_plane_state *
 sun4i_backend_layer_duplicate_state(struct drm_plane *plane)
 {
+	struct sun4i_layer_state *orig = state_to_sun4i_layer_state(plane->state);
 	struct sun4i_layer_state *copy;
 
 	copy = kzalloc(sizeof(*copy), GFP_KERNEL);
@@ -55,6 +57,7 @@ sun4i_backend_layer_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
 	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
+	copy->uses_frontend = orig->uses_frontend;
 
 	return &copy->state;
 }
@@ -72,21 +75,45 @@ static void sun4i_backend_layer_destroy_state(struct drm_plane *plane,
 static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
+	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(old_state);
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_backend *backend = layer->backend;
 
 	sun4i_backend_layer_enable(backend, layer->id, false);
+
+	if (layer_state->uses_frontend) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&backend->frontend_lock, flags);
+		backend->frontend_teardown = true;
+		spin_unlock_irqrestore(&backend->frontend_lock, flags);
+	}
 }
 
 static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 					      struct drm_plane_state *old_state)
 {
+	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(plane->state);
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_backend *backend = layer->backend;
+	struct sun4i_frontend *frontend = backend->frontend;
+
+	if (layer_state->uses_frontend) {
+		sun4i_frontend_init(frontend);
+		sun4i_frontend_update_coord(frontend, plane);
+		sun4i_frontend_update_buffer(frontend, plane);
+		sun4i_frontend_update_formats(frontend, plane,
+					      DRM_FORMAT_ARGB8888);
+		sun4i_backend_update_layer_frontend(backend, layer->id,
+						    DRM_FORMAT_ARGB8888);
+		sun4i_backend_update_layer_coord(backend, layer->id, plane);
+		sun4i_frontend_enable(frontend);
+	} else {
+		sun4i_backend_update_layer_coord(backend, layer->id, plane);
+		sun4i_backend_update_layer_formats(backend, layer->id, plane);
+		sun4i_backend_update_layer_buffer(backend, layer->id, plane);
+	}
 
-	sun4i_backend_update_layer_coord(backend, layer->id, plane);
-	sun4i_backend_update_layer_formats(backend, layer->id, plane);
-	sun4i_backend_update_layer_buffer(backend, layer->id, plane);
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index d2c19348d1b0..75b4868ba87c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -24,6 +24,7 @@ struct sun4i_layer {
 
 struct sun4i_layer_state {
 	struct drm_plane_state	state;
+	bool			uses_frontend;
 };
 
 static inline struct sun4i_layer *
-- 
git-series 0.9.1
