From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:40:29 +0100
Subject: [PATCH 112/222] net:fec: add byte queue limits support
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeUX-0007Kg-BS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for byte queue limits.  Information on this feature can
be found here: https://lwn.net/Articles/469652/

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 45733f9c3c85..c697b6ae9039 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -499,6 +499,7 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	}
 
 	skb_tx_timestamp(skb);
+	netdev_sent_queue(ndev, skb->len);
 
 	if (++last >= fep->tx_ring_size)
 		last = 0;
@@ -606,6 +607,7 @@ fec_restart(struct net_device *ndev)
 	writel(PKT_MAXBLR_SIZE, fep->hwp + FEC_R_BUFF_SIZE);
 
 	fec_enet_bd_init(ndev);
+	netdev_reset_queue(ndev);
 
 	/* Set receive and transmit descriptor base. */
 	writel(fep->bd_dma, fep->hwp + FEC_R_DES_START);
@@ -836,7 +838,9 @@ fec_enet_tx(struct net_device *ndev)
 	unsigned short status;
 	struct	sk_buff	*skb;
 	unsigned index = fep->tx_dirty;
+	unsigned pkts_compl, bytes_compl;
 
+	pkts_compl = bytes_compl = 0;
 	do {
 		if (++index >= fep->tx_ring_size)
 			index = 0;
@@ -891,6 +895,9 @@ fec_enet_tx(struct net_device *ndev)
 				skb_tstamp_tx(skb, &shhwtstamps);
 			}
 
+			pkts_compl++;
+			bytes_compl += skb->len;
+
 			/* Free the sk buffer associated with this last transmit */
 			dev_kfree_skb_any(skb);
 		}
@@ -898,6 +905,8 @@ fec_enet_tx(struct net_device *ndev)
 		fep->tx_dirty = index;
 	} while (1);
 
+	netdev_completed_queue(ndev, pkts_compl, bytes_compl);
+
 	/* ERR006538: Keep the transmitter going */
 	if (index != fep->tx_next && readl(fep->hwp + FEC_X_DES_ACTIVE) == 0)
 		writel(0, fep->hwp + FEC_X_DES_ACTIVE);
-- 
1.8.3.1
