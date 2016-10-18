From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:29:35 +0200
Subject: [PATCH 2/5] drm/modes: Support modes names on the command line
In-Reply-To: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
Message-ID: <853193fdf9ec1af94056d9fa2c276079c779aaf4.1476779323.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drm subsystem also uses the video= kernel parameter, and in the
documentation refers to the fbdev documentation for that parameter.

However, that documentation also says that instead of giving the mode using
its resolution we can also give a name. However, DRM doesn't handle that
case at the moment. Even though in most case it shouldn't make any
difference, it might be useful for analog modes, where different standards
might have the same resolution, but still have a few different parameters
that are not encoded in the modes (NTSC vs NTSC-J vs PAL-M for example).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/drm_connector.c |  3 +-
 drivers/gpu/drm/drm_fb_helper.c |  4 +++-
 drivers/gpu/drm/drm_modes.c     | 49 +++++++++++++++++++++++-----------
 include/drm/drm_connector.h     |  1 +-
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 2db7fb510b6c..27a8a511257c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -147,8 +147,9 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
 		connector->force = mode->force;
 	}
 
-	DRM_DEBUG_KMS("cmdline mode for connector %s %dx%d@%dHz%s%s%s\n",
+	DRM_DEBUG_KMS("cmdline mode for connector %s %s %dx%d@%dHz%s%s%s\n",
 		      connector->name,
+		      mode->name ? mode->name : "",
 		      mode->xres, mode->yres,
 		      mode->refresh_specified ? mode->refresh : 60,
 		      mode->rb ? " reduced blanking" : "",
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 03414bde1f15..20a68305fb45 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1748,6 +1748,10 @@ struct drm_display_mode *drm_pick_cmdline_mode(struct drm_fb_helper_connector *f
 	prefer_non_interlace = !cmdline_mode->interlace;
 again:
 	list_for_each_entry(mode, &fb_helper_conn->connector->modes, head) {
+		/* Check (optional) mode name first */
+		if (!strcmp(mode->name, cmdline_mode->name))
+			return mode;
+
 		/* check width/height */
 		if (mode->hdisplay != cmdline_mode->xres ||
 		    mode->vdisplay != cmdline_mode->yres)
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 7d5bdca276f2..fdbf541a5978 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1413,7 +1413,7 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 					       struct drm_cmdline_mode *mode)
 {
 	const char *name;
-	bool parse_extras = false;
+	bool named_mode = false, parse_extras = false;
 	unsigned int bpp_off = 0, refresh_off = 0;
 	unsigned int mode_end = 0;
 	char *bpp_ptr = NULL, *refresh_ptr = NULL, *extra_ptr = NULL;
@@ -1432,8 +1432,14 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 
 	name = mode_option;
 
+	/*
+	 * If the first character is not a digit, then it means that
+	 * we have a named mode.
+	 */
 	if (!isdigit(name[0]))
-		return false;
+		named_mode = true;
+	else
+		named_mode = false;
 
 	/* Try to locate the bpp and refresh specifiers, if any */
 	bpp_ptr = strchr(name, '-');
@@ -1460,12 +1466,16 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 		parse_extras = true;
 	}
 
-	ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
-					      parse_extras,
-					      connector,
-					      mode);
-	if (ret)
-		return false;
+	if (named_mode) {
+		strncpy(mode->name, name, mode_end);
+	} else {
+		ret = drm_mode_parse_cmdline_res_mode(name, mode_end,
+						      parse_extras,
+						      connector,
+						      mode);
+		if (ret)
+			return false;
+	}
 	mode->specified = true;
 
 	if (bpp_ptr) {
@@ -1493,14 +1503,23 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 		extra_ptr = refresh_end_ptr;
 
 	if (extra_ptr) {
-		int remaining = strlen(name) - (extra_ptr - name);
+		if (!named_mode) {
+			int len = strlen(name) - (extra_ptr - name);
 
-		/*
-		 * We still have characters to process, while
-		 * we shouldn't have any
-		 */
-		if (remaining > 0)
-			return false;
+			ret = drm_mode_parse_cmdline_extra(extra_ptr, len,
+							   connector, mode);
+			if (ret)
+				return false;
+		} else {
+			int remaining = strlen(name) - (extra_ptr - name);
+
+			/*
+			 * We still have characters to process, while
+			 * we shouldn't have any
+			 */
+			if (remaining > 0)
+				return false;
+		}
 	}
 
 	return true;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index ac9d7d8e0e43..dce3d4b2fd33 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -485,6 +485,7 @@ struct drm_connector_funcs {
 
 /* mode specified on the command line */
 struct drm_cmdline_mode {
+	char name[DRM_DISPLAY_MODE_LEN];
 	bool specified;
 	bool refresh_specified;
 	bool bpp_specified;
-- 
git-series 0.8.10
