From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Jul 2015 17:31:54 +0530
Subject: [PATCH 2/2] dmaengine: xdmac: Add scatter gathered memset support
In-Reply-To: <1436177964-19380-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
 <1436177964-19380-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150716120154.GN5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 12:19:24PM +0200, Maxime Ripard wrote:
> The XDMAC also supports memset operations over discontiguous areas. Add the
> necessary logic to support this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/dma/at_xdmac.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 165 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index cf1213de7865..1a2d9a39ff25 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1133,7 +1133,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
>  	 * SAMA5D4x), so we can use the same interface for source and dest,
>  	 * that solves the fact we don't know the direction.
>  	 */
> -	u32			chan_cc = AT_XDMAC_CC_DAM_INCREMENTED_AM
> +	u32			chan_cc = AT_XDMAC_CC_DAM_UBS_AM
>  					| AT_XDMAC_CC_SAM_INCREMENTED_AM
>  					| AT_XDMAC_CC_DIF(0)
>  					| AT_XDMAC_CC_SIF(0)
> @@ -1201,6 +1201,168 @@ at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
>  	return &desc->tx_dma_desc;
>  }
>  
> +static struct dma_async_tx_descriptor *
> +at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +			    unsigned int sg_len, int value,
> +			    unsigned long flags)
> +{
> +	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> +	struct at_xdmac_desc	*desc, *pdesc = NULL,
> +				*ppdesc = NULL, *first = NULL;
> +	struct scatterlist	*sg, *psg = NULL, *ppsg = NULL;
> +	size_t			stride = 0, pstride = 0, len = 0;
> +	int			i;
> +
> +	if (!sgl)
> +		return NULL;
> +
> +	dev_dbg(chan2dev(chan), "%s: sg_len=%d, value=0x%x, flags=0x%lx\n",
> +		__func__, sg_len, value, flags);
> +
> +	/* Prepare descriptors. */
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		dev_dbg(chan2dev(chan), "%s: dest=0x%08x, len=%d, pattern=0x%x, flags=0x%lx\n",
> +			__func__, sg_dma_address(sg), sg_dma_len(sg),
> +			value, flags);
> +		desc = at_xdmac_memset_create_desc(chan, atchan,
> +						   sg_dma_address(sg),
> +						   sg_dma_len(sg),
> +						   value);
> +		if (!desc && first)
> +			list_splice_init(&first->descs_list,
> +					 &atchan->free_descs_list);
> +
> +		if (!first)
> +			first = desc;
> +
> +		/* Update our strides */
> +		pstride = stride;
> +		if (psg)
> +			stride = sg_dma_address(sg) -
> +				(sg_dma_address(psg) + sg_dma_len(psg));
> +
> +		/*
> +		 * The scatterlist API gives us only the address and
> +		 * length of each elements.
> +		 *
> +		 * Unfortunately, we don't have the stride, which we
> +		 * will need to compute.
> +		 *
> +		 * That make us end up in a situation like this one:
> +		 *    len    stride    len    stride    len
> +		 * +-------+        +-------+        +-------+
> +		 * |  N-2  |        |  N-1  |        |   N   |
> +		 * +-------+        +-------+        +-------+
> +		 *
> +		 * We need all these three elements (N-2, N-1 and N)
> +		 * to actually take the decision on whether we need to
> +		 * queue N-1 or reuse N-2.
> +		 *
> +		 * We will only consider N if it is the last element.
> +		 */
Why do you need stride?

This is scatterlist so the computation of stride sounds odd here. Ideally
you should take the scatterlist and program the lli for controller.

-- 
~Vinod

> +		if (ppdesc && pdesc) {
> +			if ((stride == pstride) &&
> +			    (sg_dma_len(ppsg) == sg_dma_len(psg))) {
> +				dev_dbg(chan2dev(chan),
> +					"%s: desc 0x%p can be merged with desc 0x%p\n",
> +					__func__, pdesc, ppdesc);
> +
> +				/*
> +				 * Increment the block count of the
> +				 * N-2 descriptor
> +				 */
> +				at_xdmac_increment_block_count(chan, ppdesc);
> +				ppdesc->lld.mbr_dus = stride;
> +
> +				/*
> +				 * Put back the N-1 descriptor in the
> +				 * free descriptor list
> +				 */
> +				list_add_tail(&pdesc->desc_node,
> +					      &atchan->free_descs_list);
> +
> +				/*
> +				 * Make our N-1 descriptor pointer
> +				 * point to the N-2 since they were
> +				 * actually merged.
> +				 */
> +				pdesc = ppdesc;
> +
> +			/*
> +			 * Rule out the case where we don't have
> +			 * pstride computed yet (our second sg
> +			 * element)
> +			 *
> +			 * We also want to catch the case where there
> +			 * would be a negative stride,
> +			 */
> +			} else if (pstride ||
> +				   sg_dma_address(sg) < sg_dma_address(psg)) {
> +				/*
> +				 * Queue the N-1 descriptor after the
> +				 * N-2
> +				 */
> +				at_xdmac_queue_desc(chan, ppdesc, pdesc);
> +
> +				/*
> +				 * Add the N-1 descriptor to the list
> +				 * of the descriptors used for this
> +				 * transfer
> +				 */
> +				list_add_tail(&desc->desc_node,
> +					      &first->descs_list);
> +				dev_dbg(chan2dev(chan),
> +					"%s: add desc 0x%p to descs_list 0x%p\n",
> +					__func__, desc, first);
> +			}
> +		}
> +
> +		/*
> +		 * If we are the last element, just see if we have the
> +		 * same size than the previous element.
> +		 *
> +		 * If so, we can merge it with the previous descriptor
> +		 * since we don't care about the stride anymore.
> +		 */
> +		if ((i == (sg_len - 1)) &&
> +		    sg_dma_len(ppsg) == sg_dma_len(psg)) {
> +			dev_dbg(chan2dev(chan),
> +				"%s: desc 0x%p can be merged with desc 0x%p\n",
> +				__func__, desc, pdesc);
> +
> +			/*
> +			 * Increment the block count of the N-1
> +			 * descriptor
> +			 */
> +			at_xdmac_increment_block_count(chan, pdesc);
> +			pdesc->lld.mbr_dus = stride;
> +
> +			/*
> +			 * Put back the N descriptor in the free
> +			 * descriptor list
> +			 */
> +			list_add_tail(&desc->desc_node,
> +				      &atchan->free_descs_list);
> +		}
> +
> +		/* Update our descriptors */
> +		ppdesc = pdesc;
> +		pdesc = desc;
> +
> +		/* Update our scatter pointers */
> +		ppsg = psg;
> +		psg = sg;
> +
> +		len += sg_dma_len(sg);
> +	}
> +
> +	first->tx_dma_desc.cookie = -EBUSY;
> +	first->tx_dma_desc.flags = flags;
> +	first->xfer_size = len;
> +
> +	return &first->tx_dma_desc;
> +}
> +
>  static enum dma_status
>  at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  		struct dma_tx_state *txstate)
> @@ -1734,6 +1896,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_INTERLEAVE, atxdmac->dma.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, atxdmac->dma.cap_mask);
>  	dma_cap_set(DMA_MEMSET, atxdmac->dma.cap_mask);
> +	dma_cap_set(DMA_MEMSET_SG, atxdmac->dma.cap_mask);
>  	dma_cap_set(DMA_SLAVE, atxdmac->dma.cap_mask);
>  	/*
>  	 * Without DMA_PRIVATE the driver is not able to allocate more than
> @@ -1749,6 +1912,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
>  	atxdmac->dma.device_prep_interleaved_dma	= at_xdmac_prep_interleaved;
>  	atxdmac->dma.device_prep_dma_memcpy		= at_xdmac_prep_dma_memcpy;
>  	atxdmac->dma.device_prep_dma_memset		= at_xdmac_prep_dma_memset;
> +	atxdmac->dma.device_prep_dma_memset_sg		= at_xdmac_prep_dma_memset_sg;
>  	atxdmac->dma.device_prep_slave_sg		= at_xdmac_prep_slave_sg;
>  	atxdmac->dma.device_config			= at_xdmac_device_config;
>  	atxdmac->dma.device_pause			= at_xdmac_device_pause;
> -- 
> 2.4.5
> 

-- 
