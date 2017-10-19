From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 19 Oct 2017 11:48:08 +0800
Subject: [PATCH v6 06/10] drm/rockchip: dw-mipi-dsi: Fix error handling path
In-Reply-To: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
Message-ID: <20171019034812.13768-7-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing pm_runtime_disable() in bind()'s error handling path.

Also cleanup encoder & connector in unbind().

Fixes: 80a9a059d4e4 ("drm/rockchip/dsi: add dw-mipi power domain support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5:
Call the destroy hook in the error handling path like in unbind().

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index b15755b6129c..e72d4e2b61aa 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1282,7 +1282,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 	ret = dw_mipi_dsi_register(drm, dsi);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to register mipi_dsi: %d\n", ret);
-		goto err_pllref;
+		goto err_disable_pllref;
 	}
 
 	pm_runtime_enable(dev);
@@ -1292,23 +1292,24 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to register MIPI host: %d\n", ret);
-		goto err_cleanup;
+		goto err_disable_pm_runtime;
 	}
 
 	if (!dsi->panel) {
 		ret = -EPROBE_DEFER;
-		goto err_mipi_dsi_host;
+		goto err_unreg_mipi_dsi_host;
 	}
 
 	dev_set_drvdata(dev, dsi);
 	return 0;
 
-err_mipi_dsi_host:
+err_unreg_mipi_dsi_host:
 	mipi_dsi_host_unregister(&dsi->dsi_host);
-err_cleanup:
-	drm_encoder_cleanup(&dsi->encoder);
-	drm_connector_cleanup(&dsi->connector);
-err_pllref:
+err_disable_pm_runtime:
+	pm_runtime_disable(dev);
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
+err_disable_pllref:
 	clk_disable_unprepare(dsi->pllref_clk);
 	return ret;
 }
@@ -1320,6 +1321,10 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 	pm_runtime_disable(dev);
+
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
+
 	clk_disable_unprepare(dsi->pllref_clk);
 }
 
-- 
2.11.0
