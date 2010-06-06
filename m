From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  6 Jun 2010 15:28:55 +0300
Subject: [PATCH 1/2] mv643xx_eth: disable csum offloading if the hw limited by
	max size
Message-ID: <1275827336-31111-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers (KW, Dove) limits the TX IP/layer4 checksum offloading to a max size.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/net/mv643xx_eth.c   |   10 ++++++++++
 include/linux/mv643xx_eth.h |    4 ++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index e345ec8..79243dd 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -289,6 +289,7 @@ struct mv643xx_eth_shared_private {
 	unsigned int t_clk;
 	int extended_rx_coal_limit;
 	int tx_bw_control;
+	int tx_csum_limit;
 };
 
 #define TX_BW_CONTROL_ABSENT		0
@@ -2468,6 +2469,14 @@ static int mv643xx_eth_change_mtu(struct net_device *dev, int new_mtu)
 	mv643xx_eth_recalc_skb_size(mp);
 	tx_set_rate(mp, 1000000000, 16777216);
 
+	if (mp->shared->tx_csum_limit && dev->mtu > mp->shared->tx_csum_limit) {
+		dev->features &= ~NETIF_F_IP_CSUM;
+		dev->vlan_features &= ~NETIF_F_IP_CSUM;
+	} else {
+		dev->features |= NETIF_F_IP_CSUM;
+		dev->vlan_features |= NETIF_F_IP_CSUM;
+	}
+
 	if (!netif_running(dev))
 		return 0;
 
@@ -2666,6 +2675,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	 * Detect hardware parameters.
 	 */
 	msp->t_clk = (pd != NULL && pd->t_clk != 0) ? pd->t_clk : 133000000;
+	msp->tx_csum_limit = pd->tx_csum_limit;
 	infer_hw_params(msp);
 
 	platform_set_drvdata(pdev, msp);
diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
index cbbbe9b..7402718 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/mv643xx_eth.h
@@ -19,6 +19,10 @@ struct mv643xx_eth_shared_platform_data {
 	struct mbus_dram_target_info	*dram;
 	struct platform_device	*shared_smi;
 	unsigned int		t_clk;
+	/*
+	 * Max packet size for Tx IP/Layer 4 checksum (0 -> no limit)
+	 */
+	int			tx_csum_limit;
 };
 
 #define MV643XX_ETH_PHY_ADDR_DEFAULT	0
-- 
1.6.0.4
