From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:25:27 -0700
Subject: [PATCH net-next 03/40] net: fec: fix fec_enet_get_free_txdesc_num
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-4-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When first initialized, cur_tx points to the 1st
entry in the queue, and dirty_tx points to the last.
At this point, fec_enet_get_free_txdesc_num will
return tx_ring_size -2. If tx_ring_size -2 entries
are now queued, then fec_enet_get_free_txdesc_num
should return 0, but it returns tx_ring_size instead.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 620834f..8e1f2a6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -296,7 +296,7 @@ static int fec_enet_get_free_txdesc_num(struct fec_enet_private *fep,
 	entries = ((const char *)txq->dirty_tx -
 			(const char *)txq->cur_tx) / fep->bufdesc_size - 1;
 
-	return entries > 0 ? entries : entries + txq->tx_ring_size;
+	return entries >= 0 ? entries : entries + txq->tx_ring_size;
 }
 
 static void swap_buffer(void *bufaddr, int len)
-- 
2.5.0
