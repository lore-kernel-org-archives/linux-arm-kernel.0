From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 11:41:00 +0200
Subject: [PATCH v2 2/2] dmaengine: hdmac: Add scatter-gathered memset support
In-Reply-To: <1445506860-22619-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445506860-22619-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445506860-22619-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like memset support, the HDMAC might be used to do a memset over a
discontiguous memory area.

In such a case, we'll just build up a chain of memset descriptors over the
contiguous chunks of memory to set, in order to allow such a support.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/at_hdmac.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index cad18f3660ae..4e55239c7a30 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -986,6 +986,83 @@ err_free_buffer:
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *
+atc_prep_dma_memset_sg(struct dma_chan *chan,
+		       struct scatterlist *sgl,
+		       unsigned int sg_len, int value,
+		       unsigned long flags)
+{
+	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
+	struct at_dma		*atdma = to_at_dma(chan->device);
+	struct at_desc		*desc = NULL, *first = NULL, *prev = NULL;
+	struct scatterlist	*sg;
+	void __iomem		*vaddr;
+	dma_addr_t		paddr;
+	size_t			total_len = 0;
+	int			i;
+
+	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
+		 value, sg_len, flags);
+
+	if (unlikely(!sgl || !sg_len)) {
+		dev_dbg(chan2dev(chan), "%s: scatterlist is empty!\n",
+			__func__);
+		return NULL;
+	}
+
+	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC, &paddr);
+	if (!vaddr) {
+		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
+			__func__);
+		return NULL;
+	}
+	*(u32*)vaddr = value;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t dest = sg_dma_address(sg);
+		size_t len = sg_dma_len(sg);
+
+		dev_vdbg(chan2dev(chan), "%s: d0x%08x, l0x%zx\n",
+			 __func__, dest, len);
+
+		if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
+			dev_err(chan2dev(chan), "%s: buffer is not aligned\n",
+				__func__);
+			goto err_put_desc;
+		}
+
+		desc = atc_create_memset_desc(chan, paddr, dest, len);
+		if (!desc)
+			goto err_put_desc;
+
+		atc_desc_chain(&first, &prev, desc);
+
+		total_len += len;
+	}
+
+	/*
+	 * Only set the buffer pointers on the last descriptor to
+	 * avoid free'ing while we have our transfer still going
+	 */
+	desc->memset_paddr = paddr;
+	desc->memset_vaddr = vaddr;
+	desc->memset_buffer = true;
+
+	first->txd.cookie = -EBUSY;
+	first->total_len = total_len;
+
+	/* set end-of-link on the descriptor */
+	set_desc_eol(desc);
+
+	first->txd.flags = flags;
+
+	return &first->txd;
+
+err_put_desc:
+	atc_desc_put(atchan, first);
+	return NULL;
+}
+
 /**
  * atc_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
  * @chan: DMA channel
@@ -1868,6 +1945,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_INTERLEAVE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_MEMCPY, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_MEMSET, at91sam9g45_config.cap_mask);
+	dma_cap_set(DMA_MEMSET_SG, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_PRIVATE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_SLAVE, at91sam9g45_config.cap_mask);
 	dma_cap_set(DMA_SG, at91sam9g45_config.cap_mask);
@@ -1989,6 +2067,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 
 	if (dma_has_cap(DMA_MEMSET, atdma->dma_common.cap_mask)) {
 		atdma->dma_common.device_prep_dma_memset = atc_prep_dma_memset;
+		atdma->dma_common.device_prep_dma_memset_sg = atc_prep_dma_memset_sg;
 		atdma->dma_common.fill_align = DMAENGINE_ALIGN_4_BYTES;
 	}
 
-- 
2.6.2
