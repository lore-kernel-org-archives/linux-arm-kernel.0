From: john@metanate.com (John Keeping)
Date: Sat, 21 Jan 2017 16:31:25 +0000
Subject: [PATCH v2 23/26] drm/rockchip: dw-mipi-dsi: defer probe if panel is
 not loaded
In-Reply-To: <20170121163128.22240-1-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
Message-ID: <20170121163128.22240-24-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This ensures that the output resolution is known before fbcon loads.

Signed-off-by: John Keeping <john@metanate.com>
---
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index e448d71be447..2dafb17e31d2 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1173,10 +1173,17 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
-	return mipi_dsi_host_register(&dsi->dsi_host);
+	ret = mipi_dsi_host_register(&dsi->dsi_host);
+	if (!ret && !dsi->panel) {
+		mipi_dsi_host_unregister(&dsi->dsi_host);
+		drm_encoder_cleanup(&dsi->encoder);
+		drm_connector_cleanup(&dsi->connector);
+		ret = -EPROBE_DEFER;
+	}
 
 err_pllref:
-	clk_disable_unprepare(dsi->pllref_clk);
+	if (ret)
+		clk_disable_unprepare(dsi->pllref_clk);
 	return ret;
 }
 
-- 
2.11.0.197.gb556de5.dirty
