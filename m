From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:31 -0500
Subject: [PATCH 08/18] staging: fsl-dpaa2/eth: Always call napi_gro_receive()
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-9-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function itself checks whether GRO support is enabled
and acts accordingly, so we don't need to verify it in the
driver as well.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 57628cd3ecf2..d3ec384c7364 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -273,10 +273,7 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += dpaa2_fd_get_len(fd);
 
-	if (priv->net_dev->features & NETIF_F_GRO)
-		napi_gro_receive(napi, skb);
-	else
-		netif_receive_skb(skb);
+	napi_gro_receive(napi, skb);
 
 	return;
 
-- 
2.11.0
