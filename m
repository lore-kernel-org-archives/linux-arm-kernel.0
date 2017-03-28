From: elena.reshetova@intel.com (Elena Reshetova)
Date: Tue, 28 Mar 2017 11:56:29 +0300
Subject: [PATCH 02/16] drivers, net,
 ethernet: convert mtk_eth.dma_refcnt from atomic_t to refcount_t
In-Reply-To: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
References: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <1490691403-4016-3-git-send-email-elena.reshetova@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 +++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index bf6317e..d27f9d9 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1725,7 +1725,7 @@ static int mtk_open(struct net_device *dev)
 	struct mtk_eth *eth = mac->hw;
 
 	/* we run 2 netdevs on the same dma ring so we only bring it up once */
-	if (!atomic_read(&eth->dma_refcnt)) {
+	if (!refcount_read(&eth->dma_refcnt)) {
 		int err = mtk_start_dma(eth);
 
 		if (err)
@@ -1735,8 +1735,10 @@ static int mtk_open(struct net_device *dev)
 		napi_enable(&eth->rx_napi);
 		mtk_irq_enable(eth, MTK_QDMA_INT_MASK, MTK_TX_DONE_INT);
 		mtk_irq_enable(eth, MTK_PDMA_INT_MASK, MTK_RX_DONE_INT);
+		refcount_set(&eth->dma_refcnt, 1);
 	}
-	atomic_inc(&eth->dma_refcnt);
+	else
+		refcount_inc(&eth->dma_refcnt);
 
 	phy_start(dev->phydev);
 	netif_start_queue(dev);
@@ -1776,7 +1778,7 @@ static int mtk_stop(struct net_device *dev)
 	phy_stop(dev->phydev);
 
 	/* only shutdown DMA if this is the last user */
-	if (!atomic_dec_and_test(&eth->dma_refcnt))
+	if (!refcount_dec_and_test(&eth->dma_refcnt))
 		return 0;
 
 	mtk_irq_disable(eth, MTK_QDMA_INT_MASK, MTK_TX_DONE_INT);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 99b1c8e..e5b99b7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -15,6 +15,8 @@
 #ifndef MTK_ETH_H
 #define MTK_ETH_H
 
+#include <linux/refcount.h>
+
 #define MTK_QDMA_PAGE_SIZE	2048
 #define	MTK_MAX_RX_LENGTH	1536
 #define MTK_TX_DMA_BUF_LEN	0x3fff
@@ -541,7 +543,7 @@ struct mtk_eth {
 	struct regmap			*pctl;
 	u32				chip_id;
 	bool				hwlro;
-	atomic_t			dma_refcnt;
+	refcount_t			dma_refcnt;
 	struct mtk_tx_ring		tx_ring;
 	struct mtk_rx_ring		rx_ring[MTK_MAX_RX_RING_NUM];
 	struct napi_struct		tx_napi;
-- 
2.7.4
