From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  8 Jul 2016 17:04:58 +0800
Subject: [PATCH 4/7] drm/rockchip: dw-mipi: add dw-mipi power domain support
In-Reply-To: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
References: <1467968701-15620-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1467968701-15620-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference the power domain incase dw-mipi power down when
in use.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 100da01..15ba796 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -12,6 +12,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <drm/drm_atomic_helper.h>
@@ -293,6 +294,7 @@ struct dw_mipi_dsi {
 	struct clk *pclk;
 	struct clk *phy_cfg_clk;
 
+	int dpms_mode;
 	unsigned int lane_mbps; /* per lane */
 	u32 channel;
 	u32 lanes;
@@ -844,6 +846,11 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 	int ret;
 
+	if (dsi->dpms_mode == DRM_MODE_DPMS_ON)
+		return;
+
+	pm_runtime_get_sync(dsi->dev);
+
 	dsi->mode = adjusted_mode;
 
 	ret = dw_mipi_dsi_get_lane_bps(dsi);
@@ -876,6 +883,9 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 {
 	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
 
+	if (dsi->dpms_mode != DRM_MODE_DPMS_ON)
+		return;
+
 	drm_panel_disable(dsi->panel);
 
 	if (clk_prepare_enable(dsi->pclk)) {
@@ -896,6 +906,8 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
 	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
 	dw_mipi_dsi_disable(dsi);
 	clk_disable_unprepare(dsi->pclk);
+	pm_runtime_put(dsi->dev);
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
 }
 
 static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
@@ -929,6 +941,7 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
 
 	regmap_write(dsi->grf_regmap, pdata->grf_switch_reg, val);
 	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
+	dsi->dpms_mode = DRM_MODE_DPMS_ON;
 }
 
 static int
@@ -1150,6 +1163,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->dev = dev;
 	dsi->pdata = pdata;
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
 
 	ret = rockchip_mipi_parse_dt(dsi);
 	if (ret)
@@ -1195,6 +1209,8 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 
 	dev_set_drvdata(dev, dsi);
 
+	pm_runtime_enable(dev);
+
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
 	return mipi_dsi_host_register(&dsi->dsi_host);
@@ -1210,6 +1226,7 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
 
 	mipi_dsi_host_unregister(&dsi->dsi_host);
+	pm_runtime_disable(dev);
 	clk_disable_unprepare(dsi->pllref_clk);
 }
 
-- 
2.6.3
