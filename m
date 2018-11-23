From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:33 +0100
Subject: [PATCH v2 01/43] drm/sun4i: Cleanup video/YUV source before enabling
 a layer
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-2-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a dedicated function for cleaning the video and YUV source
channel layer enable bits. This function is called first on layer atomic
update to make sure that there are no leftover bits from previous
plane configuration that were not cleaned until now.

It fixes issues when alternating between video and YUV planes, where
both bits would be set eventually, leading to broken plane display.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 9 +++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index bf49c55b0f2c..67b4bb4f5365 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -395,6 +395,15 @@ int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend, int layer,
 	return 0;
 }
 
+void sun4i_backend_cleanup_layer(struct sun4i_backend *backend,
+				 int layer)
+{
+	regmap_update_bits(backend->engine.regs,
+			   SUN4I_BACKEND_ATTCTL_REG0(layer),
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN |
+			   SUN4I_BACKEND_ATTCTL_REG0_LAY_YUVEN, 0);
+}
+
 static bool sun4i_backend_plane_uses_scaler(struct drm_plane_state *state)
 {
 	u16 src_h = state->src_h >> 16;
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index e3d4c6035eb2..339dbff1cce4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -208,5 +208,7 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 					int layer, uint32_t in_fmt);
 int sun4i_backend_update_layer_zpos(struct sun4i_backend *backend,
 				    int layer, struct drm_plane *plane);
+void sun4i_backend_cleanup_layer(struct sun4i_backend *backend,
+				 int layer);
 
 #endif /* _SUN4I_BACKEND_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 78f77af8805a..e0e37c2f1721 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -92,6 +92,8 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	struct sun4i_backend *backend = layer->backend;
 	struct sun4i_frontend *frontend = backend->frontend;
 
+	sun4i_backend_cleanup_layer(backend, layer->id);
+
 	if (layer_state->uses_frontend) {
 		sun4i_frontend_init(frontend);
 		sun4i_frontend_update_coord(frontend, plane);
-- 
2.19.1
