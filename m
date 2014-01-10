From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 10 Jan 2014 15:00:08 +0800
Subject: [PATCH v2 07/16] net: stmmac: Use driver data and callbacks tied with
 compatible strings
In-Reply-To: <1389337217-29032-1-git-send-email-wens@csie.org>
References: <1389337217-29032-1-git-send-email-wens@csie.org>
Message-ID: <1389337217-29032-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stmmac driver core allows passing feature flags and callbacks via
platform data. Add a similar stmmac_of_data to pass flags and callbacks
tied to compatible strings. This allows us to extend stmmac with glue
layers for different SoCs.

Also deprecate device tree "snps,phy-addr" property, and default to PHY
address auto-detection.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 46 +++++++++++++++++-----
 include/linux/stmmac.h                             | 18 +++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 92627e0..2e554e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -26,8 +26,20 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/of_device.h>
 #include "stmmac.h"
 
+static const struct of_device_id stmmac_dt_ids[] = {
+	/* SoC specific glue layers should come before generic bindings */
+	{ .compatible = "st,spear600-gmac"},
+	{ .compatible = "snps,dwmac-3.610"},
+	{ .compatible = "snps,dwmac-3.70a"},
+	{ .compatible = "snps,dwmac-3.710"},
+	{ .compatible = "snps,dwmac"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, stmmac_dt_ids);
+
 #ifdef CONFIG_OF
 static int stmmac_probe_config_dt(struct platform_device *pdev,
 				  struct plat_stmmacenet_data *plat,
@@ -35,10 +47,32 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct stmmac_dma_cfg *dma_cfg;
+	const struct of_device_id *device;
 
 	if (!np)
 		return -ENODEV;
 
+	device = of_match_device(stmmac_dt_ids, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	if (device->data) {
+		const struct stmmac_of_data *data = device->data;
+		plat->has_gmac = data->has_gmac;
+		plat->enh_desc = data->enh_desc;
+		plat->tx_coe = data->tx_coe;
+		plat->rx_coe = data->rx_coe;
+		plat->bugged_jumbo = data->bugged_jumbo;
+		plat->pmt = data->pmt;
+		plat->riwt_off = data->riwt_off;
+		plat->fix_mac_speed = data->fix_mac_speed;
+		plat->bus_setup = data->bus_setup;
+		plat->setup = data->setup;
+		plat->free = data->free;
+		plat->init = data->init;
+		plat->exit = data->exit;
+	}
+
 	*mac = of_get_mac_address(np);
 	plat->interface = of_get_phy_mode(np);
 
@@ -46,6 +80,8 @@ static int stmmac_probe_config_dt(struct platform_device *pdev,
 	if (plat->bus_id < 0)
 		plat->bus_id = 0;
 
+	/* Default to phy auto-detection */
+	plat->phy_addr = -1;
 	of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr);
 
 	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
@@ -268,16 +304,6 @@ static const struct dev_pm_ops stmmac_pltfr_pm_ops = {
 static const struct dev_pm_ops stmmac_pltfr_pm_ops;
 #endif /* CONFIG_PM */
 
-static const struct of_device_id stmmac_dt_ids[] = {
-	{ .compatible = "st,spear600-gmac"},
-	{ .compatible = "snps,dwmac-3.610"},
-	{ .compatible = "snps,dwmac-3.70a"},
-	{ .compatible = "snps,dwmac-3.710"},
-	{ .compatible = "snps,dwmac"},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, stmmac_dt_ids);
-
 struct platform_driver stmmac_pltfr_driver = {
 	.probe = stmmac_pltfr_probe,
 	.remove = stmmac_pltfr_remove,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c407791..10a9e2a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -120,4 +120,22 @@ struct plat_stmmacenet_data {
 	void *custom_data;
 	void *bsp_priv;
 };
+
+/* of_data for SoC glue layer device tree bindings */
+
+struct stmmac_of_data {
+	int has_gmac;
+	int enh_desc;
+	int tx_coe;
+	int rx_coe;
+	int bugged_jumbo;
+	int pmt;
+	int riwt_off;
+	void (*fix_mac_speed)(void *priv, unsigned int speed);
+	void (*bus_setup)(void __iomem *ioaddr);
+	void *(*setup)(struct platform_device *pdev);
+	void (*free)(struct platform_device *pdev, void *priv);
+	int (*init)(struct platform_device *pdev, void *priv);
+	void (*exit)(struct platform_device *pdev, void *priv);
+};
 #endif
-- 
1.8.5.2
