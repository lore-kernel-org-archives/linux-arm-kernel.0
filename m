From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Wed, 1 Aug 2018 02:04:30 +0530
Subject: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
Message-ID: <20180731203430.GA30136@jordon-HP-15-Notebook-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

convert drm_atomic_helper_suspend/resume() to use
drm_mode_config_helper_suspend/resume().

With this conversion, rockchip_drm_fb_resume() and
rockchip_drm_fb_suspend() will not be used anymore.
Both of these functions can be removed.

Also, in struct rockchip_drm_private state will not be
used anymore. So this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 46 ++---------------------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 -
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f814d37..dd12390 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -243,60 +243,18 @@ static void rockchip_drm_unbind(struct device *dev)
 };
 
 #ifdef CONFIG_PM_SLEEP
-static void rockchip_drm_fb_suspend(struct drm_device *drm)
-{
-	struct rockchip_drm_private *priv = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 1);
-	console_unlock();
-}
-
-static void rockchip_drm_fb_resume(struct drm_device *drm)
-{
-	struct rockchip_drm_private *priv = drm->dev_private;
-
-	console_lock();
-	drm_fb_helper_set_suspend(&priv->fbdev_helper, 0);
-	console_unlock();
-}
-
 static int rockchip_drm_sys_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv;
-
-	if (!drm)
-		return 0;
-
-	drm_kms_helper_poll_disable(drm);
-	rockchip_drm_fb_suspend(drm);
 
-	priv = drm->dev_private;
-	priv->state = drm_atomic_helper_suspend(drm);
-	if (IS_ERR(priv->state)) {
-		rockchip_drm_fb_resume(drm);
-		drm_kms_helper_poll_enable(drm);
-		return PTR_ERR(priv->state);
-	}
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm);
 }
 
 static int rockchip_drm_sys_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv;
 
-	if (!drm)
-		return 0;
-
-	priv = drm->dev_private;
-	drm_atomic_helper_resume(drm, priv->state);
-	rockchip_drm_fb_resume(drm);
-	drm_kms_helper_poll_enable(drm);
-
-	return 0;
+	return drm_mode_config_helper_resume(drm);
 }
 #endif
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3a6ebfc..d67ad0a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -51,7 +51,6 @@ struct rockchip_crtc_state {
 struct rockchip_drm_private {
 	struct drm_fb_helper fbdev_helper;
 	struct drm_gem_object *fbdev_bo;
-	struct drm_atomic_state *state;
 	struct iommu_domain *domain;
 	struct mutex mm_lock;
 	struct drm_mm mm;
-- 
1.9.1
