From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:41:14 +0200
Subject: [PATCH 2/4] drm/sun4i: Use the runtime_pm commit_tail variant
In-Reply-To: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
Message-ID: <672c009f30c3121d75eb367743f89b0c69d16f5f.1499956639.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The backend (planes) commit can only happen when the TCON (CRTC) is
enabled, which is not guaranteed with the default commit_tail helper.

Let's use the runtime_pm version that is designed specifically to deal with
that case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 9872e0fc03b0..189048d33a1d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -10,6 +10,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drmP.h>
@@ -31,6 +32,10 @@ static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
 	.fb_create		= drm_fb_cma_create,
 };
 
+static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
+	.atomic_commit_tail	= drm_atomic_helper_commit_tail_runtime_pm,
+};
+
 struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
 {
 	drm_mode_config_reset(drm);
@@ -39,6 +44,7 @@ struct drm_fbdev_cma *sun4i_framebuffer_init(struct drm_device *drm)
 	drm->mode_config.max_height = 8192;
 
 	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
+	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
 
 	return drm_fbdev_cma_init(drm, 32, drm->mode_config.num_connector);
 }
-- 
git-series 0.9.1
