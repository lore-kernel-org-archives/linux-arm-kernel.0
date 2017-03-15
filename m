From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 15 Mar 2017 13:27:18 -0700
Subject: [PATCH net-next 4/7] drivers: net: xgene: Fix Rx checksum validation
 logic
In-Reply-To: <1489609641-31557-1-git-send-email-isubramanian@apm.com>
References: <1489609641-31557-1-git-send-email-isubramanian@apm.com>
Message-ID: <1489609641-31557-5-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes Rx checksum validation logic and
adds NETIF_F_RXCSUM flag.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 27 +++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index ec43278..e881365 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -601,14 +601,24 @@ static netdev_tx_t xgene_enet_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static void xgene_enet_skip_csum(struct sk_buff *skb)
+static void xgene_enet_rx_csum(struct sk_buff *skb)
 {
+	struct net_device *ndev = skb->dev;
 	struct iphdr *iph = ip_hdr(skb);
 
-	if (!ip_is_fragment(iph) ||
-	    (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP)) {
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	}
+	if (!(ndev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return;
+
+	if (ip_is_fragment(iph))
+		return;
+
+	if (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP)
+		return;
+
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
 static void xgene_enet_free_pagepool(struct xgene_enet_desc_ring *buf_pool,
@@ -729,10 +739,7 @@ static int xgene_enet_rx_frame(struct xgene_enet_desc_ring *rx_ring,
 skip_jumbo:
 	skb_checksum_none_assert(skb);
 	skb->protocol = eth_type_trans(skb, ndev);
-	if (likely((ndev->features & NETIF_F_IP_CSUM) &&
-		   skb->protocol == htons(ETH_P_IP))) {
-		xgene_enet_skip_csum(skb);
-	}
+	xgene_enet_rx_csum(skb);
 
 	rx_ring->rx_packets++;
 	rx_ring->rx_bytes += datalen;
@@ -2039,7 +2046,7 @@ static int xgene_enet_probe(struct platform_device *pdev)
 	xgene_enet_setup_ops(pdata);
 
 	if (pdata->phy_mode == PHY_INTERFACE_MODE_XGMII) {
-		ndev->features |= NETIF_F_TSO;
+		ndev->features |= NETIF_F_TSO | NETIF_F_RXCSUM;
 		spin_lock_init(&pdata->mss_lock);
 	}
 	ndev->hw_features = ndev->features;
-- 
1.9.1
