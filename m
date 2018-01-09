From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:33 +0100
Subject: [PATCH 14/19] drm/sun4i: backend: Add support for zpos
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <80dd87e70ba86233e250566a6f628a624c5b2868.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our various planes have a configurable zpos, that combined with the pipes
allow to configure the composition.

Since the interaction between the pipes, zpos and alphas framebuffers are
not trivials, let's just enable the zpos as an immutable property for now,
and use that zpos in our atomic_update part.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c     | 15 +++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h     |  2 ++
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c |  4 ++++
 drivers/gpu/drm/sun4i/sun4i_layer.c       |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index a18c86a15748..c4986054909b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -272,6 +272,21 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 	return 0;
 }
 
+int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend, int layer,
+				    struct drm_plane *plane)
+{
+	struct drm_plane_state *state = plane->state;
+	unsigned int priority = state->normalized_zpos;
+
+	DRM_DEBUG_DRIVER("Setting layer %d priority to %d\n", layer, priority);
+
+	regmap_update_bits(backend->engine.regs, SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK,
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(priority));
+
+	return 0;
+}
+
 static bool sun4i_backend_plane_uses_scaler(struct drm_plane_state *state)
 {
 	u16 src_h = state->src_h >> 16;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 1ca8b7db6807..04a4f11b87a8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -182,5 +182,7 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
 				      int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 					int layer, uint32_t in_fmt);
+int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
+				    int layer, struct drm_plane *plane);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index e68004844abe..5b3986437a50 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -35,6 +35,10 @@ static int sun4i_de_atomic_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	ret = drm_atomic_normalize_zpos(dev, state);
+	if (ret)
+		return ret;
+
 	return drm_atomic_helper_check_planes(dev, state);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 03549646528a..fbf25d59cf88 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -115,6 +115,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	}
 
 	sun4i_backend_update_layer_coord(backend, layer->id, plane);
+	sun4i_backend_update_layer_zpos(backend, layer->id, plane);
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
@@ -237,6 +238,8 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 			return ERR_CAST(layer);
 		};
 
+		drm_plane_create_zpos_immutable_property(&layer->plane, i);
+
 		DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
 				 i ? "overlay" : "primary", plane->pipe);
 		regmap_update_bits(engine->regs, SUN4I_BACKEND_ATTCTL_REG0(i),
-- 
git-series 0.9.1
