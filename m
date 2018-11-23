From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:36 +0100
Subject: [PATCH v2 04/43] drm/sun4i: backend: Add a helper and a list for
 supported formats
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-5-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to check whether the backend supports a specific format, an
explicit list and a related helper are introduced.

The prototype of this helper is added to the header so that it can be
called from sun4i_layer later (when introducing tiled mode support).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index c3444246755b..7dd24eb03f89 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -155,6 +155,33 @@ static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
 	return 0;
 }
 
+static const uint32_t sun4i_backend_formats[] = {
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_BGRX8888,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGBA4444,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_UYVY,
+	DRM_FORMAT_VYUY,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_YUYV,
+	DRM_FORMAT_YVYU,
+};
+
+bool sun4i_backend_format_is_supported(uint32_t fmt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++)
+		if (sun4i_backend_formats[i] == fmt)
+			return true;
+
+	return false;
+}
+
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 339dbff1cce4..93db3af675b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -198,6 +198,7 @@ engine_to_sun4i_backend(struct sunxi_engine *engine)
 
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable);
+bool sun4i_backend_format_is_supported(uint32_t fmt);
 int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
 				     int layer, struct drm_plane *plane);
 int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
-- 
2.19.1
