From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 24 Jan 2017 10:38:06 +0800
Subject: [PATCH v4 6/6] drm/rockchip/dsi: add dw-mipi power domain support
In-Reply-To: <1485225486-669-1-git-send-email-zyw@rock-chips.com>
References: <1485225486-669-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1485225486-669-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference the power domain incase dw-mipi power down when
in use.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 6f0e252..1462101e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -12,6 +12,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/mfd/syscon.h>
@@ -293,6 +294,7 @@ struct dw_mipi_dsi {
 	struct clk *pclk;
 	struct clk *phy_cfg_clk;
 
+	int dpms_mode;
 	unsigned int lane_mbps; /* per lane */
 	u32 channel;
 	u32 lanes;
@@ -969,6 +971,9 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 
+	if (dsi->dpms_mode != DRM_MODE_DPMS_ON)
+		return;
+
 	if (clk_prepare_enable(dsi->pclk)) {
 		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
 		return;
@@ -980,7 +985,9 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(dsi->panel);
 
 	dw_mipi_dsi_disable(dsi);
+	pm_runtime_put(dsi->dev);
 	clk_disable_unprepare(dsi->pclk);
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
 static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
@@ -990,11 +997,15 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
 	u32 val;
 
+	if (dsi->dpms_mode == DRM_MODE_DPMS_ON)
+		return;
+
 	if (clk_prepare_enable(dsi->pclk)) {
 		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
 		return;
 	}
 
+	pm_runtime_get_sync(dsi->dev);
 	dw_mipi_dsi_init(dsi);
 	dw_mipi_dsi_dpi_config(dsi);
 	dw_mipi_dsi_packet_handler_config(dsi);
@@ -1030,6 +1041,7 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 
 	regmap_write(dsi->grf_regmap, pdata->grf_switch_reg, val);
 	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
+	dsi->dpms_mode = DRM_MODE_DPMS_ON;
 }
 
 static int
@@ -1198,6 +1210,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->dev = dev;
 	dsi->pdata = pdata;
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
 
 	ret = rockchip_mipi_parse_dt(dsi);
 	if (ret)
@@ -1271,6 +1284,8 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	dev_set_drvdata(dev, dsi);
 
+	pm_runtime_enable(dev);
+
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
@@ -1293,6 +1308,7 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
 	mipi_dsi_host_unregister(&dsi->dsi_host);
+	pm_runtime_disable(dev);
 	clk_disable_unprepare(dsi->pllref_clk);
 }
 
-- 
2.6.3
