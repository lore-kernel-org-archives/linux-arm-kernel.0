From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  2 Mar 2018 18:57:53 +0100
Subject: [PATCH v9 1/5] drm/rockchip: dw-mipi-dsi: Fix connector and encoder
 cleanup.
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Message-ID: <20180302175757.28192-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

In bind()'s error handling path call destroy functions instead of
cleanup functions for encoder and connector and reorder to match how is
called in bind().

In unbind() call the connector and encoder destroy functions.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Removed the pm_runtime_disable call as is not really needed.

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 591953cbdd18..d53d5a09547f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1302,8 +1302,8 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 err_mipi_dsi_host:
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 err_cleanup:
-	drm_encoder_cleanup(&dsi->encoder);
-	drm_connector_cleanup(&dsi->connector);
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
 err_pllref:
 	clk_disable_unprepare(dsi->pllref_clk);
 	return ret;
@@ -1316,6 +1316,10 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 	pm_runtime_disable(dev);
+
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
+
 	clk_disable_unprepare(dsi->pllref_clk);
 }
 
-- 
2.16.1
