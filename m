From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:18:02 +0100
Subject: [net-next: PATCH 6/8] net: mvpp2: use device_*/fwnode_* APIs instead
 of of_*
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <1513588684-15647-7-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF functions can be used only for the driver using DT.
As a preparation for introducing ACPI support in mvpp2
driver, use struct fwnode_handle in order to obtain
properties from the hardware description.

Because there is no equivalent for for_each_available_child_of_node(),
use device_for_each_child_node() and check the port availability
inside the mvpp2_port_probe() routine.

This patch replaces of_* function with device_*/fwnode_*
where possible in the mvpp2.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 47 +++++++++++---------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 7f42d90..537474f 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -932,6 +932,9 @@ struct mvpp2_port {
 
 	struct mvpp2 *priv;
 
+	/* Firmware node associated to the port */
+	struct fwnode_handle *fwnode;
+
 	/* Per-port registers' base address */
 	void __iomem *base;
 	void __iomem *stats_base;
@@ -7711,17 +7714,16 @@ static bool mvpp2_port_has_tx_irqs(struct mvpp2 *priv,
 }
 
 static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
-				     struct device_node *port_node,
+				     struct fwnode_handle *fwnode,
 				     char **mac_from)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	char hw_mac_addr[ETH_ALEN] = {0};
-	const char *dt_mac_addr;
+	char fw_mac_addr[ETH_ALEN];
 
-	dt_mac_addr = of_get_mac_address(port_node);
-	if (dt_mac_addr && is_valid_ether_addr(dt_mac_addr)) {
-		*mac_from = "device tree";
-		ether_addr_copy(dev->dev_addr, dt_mac_addr);
+	if (fwnode_get_mac_address(fwnode, fw_mac_addr, ETH_ALEN)) {
+		*mac_from = "firmware node";
+		ether_addr_copy(dev->dev_addr, fw_mac_addr);
 		return;
 	}
 
@@ -7740,13 +7742,14 @@ static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
 
 /* Ports initialization */
 static int mvpp2_port_probe(struct platform_device *pdev,
-			    struct device_node *port_node,
+			    struct fwnode_handle *port_fwnode,
 			    struct mvpp2 *priv)
 {
 	struct device_node *phy_node;
 	struct phy *comphy;
 	struct mvpp2_port *port;
 	struct mvpp2_port_pcpu *port_pcpu;
+	struct device_node *port_node = to_of_node(port_fwnode);
 	struct net_device *dev;
 	struct resource *res;
 	char *mac_from = "";
@@ -7757,6 +7760,10 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	int phy_mode;
 	int err, i, cpu;
 
+	/* Silently exit, if the port node turns out to be disabled. */
+	if (!fwnode_device_is_available(port_fwnode))
+		return 0;
+
 	has_tx_irqs = mvpp2_port_has_tx_irqs(priv, port_node);
 
 	if (!has_tx_irqs)
@@ -7773,7 +7780,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		return -ENOMEM;
 
 	phy_node = of_parse_phandle(port_node, "phy", 0);
-	phy_mode = of_get_phy_mode(port_node);
+	phy_mode = fwnode_get_phy_mode(port_fwnode);
 	if (phy_mode < 0) {
 		dev_err(&pdev->dev, "incorrect phy mode\n");
 		err = phy_mode;
@@ -7789,7 +7796,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		comphy = NULL;
 	}
 
-	if (of_property_read_u32(port_node, "port-id", &id)) {
+	if (fwnode_property_read_u32(port_fwnode, "port-id", &id)) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "missing port-id value\n");
 		goto err_free_netdev;
@@ -7820,7 +7827,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		/* the link irq is optional */
 		port->link_irq = 0;
 
-	if (of_property_read_bool(port_node, "marvell,loopback"))
+	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
 		port->flags |= MVPP2_F_LOOPBACK;
 
 	port->id = id;
@@ -7845,8 +7852,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 				   MVPP21_MIB_COUNTERS_OFFSET +
 				   port->gop_id * MVPP21_MIB_COUNTERS_PORT_SZ;
 	} else {
-		if (of_property_read_u32(port_node, "gop-port-id",
-					 &port->gop_id)) {
+		if (fwnode_property_read_u32(port_fwnode, "gop-port-id",
+					     &port->gop_id)) {
 			err = -EINVAL;
 			dev_err(&pdev->dev, "missing gop-port-id value\n");
 			goto err_deinit_qvecs;
@@ -7876,7 +7883,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	mutex_init(&port->gather_stats_lock);
 	INIT_DELAYED_WORK(&port->stats_work, mvpp2_gather_hw_statistics);
 
-	mvpp2_port_copy_mac_addr(dev, priv, port_node, &mac_from);
+	mvpp2_port_copy_mac_addr(dev, priv, port_fwnode, &mac_from);
 
 	port->tx_ring_size = MVPP2_MAX_TXD_DFLT;
 	port->rx_ring_size = MVPP2_MAX_RXD_DFLT;
@@ -8194,8 +8201,7 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
 
 static int mvpp2_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
-	struct device_node *port_node;
+	struct fwnode_handle *port_fwnode;
 	struct mvpp2 *priv;
 	struct resource *res;
 	void __iomem *base;
@@ -8315,8 +8321,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize ports */
-	for_each_available_child_of_node(dn, port_node) {
-		err = mvpp2_port_probe(pdev, port_node, priv);
+	device_for_each_child_node(&pdev->dev, port_fwnode) {
+		err = mvpp2_port_probe(pdev, port_fwnode, priv);
 		if (err < 0)
 			goto err_port_probe;
 	}
@@ -8347,7 +8353,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 
 err_port_probe:
 	i = 0;
-	for_each_available_child_of_node(dn, port_node) {
+	device_for_each_child_node(&pdev->dev, port_fwnode) {
 		if (priv->port_list[i])
 			mvpp2_port_remove(priv->port_list[i]);
 		i++;
@@ -8366,14 +8372,13 @@ static int mvpp2_probe(struct platform_device *pdev)
 static int mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
-	struct device_node *dn = pdev->dev.of_node;
-	struct device_node *port_node;
+	struct fwnode_handle *port_fwnode;
 	int i = 0;
 
 	flush_workqueue(priv->stats_queue);
 	destroy_workqueue(priv->stats_queue);
 
-	for_each_available_child_of_node(dn, port_node) {
+	device_for_each_child_node(&pdev->dev, port_fwnode) {
 		if (priv->port_list[i]) {
 			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
 			mvpp2_port_remove(priv->port_list[i]);
-- 
2.7.4
