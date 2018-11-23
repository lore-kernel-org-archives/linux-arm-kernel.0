From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:25:04 +0100
Subject: [PATCH v2 32/43] drm/sun4i: Pass modifier to backend and frontend
 format support helpers
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-33-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the introduction of tiled mode support, pass the framebuffer
format modifier to the helpers dealing with format support.

Since only linear mode is supported for now, add corresponding checks in
each helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 10 +++++++---
 drivers/gpu/drm/sun4i/sun4i_backend.h  |  2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c |  5 ++++-
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 986bdb64521c..bbadc2ab9f4d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -175,10 +175,13 @@ static const uint32_t sun4i_backend_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
-bool sun4i_backend_format_is_supported(uint32_t fmt)
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
+	if (modifier != DRM_FORMAT_MOD_LINEAR)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++)
 		if (sun4i_backend_formats[i] == fmt)
 			return true;
@@ -455,14 +458,15 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	struct sun4i_layer *layer = plane_to_sun4i_layer(state->plane);
 	struct sun4i_backend *backend = layer->backend;
 	uint32_t format = state->fb->format->format;
+	uint64_t modifier = state->fb->modifier;
 
 	if (IS_ERR(backend->frontend))
 		return false;
 
-	if (!sun4i_frontend_format_is_supported(format))
+	if (!sun4i_frontend_format_is_supported(format, modifier))
 		return false;
 
-	if (!sun4i_backend_format_is_supported(format))
+	if (!sun4i_backend_format_is_supported(format, modifier))
 		return true;
 
 	/*
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 93db3af675b3..01f66463271b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -198,7 +198,7 @@ engine_to_sun4i_backend(struct sunxi_engine *engine)
 
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable);
-bool sun4i_backend_format_is_supported(uint32_t fmt);
+bool sun4i_backend_format_is_supported(uint32_t fmt, uint64_t modifier);
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 001139417cf5..b78e0a208c95 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -299,10 +299,13 @@ static const uint32_t sun4i_frontend_formats[] = {
 	DRM_FORMAT_YVYU,
 };
 
-bool sun4i_frontend_format_is_supported(uint32_t fmt)
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier)
 {
 	unsigned int i;
 
+	if (modifier != DRM_FORMAT_MOD_LINEAR)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sun4i_frontend_formats); i++)
 		if (sun4i_frontend_formats[i] == fmt)
 			return true;
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 54ec71a3e2f4..b209eacdf8c2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -115,6 +115,6 @@ void sun4i_frontend_update_coord(struct sun4i_frontend *frontend,
 				 struct drm_plane *plane);
 int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 				  struct drm_plane *plane, uint32_t out_fmt);
-bool sun4i_frontend_format_is_supported(uint32_t fmt);
+bool sun4i_frontend_format_is_supported(uint32_t fmt, uint64_t modifier);
 
 #endif /* _SUN4I_FRONTEND_H_ */
-- 
2.19.1
