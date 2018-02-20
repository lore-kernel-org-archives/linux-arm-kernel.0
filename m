From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Feb 2018 08:28:59 +0100
Subject: [PATCH] drm: simple_kms_helper: Add mode_valid() callback support
Message-ID: <20180220072859.3386-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PL111 needs to filter valid modes based on memory bandwidth.
I guess it is a pretty simple operation, so we can still claim
the DRM KMS helper pipeline is simple after adding this (optional)
vtable callback.

Reviewed-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix up the kerneldoc to just refer to the enum.
- Collect Eric's and Daniel's review tags.
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++++++++++
 include/drm/drm_simple_kms_helper.h     | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 9f3b1c94802b..652cde9a5a6b 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -34,6 +34,20 @@ static const struct drm_encoder_funcs drm_simple_kms_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
 
+static enum drm_mode_status
+drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
+			       const struct drm_display_mode *mode)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
+	if (!pipe->funcs || !pipe->funcs->mode_valid)
+		/* Anything goes */
+		return MODE_OK;
+
+	return pipe->funcs->mode_valid(crtc, mode);
+}
+
 static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
 				     struct drm_crtc_state *state)
 {
@@ -72,6 +86,7 @@ static void drm_simple_kms_crtc_disable(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
+	.mode_valid = drm_simple_kms_crtc_mode_valid,
 	.atomic_check = drm_simple_kms_crtc_check,
 	.atomic_enable = drm_simple_kms_crtc_enable,
 	.atomic_disable = drm_simple_kms_crtc_disable,
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index 6d9adbb46293..d9e4c3c3f009 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -21,6 +21,20 @@ struct drm_simple_display_pipe;
  *                                        display pipeline
  */
 struct drm_simple_display_pipe_funcs {
+	/**
+	 * @mode_valid:
+	 *
+	 * This function is called to filter out valid modes from the
+	 * suggestions suggested by the bridge or display. This optional
+	 * hook is passed in when initializing the pipeline.
+	 *
+	 * RETURNS:
+	 *
+	 * drm_mode_status Enum
+	 */
+	enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
+					   const struct drm_display_mode *mode);
+
 	/**
 	 * @enable:
 	 *
-- 
2.14.3
