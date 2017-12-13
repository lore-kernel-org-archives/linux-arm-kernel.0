From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:33:30 +0100
Subject: [PATCH 6/8] drm/sun4i: sun4i_layer: Wire in the frontend
In-Reply-To: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <0cd2570c9cbe20d094cee0e8e9918c3a0f6af2fa.1513178989.git-series.maxime.ripard@free-electrons.com>
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
 drivers/gpu/drm/sun4i/sun4i_backend.c | 53 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h |  3 ++-
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 27 ++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +-
 4 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e83e1fe43823..f1d19767c55d 100644
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
@@ -330,6 +355,34 @@ static int sun4i_backend_of_get_id(struct device_node *node)
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
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index ba1410fd5410..636a51521e77 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -72,6 +72,7 @@
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)		((x) << 15)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK	GENMASK(11, 10)
 #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)			((x) << 10)
+#define SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN		BIT(1)
 
 #define SUN4I_BACKEND_ATTCTL_REG1(l)		(0x8a0 + (0x4 * (l)))
 #define SUN4I_BACKEND_ATTCTL_REG1_LAY_HSCAFCT		GENMASK(15, 14)
@@ -171,5 +172,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 				       int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane);
+int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
+					int layer, uint32_t in_fmt);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index c3afcf888906..3b58667a06dc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -15,6 +15,7 @@
 #include <drm/drmP.h>
 
 #include "sun4i_backend.h"
+#include "sun4i_frontend.h"
 #include "sun4i_layer.h"
 #include "sunxi_engine.h"
 
@@ -70,21 +71,41 @@ static void sun4i_backend_layer_destroy_state(struct drm_plane *plane,
 static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
+	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(old_state);
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
 	struct sun4i_backend *backend = layer->backend;
+	struct sun4i_frontend *frontend = backend->frontend;
 
 	sun4i_backend_layer_enable(backend, layer->id, false);
+
+	if (layer_state->uses_frontend)
+		sun4i_frontend_exit(frontend);
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
