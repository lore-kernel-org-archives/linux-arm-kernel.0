From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 20 Aug 2015 11:10:34 +0530
Subject: [PATCH v1 2/4] dmaengine: xgene-dma: Add support for CRC32C
 calculation via DMA engine
In-Reply-To: <1438258268-3099-3-git-send-email-rsahu@apm.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
 <1438258268-3099-3-git-send-email-rsahu@apm.com>
Message-ID: <20150820054034.GX13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 05:41:06PM +0530, Rameshwar Prasad Sahu wrote:
> +	/* Invalidate unused source address field */
> +	for (; i < 4; i++)
> +		xgene_dma_invalidate_buffer(xgene_dma_lookup_ext8(desc2, i));
> +
> +	/* Check whether requested buffer processed */
> +	if (nbytes) {
> +		chan_err(chan, "Src count crossed maximum limit\n");
> +		return -EINVAL;
no cleanup ?

> +struct dma_async_tx_descriptor *xgene_dma_prep_flyby(
> +	struct xgene_dma_chan *chan, struct scatterlist *src_sg,
> +	size_t len, u32 seed, u8 *result, unsigned long flags, u8 opcode)
please fix style here

> +struct dma_async_tx_descriptor *xgene_dma_prep_crc32c(
> +	struct dma_chan *dchan, struct scatterlist *src_sg,
> +	size_t len, u32 seed, u8 *result, unsigned long flags)
here too

> @@ -1309,8 +1512,13 @@ static void xgene_dma_setup_ring(struct xgene_dma_ring *ring)
>  		  ring->pdma->csr_ring + XGENE_DMA_RING_ID);
> 
>  	/* Set DMA ring buffer */
> -	iowrite32(XGENE_DMA_RING_ID_BUF_SETUP(ring->num),
> -		  ring->pdma->csr_ring + XGENE_DMA_RING_ID_BUF);
> +	ring_id_buf = XGENE_DMA_RING_ID_BUF_SETUP(ring->num);
> +
> +	if (ring->is_bufpool)
> +		ring_id_buf |= XGENE_DMA_RING_IS_BUFPOOL;
> +
> +	iowrite32(ring_id_buf, ring->pdma->csr_ring +
> +		  XGENE_DMA_RING_ID_BUF);
pls fix style here

-- 
~Vinod
