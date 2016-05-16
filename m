From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:11 +0200
Subject: [PATCH 11/20] drm/sun4i: Convert to connector register helpers
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-12-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that connector register helpers have been created, switch to them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index af62b24c39b1..257d2b4f3645 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -24,34 +24,6 @@
 #include "sun4i_layer.h"
 #include "sun4i_tcon.h"
 
-static int sun4i_drv_connector_plug_all(struct drm_device *drm)
-{
-	struct drm_connector *connector, *failed;
-	int ret;
-
-	mutex_lock(&drm->mode_config.mutex);
-	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
-		ret = drm_connector_register(connector);
-		if (ret) {
-			failed = connector;
-			goto err;
-		}
-	}
-	mutex_unlock(&drm->mode_config.mutex);
-	return 0;
-
-err:
-	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
-		if (failed == connector)
-			break;
-
-		drm_connector_unregister(connector);
-	}
-	mutex_unlock(&drm->mode_config.mutex);
-
-	return ret;
-}
-
 static int sun4i_drv_enable_vblank(struct drm_device *drm, unsigned int pipe)
 {
 	struct sun4i_drv *drv = drm->dev_private;
@@ -206,7 +178,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (ret)
 		goto free_drm;
 
-	ret = sun4i_drv_connector_plug_all(drm);
+	ret = drm_connector_register_all(drm);
 	if (ret)
 		goto unregister_drm;
 
@@ -223,6 +195,7 @@ static void sun4i_drv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
+	drm_connector_unregister_all(drm);
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	sun4i_framebuffer_free(drm);
-- 
2.8.2
