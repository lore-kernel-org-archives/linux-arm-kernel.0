From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 18:39:33 +0100
Subject: [PATCH v3 5/8] drm/sun4i: Remove the plane description structure
In-Reply-To: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <6b09e3698e692c3338f70a5ae1e5a580f9dd08ee.1518802627.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plane description structure was mostly needed to differentiate the
formats usable on the primary plane (because of its lowest position), and
assign the pipes. Now that both are dynamically checked and assigned, we
can remove the static definition.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 44 +++++-------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 3e3d554713cb..85cc7e9461b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -19,13 +19,6 @@
 #include "sun4i_layer.h"
 #include "sunxi_engine.h"
 
-struct sun4i_plane_desc {
-	enum drm_plane_type     type;
-	u8                      pipe;
-	const uint32_t          *formats;
-	uint32_t                nformats;
-};
-
 static void sun4i_backend_layer_reset(struct drm_plane *plane)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
@@ -133,14 +126,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-static const uint32_t sun4i_backend_layer_formats_primary[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_XRGB8888,
-};
-
-static const uint32_t sun4i_backend_layer_formats_overlay[] = {
+static const uint32_t sun4i_backend_layer_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
@@ -151,24 +137,9 @@ static const uint32_t sun4i_backend_layer_formats_overlay[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-static const struct sun4i_plane_desc sun4i_backend_planes[] = {
-	{
-		.type = DRM_PLANE_TYPE_PRIMARY,
-		.pipe = 0,
-		.formats = sun4i_backend_layer_formats_primary,
-		.nformats = ARRAY_SIZE(sun4i_backend_layer_formats_primary),
-	},
-	{
-		.type = DRM_PLANE_TYPE_OVERLAY,
-		.pipe = 1,
-		.formats = sun4i_backend_layer_formats_overlay,
-		.nformats = ARRAY_SIZE(sun4i_backend_layer_formats_overlay),
-	},
-};
-
 static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 						struct sun4i_backend *backend,
-						const struct sun4i_plane_desc *plane)
+						enum drm_plane_type type)
 {
 	struct sun4i_layer *layer;
 	int ret;
@@ -180,8 +151,9 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
-				       plane->formats, plane->nformats,
-				       NULL, plane->type, NULL);
+				       sun4i_backend_layer_formats,
+				       ARRAY_SIZE(sun4i_backend_layer_formats),
+				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
 		return ERR_PTR(ret);
@@ -207,11 +179,11 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 	if (!planes)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
-		const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
+	for (i = 0; i < SUN4I_BACKEND_NUM_LAYERS; i++) {
+		enum drm_plane_type type = i ? DRM_PLANE_TYPE_OVERLAY : DRM_PLANE_TYPE_PRIMARY;
 		struct sun4i_layer *layer;
 
-		layer = sun4i_layer_init_one(drm, backend, plane);
+		layer = sun4i_layer_init_one(drm, backend, type);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
-- 
git-series 0.9.1
