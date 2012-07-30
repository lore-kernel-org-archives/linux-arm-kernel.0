From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 16:15:56 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree support to the mv643xx ethernet driver.

It should be enough for most current users of the device, and should allow
a fairly painless migration once proper support for clk devices is available
to those platforms.

Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |  111 ++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 92497eb..579692f 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -48,6 +48,9 @@
 #include <linux/ethtool.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -2601,11 +2604,11 @@ static void infer_hw_params(struct mv643xx_eth_shared_private *msp)
 static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 {
 	static int mv643xx_eth_version_printed;
-	struct mv643xx_eth_shared_platform_data *pd = pdev->dev.platform_data;
+	struct mv643xx_eth_shared_platform_data *pd;
 	struct mv643xx_eth_shared_private *msp;
 	const struct mbus_dram_target_info *dram;
 	struct resource *res;
-	int ret;
+	int ret, irq = -1;
 
 	if (!mv643xx_eth_version_printed++)
 		pr_notice("MV-643xx 10/100/1000 ethernet driver version %s\n",
@@ -2625,6 +2628,23 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	if (msp->base == NULL)
 		goto out_free;
 
+	if (pdev->dev.of_node) {
+		struct device_node *np = NULL;
+
+		/* when all users of this driver use FDT, we can remove this */
+		pd = kzalloc(sizeof(*pd), GFP_ATOMIC);
+		if (!pd) {
+			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
+			goto out_free;
+		}
+
+		np = of_parse_phandle(pdev->dev.of_node, "shared_smi", 0);
+		if (np)
+			pd->shared_smi = of_find_device_by_node(np);
+
+	} else {
+		pd = pdev->dev.platform_data;
+	}
 	/*
 	 * Set up and register SMI bus.
 	 */
@@ -2654,15 +2674,22 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	/*
 	 * Check whether the error interrupt is hooked up.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res != NULL) {
+	if (pdev->dev.of_node) {
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (res)
+			irq = res->start;
+	}
+
+	if (irq != -1) {
 		int err;
 
-		err = request_irq(res->start, mv643xx_eth_err_irq,
+		err = request_irq(irq, mv643xx_eth_err_irq,
 				  IRQF_SHARED, "mv643xx_eth", msp);
 		if (!err) {
 			writel(ERR_INT_SMI_DONE, msp->base + ERR_INT_MASK);
-			msp->err_interrupt = res->start;
+			msp->err_interrupt = irq;
 		}
 	}
 
@@ -2675,6 +2702,10 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
 					pd->tx_csum_limit : 9 * 1024;
+
+	if (pdev->dev.of_node)
+		kfree(pd);  /* If we created a fake pd, free it now */
+
 	infer_hw_params(msp);
 
 	platform_set_drvdata(pdev, msp);
@@ -2708,12 +2739,21 @@ static int mv643xx_eth_shared_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_mdio_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,mdio-mv643xx", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mv_mdio_dt_ids);
+#endif
+
 static struct platform_driver mv643xx_eth_shared_driver = {
 	.probe		= mv643xx_eth_shared_probe,
 	.remove		= mv643xx_eth_shared_remove,
 	.driver = {
 		.name	= MV643XX_ETH_SHARED_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mv_mdio_dt_ids),
 	},
 };
 
@@ -2873,7 +2913,31 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
-	pd = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		struct device_node *np = NULL;
+
+		/* when all users of this driver use FDT, we can remove this */
+		pd = kzalloc(sizeof(*pd), GFP_ATOMIC);
+		if (!pd) {
+			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
+			return -ENOMEM;
+		}
+
+		of_property_read_u32(pdev->dev.of_node,
+			"port_number", &pd->port_number);
+		of_property_read_u32(pdev->dev.of_node,
+			"phy_addr", &pd->phy_addr);
+		np = of_parse_phandle(pdev->dev.of_node, "mdio", 0);
+		if (np) {
+			pd->shared = of_find_device_by_node(np);
+		} else {
+			kfree(pd);
+			return -ENODEV;
+		}
+	} else {
+		pd = pdev->dev.platform_data;
+	}
+
 	if (pd == NULL) {
 		dev_err(&pdev->dev, "no mv643xx_eth_platform_data\n");
 		return -ENODEV;
@@ -2881,12 +2945,15 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	if (pd->shared == NULL) {
 		dev_err(&pdev->dev, "no mv643xx_eth_platform_data->shared\n");
-		return -ENODEV;
+		err = -ENODEV;
+		goto out_free_pd;
 	}
 
 	dev = alloc_etherdev_mq(sizeof(struct mv643xx_eth_private), 8);
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		err = -ENOMEM;
+		goto out_free_pd;
+	}
 
 	mp = netdev_priv(dev);
 	platform_set_drvdata(pdev, mp);
@@ -2923,6 +2990,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	init_pscr(mp, pd->speed, pd->duplex);
 
+	if (pdev->dev.of_node)
+		kfree(pd); /* If we created a fake pd, free it now */
 
 	mib_counters_clear(mp);
 
@@ -2942,10 +3011,13 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	mp->rx_oom.data = (unsigned long)mp;
 	mp->rx_oom.function = oom_timer_wrapper;
 
-
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	BUG_ON(!res);
-	dev->irq = res->start;
+	if (pdev->dev.of_node) {
+		dev->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		BUG_ON(!res);
+		dev->irq = res->start;
+	}
 
 	dev->netdev_ops = &mv643xx_eth_netdev_ops;
 
@@ -2991,6 +3063,8 @@ out:
 	}
 #endif
 	free_netdev(dev);
+out_free_pd:
+	kfree(pd);
 
 	return err;
 }
@@ -3030,6 +3104,14 @@ static void mv643xx_eth_shutdown(struct platform_device *pdev)
 		port_reset(mp);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id mv_eth_dt_ids[] __devinitdata = {
+	{ .compatible = "marvell,mv643xx", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mv_eth_dt_ids);
+#endif
+
 static struct platform_driver mv643xx_eth_driver = {
 	.probe		= mv643xx_eth_probe,
 	.remove		= mv643xx_eth_remove,
@@ -3037,6 +3119,7 @@ static struct platform_driver mv643xx_eth_driver = {
 	.driver = {
 		.name	= MV643XX_ETH_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mv_eth_dt_ids),
 	},
 };
 
-- 
1.7.9.5
