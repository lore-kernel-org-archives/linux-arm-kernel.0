From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:29:38 +0200
Subject: [PATCH 5/5] drm/sun4i: Add support for the overscan profiles
In-Reply-To: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b980759ad766658d7bc3d67c18f505c5bf727ef5.1476779323.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create overscan profiles reducing the displayed zone.

For each TV standard (PAL and NTSC so far), we create 4 more reduced modes
by steps of 5% that the user will be able to select.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 60 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index f99886462cb8..9ee03ba086b6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -301,27 +301,33 @@ static const struct tv_mode *sun4i_tv_find_tv_by_mode(const struct drm_display_m
 		DRM_DEBUG_DRIVER("Comparing mode %s vs %s",
 				 mode->name, tv_mode->name);
 
-		if (!strcmp(mode->name, tv_mode->name))
+		if (!strncmp(mode->name, tv_mode->name, strlen(tv_mode->name)))
 			return tv_mode;
 	}
 
 	/* Then by number of lines */
 	for (i = 0; i < ARRAY_SIZE(tv_modes); i++) {
 		const struct tv_mode *tv_mode = &tv_modes[i];
+		int j;
 
-		DRM_DEBUG_DRIVER("Comparing mode %s vs %s (X: %d vs %d)",
-				 mode->name, tv_mode->name,
-				 mode->vdisplay, tv_mode->vdisplay);
+		for (j = 0; j < 20; j += 5) {
+			u32 vdisplay = tv_mode->vdisplay * (100 - j) / 100;
 
-		if (mode->vdisplay == tv_mode->vdisplay)
-			return tv_mode;
+			DRM_DEBUG_DRIVER("Comparing mode with %s (%d) (X: %d vs %d)",
+					 tv_mode->name, j,
+					 vdisplay, tv_mode->vdisplay);
+
+			if (vdisplay == tv_mode->vdisplay)
+				return tv_mode;
+		}
 	}
 
 	return NULL;
 }
 
 static void sun4i_tv_mode_to_drm_mode(const struct tv_mode *tv_mode,
-				      struct drm_display_mode *mode)
+				      struct drm_display_mode *mode,
+				      int overscan)
 {
 	DRM_DEBUG_DRIVER("Creating mode %s\n", mode->name);
 
@@ -329,12 +335,12 @@ static void sun4i_tv_mode_to_drm_mode(const struct tv_mode *tv_mode,
 	mode->clock = 13500;
 	mode->flags = DRM_MODE_FLAG_INTERLACE;
 
-	mode->hdisplay = tv_mode->hdisplay;
+	mode->hdisplay = tv_mode->hdisplay * (100 - overscan) / 100;
 	mode->hsync_start = mode->hdisplay + tv_mode->hfront_porch;
 	mode->hsync_end = mode->hsync_start + tv_mode->hsync_len;
 	mode->htotal = mode->hsync_end  + tv_mode->hback_porch;
 
-	mode->vdisplay = tv_mode->vdisplay;
+	mode->vdisplay = tv_mode->vdisplay * (100 - overscan) / 100;
 	mode->vsync_start = mode->vdisplay + tv_mode->vfront_porch;
 	mode->vsync_end = mode->vsync_start + tv_mode->vsync_len;
 	mode->vtotal = mode->vsync_end  + tv_mode->vback_porch;
@@ -352,10 +358,10 @@ static int sun4i_tv_atomic_check(struct drm_encoder *encoder,
 		return -EINVAL;
 
 	state->display_x_size = tv_mode->hdisplay;
-	state->plane_x_offset = 0;
+	state->plane_x_offset = (tv_mode->hdisplay - mode->hdisplay) / 2;
 
 	state->display_y_size = tv_mode->vdisplay;
-	state->plane_y_offset = 0;
+	state->plane_y_offset = (tv_mode->vdisplay - mode->vdisplay) / 2;
 
 	return 0;
 }
@@ -404,7 +410,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	struct drm_display_mode tv_drm_mode = { 0 };
 
 	strcpy(tv_drm_mode.name, "TV");
-	sun4i_tv_mode_to_drm_mode(tv_mode, &tv_drm_mode);
+	sun4i_tv_mode_to_drm_mode(tv_mode, &tv_drm_mode, 0);
 	drm_mode_set_crtcinfo(&tv_drm_mode, CRTC_INTERLACE_HALVE_V);
 
 	sun4i_tcon1_mode_set(tcon, &tv_drm_mode);
@@ -526,22 +532,28 @@ static int sun4i_tv_comp_get_modes(struct drm_connector *connector)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(tv_modes); i++) {
-		struct drm_display_mode *mode;
 		const struct tv_mode *tv_mode = &tv_modes[i];
-
-		mode = drm_mode_create(connector->dev);
-		if (!mode) {
-			DRM_ERROR("Failed to create a new display mode\n");
-			return 0;
+		int j;
+
+		for (j = 0; j < 20; j += 5) {
+			struct drm_display_mode *mode = drm_mode_create(connector->dev);
+			if (!mode) {
+				DRM_ERROR("Failed to create a new display mode\n");
+				return 0;
+			}
+
+			if (j)
+				sprintf(mode->name, "%s%d", tv_mode->name,
+					j);
+			else
+				strcpy(mode->name, tv_mode->name);
+
+			sun4i_tv_mode_to_drm_mode(tv_mode, mode, j);
+			drm_mode_probed_add(connector, mode);
 		}
-
-		strcpy(mode->name, tv_mode->name);
-
-		sun4i_tv_mode_to_drm_mode(tv_mode, mode);
-		drm_mode_probed_add(connector, mode);
 	}
 
-	return i;
+	return i * 4;
 }
 
 static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
-- 
git-series 0.8.10
