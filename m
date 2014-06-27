From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 17:19:25 +0200
Subject: [PATCH v3 4/4] drm/tegra: Implement race-free hotplug detection
In-Reply-To: <1403882365-18337-1-git-send-email-thierry.reding@gmail.com>
References: <1403882365-18337-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403882365-18337-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

A race condition currently exists on Tegra, where it can happen that a
monitor attached via HDMI isn't detected during the initial FB helper
setup, but the hotplug event happens too early to be processed by the
poll helpers because they haven't been initialized yet. This happens
because on some boards the HDMI driver can control the regulator that
supplies the +5V pin on the HDMI connector. Therefore depending on the
timing between the initialization of the HDMI driver and the rest of
DRM, it's possible that the monitor returns the hotplug signal right
within the window where we would miss it.

Unfortunately, drm_kms_helper_poll_init() will wreak havoc when called
before at least some parts of the FB helpers have been set up.

This commit fixes this by splitting out the minimum of initialization
required to make drm_kms_helper_poll_init() work into a separate
function that can be called early. It is then safe to move all of the
poll helper initialization to an earlier point in time (before the
HDMI output driver has a chance to enable the +5V supply). That way if
the hotplug signal is returned before the initial FB helper setup, the
monitor will be forcefully detected at that point, and if the hotplug
signal is returned after that it will be properly handled by the poll
helpers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c |  8 ++++++--
 drivers/gpu/drm/tegra/drm.h |  1 +
 drivers/gpu/drm/tegra/fb.c  | 47 ++++++++++++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 3396f9f6a9f7..fd736efd14bd 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -40,6 +40,12 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 
 	drm_mode_config_init(drm);
 
+	err = tegra_drm_fb_prepare(drm);
+	if (err < 0)
+		return err;
+
+	drm_kms_helper_poll_init(drm);
+
 	err = host1x_device_init(device);
 	if (err < 0)
 		return err;
@@ -59,8 +65,6 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 	if (err < 0)
 		return err;
 
-	drm_kms_helper_poll_init(drm);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 6b8fe9d86ed4..0d30689dff01 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -280,6 +280,7 @@ struct tegra_bo *tegra_fb_get_plane(struct drm_framebuffer *framebuffer,
 				    unsigned int index);
 bool tegra_fb_is_bottom_up(struct drm_framebuffer *framebuffer);
 bool tegra_fb_is_tiled(struct drm_framebuffer *framebuffer);
+int tegra_drm_fb_prepare(struct drm_device *drm);
 int tegra_drm_fb_init(struct drm_device *drm);
 void tegra_drm_fb_exit(struct drm_device *drm);
 #ifdef CONFIG_DRM_TEGRA_FBDEV
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index d5d53aa79ced..fc1528e0bda1 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -271,13 +271,9 @@ static const struct drm_fb_helper_funcs tegra_fb_helper_funcs = {
 	.fb_probe = tegra_fbdev_probe,
 };
 
-static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm,
-					      unsigned int preferred_bpp,
-					      unsigned int num_crtc,
-					      unsigned int max_connectors)
+static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm)
 {
 	struct tegra_fbdev *fbdev;
-	int err;
 
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
 	if (!fbdev) {
@@ -287,10 +283,21 @@ static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm,
 
 	drm_fb_helper_prepare(drm, &fbdev->base, &tegra_fb_helper_funcs);
 
+	return fbdev;
+}
+
+static int tegra_fbdev_init(struct tegra_fbdev *fbdev,
+			    unsigned int preferred_bpp,
+			    unsigned int num_crtc,
+			    unsigned int max_connectors)
+{
+	struct drm_device *drm = fbdev->base.dev;
+	int err;
+
 	err = drm_fb_helper_init(drm, &fbdev->base, num_crtc, max_connectors);
 	if (err < 0) {
 		dev_err(drm->dev, "failed to initialize DRM FB helper\n");
-		goto free;
+		return err;
 	}
 
 	err = drm_fb_helper_single_add_all_connectors(&fbdev->base);
@@ -299,21 +306,17 @@ static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm,
 		goto fini;
 	}
 
-	drm_helper_disable_unused_functions(drm);
-
 	err = drm_fb_helper_initial_config(&fbdev->base, preferred_bpp);
 	if (err < 0) {
 		dev_err(drm->dev, "failed to set initial configuration\n");
 		goto fini;
 	}
 
-	return fbdev;
+	return 0;
 
 fini:
 	drm_fb_helper_fini(&fbdev->base);
-free:
-	kfree(fbdev);
-	return ERR_PTR(err);
+	return err;
 }
 
 static void tegra_fbdev_free(struct tegra_fbdev *fbdev)
@@ -364,7 +367,7 @@ static const struct drm_mode_config_funcs tegra_drm_mode_funcs = {
 #endif
 };
 
-int tegra_drm_fb_init(struct drm_device *drm)
+int tegra_drm_fb_prepare(struct drm_device *drm)
 {
 #ifdef CONFIG_DRM_TEGRA_FBDEV
 	struct tegra_drm *tegra = drm->dev_private;
@@ -379,8 +382,7 @@ int tegra_drm_fb_init(struct drm_device *drm)
 	drm->mode_config.funcs = &tegra_drm_mode_funcs;
 
 #ifdef CONFIG_DRM_TEGRA_FBDEV
-	tegra->fbdev = tegra_fbdev_create(drm, 32, drm->mode_config.num_crtc,
-					  drm->mode_config.num_connector);
+	tegra->fbdev = tegra_fbdev_create(drm);
 	if (IS_ERR(tegra->fbdev))
 		return PTR_ERR(tegra->fbdev);
 #endif
@@ -388,6 +390,21 @@ int tegra_drm_fb_init(struct drm_device *drm)
 	return 0;
 }
 
+int tegra_drm_fb_init(struct drm_device *drm)
+{
+#ifdef CONFIG_DRM_TEGRA_FBDEV
+	struct tegra_drm *tegra = drm->dev_private;
+	int err;
+
+	err = tegra_fbdev_init(tegra->fbdev, 32, drm->mode_config.num_crtc,
+			       drm->mode_config.num_connector);
+	if (err < 0)
+		return err;
+#endif
+
+	return 0;
+}
+
 void tegra_drm_fb_exit(struct drm_device *drm)
 {
 #ifdef CONFIG_DRM_TEGRA_FBDEV
-- 
2.0.0
