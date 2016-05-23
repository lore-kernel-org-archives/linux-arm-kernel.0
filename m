From: peppe.cavallaro@st.com (Giuseppe Cavallaro)
Date: Mon, 23 May 2016 15:17:42 +0200
Subject: [PATCH 1/2 (linux-stable-4.5.y)] Revert "stmmac: Fix 'eth0: No PHY
 found' regression"
In-Reply-To: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
References: <1464009463-23654-1-git-send-email-peppe.cavallaro@st.com>
Message-ID: <1464009463-23654-2-git-send-email-peppe.cavallaro@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>

This reverts commit 88f8b1bb41c6208f81b6a480244533ded7b59493.
due to problems on GeekBox and Banana Pi M1 board when
connected to a real transceiver instead of a switch via
fixed-link.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: Andreas F?rber <afaerber@suse.de>
Cc: Frank Sch?fer <fschaefer.oss@googlemail.com>
Cc: Dinh Nguyen <dinh.linux@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c     | 11 ++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  9 +--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index efb54f3..0faf163 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -199,12 +199,21 @@ int stmmac_mdio_register(struct net_device *ndev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct stmmac_mdio_bus_data *mdio_bus_data = priv->plat->mdio_bus_data;
 	int addr, found;
-	struct device_node *mdio_node = priv->plat->mdio_node;
+	struct device_node *mdio_node = NULL;
+	struct device_node *child_node = NULL;
 
 	if (!mdio_bus_data)
 		return 0;
 
 	if (IS_ENABLED(CONFIG_OF)) {
+		for_each_child_of_node(priv->device->of_node, child_node) {
+			if (of_device_is_compatible(child_node,
+						    "snps,dwmac-mdio")) {
+				mdio_node = child_node;
+				break;
+			}
+		}
+
 		if (mdio_node) {
 			netdev_dbg(ndev, "FOUND MDIO subnode\n");
 		} else {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4514ba7..6a52fa1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -110,7 +110,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
-	struct device_node *child_node = NULL;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -141,19 +140,13 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 		plat->phy_node = of_node_get(np);
 	}
 
-	for_each_child_of_node(np, child_node)
-		if (of_device_is_compatible(child_node,	"snps,dwmac-mdio")) {
-			plat->mdio_node = child_node;
-			break;
-		}
-
 	/* "snps,phy-addr" is not a standard property. Mark it as deprecated
 	 * and warn of its use. Remove this when phy node support is added.
 	 */
 	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
-	if ((plat->phy_node && !of_phy_is_fixed_link(np)) || !plat->mdio_node)
+	if ((plat->phy_node && !of_phy_is_fixed_link(np)) || plat->phy_bus_name)
 		plat->mdio_bus_data = NULL;
 	else
 		plat->mdio_bus_data =
-- 
2.7.4
