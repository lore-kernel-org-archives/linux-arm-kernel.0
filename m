From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:04 +0000
Subject: [PATCH v4 21/23] drm/rockchip: dw-mipi-dsi: defer probe if panel is
 not loaded
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-22-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ensures that the output resolution is known before fbcon loads.
mipi_dsi_host_register() is moved above dw_mipi_dsi_register() to
simplify error cleanup since the order of these operations does not
matter.

Signed-off-by: John Keeping <john@metanate.com>
---
v4:
- Use "return 0" to separate normal code flow from error cleanup
Unchanged in v3
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 60dfb5666a25..9edb868f8dc1 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1189,12 +1189,27 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		goto err_pllref;
 	}
 
-	dev_set_drvdata(dev, dsi);
-
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
-	return mipi_dsi_host_register(&dsi->dsi_host);
+	ret = mipi_dsi_host_register(&dsi->dsi_host);
+	if (ret) {
+		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
+		goto err_cleanup;
+	}
+
+	if (!dsi->panel) {
+		ret = -EPROBE_DEFER;
+		goto err_mipi_dsi_host;
+	}
 
+	dev_set_drvdata(dev, dsi);
+	return 0;
+
+err_mipi_dsi_host:
+	mipi_dsi_host_unregister(&dsi->dsi_host);
+err_cleanup:
+	drm_encoder_cleanup(&dsi->encoder);
+	drm_connector_cleanup(&dsi->connector);
 err_pllref:
 	clk_disable_unprepare(dsi->pllref_clk);
 	return ret;
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
