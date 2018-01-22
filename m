From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:34 +0100
Subject: [PATCH v2 05/19] drm/vc4: Use the alpha format field in
 drm_format_info
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <38d4d0a085634a0b8308e819c846b9173d4d93df.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the drm_format_info has a alpha field to tell if a format embeds
an alpha component in it, let's use it.

Cc: Eric Anholt <eric@anholt.net>
Reviewed-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 423a23ed8fc2..a0a626242bcd 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -85,40 +85,39 @@ static const struct hvs_format {
 	u32 drm; /* DRM_FORMAT_* */
 	u32 hvs; /* HVS_FORMAT_* */
 	u32 pixel_order;
-	bool has_alpha;
 	bool flip_cbcr;
 } hvs_formats[] = {
 	{
 		.drm = DRM_FORMAT_XRGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
-		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = false,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
 	},
 	{
 		.drm = DRM_FORMAT_ARGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
-		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = true,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
 	},
 	{
 		.drm = DRM_FORMAT_ABGR8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
-		.pixel_order = HVS_PIXEL_ORDER_ARGB, .has_alpha = true,
+		.pixel_order = HVS_PIXEL_ORDER_ARGB,
 	},
 	{
 		.drm = DRM_FORMAT_XBGR8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
-		.pixel_order = HVS_PIXEL_ORDER_ARGB, .has_alpha = false,
+		.pixel_order = HVS_PIXEL_ORDER_ARGB,
 	},
 	{
 		.drm = DRM_FORMAT_RGB565, .hvs = HVS_PIXEL_FORMAT_RGB565,
-		.pixel_order = HVS_PIXEL_ORDER_XRGB, .has_alpha = false,
+		.pixel_order = HVS_PIXEL_ORDER_XRGB,
 	},
 	{
 		.drm = DRM_FORMAT_BGR565, .hvs = HVS_PIXEL_FORMAT_RGB565,
-		.pixel_order = HVS_PIXEL_ORDER_XBGR, .has_alpha = false,
+		.pixel_order = HVS_PIXEL_ORDER_XBGR,
 	},
 	{
 		.drm = DRM_FORMAT_ARGB1555, .hvs = HVS_PIXEL_FORMAT_RGBA5551,
-		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = true,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
 	},
 	{
 		.drm = DRM_FORMAT_XRGB1555, .hvs = HVS_PIXEL_FORMAT_RGBA5551,
-		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = false,
+		.pixel_order = HVS_PIXEL_ORDER_ABGR,
 	},
 	{
 		.drm = DRM_FORMAT_YUV422,
@@ -601,7 +600,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	/* Position Word 2: Source Image Size, Alpha Mode */
 	vc4_state->pos2_offset = vc4_state->dlist_count;
 	vc4_dlist_write(vc4_state,
-			VC4_SET_FIELD(format->has_alpha ?
+			VC4_SET_FIELD(fb->format->has_alpha ?
 				      SCALER_POS2_ALPHA_MODE_PIPELINE :
 				      SCALER_POS2_ALPHA_MODE_FIXED,
 				      SCALER_POS2_ALPHA_MODE) |
-- 
git-series 0.9.1
