From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:48 +0100
Subject: [PATCH v2 19/19] drm/sun4i: backend: Remove ARGB spoofing
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7d2835035a00dc8a58e4715fd0a4376b199f6cb7.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've had some code for quite some time to prevent the alpha bug from
happening on the lowest primary plane. Since we now check for this in our
atomic_check, we can simply remove it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index f5beeec06fd5..b414dc87e217 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -92,13 +92,8 @@ void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_MODCTL_LAY_EN(layer), val);
 }
 
-static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
-					     u32 format, u32 *mode)
+static int sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
 {
-	if (plane && (plane->type == DRM_PLANE_TYPE_PRIMARY) &&
-	    (format == DRM_FORMAT_ARGB8888))
-		format = DRM_FORMAT_XRGB8888;
-
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
 		*mode = SUN4I_BACKEND_LAY_FBFMT_ARGB8888;
@@ -200,8 +195,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
 			   SUN4I_BACKEND_ATTCTL_REG0_LAY_GLBALPHA_EN,
 			   val);
 
-	ret = sun4i_backend_drm_format_to_layer(plane, fb->format->format,
-						&val);
+	ret = sun4i_backend_drm_format_to_layer(fb->format->format, &val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return ret;
@@ -220,7 +214,7 @@ int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
 	u32 val;
 	int ret;
 
-	ret = sun4i_backend_drm_format_to_layer(NULL, fmt, &val);
+	ret = sun4i_backend_drm_format_to_layer(fmt, &val);
 	if (ret) {
 		DRM_DEBUG_DRIVER("Invalid format\n");
 		return ret;
-- 
git-series 0.9.1
