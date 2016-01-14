From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:24:58 +0100
Subject: [PATCH v2 15/26] drm/modes: Support modes names on the command line
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-16-git-send-email-maxime.ripard@free-electrons.com>
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
 drivers/gpu/drm/drm_crtc.c      |  3 ++-
 drivers/gpu/drm/drm_fb_helper.c |  4 ++++
 drivers/gpu/drm/drm_modes.c     | 49 ++++++++++++++++++++++++++++-------------
 include/drm/drm_modes.h         |  1 +
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 24c5434abd1c..c3267d695e4e 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -846,8 +846,9 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
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
index 69cbab5e5c81..fcb7ba796202 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1649,6 +1649,10 @@ struct drm_display_mode *drm_pick_cmdline_mode(struct drm_fb_helper_connector *f
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
index 5b1921b22dd6..bbb23000eb5b 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1351,7 +1351,7 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 					       struct drm_cmdline_mode *mode)
 {
 	const char *name;
-	bool parse_extras = false;
+	bool named_mode = false, parse_extras = false;
 	unsigned int bpp_off = 0, refresh_off = 0;
 	unsigned int mode_end = 0;
 	char *bpp_ptr = NULL, *refresh_ptr = NULL, *extra_ptr = NULL;
@@ -1370,8 +1370,14 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 
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
@@ -1398,12 +1404,16 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
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
@@ -1431,14 +1441,23 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
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
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index 08a8cac9e555..709d43f3515e 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -151,6 +151,7 @@ struct drm_display_mode {
 
 /* mode specified on the command line */
 struct drm_cmdline_mode {
+	char name[DRM_DISPLAY_MODE_LEN];
 	bool specified;
 	bool refresh_specified;
 	bool bpp_specified;
-- 
2.6.4
