From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 27 Sep 2018 17:18:42 +0530
Subject: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable missing DSI bus clock
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
Message-ID: <20180927114850.24565-5-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DSI bus_clk is already available in sun6i_dsi but missed to
get the clk and process for enable/disable.

This patch add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8e9c76febca2..156b371243c6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
+	dsi->bus_clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(dsi->bus_clk)) {
+		dev_err(dev, "Couldn't get the DSI bus clock\n");
+		return PTR_ERR(dsi->bus_clk);
+	}
+
 	if (dsi->variant->has_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
@@ -1012,6 +1018,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		}
 	}
 
+	clk_prepare_enable(dsi->bus_clk);
 	/*
 	 * In order to operate properly, that clock seems to be always
 	 * set to 297MHz.
@@ -1065,6 +1072,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	sun6i_dphy_remove(dsi);
 	if (dsi->variant->has_mod_clk)
 		clk_rate_exclusive_put(dsi->mod_clk);
+	clk_disable_unprepare(dsi->bus_clk);
 
 	return 0;
 }
-- 
2.18.0.321.gffc6fa0e3
