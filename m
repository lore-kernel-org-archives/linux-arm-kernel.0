From: m.purski@samsung.com (Maciej Purski)
Date: Wed, 30 May 2018 14:15:54 +0200
Subject: [PATCH v2 03/10] drm/exynos: move connector creation to attach
 callback
In-Reply-To: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121624eucas1p2678b6a5424cb8df286b6142cd3754b65@eucas1p2.samsung.com>
Message-ID: <1527682561-1386-4-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation assumes that the only possible peripheral
device for DSIM is a panel. Using an output bridge should also be
possible.

If an output bridge in available, don't create a new connector.
Instead add bridge to DSIM encdoer in dsi_host_attach().

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 35 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 85eb2262..7b50bad 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1501,7 +1501,28 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 				  struct mipi_dsi_device *device)
 {
 	struct exynos_dsi *dsi = host_to_dsi(host);
-	struct drm_device *drm = dsi->connector.dev;
+	struct drm_encoder *encoder = &dsi->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct drm_bridge *out_bridge;
+
+	out_bridge  = of_drm_find_bridge(device->dev.of_node);
+	if (out_bridge) {
+		drm_bridge_attach(encoder, out_bridge, NULL);
+	} else {
+		int ret = exynos_dsi_create_connector(encoder);
+
+		if (ret) {
+			DRM_ERROR("failed to create connector ret = %d\n", ret);
+			drm_encoder_cleanup(encoder);
+			return ret;
+		}
+
+		dsi->panel = of_drm_find_panel(device->dev.of_node);
+		if (dsi->panel) {
+			drm_panel_attach(dsi->panel, &dsi->connector);
+			dsi->connector.status = connector_status_connected;
+		}
+	}
 
 	/*
 	 * This is a temporary solution and should be made by more generic way.
@@ -1520,11 +1541,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->lanes = device->lanes;
 	dsi->format = device->format;
 	dsi->mode_flags = device->mode_flags;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (dsi->panel) {
-		drm_panel_attach(dsi->panel, &dsi->connector);
-		dsi->connector.status = connector_status_connected;
-	}
 	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
 			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
 
@@ -1653,13 +1669,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
 	if (ret < 0)
 		return ret;
 
-	ret = exynos_dsi_create_connector(encoder);
-	if (ret) {
-		DRM_ERROR("failed to create connector ret = %d\n", ret);
-		drm_encoder_cleanup(encoder);
-		return ret;
-	}
-
 	if (dsi->mic_bridge_node) {
 		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
 		if (mic_bridge)
-- 
2.7.4
