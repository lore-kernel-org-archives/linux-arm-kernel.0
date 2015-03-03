From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Mar 2015 19:29:01 +0100
Subject: [PATCH v3 2/2] dma: at_hdmac: Add support for memory to memory
 sg transfers
In-Reply-To: <1424710451-5601-3-git-send-email-torfl6749@gmail.com>
References: <1424710451-5601-1-git-send-email-torfl6749@gmail.com>
 <1424710451-5601-3-git-send-email-torfl6749@gmail.com>
Message-ID: <54F5FD6D.7070509@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/02/2015 17:54, Torsten Fleischer a ?crit :
> From: Torsten Fleischer <torfl6749@gmail.com>
> 
> This patch adds support for memory to memory scatter-gather transfers.
> 
> Changes from V1:
>    * Fixed coding style of the multi-line comments.
> 
> Changes from V2:
>    * Added setup of 'desc->tx_width' that is needed to calculate the
>      residue.
> 
> Signed-off-by: Torsten Fleischer <torfl6749@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks!

> ---
>  drivers/dma/at_hdmac.c | 175 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 164 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 0b4fc6f..57b2141 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -65,6 +65,21 @@ static void atc_issue_pending(struct dma_chan *chan);
>  
>  /*----------------------------------------------------------------------*/
>  
> +static inline unsigned int atc_get_xfer_width(dma_addr_t src, dma_addr_t dst,
> +						size_t len)
> +{
> +	unsigned int width;
> +
> +	if (!((src | dst  | len) & 3))
> +		width = 2;
> +	else if (!((src | dst | len) & 1))
> +		width = 1;
> +	else
> +		width = 0;
> +
> +	return width;
> +}
> +
>  static struct at_desc *atc_first_active(struct at_dma_chan *atchan)
>  {
>  	return list_first_entry(&atchan->active_list,
> @@ -659,16 +674,10 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	 * We can be a lot more clever here, but this should take care
>  	 * of the most common optimization.
>  	 */
> -	if (!((src | dest  | len) & 3)) {
> -		ctrla = ATC_SRC_WIDTH_WORD | ATC_DST_WIDTH_WORD;
> -		src_width = dst_width = 2;
> -	} else if (!((src | dest | len) & 1)) {
> -		ctrla = ATC_SRC_WIDTH_HALFWORD | ATC_DST_WIDTH_HALFWORD;
> -		src_width = dst_width = 1;
> -	} else {
> -		ctrla = ATC_SRC_WIDTH_BYTE | ATC_DST_WIDTH_BYTE;
> -		src_width = dst_width = 0;
> -	}
> +	src_width = dst_width = atc_get_xfer_width(src, dest, len);
> +
> +	ctrla = ATC_SRC_WIDTH(src_width) |
> +		ATC_DST_WIDTH(dst_width);
>  
>  	for (offset = 0; offset < len; offset += xfer_count << src_width) {
>  		xfer_count = min_t(size_t, (len - offset) >> src_width,
> @@ -862,6 +871,144 @@ err:
>  }
>  
>  /**
> + * atc_prep_dma_sg - prepare memory to memory scather-gather operation
> + * @chan: the channel to prepare operation on
> + * @dst_sg: destination scatterlist
> + * @dst_nents: number of destination scatterlist entries
> + * @src_sg: source scatterlist
> + * @src_nents: number of source scatterlist entries
> + * @flags: tx descriptor status flags
> + */
> +static struct dma_async_tx_descriptor *
> +atc_prep_dma_sg(struct dma_chan *chan,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents,
> +		unsigned long flags)
> +{
> +	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
> +	struct at_desc		*desc = NULL;
> +	struct at_desc		*first = NULL;
> +	struct at_desc		*prev = NULL;
> +	unsigned int		src_width;
> +	unsigned int		dst_width;
> +	size_t			xfer_count;
> +	u32			ctrla;
> +	u32			ctrlb;
> +	size_t			dst_len = 0, src_len = 0;
> +	dma_addr_t		dst = 0, src = 0;
> +	size_t			len = 0, total_len = 0;
> +
> +	if (unlikely(dst_nents == 0 || src_nents == 0))
> +		return NULL;
> +
> +	if (unlikely(dst_sg == NULL || src_sg == NULL))
> +		return NULL;
> +
> +	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
> +		| ATC_SRC_ADDR_MODE_INCR
> +		| ATC_DST_ADDR_MODE_INCR
> +		| ATC_FC_MEM2MEM;
> +
> +	/*
> +	 * loop until there is either no more source or no more destination
> +	 * scatterlist entry
> +	 */
> +	while (true) {
> +
> +		/* prepare the next transfer */
> +		if (dst_len == 0) {
> +
> +			/* no more destination scatterlist entries */
> +			if (!dst_sg || !dst_nents)
> +				break;
> +
> +			dst = sg_dma_address(dst_sg);
> +			dst_len = sg_dma_len(dst_sg);
> +
> +			dst_sg = sg_next(dst_sg);
> +			dst_nents--;
> +		}
> +
> +		if (src_len == 0) {
> +
> +			/* no more source scatterlist entries */
> +			if (!src_sg || !src_nents)
> +				break;
> +
> +			src = sg_dma_address(src_sg);
> +			src_len = sg_dma_len(src_sg);
> +
> +			src_sg = sg_next(src_sg);
> +			src_nents--;
> +		}
> +
> +		len = min_t(size_t, src_len, dst_len);
> +		if (len == 0)
> +			continue;
> +
> +		/* take care for the alignment */
> +		src_width = dst_width = atc_get_xfer_width(src, dst, len);
> +
> +		ctrla = ATC_SRC_WIDTH(src_width) |
> +			ATC_DST_WIDTH(dst_width);
> +
> +		/*
> +		 * The number of transfers to set up refer to the source width
> +		 * that depends on the alignment.
> +		 */
> +		xfer_count = len >> src_width;
> +		if (xfer_count > ATC_BTSIZE_MAX) {
> +			xfer_count = ATC_BTSIZE_MAX;
> +			len = ATC_BTSIZE_MAX << src_width;
> +		}
> +
> +		/* create the transfer */
> +		desc = atc_desc_get(atchan);
> +		if (!desc)
> +			goto err_desc_get;
> +
> +		desc->lli.saddr = src;
> +		desc->lli.daddr = dst;
> +		desc->lli.ctrla = ctrla | xfer_count;
> +		desc->lli.ctrlb = ctrlb;
> +
> +		desc->txd.cookie = 0;
> +		desc->len = len;
> +
> +		/*
> +		 * Although we only need the transfer width for the first and
> +		 * the last descriptor, its easier to set it to all descriptors.
> +		 */
> +		desc->tx_width = src_width;
> +
> +		atc_desc_chain(&first, &prev, desc);
> +
> +		/* update the lengths and addresses for the next loop cycle */
> +		dst_len -= len;
> +		src_len -= len;
> +		dst += len;
> +		src += len;
> +
> +		total_len += len;
> +	}
> +
> +	/* First descriptor of the chain embedds additional information */
> +	first->txd.cookie = -EBUSY;
> +	first->total_len = total_len;
> +
> +	/* set end-of-link to the last link descriptor of list*/
> +	set_desc_eol(desc);
> +
> +	first->txd.flags = flags; /* client is in control of this ack */
> +
> +	return &first->txd;
> +
> +err_desc_get:
> +	atc_desc_put(atchan, first);
> +	return NULL;
> +}
> +
> +/**
>   * atc_dma_cyclic_check_values
>   * Check for too big/unaligned periods and unaligned DMA buffer
>   */
> @@ -1461,8 +1608,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  
>  	/* setup platform data for each SoC */
>  	dma_cap_set(DMA_MEMCPY, at91sam9rl_config.cap_mask);
> +	dma_cap_set(DMA_SG, at91sam9rl_config.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, at91sam9g45_config.cap_mask);
>  	dma_cap_set(DMA_SLAVE, at91sam9g45_config.cap_mask);
> +	dma_cap_set(DMA_SG, at91sam9g45_config.cap_mask);
>  
>  	/* get DMA parameters from controller type */
>  	plat_dat = at_dma_get_driver_data(pdev);
> @@ -1582,11 +1731,15 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  		atdma->dma_common.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  	}
>  
> +	if (dma_has_cap(DMA_SG, atdma->dma_common.cap_mask))
> +		atdma->dma_common.device_prep_dma_sg = atc_prep_dma_sg;
> +
>  	dma_writel(atdma, EN, AT_DMA_ENABLE);
>  
> -	dev_info(&pdev->dev, "Atmel AHB DMA Controller ( %s%s), %d channels\n",
> +	dev_info(&pdev->dev, "Atmel AHB DMA Controller ( %s%s%s), %d channels\n",
>  	  dma_has_cap(DMA_MEMCPY, atdma->dma_common.cap_mask) ? "cpy " : "",
>  	  dma_has_cap(DMA_SLAVE, atdma->dma_common.cap_mask)  ? "slave " : "",
> +	  dma_has_cap(DMA_SG, atdma->dma_common.cap_mask)  ? "sg-cpy " : "",
>  	  plat_dat->nr_channels);
>  
>  	dma_async_device_register(&atdma->dma_common);
> 


-- 
Nicolas Ferre
