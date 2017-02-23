From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 16:05:42 +0800
Subject: [PATCH 10/11] drm/sun4i: Add backend pointer to sun4i_layer
In-Reply-To: <20170223080543.6659-1-wens@csie.org>
References: <20170223080543.6659-1-wens@csie.org>
Message-ID: <20170223080543.6659-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_layer only controls the backend hardware block of the display
pipeline. Instead of getting a pointer to the underlying backend
through the drm_device structure, leave one in itself.

Also drop the drm_device pointer, since it is no longer needed.

The next step forward would be to pass the pointer in through
sun4i_layers_init as a parameter. This would make it easier to support
multiple display pipelines layer on.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 8 +++-----
 drivers/gpu/drm/sun4i/sun4i_layer.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 431e13362b62..6feaf85a5942 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -36,8 +36,7 @@ static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
 					       struct drm_plane_state *old_state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
-	struct sun4i_drv *drv = layer->drv;
-	struct sun4i_backend *backend = drv->backend;
+	struct sun4i_backend *backend = layer->backend;
 
 	sun4i_backend_layer_enable(backend, layer->id, false);
 }
@@ -46,8 +45,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 					      struct drm_plane_state *old_state)
 {
 	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
-	struct sun4i_drv *drv = layer->drv;
-	struct sun4i_backend *backend = drv->backend;
+	struct sun4i_backend *backend = layer->backend;
 
 	sun4i_backend_update_layer_coord(backend, layer->id, plane);
 	sun4i_backend_update_layer_formats(backend, layer->id, plane);
@@ -126,7 +124,7 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 
 	drm_plane_helper_add(&layer->plane,
 			     &sun4i_backend_layer_helper_funcs);
-	layer->drv = drv;
+	layer->backend = drv->backend;
 
 	return layer;
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
index a2f65d7a3f4e..a97e376bae17 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.h
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
@@ -16,6 +16,7 @@
 struct sun4i_layer {
 	struct drm_plane	plane;
 	struct sun4i_drv	*drv;
+	struct sun4i_backend	*backend;
 	int			id;
 };
 
-- 
2.11.0
