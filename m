From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 25 Nov 2015 08:17:36 -0800
Subject: KASAN failures in X-Gene ethernet driver in v4.4-rc2
In-Reply-To: <20151125155753.GE12434@leverpostej>
References: <20151125155753.GE12434@leverpostej>
Message-ID: <1448468256.24696.5.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-11-25 at 15:59 +0000, Mark Rutland wrote:
> xgene_enet_start_xmit

Please try following trivial fix

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 1adfe7036843..9147a0107c44 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -450,12 +450,12 @@ static netdev_tx_t xgene_enet_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	pdata->ring_ops->wr_cmd(tx_ring, count);
 	skb_tx_timestamp(skb);
 
 	pdata->stats.tx_packets++;
 	pdata->stats.tx_bytes += skb->len;
 
+	pdata->ring_ops->wr_cmd(tx_ring, count);
 	return NETDEV_TX_OK;
 }
 
