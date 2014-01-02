From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:29:05 +0000
Subject: [PATCH RFC 39/46] imx-drm: imx-drm-core: kill off mutex
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VyppB-0007G7-6I@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mutex doesn't protect anything anymore; get rid of it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 10cfea0e948a..0172739a00fe 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -40,14 +40,12 @@ struct imx_drm_device {
 	struct drm_device			*drm;
 	struct device				*dev;
 	struct imx_drm_crtc			*crtc[MAX_CRTC];
-	struct mutex				mutex;
 	int					pipes;
 	struct drm_fbdev_cma			*fbhelper;
 };
 
 struct imx_drm_crtc {
 	struct drm_crtc				*crtc;
-	struct imx_drm_device			*imxdrm;
 	int					pipe;
 	struct imx_drm_crtc_helper_funcs	imx_drm_helper_funcs;
 	struct crtc_cookie			cookie;
@@ -270,8 +268,6 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 
 	drm_mode_config_init(drm);
 
-	mutex_lock(&imxdrm->mutex);
-
 	drm_kms_helper_poll_init(drm);
 
 	ret = drm_vblank_init(drm, MAX_CRTC);
@@ -285,12 +281,10 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 	 */
 	drm->vblank_disable_allowed = true;
 
-	mutex_unlock(&imxdrm->mutex);
-
 	/* Now try and bind all our sub-components */
 	ret = component_bind_all(drm->dev, drm);
 	if (ret)
-		goto err_relock;
+		goto err_vblank;
 
 	/*
 	 * All components are now added, we can publish the connector sysfs
@@ -330,13 +324,11 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 
 err_unbind:
 	component_unbind_all(drm->dev, drm);
-err_relock:
-	mutex_lock(&imxdrm->mutex);
+err_vblank:
 	drm_vblank_cleanup(drm);
 err_kms:
 	drm_kms_helper_poll_fini(drm);
 	drm_mode_config_cleanup(drm);
-	mutex_unlock(&imxdrm->mutex);
 
 	return ret;
 }
@@ -356,8 +348,6 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	struct imx_drm_crtc *imx_drm_crtc;
 	int ret;
 
-	mutex_lock(&imxdrm->mutex);
-
 	/*
 	 * The vblank arrays are dimensioned by MAX_CRTC - we can't
 	 * pass IDs greater than this to those functions.
@@ -384,7 +374,6 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	imx_drm_crtc->cookie.id = id;
 	imx_drm_crtc->mux_id = imx_drm_crtc->pipe;
 	imx_drm_crtc->crtc = crtc;
-	imx_drm_crtc->imxdrm = imxdrm;
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = imx_drm_crtc;
 
@@ -400,8 +389,6 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	drm_crtc_init(drm, crtc,
 			imx_drm_crtc->imx_drm_helper_funcs.crtc_funcs);
 
-	mutex_unlock(&imxdrm->mutex);
-
 	return 0;
 
 err_register:
@@ -409,7 +396,6 @@ int imx_drm_add_crtc(struct drm_device *drm, struct drm_crtc *crtc,
 	kfree(imx_drm_crtc);
 err_alloc:
 err_busy:
-	mutex_unlock(&imxdrm->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(imx_drm_add_crtc);
@@ -419,16 +405,12 @@ EXPORT_SYMBOL_GPL(imx_drm_add_crtc);
  */
 int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 {
-	struct imx_drm_device *imxdrm = imx_drm_crtc->imxdrm;
-
-	mutex_lock(&imxdrm->mutex);
+	struct imx_drm_device *imxdrm = imx_drm_crtc->crtc->dev->dev_private;
 
 	drm_crtc_cleanup(imx_drm_crtc->crtc);
 
 	imxdrm->crtc[imx_drm_crtc->pipe] = NULL;
 
-	mutex_unlock(&imxdrm->mutex);
-
 	kfree(imx_drm_crtc);
 
 	return 0;
@@ -655,8 +637,6 @@ static int __init imx_drm_init(void)
 	if (!imx_drm_device)
 		return -ENOMEM;
 
-	mutex_init(&imx_drm_device->mutex);
-
 	ret = platform_driver_register(&imx_drm_pdrv);
 	if (ret)
 		goto err_pdrv;
-- 
1.7.4.4
