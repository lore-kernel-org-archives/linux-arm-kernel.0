From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Oct 2015 16:52:37 +0200
Subject: [PATCH 1/2] dmaengine: hdmac: factorise memset descriptor allocation
In-Reply-To: <1443711158-18495-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1443711158-18495-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1443711158-18495-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memset and scatter gathered memset are going to use some common logic
to create their descriptors.

Move that logic into a function of its own so that we can share it with the
future memset_sg callback.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/at_hdmac.c      | 98 +++++++++++++++++++++++++++------------------
 drivers/dma/at_hdmac_regs.h |  2 +-
 2 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 58d406230d89..009103fd6d9a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -458,10 +458,10 @@ atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
 		dma_cookie_complete(txd);
 
 	/* If the transfer was a memset, free our temporary buffer */
-	if (desc->memset) {
+	if (desc->memset_buffer) {
 		dma_pool_free(atdma->memset_pool, desc->memset_vaddr,
 			      desc->memset_paddr);
-		desc->memset = false;
+		desc->memset_buffer = false;
 	}
 
 	/* move children to free_list */
@@ -881,6 +881,47 @@ err_desc_get:
 	return NULL;
 }
 
+static struct at_desc *atc_create_memset_desc(struct dma_chan *chan,
+					      dma_addr_t psrc,
+					      dma_addr_t pdst,
+					      size_t len)
+{
+	struct at_dma_chan *atchan = to_at_dma_chan(chan);
+	struct at_desc *desc;
+	size_t xfer_count;
+
+	u32 ctrla = ATC_SRC_WIDTH(2) |
+		ATC_DST_WIDTH(2);
+	u32 ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
+		ATC_SRC_ADDR_MODE_FIXED |
+		ATC_DST_ADDR_MODE_INCR |
+		ATC_FC_MEM2MEM;
+
+	xfer_count = len >> 2;
+	if (xfer_count > ATC_BTSIZE_MAX) {
+		dev_err(chan2dev(chan), "%s: buffer is too big\n",
+			__func__);
+		return NULL;
+	}
+
+	desc = atc_desc_get(atchan);
+	if (!desc) {
+		dev_err(chan2dev(chan), "%s: can't get a descriptor\n",
+			__func__);
+		return NULL;
+	}
+
+	desc->lli.saddr = psrc;
+	desc->lli.daddr = pdst;
+	desc->lli.ctrla = ctrla | xfer_count;
+	desc->lli.ctrlb = ctrlb;
+
+	desc->txd.cookie = 0;
+	desc->len = len;
+
+	return desc;
+}
+
 /**
  * atc_prep_dma_memset - prepare a memcpy operation
  * @chan: the channel to prepare operation on
@@ -893,12 +934,10 @@ static struct dma_async_tx_descriptor *
 atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		    size_t len, unsigned long flags)
 {
-	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	struct at_desc		*desc = NULL;
-	size_t			xfer_count;
-	u32			ctrla;
-	u32			ctrlb;
+	struct at_desc		*desc;
+	void __iomem		*vaddr;
+	dma_addr_t		paddr;
 
 	dev_vdbg(chan2dev(chan), "%s: d0x%x v0x%x l0x%zx f0x%lx\n", __func__,
 		dest, value, len, flags);
@@ -914,46 +953,26 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		return NULL;
 	}
 
-	xfer_count = len >> 2;
-	if (xfer_count > ATC_BTSIZE_MAX) {
-		dev_err(chan2dev(chan), "%s: buffer is too big\n",
+	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC, &paddr);
+	if (!vaddr) {
+		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
 			__func__);
 		return NULL;
 	}
+	*(u32*)vaddr = value;
 
-	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
-		| ATC_SRC_ADDR_MODE_FIXED
-		| ATC_DST_ADDR_MODE_INCR
-		| ATC_FC_MEM2MEM;
-
-	ctrla = ATC_SRC_WIDTH(2) |
-		ATC_DST_WIDTH(2);
-
-	desc = atc_desc_get(atchan);
+	desc = atc_create_memset_desc(chan, paddr, dest, len);
 	if (!desc) {
-		dev_err(chan2dev(chan), "%s: can't get a descriptor\n",
+		dev_err(chan2dev(chan), "%s: couldn't get a descriptor\n",
 			__func__);
-		return NULL;
+		goto err_free_buffer;
 	}
 
-	desc->memset_vaddr = dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC,
-					    &desc->memset_paddr);
-	if (!desc->memset_vaddr) {
-		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
-			__func__);
-		goto err_put_desc;
-	}
-
-	*desc->memset_vaddr = value;
-	desc->memset = true;
-
-	desc->lli.saddr = desc->memset_paddr;
-	desc->lli.daddr = dest;
-	desc->lli.ctrla = ctrla | xfer_count;
-	desc->lli.ctrlb = ctrlb;
+	desc->memset_paddr = paddr;
+	desc->memset_vaddr = vaddr;
+	desc->memset_buffer = true;
 
 	desc->txd.cookie = -EBUSY;
-	desc->len = len;
 	desc->total_len = len;
 
 	/* set end-of-link on the descriptor */
@@ -963,12 +982,11 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 
 	return &desc->txd;
 
-err_put_desc:
-	atc_desc_put(atchan, desc);
+err_free_buffer:
+	dma_pool_free(atdma->memset_pool, vaddr, paddr);
 	return NULL;
 }
 
-
 /**
  * atc_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
  * @chan: DMA channel
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index c3bebbe899ac..d1cfc8c876f9 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -202,7 +202,7 @@ struct at_desc {
 	size_t				src_hole;
 
 	/* Memset temporary buffer */
-	bool				memset;
+	bool				memset_buffer;
 	dma_addr_t			memset_paddr;
 	int				*memset_vaddr;
 };
-- 
2.5.3
