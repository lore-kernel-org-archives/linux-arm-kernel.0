From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 11:56:24 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
Message-ID: <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power entire ethernet block down in ndo_stop().
Power it back up in ndo_open() and perform HW init.
Delete nb8800_dma_stop.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/net/ethernet/aurora/nb8800.c | 146 +++++++++--------------------------
 drivers/net/ethernet/aurora/nb8800.h |   4 +-
 2 files changed, 40 insertions(+), 110 deletions(-)

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 09b8001e1ecc..b71d8fb80610 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -40,7 +40,7 @@
 #include "nb8800.h"
 
 static void nb8800_tx_done(struct net_device *dev);
-static int nb8800_dma_stop(struct net_device *dev);
+static void nb8800_hw_init(struct net_device *dev);
 
 static inline u8 nb8800_readb(struct nb8800_priv *priv, int reg)
 {
@@ -862,61 +862,6 @@ static int nb8800_dma_init(struct net_device *dev)
 	return -ENOMEM;
 }
 
-static int nb8800_dma_stop(struct net_device *dev)
-{
-	struct nb8800_priv *priv = netdev_priv(dev);
-	struct nb8800_tx_buf *txb = &priv->tx_bufs[0];
-	struct nb8800_tx_desc *txd = &priv->tx_descs[0];
-	int retry = 5;
-	u32 txcr;
-	u32 rxcr;
-	int err;
-	unsigned int i;
-
-	/* wait for tx to finish */
-	err = readl_poll_timeout_atomic(priv->base + NB8800_TXC_CR, txcr,
-					!(txcr & TCR_EN) &&
-					priv->tx_done == priv->tx_next,
-					1000, 1000000);
-	if (err)
-		return err;
-
-	/* The rx DMA only stops if it reaches the end of chain.
-	 * To make this happen, we set the EOC flag on all rx
-	 * descriptors, put the device in loopback mode, and send
-	 * a few dummy frames.  The interrupt handler will ignore
-	 * these since NAPI is disabled and no real frames are in
-	 * the tx queue.
-	 */
-
-	for (i = 0; i < RX_DESC_COUNT; i++)
-		priv->rx_descs[i].desc.config |= DESC_EOC;
-
-	txd->desc[0].s_addr =
-		txb->dma_desc + offsetof(struct nb8800_tx_desc, buf);
-	txd->desc[0].config = DESC_BTS(2) | DESC_DS | DESC_EOF | DESC_EOC | 8;
-	memset(txd->buf, 0, sizeof(txd->buf));
-
-	nb8800_mac_af(dev, false);
-	nb8800_setb(priv, NB8800_MAC_MODE, LOOPBACK_EN);
-
-	do {
-		nb8800_writel(priv, NB8800_TX_DESC_ADDR, txb->dma_desc);
-		wmb();
-		nb8800_writel(priv, NB8800_TXC_CR, txcr | TCR_EN);
-
-		err = readl_poll_timeout_atomic(priv->base + NB8800_RXC_CR,
-						rxcr, !(rxcr & RCR_EN),
-						1000, 100000);
-	} while (err && --retry);
-
-	nb8800_mac_af(dev, true);
-	nb8800_clearb(priv, NB8800_MAC_MODE, LOOPBACK_EN);
-	nb8800_dma_reset(dev);
-
-	return retry ? 0 : -ETIMEDOUT;
-}
-
 static void nb8800_pause_adv(struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
@@ -941,6 +886,11 @@ static int nb8800_open(struct net_device *dev)
 	struct phy_device *phydev;
 	int err;
 
+	priv->ops->power_up(dev);
+	nb8800_hw_init(dev);
+	priv->ops->init(dev);
+	nb8800_update_mac_addr(dev);
+
 	/* clear any pending interrupts */
 	nb8800_writel(priv, NB8800_RXC_SR, 0xf);
 	nb8800_writel(priv, NB8800_TXC_SR, 0xf);
@@ -993,12 +943,11 @@ static int nb8800_stop(struct net_device *dev)
 	netif_stop_queue(dev);
 	napi_disable(&priv->napi);
 
-	nb8800_dma_stop(dev);
-	nb8800_mac_rx(dev, false);
-	nb8800_mac_tx(dev, false);
-
 	phy_disconnect(phydev);
 
+	priv->ops->power_down(dev);
+	priv->speed = 0;
+
 	free_irq(dev->irq, dev);
 
 	nb8800_dma_free(dev);
@@ -1150,7 +1099,7 @@ static const struct ethtool_ops nb8800_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int nb8800_hw_init(struct net_device *dev)
+static void nb8800_hw_init(struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
 	u32 val;
@@ -1230,20 +1179,14 @@ static int nb8800_hw_init(struct net_device *dev)
 	nb8800_writeb(priv, NB8800_PQ1, val >> 8);
 	nb8800_writeb(priv, NB8800_PQ2, val & 0xff);
 
-	/* Auto-negotiate by default */
-	priv->pause_aneg = true;
-	priv->pause_rx = true;
-	priv->pause_tx = true;
-
 	nb8800_mc_init(dev, 0);
-
-	return 0;
 }
 
 static int nb8800_tangox_init(struct net_device *dev)
 {
 	struct nb8800_priv *priv = netdev_priv(dev);
 	u32 pad_mode = PAD_MODE_MII;
+	int clk_div;
 
 	switch (priv->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
@@ -1266,29 +1209,26 @@ static int nb8800_tangox_init(struct net_device *dev)
 
 	nb8800_writeb(priv, NB8800_TANGOX_PAD_MODE, pad_mode);
 
+	clk_div = DIV_ROUND_UP(clk_get_rate(priv->clk), 2 * MAX_MDC_CLOCK);
+	nb8800_writew(priv, NB8800_TANGOX_MDIO_CLKDIV, clk_div);
+
 	return 0;
 }
 
-static int nb8800_tangox_reset(struct net_device *dev)
+static void nb8800_tango_power_down(struct net_device *dev)
 {
-	struct nb8800_priv *priv = netdev_priv(dev);
-	int clk_div;
-
-	nb8800_writeb(priv, NB8800_TANGOX_RESET, 0);
-	usleep_range(1000, 10000);
-	nb8800_writeb(priv, NB8800_TANGOX_RESET, 1);
-
-	wmb();		/* ensure reset is cleared before proceeding */
-
-	clk_div = DIV_ROUND_UP(clk_get_rate(priv->clk), 2 * MAX_MDC_CLOCK);
-	nb8800_writew(priv, NB8800_TANGOX_MDIO_CLKDIV, clk_div);
+	nb8800_writel(netdev_priv(dev), NB8800_TANGOX_RESET, 0);
+}
 
-	return 0;
+static void nb8800_tango_power_up(struct net_device *dev)
+{
+	nb8800_writel(netdev_priv(dev), NB8800_TANGOX_RESET, 1);
 }
 
 static const struct nb8800_ops nb8800_tangox_ops = {
-	.init	= nb8800_tangox_init,
-	.reset	= nb8800_tangox_reset,
+	.init		= nb8800_tangox_init,
+	.power_down	= nb8800_tango_power_down,
+	.power_up	= nb8800_tango_power_up,
 };
 
 static int nb8800_tango4_init(struct net_device *dev)
@@ -1314,8 +1254,9 @@ static int nb8800_tango4_init(struct net_device *dev)
 }
 
 static const struct nb8800_ops nb8800_tango4_ops = {
-	.init	= nb8800_tango4_init,
-	.reset	= nb8800_tangox_reset,
+	.init		= nb8800_tango4_init,
+	.power_down	= nb8800_tango_power_down,
+	.power_up	= nb8800_tango_power_up,
 };
 
 static const struct of_device_id nb8800_dt_ids[] = {
@@ -1334,7 +1275,6 @@ MODULE_DEVICE_TABLE(of, nb8800_dt_ids);
 static int nb8800_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
-	const struct nb8800_ops *ops = NULL;
 	struct nb8800_priv *priv;
 	struct resource *res;
 	struct net_device *dev;
@@ -1345,8 +1285,8 @@ static int nb8800_probe(struct platform_device *pdev)
 	int ret;
 
 	match = of_match_device(nb8800_dt_ids, &pdev->dev);
-	if (match)
-		ops = match->data;
+	if (!match || !match->data)
+		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -1388,12 +1328,6 @@ static int nb8800_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->tx_lock);
 
-	if (ops && ops->reset) {
-		ret = ops->reset(dev);
-		if (ret)
-			goto err_disable_clk;
-	}
-
 	bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!bus) {
 		ret = -ENOMEM;
@@ -1435,16 +1369,6 @@ static int nb8800_probe(struct platform_device *pdev)
 
 	priv->mii_bus = bus;
 
-	ret = nb8800_hw_init(dev);
-	if (ret)
-		goto err_deregister_fixed_link;
-
-	if (ops && ops->init) {
-		ret = ops->init(dev);
-		if (ret)
-			goto err_deregister_fixed_link;
-	}
-
 	dev->netdev_ops = &nb8800_netdev_ops;
 	dev->ethtool_ops = &nb8800_ethtool_ops;
 	dev->flags |= IFF_MULTICAST;
@@ -1457,24 +1381,28 @@ static int nb8800_probe(struct platform_device *pdev)
 	if (!is_valid_ether_addr(dev->dev_addr))
 		eth_hw_addr_random(dev);
 
-	nb8800_update_mac_addr(dev);
-
 	netif_carrier_off(dev);
 
 	ret = register_netdev(dev);
 	if (ret) {
 		netdev_err(dev, "failed to register netdev\n");
-		goto err_free_dma;
+		goto err_deregister_fixed_link;
 	}
 
 	netif_napi_add(dev, &priv->napi, nb8800_poll, NAPI_POLL_WEIGHT);
 
 	netdev_info(dev, "MAC address %pM\n", dev->dev_addr);
 
+	/* Auto-negotiate by default */
+	priv->pause_aneg = true;
+	priv->pause_rx = true;
+	priv->pause_tx = true;
+
+	priv->ops = match->data;
+	priv->ops->power_down(dev);
+
 	return 0;
 
-err_free_dma:
-	nb8800_dma_free(dev);
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(pdev->dev.of_node))
 		of_phy_deregister_fixed_link(pdev->dev.of_node);
diff --git a/drivers/net/ethernet/aurora/nb8800.h b/drivers/net/ethernet/aurora/nb8800.h
index 6ec4a956e1e5..23fefca54804 100644
--- a/drivers/net/ethernet/aurora/nb8800.h
+++ b/drivers/net/ethernet/aurora/nb8800.h
@@ -305,11 +305,13 @@ struct nb8800_priv {
 	dma_addr_t			tx_desc_dma;
 
 	struct clk			*clk;
+	const struct nb8800_ops		*ops;
 };
 
 struct nb8800_ops {
 	int				(*init)(struct net_device *dev);
-	int				(*reset)(struct net_device *dev);
+	void				(*power_down)(struct net_device *dev);
+	void				(*power_up)(struct net_device *dev);
 };
 
 #endif /* _NB8800_H_ */
-- 
2.15.0
