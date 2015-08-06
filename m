From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  6 Aug 2015 09:07:21 -0500
Subject: [RFC PATCH 2/8] drm: exynos/dp: convert to drm bridge mode
In-Reply-To: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438870041-23130-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to move exynos dp code to bridge directory,
we need to convert driver drm bridge mode first. As
dp driver already have a ptn3460 bridge, so we need
to move ptn bridge to the next bridge of dp bridge.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/exynos/exynos_dp_core.c | 196 ++++++++++++++++++++------------
 drivers/gpu/drm/exynos/exynos_dp_core.h |   2 +
 2 files changed, 126 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index a8097a4..aa99e23 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Samsung Electronics Co., Ltd.
  * Author: Jingoo Han <jg1.han@samsung.com>
+ *         Yakir Yang <ykk@rock-chips.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -998,59 +999,6 @@ static struct drm_connector_helper_funcs exynos_dp_connector_helper_funcs = {
 	.best_encoder = exynos_dp_best_encoder,
 };
 
-/* returns the number of bridges attached */
-static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
-					struct drm_encoder *encoder)
-{
-	int ret;
-
-	encoder->bridge = dp->bridge;
-	dp->bridge->encoder = encoder;
-	ret = drm_bridge_attach(encoder->dev, dp->bridge);
-	if (ret) {
-		DRM_ERROR("Failed to attach bridge to drm\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int exynos_dp_create_connector(struct exynos_drm_display *display,
-				      struct drm_encoder *encoder)
-{
-	struct exynos_dp_device *dp = display_to_dp(display);
-	struct drm_connector *connector = &dp->connector;
-	int ret;
-
-	dp->encoder = encoder;
-
-	/* Pre-empt DP connector creation if there's a bridge */
-	if (dp->bridge) {
-		ret = exynos_drm_attach_lcd_bridge(dp, encoder);
-		if (!ret)
-			return 0;
-	}
-
-	connector->polled = DRM_CONNECTOR_POLL_HPD;
-
-	ret = drm_connector_init(dp->drm_dev, connector,
-				 &exynos_dp_connector_funcs,
-				 DRM_MODE_CONNECTOR_eDP);
-	if (ret) {
-		DRM_ERROR("Failed to initialize connector with drm\n");
-		return ret;
-	}
-
-	drm_connector_helper_add(connector, &exynos_dp_connector_helper_funcs);
-	drm_connector_register(connector);
-	drm_mode_connector_attach_encoder(connector, encoder);
-
-	if (dp->panel)
-		ret = drm_panel_attach(dp->panel, &dp->connector);
-
-	return ret;
-}
-
 static void exynos_dp_phy_init(struct exynos_dp_device *dp)
 {
 	if (dp->phy)
@@ -1115,23 +1063,126 @@ static void exynos_dp_poweroff(struct exynos_dp_device *dp)
 	}
 }
 
-static void exynos_dp_dpms(struct exynos_drm_display *display, int mode)
+/* returns the number of bridges attached */
+static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
+		struct drm_encoder *encoder)
+{
+	int ret;
+
+	dp->bridge->next = dp->ptn_bridge;
+	dp->bridge->encoder = encoder;
+	ret = drm_bridge_attach(encoder->dev, dp->bridge);
+	if (ret) {
+		DRM_ERROR("Failed to attach ptn bridge to drm\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int exynos_dp_bridge_attach(struct drm_bridge *bridge)
+{
+
+	struct exynos_dp_device *dp = bridge->driver_private;
+	struct drm_encoder *encoder = dp->encoder;
+	struct drm_connector *connector = &dp->connector;
+	int ret;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Parent encoder object not found");
+		return -ENODEV;
+	}
+
+	encoder->bridge = bridge;
+
+	/* Pre-empt DP connector creation if there's a bridge */
+	if (dp->ptn_bridge) {
+		ret = exynos_drm_attach_lcd_bridge(dp, encoder);
+		if (ret)
+			return -ENODEV;
+	}
+
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+
+	ret = drm_connector_init(dp->drm_dev, connector,
+			&exynos_dp_connector_funcs, DRM_MODE_CONNECTOR_eDP);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector with drm\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(connector, &exynos_dp_connector_helper_funcs);
+	drm_connector_register(connector);
+	drm_mode_connector_attach_encoder(connector, encoder);
+
+	if (dp->panel)
+		ret = drm_panel_attach(dp->panel, &dp->connector);
+
+	return ret;
+}
+
+static void exynos_dp_bridge_nop(struct drm_bridge *bridge)
+{
+	/* do nothing */
+}
+
+static void exynos_dp_bridge_enable(struct drm_bridge *bridge)
+{
+	struct exynos_dp_device *dp = bridge->driver_private;
+
+	exynos_dp_poweron(dp);
+	dp->dpms_mode = DRM_MODE_DPMS_ON;
+}
+
+static void exynos_dp_bridge_disable(struct drm_bridge *bridge)
+{
+	struct exynos_dp_device *dp = bridge->driver_private;
+
+	exynos_dp_poweroff(dp);
+	dp->dpms_mode = DRM_MODE_DPMS_OFF;
+}
+
+static const struct drm_bridge_funcs exynos_dp_bridge_funcs = {
+	.enable = exynos_dp_bridge_enable,
+	.disable = exynos_dp_bridge_disable,
+	.pre_enable = exynos_dp_bridge_nop,
+	.post_disable = exynos_dp_bridge_nop,
+	.attach = exynos_dp_bridge_attach,
+};
+
+static int exynos_dp_create_connector(struct exynos_drm_display *display,
+				struct drm_encoder *encoder)
 {
 	struct exynos_dp_device *dp = display_to_dp(display);
+	struct drm_device *drm_dev = dp->drm_dev;
+	struct drm_bridge *bridge;
+	int ret;
 
-	switch (mode) {
-	case DRM_MODE_DPMS_ON:
-		exynos_dp_poweron(dp);
-		break;
-	case DRM_MODE_DPMS_STANDBY:
-	case DRM_MODE_DPMS_SUSPEND:
-	case DRM_MODE_DPMS_OFF:
-		exynos_dp_poweroff(dp);
-		break;
-	default:
-		break;
+	bridge = devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
+	if (!bridge) {
+		DRM_ERROR("failed to allocate for drm bridge\n");
+		return -ENOMEM;
 	}
-	dp->dpms_mode = mode;
+
+	dp->bridge = bridge;
+	dp->encoder = encoder;
+
+	bridge->driver_private = dp;
+	bridge->encoder = dp->encoder;
+	bridge->funcs = &exynos_dp_bridge_funcs;
+
+	ret = drm_bridge_attach(drm_dev, bridge);
+	if (ret) {
+		DRM_ERROR("failed to attach drm bridge\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void exynos_dp_dpms(struct exynos_drm_display *display, int mode)
+{
+	/* do nothing */
 }
 
 static struct exynos_drm_display_ops exynos_dp_display_ops = {
@@ -1243,7 +1294,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 		}
 	}
 
-	if (!dp->panel && !dp->bridge) {
+	if (!dp->panel && !dp->ptn_bridge) {
 		ret = exynos_dp_dt_parse_panel(dp);
 		if (ret)
 			return ret;
@@ -1316,7 +1367,7 @@ static void exynos_dp_unbind(struct device *dev, struct device *master,
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
-	exynos_dp_dpms(&dp->display, DRM_MODE_DPMS_OFF);
+	exynos_dp_bridge_disable(dp->bridge);
 }
 
 static const struct component_ops exynos_dp_ops = {
@@ -1351,9 +1402,9 @@ static int exynos_dp_probe(struct platform_device *pdev)
 	if (endpoint) {
 		bridge_node = of_graph_get_remote_port_parent(endpoint);
 		if (bridge_node) {
-			dp->bridge = of_drm_find_bridge(bridge_node);
+			dp->ptn_bridge = of_drm_find_bridge(bridge_node);
 			of_node_put(bridge_node);
-			if (!dp->bridge)
+			if (!dp->ptn_bridge)
 				return -EPROBE_DEFER;
 		} else {
 			return -EPROBE_DEFER;
@@ -1375,7 +1426,7 @@ static int exynos_dp_suspend(struct device *dev)
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
-	exynos_dp_dpms(&dp->display, DRM_MODE_DPMS_OFF);
+	exynos_dp_bridge_disable(dp->bridge);
 	return 0;
 }
 
@@ -1383,7 +1434,7 @@ static int exynos_dp_resume(struct device *dev)
 {
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
-	exynos_dp_dpms(&dp->display, DRM_MODE_DPMS_ON);
+	exynos_dp_bridge_enable(dp->bridge);
 	return 0;
 }
 #endif
@@ -1410,5 +1461,6 @@ struct platform_driver dp_driver = {
 };
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
 MODULE_DESCRIPTION("Samsung SoC DP Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.h b/drivers/gpu/drm/exynos/exynos_dp_core.h
index c321ad5..f2584b8 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.h
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.h
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2012 Samsung Electronics Co., Ltd.
  * Author: Jingoo Han <jg1.han@samsung.com>
+ *         Yakir Yang <ykk@rock-chips.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -154,6 +155,7 @@ struct exynos_dp_device {
 	struct drm_encoder	*encoder;
 	struct drm_panel	*panel;
 	struct drm_bridge	*bridge;
+	struct drm_bridge	*ptn_bridge;
 	struct clk		*clock;
 	unsigned int		irq;
 	void __iomem		*reg_base;
-- 
2.1.2
