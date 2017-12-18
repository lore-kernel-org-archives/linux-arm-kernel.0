From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:18:03 +0100
Subject: [net-next: PATCH 7/8] net: mvpp2: handle PHY with its fwnode
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <1513588684-15647-8-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newly introduced mvmdio driver ACPI support and also fwnode
MDIO helpers allow for switching to PHY handling with its fwnode.

This patch replaces of_* related PHY handling function with
the fwnode_* equivalent and updates mvpp2_port structure
accordingly.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 41 ++++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 537474f..4e61ce7 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -963,7 +963,7 @@ struct mvpp2_port {
 	struct delayed_work stats_work;
 
 	phy_interface_t phy_interface;
-	struct device_node *phy_node;
+	struct fwnode_handle *phy_fwnode;
 	struct phy *comphy;
 	unsigned int link;
 	unsigned int duplex;
@@ -6890,14 +6890,22 @@ static void mvpp21_get_mac_address(struct mvpp2_port *port, unsigned char *addr)
 static int mvpp2_phy_connect(struct mvpp2_port *port)
 {
 	struct phy_device *phy_dev;
+	int ret;
 
 	/* No PHY is attached */
-	if (!port->phy_node)
+	if (!port->phy_fwnode)
 		return 0;
 
-	phy_dev = of_phy_connect(port->dev, port->phy_node, mvpp2_link_event, 0,
+	phy_dev = fwnode_phy_find_device(port->phy_fwnode);
+	phy_dev->dev_flags = 0;
+
+	ret = phy_connect_direct(port->dev, phy_dev, mvpp2_link_event,
 				 port->phy_interface);
-	if (!phy_dev) {
+
+	/* Refcount is held by phy_connect_direct() on success */
+	put_device(&phy_dev->mdio.dev);
+
+	if (ret) {
 		netdev_err(port->dev, "cannot connect to phy\n");
 		return -ENODEV;
 	}
@@ -7047,7 +7055,7 @@ static int mvpp2_open(struct net_device *dev)
 		goto err_cleanup_txqs;
 	}
 
-	if (priv->hw_version == MVPP22 && !port->phy_node && port->link_irq) {
+	if (priv->hw_version == MVPP22 && !port->phy_fwnode && port->link_irq) {
 		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
 				  dev->name, port);
 		if (err) {
@@ -7082,7 +7090,7 @@ static int mvpp2_open(struct net_device *dev)
 	return 0;
 
 err_free_link_irq:
-	if (priv->hw_version == MVPP22 && !port->phy_node && port->link_irq)
+	if (priv->hw_version == MVPP22 && !port->phy_fwnode && port->link_irq)
 		free_irq(port->link_irq, port);
 err_free_irq:
 	mvpp2_irqs_deinit(port);
@@ -7107,7 +7115,7 @@ static int mvpp2_stop(struct net_device *dev)
 	on_each_cpu(mvpp2_interrupts_mask, port, 1);
 	mvpp2_shared_interrupt_mask_unmask(port, true);
 
-	if (priv->hw_version == MVPP22 && !port->phy_node && port->link_irq)
+	if (priv->hw_version == MVPP22 && !port->phy_fwnode && port->link_irq)
 		free_irq(port->link_irq, port);
 
 	mvpp2_irqs_deinit(port);
@@ -7745,11 +7753,11 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 			    struct fwnode_handle *port_fwnode,
 			    struct mvpp2 *priv)
 {
-	struct device_node *phy_node;
 	struct phy *comphy;
 	struct mvpp2_port *port;
 	struct mvpp2_port_pcpu *port_pcpu;
 	struct device_node *port_node = to_of_node(port_fwnode);
+	struct fwnode_reference_args args;
 	struct net_device *dev;
 	struct resource *res;
 	char *mac_from = "";
@@ -7779,7 +7787,6 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	if (!dev)
 		return -ENOMEM;
 
-	phy_node = of_parse_phandle(port_node, "phy", 0);
 	phy_mode = fwnode_get_phy_mode(port_fwnode);
 	if (phy_mode < 0) {
 		dev_err(&pdev->dev, "incorrect phy mode\n");
@@ -7814,6 +7821,17 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	port->priv = priv;
 	port->has_tx_irqs = has_tx_irqs;
 
+	err = fwnode_property_get_reference_args(port_fwnode, "phy", NULL,
+						 0, 0, &args);
+	if (!err) {
+		port->phy_fwnode = args.fwnode;
+	} else if (err == -ENOENT) {
+		port->phy_fwnode = NULL;
+	} else {
+		dev_err(&pdev->dev, "unable to parse \"phy\" node\n");
+		goto err_free_netdev;
+	}
+
 	err = mvpp2_queue_vectors_init(port, port_node);
 	if (err)
 		goto err_free_netdev;
@@ -7836,7 +7854,6 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	else
 		port->first_rxq = port->id * priv->max_port_rxqs;
 
-	port->phy_node = phy_node;
 	port->phy_interface = phy_mode;
 	port->comphy = comphy;
 
@@ -7958,7 +7975,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 err_deinit_qvecs:
 	mvpp2_queue_vectors_deinit(port);
 err_free_netdev:
-	of_node_put(phy_node);
+	fwnode_handle_put(args.fwnode);
 	free_netdev(dev);
 	return err;
 }
@@ -7969,7 +7986,7 @@ static void mvpp2_port_remove(struct mvpp2_port *port)
 	int i;
 
 	unregister_netdev(port->dev);
-	of_node_put(port->phy_node);
+	fwnode_handle_put(port->phy_fwnode);
 	free_percpu(port->pcpu);
 	free_percpu(port->stats);
 	for (i = 0; i < port->ntxqs; i++)
-- 
2.7.4
