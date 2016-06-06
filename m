From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  6 Jun 2016 16:53:32 +0200
Subject: [PATCH 1/2] drm/rockchip: Use atomic PM helpers
Message-ID: <1465224813-7359-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver was still using the old legacy helpers and that caused a few
NULL dereferences when trying to call empty callbacks.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Caesar Wang <wxt@rock-chips.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Yakir Yang <ykk@rock-chips.com>

---

Hi,

these two patches apply on top of Daniel Vetter's series that add async
support to the atomic commit helpers.

Thanks,

Tomeu
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 84 +++++++++++------------------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 2 files changed, 32 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 2251121343e6..36c8b58ca45f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/component.h>
+#include <linux/console.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
@@ -308,25 +309,38 @@ static struct drm_driver rockchip_drm_driver = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-static int rockchip_drm_sys_suspend(struct device *dev)
+void rockchip_drm_fb_suspend(struct drm_device *drm)
 {
-	struct drm_device *drm = dev_get_drvdata(dev);
-	struct drm_connector *connector;
+	struct rockchip_drm_private *priv = drm->dev_private;
 
-	if (!drm)
-		return 0;
+	console_lock();
+	drm_fb_helper_set_suspend(&priv->fbdev_helper, 1);
+	console_unlock();
+}
 
-	drm_modeset_lock_all(drm);
-	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
-		int old_dpms = connector->dpms;
+void rockchip_drm_fb_resume(struct drm_device *drm)
+{
+	struct rockchip_drm_private *priv = drm->dev_private;
 
-		if (connector->funcs->dpms)
-			connector->funcs->dpms(connector, DRM_MODE_DPMS_OFF);
+	console_lock();
+	drm_fb_helper_set_suspend(&priv->fbdev_helper, 0);
+	console_unlock();
+}
 
-		/* Set the old mode back to the connector for resume */
-		connector->dpms = old_dpms;
+static int rockchip_drm_sys_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct rockchip_drm_private *priv = drm->dev_private;
+
+	drm_kms_helper_poll_disable(drm);
+	rockchip_drm_fb_suspend(drm);
+
+	priv->state = drm_atomic_helper_suspend(drm);
+	if (IS_ERR(priv->state)) {
+		rockchip_drm_fb_resume(drm);
+		drm_kms_helper_poll_enable(drm);
+		return PTR_ERR(priv->state);
 	}
-	drm_modeset_unlock_all(drm);
 
 	return 0;
 }
@@ -334,47 +348,11 @@ static int rockchip_drm_sys_suspend(struct device *dev)
 static int rockchip_drm_sys_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct drm_connector *connector;
-	enum drm_connector_status status;
-	bool changed = false;
-
-	if (!drm)
-		return 0;
-
-	drm_modeset_lock_all(drm);
-	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
-		int desired_mode = connector->dpms;
-
-		/*
-		 * at suspend time, we save dpms to connector->dpms,
-		 * restore the old_dpms, and at current time, the connector
-		 * dpms status must be DRM_MODE_DPMS_OFF.
-		 */
-		connector->dpms = DRM_MODE_DPMS_OFF;
-
-		/*
-		 * If the connector has been disconnected during suspend,
-		 * disconnect it from the encoder and leave it off. We'll notify
-		 * userspace at the end.
-		 */
-		if (desired_mode == DRM_MODE_DPMS_ON) {
-			status = connector->funcs->detect(connector, true);
-			if (status == connector_status_disconnected) {
-				connector->encoder = NULL;
-				connector->status = status;
-				changed = true;
-				continue;
-			}
-		}
-		if (connector->funcs->dpms)
-			connector->funcs->dpms(connector, desired_mode);
-	}
-	drm_modeset_unlock_all(drm);
-
-	drm_helper_resume_force_mode(drm);
+	struct rockchip_drm_private *priv = drm->dev_private;
 
-	if (changed)
-		drm_kms_helper_hotplug_event(drm);
+	drm_atomic_helper_resume(drm, priv->state);
+	rockchip_drm_fb_resume(drm);
+	drm_kms_helper_poll_enable(drm);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 005634484441..ea3932940061 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -60,6 +60,7 @@ struct rockchip_drm_private {
 	struct drm_fb_helper fbdev_helper;
 	struct drm_gem_object *fbdev_bo;
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
+	struct drm_atomic_state *state;
 };
 
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
-- 
2.5.5
