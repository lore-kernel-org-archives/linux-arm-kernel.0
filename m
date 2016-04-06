From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue,  5 Apr 2016 19:25:52 -0700
Subject: [PATCH net-next V3 06/16] net: fec: split off napi routine with 3
 queues
In-Reply-To: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1459909562-22865-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1459909562-22865-7-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we only have 1 tx/rx queue, we need not check
the other queues.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: rebase changes only, fep is no longer passed as a parameter to
fec_rxq/fec_txq
---
 drivers/net/ethernet/freescale/fec_main.c | 39 +++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 918ac82..17140ea 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1524,7 +1524,7 @@ fec_enet_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
-static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
+static int fec_enet_napi_q3(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -1564,6 +1564,39 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 	return pkts;
 }
 
+static int fec_enet_napi_q1(struct napi_struct *napi, int budget)
+{
+	struct net_device *ndev = napi->dev;
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int pkts = 0;
+	uint events;
+
+	do {
+		events = readl(fep->hwp + FEC_IEVENT);
+		if (fep->events) {
+			events |= fep->events;
+			fep->events = 0;
+		}
+		events &= FEC_ENET_RXF_0 | FEC_ENET_TXF_0;
+		if (!events) {
+			if (budget) {
+				napi_complete(napi);
+				writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+			}
+			return pkts;
+		}
+
+		writel(events, fep->hwp + FEC_IEVENT);
+		if (events & FEC_ENET_RXF_0)
+			pkts += fec_rxq(ndev, fep->rx_queue[0],
+					budget - pkts);
+		if (events & FEC_ENET_TXF_0)
+			fec_txq(ndev, fep->tx_queue[0]);
+	} while (pkts < budget);
+	fep->events |= FEC_ENET_RXF_0;	/* save for next callback */
+	return pkts;
+}
+
 /* ------------------------------------------------------------------------- */
 static void fec_get_mac(struct net_device *ndev)
 {
@@ -3123,7 +3156,9 @@ static int fec_enet_init(struct net_device *ndev)
 	ndev->ethtool_ops = &fec_enet_ethtool_ops;
 
 	writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
-	netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi, NAPI_POLL_WEIGHT);
+	netif_napi_add(ndev, &fep->napi, (fep->num_rx_queues |
+		       fep->num_tx_queues) == 1 ? fec_enet_napi_q1 :
+		       fec_enet_napi_q3, NAPI_POLL_WEIGHT);
 
 	if (fep->quirks & FEC_QUIRK_HAS_VLAN)
 		/* enable hw VLAN support */
-- 
2.5.0
