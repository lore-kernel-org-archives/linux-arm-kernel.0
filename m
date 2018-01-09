From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:16 +0100
Subject: [PATCH v3 03/13] drm/sun4i: backend: Allow a NULL plane pointer to
 retrieve the format
In-Reply-To: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
Message-ID: <bfbe4c2e8525a7542526b648d59a8f3546e905f1.1515492513.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function converting the DRM format to its equivalent in the backend
registers was assuming that we were having a plane.

However, we might want to use that function when setting up a plane using
the frontend, in which case we will not have a plane associated to the
backend's layer. Yet, we still need to setup the format to the one output
by the frontend.

Test for NULL plane pointers before referencing them, so that we can work
around it.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index c99d1a7e815a..f971d3fb5ee4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -93,7 +93,7 @@ void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
 					     u32 format, u32 *mode)
 {
-	if ((plane->type == DRM_PLANE_TYPE_PRIMARY) &&
+	if (plane && (plane->type == DRM_PLANE_TYPE_PRIMARY) &&
 	    (format == DRM_FORMAT_ARGB8888))
 		format = DRM_FORMAT_XRGB8888;
 
-- 
git-series 0.9.1
