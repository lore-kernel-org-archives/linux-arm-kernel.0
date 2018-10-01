From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  1 Oct 2018 14:38:41 +0200
Subject: [PATCH v6 3/7] drm/bridge/synopsys: dsi: add ability to have
 glue-specific attach and detach
In-Reply-To: <20181001123845.11818-1-heiko@sntech.de>
References: <20181001123845.11818-1-heiko@sntech.de>
Message-ID: <20181001123845.11818-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the regular means of adding the dsi-component in probe it creates
a race condition with the panel probing, as the panel device only gets
created after the dsi-bus got created.

When the panel-driver is build as a module it currently fails hard as the
panel cannot be probed directly:

dw_mipi_dsi_bind()
  __dw_mipi_dsi_probe()
    creates dsi bus
    creates panel device
    triggers panel module load
    panel not probed (module not loaded or panel probe slow)
  drm_bridge_attach
    fails with -EINVAL due to empty panel_bridge

Additionally the panel probing can run concurrently with dsi bringup
making it possible that the panel can already be found but dsi-attach
hasn't finished running.

To solve that cleanly we may want to only create the component after
the panel has finished probing, by calling component_add from the
host-attach dsi callback.

As that is specific to glue drivers, add a new struct for host_ops
so that glue drivers can tell the bridge to call specific functions
after the common host-attach and before the common host-detach run.

Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 15 +++++++++++++++
 include/drm/bridge/dw_mipi_dsi.h              |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index bb4aeca5c0f9..3962e5d84e1e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -270,6 +270,7 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 				   struct mipi_dsi_device *device)
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
 	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 	int ret;
@@ -300,6 +301,12 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 
 	drm_bridge_add(&dsi->bridge);
 
+	if (pdata->host_ops && pdata->host_ops->attach) {
+		ret = pdata->host_ops->attach(pdata->priv_data, device);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -307,6 +314,14 @@ static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
 				   struct mipi_dsi_device *device)
 {
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+	const struct dw_mipi_dsi_plat_data *pdata = dsi->plat_data;
+	int ret;
+
+	if (pdata->host_ops && pdata->host_ops->detach) {
+		ret = pdata->host_ops->detach(pdata->priv_data, device);
+		if (ret < 0)
+			return ret;
+	}
 
 	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
 
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index 6d7f8eb5d9f2..a9c03099cf3e 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -19,6 +19,13 @@ struct dw_mipi_dsi_phy_ops {
 			     unsigned int *lane_mbps);
 };
 
+struct dw_mipi_dsi_host_ops {
+	int (*attach)(void *priv_data,
+		      struct mipi_dsi_device *dsi);
+	int (*detach)(void *priv_data,
+		      struct mipi_dsi_device *dsi);
+};
+
 struct dw_mipi_dsi_plat_data {
 	void __iomem *base;
 	unsigned int max_data_lanes;
@@ -27,6 +34,7 @@ struct dw_mipi_dsi_plat_data {
 					   const struct drm_display_mode *mode);
 
 	const struct dw_mipi_dsi_phy_ops *phy_ops;
+	const struct dw_mipi_dsi_host_ops *host_ops;
 
 	void *priv_data;
 };
-- 
2.18.0
