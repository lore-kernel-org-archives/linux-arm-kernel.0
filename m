From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Nov 2016 10:37:21 +0100
Subject: [PATCH v3 net-next 1/6] net: mvneta: Optimize rx path for small frame
In-Reply-To: <cover.a09aeaf5ba62853d595153626b6121ef52a3e9b4.1480412215.git-series.gregory.clement@free-electrons.com>
References: <cover.a09aeaf5ba62853d595153626b6121ef52a3e9b4.1480412215.git-series.gregory.clement@free-electrons.com>
Message-ID: <50c3bed2264b0755205c622e72fc5e00cbe28233.1480412215.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For small frame reuse the phys_addr variable instead of accessing the
uncacheable value in the rx descriptor.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 87274d4ab102..1b84f746d748 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1918,7 +1918,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 				goto err_drop_frame;
 
 			dma_sync_single_range_for_cpu(dev->dev.parent,
-						      rx_desc->buf_phys_addr,
+						      phys_addr,
 						      MVNETA_MH_SIZE + NET_SKB_PAD,
 						      rx_bytes,
 						      DMA_FROM_DEVICE);
-- 
git-series 0.8.10
