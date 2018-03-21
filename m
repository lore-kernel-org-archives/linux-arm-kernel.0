From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 21 Mar 2018 16:28:57 +0100
Subject: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with the
 frontend
In-Reply-To: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns out that the frontend is not capable of preserving the alpha
component (that is always set to 0xff), so only support XRGB8888
instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index b98dafda52f8..274a1db6fa8e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -440,6 +440,10 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	if (IS_ERR(backend->frontend))
 		return false;
 
+	/*
+	 * TODO: Don't use the frontend for x2/x4 scaling and allow RGB formats
+	 * with an alpha component then.
+	 */
 	return sun4i_backend_plane_uses_scaler(state);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index ddf6cfa6dd23..3ea925584891 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
 static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
-	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB8888:
 		*val = 5;
 		return 0;
 
@@ -120,7 +120,6 @@ static int sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
 {
 	switch (fmt) {
 	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_ARGB8888:
 		*val = 2;
 		return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index eb93df445a10..15238211a61a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -100,9 +100,9 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 		sun4i_frontend_update_coord(frontend, plane);
 		sun4i_frontend_update_buffer(frontend, plane);
 		sun4i_frontend_update_formats(frontend, plane,
-					      DRM_FORMAT_ARGB8888);
+					      DRM_FORMAT_XRGB8888);
 		sun4i_backend_update_layer_frontend(backend, layer->id, plane,
-						    DRM_FORMAT_ARGB8888);
+						    DRM_FORMAT_XRGB8888);
 		sun4i_frontend_enable(frontend);
 	} else {
 		sun4i_backend_update_layer_formats(backend, layer->id, plane);
-- 
2.16.2
