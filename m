From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 10 Dec 2015 16:50:08 +0800
Subject: [PATCH v10.1 15/19] drm: bridge: analogix/dp: move hpd detect to
 connector detect function
In-Reply-To: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
References: <1449470239-30667-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1449737408-12920-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change just make a little clean to make code more like
drm core expect, move hdp detect code from bridge->enable(),
and place them into connector->detect().

Note: Gustavo Padovan try to remove the controller and phy
power on function in bind time at bellow commit:
	drm/exynos: do not start enabling DP at bind() phase

But for now the connector status don't hardcode to connected,
need to operate dp phy in .detect function, so we need to revert
parts if Gustavo Padovan's changes, add phy poweron
function in bind time.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
Changes in v10.1:
- Move the panel prepare from get_modes time to bind time, and move
  the panel unprepare from bridge->disable to unbind time. (Heiko)

Changes in v10:
- Revert parts of Gustavo Padovan's changes in commit:
	drm/exynos: do not start enabling DP at bind() phase
  Add dp phy poweron function in bind time.

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Take Jingoo suggest, add commit messages.

Changes in v3:
- move dp hpd detect to connector detect function.

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 38 ++++++++++++----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 00aee44..6a13167 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -901,12 +901,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 			DRM_ERROR("failed to disable the panel\n");
 	}
 
-	ret = analogix_dp_detect_hpd(dp);
-	if (ret) {
-		/* Cable has been disconnected, we're done */
-		return;
-	}
-
 	ret = analogix_dp_handle_edid(dp);
 	if (ret) {
 		dev_err(dp->dev, "unable to handle edid\n");
@@ -941,6 +935,11 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 
 enum drm_connector_status analogix_dp_detect(struct device *dev, bool force)
 {
+	struct analogix_dp_device *dp = dev_get_drvdata(dev);
+
+	if (analogix_dp_detect_hpd(dp))
+		return connector_status_disconnected;
+
 	return connector_status_connected;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_detect);
@@ -1006,13 +1005,6 @@ static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
 
 	pm_runtime_get_sync(dp->dev);
 
-	if (dp->plat_data->panel) {
-		if (drm_panel_prepare(dp->plat_data->panel)) {
-			DRM_ERROR("failed to setup the panel\n");
-			return;
-		}
-	}
-
 	if (dp->plat_data->power_on)
 		dp->plat_data->power_on(dp->plat_data);
 
@@ -1045,11 +1037,6 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
 
-	if (dp->plat_data->panel) {
-		if (drm_panel_unprepare(dp->plat_data->panel))
-			DRM_ERROR("failed to turnoff the panel\n");
-	}
-
 	pm_runtime_put_sync(dp->dev);
 
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
@@ -1307,6 +1294,15 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	pm_runtime_enable(dev);
 
+	phy_power_on(dp->phy);
+
+	if (dp->plat_data->panel) {
+		if (drm_panel_prepare(dp->plat_data->panel)) {
+			DRM_ERROR("failed to setup the panel\n");
+			return -EBUSY;
+		}
+	}
+
 	ret = devm_request_irq(&pdev->dev, dp->irq, analogix_dp_irq_handler,
 			       irq_flags, "analogix-dp", dp);
 	if (ret) {
@@ -1340,6 +1336,12 @@ void analogix_dp_unbind(struct device *dev, struct device *master,
 	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 
 	analogix_dp_bridge_disable(dp->bridge);
+
+	if (dp->plat_data->panel) {
+		if (drm_panel_unprepare(dp->plat_data->panel))
+			DRM_ERROR("failed to turnoff the panel\n");
+	}
+
 	pm_runtime_disable(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
1.9.1
