From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:34 +0100
Subject: [PATCH v2 02/43] drm/sun4i: frontend: Replace ARGB with XRGB as
 supported format
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-3-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The frontend documentation (for the A33) mentions that ARGB is supported
as output, but with the alpha component always set to 0xff. In practice,
this means that the alpha component cannot be preserved when going
through the frontend. Since the information is lost, ARGB is not
properly supported.

As a result, expose the matching format supported by the frontend (both
for input and output) as XRGB instead of ARGB.

Since ARGB was the selected format for connecting the frontend to the
backend, change it to XRGB to reflect this as well.

The A31 and A80 SoCs apparently have a bit to enable proper alpha,
but this is not supported at this point (see the comment already in the
code).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
 drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

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
index e0e37c2f1721..50bb16566f03 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -99,9 +99,9 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 		sun4i_frontend_update_coord(frontend, plane);
 		sun4i_frontend_update_buffer(frontend, plane);
 		sun4i_frontend_update_formats(frontend, plane,
-					      DRM_FORMAT_ARGB8888);
+					      DRM_FORMAT_XRGB8888);
 		sun4i_backend_update_layer_frontend(backend, layer->id,
-						    DRM_FORMAT_ARGB8888);
+						    DRM_FORMAT_XRGB8888);
 		sun4i_frontend_enable(frontend);
 	} else {
 		sun4i_backend_update_layer_formats(backend, layer->id, plane);
-- 
2.19.1
