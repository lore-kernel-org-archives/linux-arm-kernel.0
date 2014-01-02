From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:25:56 +0000
Subject: [PATCH RFC 02/46] imx-drm: imx-drm-core: avoid going the long route
 round for drm_device
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1Vypm8-0007Dd-10@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the drm_device available, so rather than storing it and then
using the stored version, us the one we already have available to us.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-drm-core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 9aa5eaab6539..242e8db218ac 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -88,9 +88,9 @@ static int imx_drm_driver_unload(struct drm_device *drm)
 
 	imx_drm_device_put();
 
-	drm_vblank_cleanup(imxdrm->drm);
-	drm_kms_helper_poll_fini(imxdrm->drm);
-	drm_mode_config_cleanup(imxdrm->drm);
+	drm_vblank_cleanup(drm);
+	drm_kms_helper_poll_fini(drm);
+	drm_mode_config_cleanup(drm);
 
 	return 0;
 }
@@ -424,15 +424,15 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 
 	mutex_lock(&imxdrm->mutex);
 
-	drm_kms_helper_poll_init(imxdrm->drm);
+	drm_kms_helper_poll_init(drm);
 
 	/* setup the grouping for the legacy output */
-	ret = drm_mode_group_init_legacy_group(imxdrm->drm,
-			&imxdrm->drm->primary->mode_group);
+	ret = drm_mode_group_init_legacy_group(drm,
+			&drm->primary->mode_group);
 	if (ret)
 		goto err_kms;
 
-	ret = drm_vblank_init(imxdrm->drm, MAX_CRTC);
+	ret = drm_vblank_init(drm, MAX_CRTC);
 	if (ret)
 		goto err_kms;
 
@@ -441,7 +441,7 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
 	 * by drm timer once a current process gives up ownership of
 	 * vblank event.(after drm_vblank_put function is called)
 	 */
-	imxdrm->drm->vblank_disable_allowed = true;
+	drm->vblank_disable_allowed = true;
 
 	if (!imx_drm_device_get()) {
 		ret = -EINVAL;
-- 
1.7.4.4
