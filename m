From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:01:17 +0200
Subject: [PATCH v2 2/4] drm/sun4i: Use the runtime_pm commit_tail variant
In-Reply-To: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
Message-ID: <79d61e6736618dea1753d9a9b3fbde43cdee5929.1500555652.git-series.maxime.ripard@free-electrons.com>
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
index 9872e0fc03b0..53ab61665390 100644
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
+	.atomic_commit_tail	= drm_atomic_helper_commit_tail_rpm,
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
