From: Elen.Song@atmel.com (Song, Elen)
Date: Fri, 7 Sep 2012 10:00:44 +0000
Subject: [PATCH] DMA: get current descriptor data transfer count
Message-ID: <E8F7C03B253D5640818937FAAE6B175C39CD07B5@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


when data transfer by dma, we could know how many data transfered in one descriptor read DMAC_CTRLAx's btsize bit to get dma transfer size in this case, we could know how many data have been transfered even transaction timeout

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/dma/at_hdmac.c    |   18 ++++++++++++++++++
 include/linux/dmaengine.h |    2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c index 3934fcc..2099613 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -53,6 +53,7 @@ MODULE_PARM_DESC(init_nr_desc_per_channel,
 
 /* prototypes */
 static dma_cookie_t atc_tx_submit(struct dma_async_tx_descriptor *tx);
+static int atc_get_count(struct dma_async_tx_descriptor *tx);
 
 
 /*----------------------------------------------------------------------*/
@@ -95,6 +96,7 @@ static struct at_desc *atc_alloc_descriptor(struct dma_chan *chan,
 		desc->txd.flags = DMA_CTRL_ACK;
 		desc->txd.tx_submit = atc_tx_submit;
 		desc->txd.phys = phys;
+		desc->txd.get_count = atc_get_count;
 	}
 
 	return desc;
@@ -229,6 +231,22 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 	vdbg_dump_regs(atchan);
 }
 
+/*
+ * atc_get_count - get current descriptor transfer data count
+ * @tx: current descriptor
+ */
+static int atc_get_count(struct dma_async_tx_descriptor *tx) {
+	struct at_dma_chan      *atchan = to_at_dma_chan(tx->chan);
+	int ctrla, btsize;
+
+	ctrla = channel_readl(atchan, CTRLA);
+	/* btsize is incremental until data transfer complete*/
+	btsize = ctrla & ATC_BTSIZE_MAX;
+
+	return btsize;
+}
+
 /**
  * atc_chain_complete - finish work for one transaction chain
  * @atchan: channel we work on
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h index 9c02a45..c719fff 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -404,6 +404,7 @@ typedef void (*dma_async_tx_callback)(void *dma_async_param);
  * @tx_submit: set the prepared descriptor(s) to be executed by the engine
  * @callback: routine to call after this operation is complete
  * @callback_param: general parameter to pass to the callback routine
+ * @get_count: get current descriptor data transfer count
  * ---async_tx api specific fields---
  * @next: at completion submit this descriptor
  * @parent: pointer to the next level up in the dependency chain @@ -417,6 +418,7 @@ struct dma_async_tx_descriptor {
 	dma_cookie_t (*tx_submit)(struct dma_async_tx_descriptor *tx);
 	dma_async_tx_callback callback;
 	void *callback_param;
+	int (*get_count)(struct dma_async_tx_descriptor *tx);
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;
--
1.7.10
