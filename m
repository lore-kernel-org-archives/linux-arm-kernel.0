From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 15 Dec 2014 15:13:31 +0100
Subject: [PATCH 1/2] net/macb: fix misplaced call of free_netdev() in
 macb_remove()
In-Reply-To: <cover.1418651689.git.cyrille.pitchen@atmel.com>
References: <cover.1418651689.git.cyrille.pitchen@atmel.com>
Message-ID: <bb09b43ee435334877b4f8aa6c006d03c1afa8f3.1418651689.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix a bug introduced by the multiqueue support patch:
"net/macb: add TX multiqueue support for gem"

the "bp" pointer to the netdev private data was dereferenced and used after the
associated memory had been freed by calling free_netdev().

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index 0987d2a..81f317f 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -2408,11 +2408,11 @@ static int __exit macb_remove(struct platform_device *pdev)
 		queue = bp->queues;
 		for (q = 0; q < bp->num_queues; ++q, ++queue)
 			devm_free_irq(&pdev->dev, queue->irq, queue);
-		free_netdev(dev);
 		if (!IS_ERR(bp->tx_clk))
 			clk_disable_unprepare(bp->tx_clk);
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
+		free_netdev(dev);
 	}
 
 	return 0;
-- 
1.8.2.2
