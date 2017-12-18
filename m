From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 10:18:04 +0100
Subject: [net-next: PATCH 8/8] net: mvpp2: enable ACPI support in the driver
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <1513588684-15647-9-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an alternative way of obtaining resources - via
ACPI tables provided by firmware. Enabling coexistence with the DT
support, in addition to the OF_*->device_*/fwnode_* API replacement,
required following steps to be taken:

* Add mvpp2_acpi_match table
* Omit clock configuration and obtain tclk from the property - in ACPI
  world, the firmware is responsible for clock maintenance.
* Disable comphy and syscon handling as they are not available for ACPI.
* Modify way of obtaining interrupts - with ACPI they are resources
  bound to struct platform_device and it's not possible to obtain
  them directly from the child node. Hence a formula is used, depending
  on the port_id and number of possible CPUs.

Moreover when booting with ACPI MVPP2_QDIST_MULTI_MODE is picked by
default, as there is no need to keep any kind of the backward
compatibility.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 130 +++++++++++++-------
 1 file changed, 87 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 4e61ce7..762a44e 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -10,6 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -7477,7 +7478,8 @@ static int mvpp2_simple_queue_vectors_init(struct mvpp2_port *port,
 	return 0;
 }
 
-static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
+static int mvpp2_multi_queue_vectors_init(struct platform_device *pdev,
+					  struct mvpp2_port *port,
 					  struct device_node *port_node)
 {
 	struct mvpp2_queue_vector *v;
@@ -7510,7 +7512,11 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 			strncpy(irqname, "rx-shared", sizeof(irqname));
 		}
 
-		v->irq = of_irq_get_byname(port_node, irqname);
+		if (port_node)
+			v->irq = of_irq_get_byname(port_node, irqname);
+		else
+			v->irq = platform_get_irq(pdev, port->id *
+						  (port->nqvecs + 2) + i);
 		if (v->irq <= 0) {
 			ret = -EINVAL;
 			goto err;
@@ -7528,11 +7534,12 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
 	return ret;
 }
 
-static int mvpp2_queue_vectors_init(struct mvpp2_port *port,
+static int mvpp2_queue_vectors_init(struct platform_device *pdev,
+				    struct mvpp2_port *port,
 				    struct device_node *port_node)
 {
 	if (port->has_tx_irqs)
-		return mvpp2_multi_queue_vectors_init(port, port_node);
+		return mvpp2_multi_queue_vectors_init(pdev, port, port_node);
 	else
 		return mvpp2_simple_queue_vectors_init(port, port_node);
 }
@@ -7753,7 +7760,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 			    struct fwnode_handle *port_fwnode,
 			    struct mvpp2 *priv)
 {
-	struct phy *comphy;
+	struct phy *comphy = NULL;
 	struct mvpp2_port *port;
 	struct mvpp2_port_pcpu *port_pcpu;
 	struct device_node *port_node = to_of_node(port_fwnode);
@@ -7772,7 +7779,12 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	if (!fwnode_device_is_available(port_fwnode))
 		return 0;
 
-	has_tx_irqs = mvpp2_port_has_tx_irqs(priv, port_node);
+	if (port_node) {
+		has_tx_irqs = mvpp2_port_has_tx_irqs(priv, port_node);
+	} else {
+		has_tx_irqs = true;
+		queue_mode = MVPP2_QDIST_MULTI_MODE;
+	}
 
 	if (!has_tx_irqs)
 		queue_mode = MVPP2_QDIST_SINGLE_MODE;
@@ -7794,13 +7806,15 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		goto err_free_netdev;
 	}
 
-	comphy = devm_of_phy_get(&pdev->dev, port_node, NULL);
-	if (IS_ERR(comphy)) {
-		if (PTR_ERR(comphy) == -EPROBE_DEFER) {
-			err = -EPROBE_DEFER;
-			goto err_free_netdev;
+	if (port_node) {
+		comphy = devm_of_phy_get(&pdev->dev, port_node, NULL);
+		if (IS_ERR(comphy)) {
+			if (PTR_ERR(comphy) == -EPROBE_DEFER) {
+				err = -EPROBE_DEFER;
+				goto err_free_netdev;
+			}
+			comphy = NULL;
 		}
-		comphy = NULL;
 	}
 
 	if (fwnode_property_read_u32(port_fwnode, "port-id", &id)) {
@@ -7820,6 +7834,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	port->nrxqs = nrxqs;
 	port->priv = priv;
 	port->has_tx_irqs = has_tx_irqs;
+	port->id = id;
 
 	err = fwnode_property_get_reference_args(port_fwnode, "phy", NULL,
 						 0, 0, &args);
@@ -7832,11 +7847,16 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		goto err_free_netdev;
 	}
 
-	err = mvpp2_queue_vectors_init(port, port_node);
+	err = mvpp2_queue_vectors_init(pdev, port, port_node);
 	if (err)
 		goto err_free_netdev;
 
-	port->link_irq = of_irq_get_byname(port_node, "link");
+	if (port_node)
+		port->link_irq = of_irq_get_byname(port_node, "link");
+	else
+		port->link_irq = platform_get_irq(pdev, port->id *
+							(port->nqvecs + 2) +
+							port->nqvecs + 1);
 	if (port->link_irq == -EPROBE_DEFER) {
 		err = -EPROBE_DEFER;
 		goto err_deinit_qvecs;
@@ -7848,7 +7868,6 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
 		port->flags |= MVPP2_F_LOOPBACK;
 
-	port->id = id;
 	if (priv->hw_version == MVPP21)
 		port->first_rxq = port->id * port->nrxqs;
 	else
@@ -8218,6 +8237,7 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
 
 static int mvpp2_probe(struct platform_device *pdev)
 {
+	const struct acpi_device_id *acpi_id;
 	struct fwnode_handle *port_fwnode;
 	struct mvpp2 *priv;
 	struct resource *res;
@@ -8229,8 +8249,14 @@ static int mvpp2_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->hw_version =
-		(unsigned long)of_device_get_match_data(&pdev->dev);
+	if (has_acpi_companion(&pdev->dev)) {
+		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
+					    &pdev->dev);
+		priv->hw_version = (unsigned long)acpi_id->driver_data;
+	} else {
+		priv->hw_version =
+			(unsigned long)of_device_get_match_data(&pdev->dev);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -8247,7 +8273,9 @@ static int mvpp2_probe(struct platform_device *pdev)
 		priv->iface_base = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(priv->iface_base))
 			return PTR_ERR(priv->iface_base);
+	}
 
+	if (priv->hw_version == MVPP22 && dev_of_node(&pdev->dev)) {
 		priv->sysctrl_base =
 			syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 							"marvell,system-controller");
@@ -8273,32 +8301,34 @@ static int mvpp2_probe(struct platform_device *pdev)
 	else
 		priv->max_port_rxqs = 32;
 
-	priv->pp_clk = devm_clk_get(&pdev->dev, "pp_clk");
-	if (IS_ERR(priv->pp_clk))
-		return PTR_ERR(priv->pp_clk);
-	err = clk_prepare_enable(priv->pp_clk);
-	if (err < 0)
-		return err;
-
-	priv->gop_clk = devm_clk_get(&pdev->dev, "gop_clk");
-	if (IS_ERR(priv->gop_clk)) {
-		err = PTR_ERR(priv->gop_clk);
-		goto err_pp_clk;
-	}
-	err = clk_prepare_enable(priv->gop_clk);
-	if (err < 0)
-		goto err_pp_clk;
+	if (dev_of_node(&pdev->dev)) {
+		priv->pp_clk = devm_clk_get(&pdev->dev, "pp_clk");
+		if (IS_ERR(priv->pp_clk))
+			return PTR_ERR(priv->pp_clk);
+		err = clk_prepare_enable(priv->pp_clk);
+		if (err < 0)
+			return err;
 
-	if (priv->hw_version == MVPP22) {
-		priv->mg_clk = devm_clk_get(&pdev->dev, "mg_clk");
-		if (IS_ERR(priv->mg_clk)) {
-			err = PTR_ERR(priv->mg_clk);
-			goto err_gop_clk;
+		priv->gop_clk = devm_clk_get(&pdev->dev, "gop_clk");
+		if (IS_ERR(priv->gop_clk)) {
+			err = PTR_ERR(priv->gop_clk);
+			goto err_pp_clk;
 		}
-
-		err = clk_prepare_enable(priv->mg_clk);
+		err = clk_prepare_enable(priv->gop_clk);
 		if (err < 0)
-			goto err_gop_clk;
+			goto err_pp_clk;
+
+		if (priv->hw_version == MVPP22) {
+			priv->mg_clk = devm_clk_get(&pdev->dev, "mg_clk");
+			if (IS_ERR(priv->mg_clk)) {
+				err = PTR_ERR(priv->mg_clk);
+				goto err_gop_clk;
+			}
+
+			err = clk_prepare_enable(priv->mg_clk);
+			if (err < 0)
+				goto err_gop_clk;
+		}
 
 		priv->axi_clk = devm_clk_get(&pdev->dev, "axi_clk");
 		if (IS_ERR(priv->axi_clk)) {
@@ -8311,10 +8341,14 @@ static int mvpp2_probe(struct platform_device *pdev)
 			if (err < 0)
 				goto err_gop_clk;
 		}
-	}
 
-	/* Get system's tclk rate */
-	priv->tclk = clk_get_rate(priv->pp_clk);
+		/* Get system's tclk rate */
+		priv->tclk = clk_get_rate(priv->pp_clk);
+	} else if (device_property_read_u32(&pdev->dev, "clock-frequency",
+					    &priv->tclk)) {
+		dev_err(&pdev->dev, "missing clock-frequency value\n");
+		return -EINVAL;
+	}
 
 	if (priv->hw_version == MVPP22) {
 		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
@@ -8418,6 +8452,9 @@ static int mvpp2_remove(struct platform_device *pdev)
 				  aggr_txq->descs_dma);
 	}
 
+	if (is_acpi_node(port_fwnode))
+		return 0;
+
 	clk_disable_unprepare(priv->axi_clk);
 	clk_disable_unprepare(priv->mg_clk);
 	clk_disable_unprepare(priv->pp_clk);
@@ -8439,12 +8476,19 @@ static const struct of_device_id mvpp2_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mvpp2_match);
 
+static const struct acpi_device_id mvpp2_acpi_match[] = {
+	{ "MRVL0110", MVPP22 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, mvpp2_acpi_match);
+
 static struct platform_driver mvpp2_driver = {
 	.probe = mvpp2_probe,
 	.remove = mvpp2_remove,
 	.driver = {
 		.name = MVPP2_DRIVER_NAME,
 		.of_match_table = mvpp2_match,
+		.acpi_match_table = ACPI_PTR(mvpp2_acpi_match),
 	},
 };
 
-- 
2.7.4
