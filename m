From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 21 Jul 2014 13:48:13 -0300
Subject: [PATCH 3/6] net: mvpp2: Fix the BM pool buffer release check
In-Reply-To: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1405961296-5846-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a call to mvpp2_bm_bufs_free(), the caller usually wants to know
if the function successfully freed the requested number. However, this
cannot be done by looking into the BM pool count, because the current
buffer count was updated by mvpp2_bm_bufs_free().

In fact, the current callers of mvpp2_bm_bufs_free() use it to release
all the buffers in the pool, so we can fix this by simply checking
if the pool is not empty.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index aa139df..43d3391 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -3420,7 +3420,7 @@ static int mvpp2_bm_pool_destroy(struct platform_device *pdev,
 	u32 val;
 
 	num = mvpp2_bm_bufs_free(priv, bm_pool, bm_pool->buf_num);
-	if (num != bm_pool->buf_num) {
+	if (bm_pool->buf_num) {
 		WARN(1, "cannot free all buffers in pool %d\n", bm_pool->id);
 		return 0;
 	}
@@ -3748,8 +3748,8 @@ static int mvpp2_bm_update_mtu(struct net_device *dev, int mtu)
 	int pkt_size = MVPP2_RX_PKT_SIZE(mtu);
 
 	/* Update BM pool with new buffer size */
-	num = mvpp2_bm_bufs_free(port->priv, port_pool, pkts_num);
-	if (num != pkts_num) {
+	mvpp2_bm_bufs_free(port->priv, port_pool, pkts_num);
+	if (port_pool->buf_num) {
 		WARN(1, "cannot free all buffers in pool %d\n", port_pool->id);
 		return -EIO;
 	}
-- 
2.0.1
