From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 20 Oct 2016 17:00:32 +0000
Subject: [PATCH -next] net: ethernet: mediatek: use dev_kfree_skb_any instead
 of dev_kfree_skb
Message-ID: <1476982832-27932-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Replace dev_kfree_skb with dev_kfree_skb_any in mtk_start_xmit()
which can be called from hard irq context (netpoll) and from
other contexts. mtk_start_xmit() only frees skbs that it has
dropped.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8f80e61..d716274 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -843,7 +843,7 @@ static int mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	spin_unlock(&eth->page_lock);
 	stats->tx_dropped++;
-	dev_kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
 
