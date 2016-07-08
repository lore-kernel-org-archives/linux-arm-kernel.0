From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:59 +0800
Subject: [PATCH 5/7] drm/rockchip: dw-mipi: support HPD poll
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-6-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the first time of bind, there is no any panel attach in mipi. Add a
DRM_CONNECTOR_POLL_HPD porperty to detect the panel status, when panel
probe, the dw_mipi_dsi_host_attach would be called, then mipi-dsi will
trigger a event to notify the drm framework.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 41 ++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 15ba796..72d7f48 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -285,6 +285,7 @@ struct dw_mipi_dsi {
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 	struct mipi_dsi_host dsi_host;
+	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct device *dev;
 	struct regmap *grf_regmap;
@@ -462,7 +463,6 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
 	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
 				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
 
-
 	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
 				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
 	if (ret < 0) {
@@ -550,11 +550,11 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->lanes = device->lanes;
 	dsi->channel = device->channel;
 	dsi->format = device->format;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (dsi->panel)
-		return drm_panel_attach(dsi->panel, &dsi->connector);
+	dsi->panel_node = device->dev.of_node;
+	if (dsi->connector.dev)
+		drm_helper_hpd_irq_event(dsi->connector.dev);
 
-	return -EINVAL;
+	return 0;
 }
 
 static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
@@ -562,7 +562,10 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 
-	drm_panel_detach(dsi->panel);
+	dsi->panel_node = NULL;
+
+	if (dsi->connector.dev)
+		drm_helper_hpd_irq_event(dsi->connector.dev);
 
 	return 0;
 }
@@ -1022,13 +1025,33 @@ static struct drm_connector_helper_funcs dw_mipi_dsi_connector_helper_funcs = {
 static enum drm_connector_status
 dw_mipi_dsi_detect(struct drm_connector *connector, bool force)
 {
-	return connector_status_connected;
+	struct dw_mipi_dsi *dsi = con_to_dsi(connector);
+
+
+	if (!dsi->panel) {
+		dsi->panel = of_drm_find_panel(dsi->panel_node);
+		if (dsi->panel)
+			drm_panel_attach(dsi->panel, &dsi->connector);
+	} else if (!dsi->panel_node) {
+		struct drm_encoder *encoder;
+
+		encoder = platform_get_drvdata(to_platform_device(dsi->dev));
+		dw_mipi_dsi_encoder_disable(encoder);
+		drm_panel_detach(dsi->panel);
+		dsi->panel = NULL;
+	}
+
+	if (dsi->panel)
+		return connector_status_connected;
+
+	return connector_status_disconnected;
 }
 
 static void dw_mipi_dsi_drm_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
+	connector->dev = NULL;
 }
 
 static struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
@@ -1069,6 +1092,8 @@ static int dw_mipi_dsi_register(struct drm_device *drm,
 		return ret;
 	}
 
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+
 	drm_connector_helper_add(connector,
 			&dw_mipi_dsi_connector_helper_funcs);
 
@@ -1225,6 +1250,8 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 {
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
+	dw_mipi_dsi_encoder_disable(&dsi->encoder);
+
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 	pm_runtime_disable(dev);
 	clk_disable_unprepare(dsi->pllref_clk);
-- 
2.6.3
