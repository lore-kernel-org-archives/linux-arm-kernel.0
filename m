From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:30 +0100
Subject: [PATCH 11/19] drm/sun4i: framebuffer: Add a custom atomic_check
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <74cd1157b24d511b8e81a256c9b029d64558d61d.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support normalized zpos, we need to call
drm_atomic_normalize_zpos in our driver's drm_mode_config_funcs'
atomic_check.

Let's duplicate the definition of drm_atomic_helper_check for now.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index a01a5b7d46e6..e68004844abe 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -26,9 +26,21 @@ static void sun4i_de_output_poll_changed(struct drm_device *drm)
 	drm_fbdev_cma_hotplug_event(drv->fbdev);
 }
 
+static int sun4i_de_atomic_check(struct drm_device *dev,
+				 struct drm_atomic_state *state)
+{
+	int ret;
+
+	ret = drm_atomic_helper_check_modeset(dev, state);
+	if (ret)
+		return ret;
+
+	return drm_atomic_helper_check_planes(dev, state);
+}
+
 static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
 	.output_poll_changed	= sun4i_de_output_poll_changed,
-	.atomic_check		= drm_atomic_helper_check,
+	.atomic_check		= sun4i_de_atomic_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 	.fb_create		= drm_gem_fb_create,
 };
-- 
git-series 0.9.1
