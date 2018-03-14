From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 14 Mar 2018 08:37:31 -0500
Subject: [PATCH 4/5] dpaa_eth: increment the RX dropped counter when needed
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Message-ID: <20180314133732.24068-5-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Camelia Groza <camelia.groza@nxp.com>

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 3e83d79..76b3c9e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2321,8 +2321,10 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 
 	skb_len = skb->len;
 
-	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
+	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
+		percpu_stats->rx_dropped++;
 		return qman_cb_dqrr_consume;
+	}
 
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += skb_len;
-- 
2.1.0
