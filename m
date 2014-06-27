From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 17:19:24 +0200
Subject: [PATCH v3 3/4] drm: Introduce drm_fb_helper_prepare()
In-Reply-To: <1403882365-18337-1-git-send-email-thierry.reding@gmail.com>
References: <1403882365-18337-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403882365-18337-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

To implement hotplug detection in a race-free manner, drivers must call
drm_kms_helper_poll_init() before hotplug events can be triggered. Such
events can be triggered right after any of the encoders or connectors
are initialized. At the same time, if the drm_fb_helper_hotplug_event()
helper is used by a driver, then the poll helper requires some parts of
the FB helper to be initialized to prevent a crash.

At the same time, drm_fb_helper_init() requires information that is not
necessarily available at such an early stage (number of CRTCs and
connectors), so it cannot be used yet.

Add a new helper, drm_fb_helper_prepare(), that initializes the bare
minimum needed to allow drm_kms_helper_poll_init() to execute and any
subsequent hotplug events to be processed properly.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- fix inconsistency "second" -> "third" (Daniel Vetter)

Changes in v2:
- improve kernel-doc (Daniel Vetter)

 drivers/gpu/drm/armada/armada_fbdev.c     |  2 +-
 drivers/gpu/drm/ast/ast_fb.c              |  4 ++-
 drivers/gpu/drm/bochs/bochs_fbdev.c       |  3 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c     |  4 ++-
 drivers/gpu/drm/drm_fb_cma_helper.c       |  3 +-
 drivers/gpu/drm/drm_fb_helper.c           | 47 ++++++++++++++++++++++++-------
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  3 +-
 drivers/gpu/drm/gma500/framebuffer.c      |  3 +-
 drivers/gpu/drm/i915/intel_fbdev.c        |  3 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c      |  3 +-
 drivers/gpu/drm/msm/msm_fbdev.c           |  2 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c   |  3 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c      |  2 +-
 drivers/gpu/drm/qxl/qxl_fb.c              |  5 +++-
 drivers/gpu/drm/radeon/radeon_fb.c        |  4 ++-
 drivers/gpu/drm/tegra/fb.c                |  4 +--
 drivers/gpu/drm/udl/udl_fb.c              |  3 +-
 include/drm/drm_fb_helper.h               |  2 ++
 18 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index a7c947cd9386..7838e731b0de 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -149,7 +149,7 @@ int armada_fbdev_init(struct drm_device *dev)
 
 	priv->fbdev = fbh;
 
-	fbh->funcs = &armada_fb_helper_funcs;
+	drm_fb_helper_prepare(dev, fbh, &armada_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(dev, fbh, 1, 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index 2113894e4ff8..cba45c774552 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -328,8 +328,10 @@ int ast_fbdev_init(struct drm_device *dev)
 		return -ENOMEM;
 
 	ast->fbdev = afbdev;
-	afbdev->helper.funcs = &ast_fb_helper_funcs;
 	spin_lock_init(&afbdev->dirty_lock);
+
+	drm_fb_helper_prepare(dev, &afbdev->helper, &ast_fb_helper_funcs);
+
 	ret = drm_fb_helper_init(dev, &afbdev->helper,
 				 1, 1);
 	if (ret) {
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 17e5c17f2730..19cf3e9413b6 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -189,7 +189,8 @@ int bochs_fbdev_init(struct bochs_device *bochs)
 {
 	int ret;
 
-	bochs->fb.helper.funcs = &bochs_fb_helper_funcs;
+	drm_fb_helper_prepare(bochs->dev, &bochs->fb.helper,
+			      &bochs_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(bochs->dev, &bochs->fb.helper,
 				 1, 1);
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 2bd0291168e4..2a135f253e29 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -306,9 +306,11 @@ int cirrus_fbdev_init(struct cirrus_device *cdev)
 		return -ENOMEM;
 
 	cdev->mode_info.gfbdev = gfbdev;
-	gfbdev->helper.funcs = &cirrus_fb_helper_funcs;
 	spin_lock_init(&gfbdev->dirty_lock);
 
+	drm_fb_helper_prepare(cdev->dev, &gfbdev->helper,
+			      &cirrus_fb_helper_funcs);
+
 	ret = drm_fb_helper_init(cdev->dev, &gfbdev->helper,
 				 cdev->num_crtc, CIRRUSFB_CONN_LIMIT);
 	if (ret) {
diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
index cb01e1606384..cc0ae047ed3b 100644
--- a/drivers/gpu/drm/drm_fb_cma_helper.c
+++ b/drivers/gpu/drm/drm_fb_cma_helper.c
@@ -354,9 +354,10 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	fbdev_cma->fb_helper.funcs = &drm_fb_cma_helper_funcs;
 	helper = &fbdev_cma->fb_helper;
 
+	drm_fb_helper_prepare(dev, helper, &drm_fb_cma_helper_funcs);
+
 	ret = drm_fb_helper_init(dev, helper, num_crtc, max_conn_count);
 	if (ret < 0) {
 		dev_err(dev->dev, "Failed to initialize drm fb helper.\n");
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 13a098c9af31..14aef947b3d2 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -49,10 +49,11 @@ static LIST_HEAD(kernel_fb_helper_list);
  * helper functions used by many drivers to implement the kernel mode setting
  * interfaces.
  *
- * Initialization is done as a three-step process with drm_fb_helper_init(),
- * drm_fb_helper_single_add_all_connectors() and drm_fb_helper_initial_config().
- * Drivers with fancier requirements than the default behaviour can override the
- * second step with their own code.  Teardown is done with drm_fb_helper_fini().
+ * Initialization is done as a four-step process with drm_fb_helper_prepare(),
+ * drm_fb_helper_init(), drm_fb_helper_single_add_all_connectors() and
+ * drm_fb_helper_initial_config(). Drivers with fancier requirements than the
+ * default behaviour can override the third step with their own code.
+ * Teardown is done with drm_fb_helper_fini().
  *
  * At runtime drivers should restore the fbdev console by calling
  * drm_fb_helper_restore_fbdev_mode() from their ->lastclose callback. They
@@ -63,6 +64,19 @@ static LIST_HEAD(kernel_fb_helper_list);
  *
  * All other functions exported by the fb helper library can be used to
  * implement the fbdev driver interface by the driver.
+ *
+ * It is possible, though perhaps somewhat tricky, to implement race-free
+ * hotplug detection using the fbdev helpers. The drm_fb_helper_prepare()
+ * helper must be called first to initialize the minimum required to make
+ * hotplug detection work. Drivers also need to make sure to properly set up
+ * the dev->mode_config.funcs member. After calling drm_kms_helper_poll_init()
+ * it is safe to enable interrupts and start processing hotplug events. At the
+ * same time, drivers should initialize all modeset objects such as CRTCs,
+ * encoders and connectors. To finish up the fbdev helper initialization, the
+ * drm_fb_helper_init() function is called. To probe for all attached displays
+ * and set up an initial configuration using the detected hardware, drivers
+ * should call drm_fb_helper_single_add_all_connectors() followed by
+ * drm_fb_helper_initial_config().
  */
 
 /**
@@ -531,6 +545,24 @@ static void drm_fb_helper_crtc_free(struct drm_fb_helper *helper)
 }
 
 /**
+ * drm_fb_helper_prepare - setup a drm_fb_helper structure
+ * @dev: DRM device
+ * @helper: driver-allocated fbdev helper structure to set up
+ * @funcs: pointer to structure of functions associate with this helper
+ *
+ * Sets up the bare minimum to make the framebuffer helper usable. This is
+ * useful to implement race-free initialization of the polling helpers.
+ */
+void drm_fb_helper_prepare(struct drm_device *dev, struct drm_fb_helper *helper,
+			   const struct drm_fb_helper_funcs *funcs)
+{
+	INIT_LIST_HEAD(&helper->kernel_fb_list);
+	helper->funcs = funcs;
+	helper->dev = dev;
+}
+EXPORT_SYMBOL(drm_fb_helper_prepare);
+
+/**
  * drm_fb_helper_init - initialize a drm_fb_helper structure
  * @dev: drm device
  * @fb_helper: driver-allocated fbdev helper structure to initialize
@@ -542,8 +574,7 @@ static void drm_fb_helper_crtc_free(struct drm_fb_helper *helper)
  * nor register the fbdev. This is only done in drm_fb_helper_initial_config()
  * to allow driver writes more control over the exact init sequence.
  *
- * Drivers must set fb_helper->funcs before calling
- * drm_fb_helper_initial_config().
+ * Drivers must call drm_fb_helper_prepare() before calling this function.
  *
  * RETURNS:
  * Zero if everything went ok, nonzero otherwise.
@@ -558,10 +589,6 @@ int drm_fb_helper_init(struct drm_device *dev,
 	if (!max_conn_count)
 		return -EINVAL;
 
-	fb_helper->dev = dev;
-
-	INIT_LIST_HEAD(&fb_helper->kernel_fb_list);
-
 	fb_helper->crtc_info = kcalloc(crtc_count, sizeof(struct drm_fb_helper_crtc), GFP_KERNEL);
 	if (!fb_helper->crtc_info)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index fc25fe75aa77..32e63f60e1d1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -266,7 +266,8 @@ int exynos_drm_fbdev_init(struct drm_device *dev)
 		return -ENOMEM;
 
 	private->fb_helper = helper = &fbdev->drm_fb_helper;
-	helper->funcs = &exynos_drm_fb_helper_funcs;
+
+	drm_fb_helper_prepare(dev, helper, &exynos_drm_fb_helper_funcs);
 
 	num_crtc = dev->mode_config.num_crtc;
 
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 76e4d777d01d..d0dd3bea8aa5 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -600,7 +600,8 @@ int psb_fbdev_init(struct drm_device *dev)
 	}
 
 	dev_priv->fbdev = fbdev;
-	fbdev->psb_fb_helper.funcs = &psb_fb_helper_funcs;
+
+	drm_fb_helper_prepare(dev, &fbdev->psb_fb_helper, &psb_fb_helper_funcs);
 
 	drm_fb_helper_init(dev, &fbdev->psb_fb_helper, dev_priv->ops->crtcs,
 							INTELFB_CONN_LIMIT);
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index c14073094024..44e17fd781b8 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -649,7 +649,8 @@ int intel_fbdev_init(struct drm_device *dev)
 	if (ifbdev == NULL)
 		return -ENOMEM;
 
-	ifbdev->helper.funcs = &intel_fb_helper_funcs;
+	drm_fb_helper_prepare(dev, &ifbdev->helper, &intel_fb_helper_funcs);
+
 	if (!intel_fbdev_init_bios(dev, ifbdev))
 		ifbdev->preferred_bpp = 32;
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index a4319aba9180..5451dc58eff1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -293,9 +293,10 @@ int mgag200_fbdev_init(struct mga_device *mdev)
 		return -ENOMEM;
 
 	mdev->mfbdev = mfbdev;
-	mfbdev->helper.funcs = &mga_fb_helper_funcs;
 	spin_lock_init(&mfbdev->dirty_lock);
 
+	drm_fb_helper_prepare(mdev->dev, &mfbdev->helper, &mga_fb_helper_funcs);
+
 	ret = drm_fb_helper_init(mdev->dev, &mfbdev->helper,
 				 mdev->num_crtc, MGAG200FB_CONN_LIMIT);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index c229bf6e865e..c7d6e85a7bf0 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -197,7 +197,7 @@ struct drm_fb_helper *msm_fbdev_init(struct drm_device *dev)
 
 	helper = &fbdev->base;
 
-	helper->funcs = &msm_fb_helper_funcs;
+	drm_fb_helper_prepare(dev, helper, &msm_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(dev, helper,
 			priv->num_crtcs, priv->num_connectors);
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 8e9c07b7fc89..afe706a20f97 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -464,7 +464,8 @@ nouveau_fbcon_init(struct drm_device *dev)
 
 	fbcon->dev = dev;
 	drm->fbcon = fbcon;
-	fbcon->helper.funcs = &nouveau_fbcon_helper_funcs;
+
+	drm_fb_helper_prepare(dev, &fbcon->helper, &nouveau_fbcon_helper_funcs);
 
 	ret = drm_fb_helper_init(dev, &fbcon->helper,
 				 dev->mode_config.num_crtc, 4);
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 4cb12083eb12..8436c6857cda 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -325,7 +325,7 @@ struct drm_fb_helper *omap_fbdev_init(struct drm_device *dev)
 
 	helper = &fbdev->base;
 
-	helper->funcs = &omap_fb_helper_funcs;
+	drm_fb_helper_prepare(dev, helper, &omap_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(dev, helper,
 			priv->num_crtcs, priv->num_connectors);
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index cf89614c72be..df567888bb1e 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -676,9 +676,12 @@ int qxl_fbdev_init(struct qxl_device *qdev)
 
 	qfbdev->qdev = qdev;
 	qdev->mode_info.qfbdev = qfbdev;
-	qfbdev->helper.funcs = &qxl_fb_helper_funcs;
 	spin_lock_init(&qfbdev->delayed_ops_lock);
 	INIT_LIST_HEAD(&qfbdev->delayed_ops);
+
+	drm_fb_helper_prepare(qdev->ddev, &qfbdev->helper,
+			      &qxl_fb_helper_funcs);
+
 	ret = drm_fb_helper_init(qdev->ddev, &qfbdev->helper,
 				 qxl_num_crtc /* num_crtc - QXL supports just 1 */,
 				 QXLFB_CONN_LIMIT);
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index ad97afdbc4c7..db598d712901 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -353,7 +353,9 @@ int radeon_fbdev_init(struct radeon_device *rdev)
 
 	rfbdev->rdev = rdev;
 	rdev->mode_info.rfbdev = rfbdev;
-	rfbdev->helper.funcs = &radeon_fb_helper_funcs;
+
+	drm_fb_helper_prepare(rdev->ddev, &rfbdev->helper,
+			      &radeon_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(rdev->ddev, &rfbdev->helper,
 				 rdev->num_crtc,
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index f7cf47bf0afb..d5d53aa79ced 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -276,7 +276,6 @@ static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm,
 					      unsigned int num_crtc,
 					      unsigned int max_connectors)
 {
-	struct drm_fb_helper *helper;
 	struct tegra_fbdev *fbdev;
 	int err;
 
@@ -286,8 +285,7 @@ static struct tegra_fbdev *tegra_fbdev_create(struct drm_device *drm,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	fbdev->base.funcs = &tegra_fb_helper_funcs;
-	helper = &fbdev->base;
+	drm_fb_helper_prepare(drm, &fbdev->base, &tegra_fb_helper_funcs);
 
 	err = drm_fb_helper_init(drm, &fbdev->base, num_crtc, max_connectors);
 	if (err < 0) {
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index 0647c8cc368b..d1da339843ca 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -583,7 +583,8 @@ int udl_fbdev_init(struct drm_device *dev)
 		return -ENOMEM;
 
 	udl->fbdev = ufbdev;
-	ufbdev->helper.funcs = &udl_fb_helper_funcs;
+
+	drm_fb_helper_prepare(dev, &ufbdev->helper, &udl_fb_helper_funcs);
 
 	ret = drm_fb_helper_init(dev, &ufbdev->helper,
 				 1, 1);
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index a47df7ca38e8..1cf587f1f927 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -97,6 +97,8 @@ struct drm_fb_helper {
 	bool delayed_hotplug;
 };
 
+void drm_fb_helper_prepare(struct drm_device *dev, struct drm_fb_helper *helper,
+			   const struct drm_fb_helper_funcs *funcs);
 int drm_fb_helper_init(struct drm_device *dev,
 		       struct drm_fb_helper *helper, int crtc_count,
 		       int max_conn);
-- 
2.0.0
