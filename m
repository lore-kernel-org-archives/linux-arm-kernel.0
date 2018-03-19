From: igor.pylypiv@gmail.com (Igor Pylypiv)
Date: Sun, 18 Mar 2018 23:40:51 -0700
Subject: [PATCH] net: gemini: fix memory leak
Message-ID: <1521441651-19753-1-git-send-email-igor.pylypiv@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cppcheck report:
[drivers/net/ethernet/cortina/gemini.c:543]: (error) Memory leak: skb_tab

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5eb999a..bd3f6e4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -540,6 +540,7 @@ static int gmac_setup_txqs(struct net_device *netdev)
 
 	if (port->txq_dma_base & ~DMA_Q_BASE_MASK) {
 		dev_warn(geth->dev, "TX queue base it not aligned\n");
+		kfree(skb_tab);
 		return -ENOMEM;
 	}
 
-- 
2.7.4
