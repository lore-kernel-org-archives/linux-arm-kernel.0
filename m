From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:35 +0530
Subject: [PATCH v3 16/25] drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI
 voltage regulator
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
Message-ID: <20181026144344.27778-17-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have VCC-DSI pin connected to voltage regulator which may
not be turned on by default.

Add support for such boards by adding voltage regulator handling code to
MIPI DSI driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- new patch
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 42bd7506abaf..bc57343592e0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -949,6 +949,12 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->drv = drv;
 
+	ret = regulator_enable(dsi->regulator);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator\n");
+		return ret;
+	}
+
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
@@ -980,6 +986,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 err_cleanup_connector:
 	drm_encoder_cleanup(&dsi->encoder);
+	regulator_disable(dsi->regulator);
 	return ret;
 }
 
@@ -989,6 +996,7 @@ static void sun6i_dsi_unbind(struct device *dev, struct device *master,
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
 	drm_panel_detach(dsi->panel);
+	regulator_disable(dsi->regulator);
 }
 
 static const struct component_ops sun6i_dsi_ops = {
@@ -1022,6 +1030,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
+	if (IS_ERR(dsi->regulator)) {
+		dev_err(dev, "Couldn't get regulator\n");
+		return PTR_ERR(dsi->regulator);
+	}
+
 	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 597b62227019..0df60f84bab3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/regulator/consumer.h>
+
 struct sun6i_dphy {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
@@ -32,6 +34,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct sun6i_dphy	*dphy;
 
-- 
2.18.0.321.gffc6fa0e3
