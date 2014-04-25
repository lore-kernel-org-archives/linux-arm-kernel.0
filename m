From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:37:20 +0100
Subject: [PATCH 075/222] net:fec: add support for dumping transmit ring on
 timeout
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeRU-0007IB-BB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we timeout on transmit, it would be useful to dump the transmit
ring, so we can see the ring state.  This can be helpful to diagnose
the cause of transmit timeouts.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 9de899eb9f8e..7d506ae2dbba 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -291,6 +291,27 @@ static void *swap_buffer(void *bufaddr, int len)
 	return bufaddr;
 }
 
+static void fec_dump(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bufdesc *bdp = fep->tx_bd_base;
+	unsigned index = 0;
+
+	netdev_info(ndev, "TX ring dump\n");
+	pr_info("Nr     SC     addr       len  SKB\n");
+
+	do {
+		pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
+			index,
+			bdp == fep->cur_tx ? 'S' : ' ',
+			bdp == fep->dirty_tx ? 'H' : ' ',
+			bdp->cbd_sc, bdp->cbd_bufaddr, bdp->cbd_datlen,
+			fep->tx_skbuff[index]);
+		bdp = fec_enet_get_nextdesc(bdp, fep);
+		index++;
+	} while (bdp != fep->tx_bd_base);
+}
+
 static int
 fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -717,6 +738,8 @@ fec_timeout(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	fec_dump(ndev);
+
 	ndev->stats.tx_errors++;
 
 	fep->delay_work.timeout = true;
-- 
1.8.3.1
