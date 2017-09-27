From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 27 Sep 2017 09:34:14 +0200
Subject: [PATCH v6 11/11] of: mdio: Prevent of_mdiobus_register from scanning
 mdio-mux nodes
In-Reply-To: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
Message-ID: <20170927073414.17361-12-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each child node of an MDIO node is scanned as a PHY when calling
of_mdiobus_register() givint the following result:
[   18.175379] mdio_bus stmmac-0: /soc/ethernet at 1c30000/mdio/mdio-mux has invalid PHY address
[   18.175408] mdio_bus stmmac-0: scan phy mdio-mux at address 0
[   18.175450] mdio_bus stmmac-0: scan phy mdio-mux at address 1
[...]
[   18.176420] mdio_bus stmmac-0: scan phy mdio-mux at address 30
[   18.176452] mdio_bus stmmac-0: scan phy mdio-mux at address 31

Since mdio-mux nodes are not PHY, this patch a way to to not scan
them.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/of/of_mdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index d94dd8b77abd..d90ddb0d90f2 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -190,6 +190,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 	struct device_node *child;
 	bool scanphys = false;
 	int addr, rc;
+	static const struct of_device_id do_not_scan[] = {
+		{ .compatible = "mdio-mux" },
+		{}
+	};
 
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
@@ -212,6 +216,9 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 
 	/* Loop over the child nodes and register a phy_device for each phy */
 	for_each_available_child_of_node(np, child) {
+		if (of_match_node(do_not_scan, child))
+			continue;
+
 		addr = of_mdio_parse_addr(&mdio->dev, child);
 		if (addr < 0) {
 			scanphys = true;
@@ -229,6 +236,9 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
+		if (of_match_node(do_not_scan, child))
+			continue;
+
 		/* Skip PHYs with reg property set */
 		if (of_find_property(child, "reg", NULL))
 			continue;
-- 
2.13.5
