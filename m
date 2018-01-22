From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 10:25:25 +0100
Subject: [PATCH v4 11/13] drm/sun4i: backend: Use runtime_pm variant of
 atomic_commit_tail
In-Reply-To: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
References: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
Message-ID: <bde95faff2078f63e9af99c3abee5360b9050fd1.1516613040.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a hardware commit, the commit bit in the backend will only be
cleared if the TCON is enabled. Use the runtime_pm variant of the
atomic_commit_tail hook that makes sure that the CRTC, our TCON, is enabled
when we perform an atomic_commit.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 2992f0a6b349..a01a5b7d46e6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -10,6 +10,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -32,6 +33,10 @@ static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
 };
 
+static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
+	.atomic_commit_tail	= drm_atomic_helper_commit_tail_rpm,
+};
+
 struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
 {
 	drm_mode_config_reset(drm);
@@ -40,6 +45,7 @@ struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
 	drm->mode_config.max_height = 8192;
 
 	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
+	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
 
 	return drm_fbdev_cma_init(drm, 32, drm->mode_config.num_connector);
 }
-- 
git-series 0.9.1
