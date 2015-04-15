From: dingtianhong@huawei.com (Ding Tianhong)
Date: Wed, 15 Apr 2015 20:30:08 +0800
Subject: [PATCH net-next 6/6] net: hip04: add ratelimit for rx/tx drops skb
In-Reply-To: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
References: <1429101008-9464-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <1429101008-9464-7-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There can be quite a lot of rx/tx drops message and affect
useful message, so need to ratelimit them to not overwhelm
logging.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index a7ab1d9..b19830d 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -608,11 +608,15 @@ static irqreturn_t hip04_mac_interrupt(int irq, void *dev_id)
 		if (ists & (RCV_NOBUF | RCV_DROP)) {
 			stats->rx_errors++;
 			stats->rx_dropped++;
-			netdev_err(ndev, "rx drop\n");
+			if (net_ratelimit())
+				netdev_dbg(ndev, "rx drop: %lu\n",
+					   stats->rx_dropped);
 		}
 		if (ists & TX_DROP) {
 			stats->tx_dropped++;
-			netdev_err(ndev, "tx drop\n");
+			if (net_ratelimit())
+				netdev_dbg(ndev, "tx drop: %lu\n",
+					   stats->rx_dropped);
 		}
 	}
 
-- 
1.8.0
