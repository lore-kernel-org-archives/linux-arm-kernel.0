From: elen.song@atmel.com (Elen Song)
Date: Fri, 10 May 2013 11:00:50 +0800
Subject: [PATCH 1/2 V4] DMA: AT91: Get transfer width
Message-ID: <1368154850-9354-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In one dma transfer, the data transfer width can be configured and it is limited by source or destination peripheral width,
tx_width will save the transfer width, but for memcpy, either source or destination transfer width is taken as tx_width.

Signed-off-by: Elen Song <elen.song@atmel.com>
---
 drivers/dma/at_hdmac.c      |    3 +++
 drivers/dma/at_hdmac_regs.h |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6e13f26..a4d427e 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -613,6 +613,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	/* First descriptor of the chain embedds additional information */
 	first->txd.cookie = -EBUSY;
 	first->len = len;
+	first->tx_width = src_width;
 
 	/* set end-of-link to the last link descriptor of list*/
 	set_desc_eol(desc);
@@ -759,6 +760,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* First descriptor of the chain embedds additional information */
 	first->txd.cookie = -EBUSY;
 	first->len = total_len;
+	first->tx_width = reg_width;
 
 	/* first link descriptor of list is responsible of flags */
 	first->txd.flags = flags; /* client is in control of this ack */
@@ -917,6 +919,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	/* First descriptor of the chain embedds additional information */
 	first->txd.cookie = -EBUSY;
 	first->len = buf_len;
+	first->tx_width = reg_width;
 
 	return &first->txd;
 
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 0eb3c13..d27942f 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -182,6 +182,7 @@ struct at_lli {
  * @txd: support for the async_tx api
  * @desc_node: node on the channed descriptors list
  * @len: total transaction bytecount
+ * @tx_width: transfer width
  */
 struct at_desc {
 	/* FIRST values the hardware uses */
@@ -192,6 +193,7 @@ struct at_desc {
 	struct dma_async_tx_descriptor	txd;
 	struct list_head		desc_node;
 	size_t				len;
+	u32				tx_width;
 };
 
 static inline struct at_desc *
-- 
1.7.9.5
