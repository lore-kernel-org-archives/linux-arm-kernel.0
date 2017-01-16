From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 16 Jan 2017 18:08:27 +0800
Subject: [PATCH v2 07/11] drm/rockchip/dsi: fix mipi display can't found at
 init time
In-Reply-To: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1484561311-494-8-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Yao <mark.yao@rock-chips.com>

The problem is that:
  mipi panel probe request mipi_dsi_host_register.
  mipi host attach is call from panel device, so the defer function
always can't works.

So at the first bind time, always can't found mipi panel.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 57 +++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 5e3f031..4ec82f6 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -551,11 +551,9 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 	dsi->panel = of_drm_find_panel(device->dev.of_node);
 	if (!dsi->panel) {
 		DRM_ERROR("failed to find panel\n");
-		return -EPROBE_DEFER;
+		return -ENODEV;
 	}
 
-	drm_panel_attach(dsi->panel, &dsi->connector);
-
 	return 0;
 }
 
@@ -567,6 +565,7 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 	if (dsi->panel)
 		drm_panel_detach(dsi->panel);
 
+	dsi->panel = NULL;
 	return 0;
 }
 
@@ -1048,6 +1047,8 @@ static int dw_mipi_dsi_register(struct drm_device *drm,
 			   &dw_mipi_dsi_atomic_connector_funcs,
 			   DRM_MODE_CONNECTOR_DSI);
 
+	drm_panel_attach(dsi->panel, &dsi->connector);
+
 	drm_mode_connector_attach_encoder(connector, encoder);
 
 	return 0;
@@ -1097,23 +1098,17 @@ MODULE_DEVICE_TABLE(of, dw_mipi_dsi_dt_ids);
 static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 			    void *data)
 {
-	const struct of_device_id *of_id =
-			of_match_device(dw_mipi_dsi_dt_ids, dev);
-	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
-	struct dw_mipi_dsi *dsi;
+	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 	struct resource *res;
 	int ret;
 
-	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
-	if (!dsi)
-		return -ENOMEM;
-
-	dsi->dev = dev;
-	dsi->pdata = pdata;
 	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
 
+	if (!dsi->panel)
+		return -EPROBE_DEFER;
+
 	ret = rockchip_mipi_parse_dt(dsi);
 	if (ret)
 		return ret;
@@ -1160,9 +1155,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	pm_runtime_enable(dev);
 
-	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
-	dsi->dsi_host.dev = dev;
-	return mipi_dsi_host_register(&dsi->dsi_host);
+	return 0;
 
 err_pllref:
 	clk_disable_unprepare(dsi->pllref_clk);
@@ -1174,7 +1167,6 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 {
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
-	mipi_dsi_host_unregister(&dsi->dsi_host);
 	pm_runtime_disable(dev);
 	clk_disable_unprepare(dsi->pllref_clk);
 }
@@ -1186,11 +1178,40 @@ static const struct component_ops dw_mipi_dsi_ops = {
 
 static int dw_mipi_dsi_probe(struct platform_device *pdev)
 {
-	return component_add(&pdev->dev, &dw_mipi_dsi_ops);
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id =
+			of_match_device(dw_mipi_dsi_dt_ids, dev);
+	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
+	struct dw_mipi_dsi *dsi;
+	int ret;
+
+	dsi = devm_kzalloc(&pdev->dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi)
+		return -ENOMEM;
+
+	dsi->dev = dev;
+	dsi->pdata = pdata;
+	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
+	dsi->dsi_host.dev = &pdev->dev;
+
+	ret = mipi_dsi_host_register(&dsi->dsi_host);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, dsi);
+	ret = component_add(&pdev->dev, &dw_mipi_dsi_ops);
+	if (ret)
+		mipi_dsi_host_unregister(&dsi->dsi_host);
+
+	return ret;
 }
 
 static int dw_mipi_dsi_remove(struct platform_device *pdev)
 {
+	struct dw_mipi_dsi *dsi = dev_get_drvdata(&pdev->dev);
+
+	if (dsi)
+		mipi_dsi_host_unregister(&dsi->dsi_host);
 	component_del(&pdev->dev, &dw_mipi_dsi_ops);
 	return 0;
 }
-- 
2.6.3
