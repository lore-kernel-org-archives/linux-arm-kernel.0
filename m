From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Aug 2017 16:51:35 +0200
Subject: [PATCH 1/3] dmaengine: sun6i: Correct DMA support on H3
In-Reply-To: <20170830233609.13855-2-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
 <20170830233609.13855-2-stefan.bruens@rwth-aachen.de>
Message-ID: <20170831145135.c6a2wubcf6xu34tz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 31, 2017 at 01:36:07AM +0200, Stefan Br?ns wrote:
> +/* Between SoC generations, there are some significant differences:
> + * - A23 added a clock gate register
> + * - the H3 burst length field has a different offset
> + */

This is not the proper comment style.

> +enum dmac_variant {
> +	DMAC_VARIANT_A31,
> +	DMAC_VARIANT_A23,
> +	DMAC_VARIANT_H3,
> +};
> +

And this is redundant with what we already have in our structures.

>  /*
>   * Hardware channels / ports representation
>   *
> @@ -101,6 +116,7 @@ struct sun6i_dma_config {
>  	u32 nr_max_channels;
>  	u32 nr_max_requests;
>  	u32 nr_max_vchans;
> +	enum dmac_variant dmac_variant;
>  };
>  
>  /*
> @@ -240,8 +256,12 @@ static inline s8 convert_burst(u32 maxburst)
>  	switch (maxburst) {
>  	case 1:
>  		return 0;
> +	case 4:
> +		return 1;
>  	case 8:
>  		return 2;
> +	case 16:
> +		return 3;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -249,11 +269,7 @@ static inline s8 convert_burst(u32 maxburst)
>  
>  static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
>  {
> -	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
> -	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
> -		return -EINVAL;
> -
> -	return addr_width >> 1;
> +	return ilog2(addr_width);
>  }

This isn't really the same operation. There should be some explanation
about why it's the right thing to do.

>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> @@ -499,45 +515,58 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  			enum dma_transfer_direction direction,
>  			u32 *p_cfg)
>  {
> +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
> +	u32 src_maxburst, dst_maxburst, supported_burst_length;
>  	s8 src_width, dst_width, src_burst, dst_burst;
>  
> +	src_addr_width = sconfig->src_addr_width;
> +	dst_addr_width = sconfig->dst_addr_width;
> +	src_maxburst = sconfig->src_maxburst;
> +	dst_maxburst = sconfig->dst_maxburst;
> +
> +	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3)
> +		supported_burst_length = BIT(1) | BIT(4) | BIT(8) | BIT(16);
> +	else
> +		supported_burst_length = BIT(1) | BIT(8);

This could be stored in the structure for example.

>  	switch (direction) {
>  	case DMA_MEM_TO_DEV:
> -		src_burst = convert_burst(sconfig->src_maxburst ?
> -					sconfig->src_maxburst : 8);
> -		src_width = convert_buswidth(sconfig->src_addr_width !=
> -						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> -				sconfig->src_addr_width :
> -				DMA_SLAVE_BUSWIDTH_4_BYTES);
> -		dst_burst = convert_burst(sconfig->dst_maxburst);
> -		dst_width = convert_buswidth(sconfig->dst_addr_width);
> +		if (src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +			src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		src_maxburst = src_maxburst ? src_maxburst : 8;
>  		break;
>  	case DMA_DEV_TO_MEM:
> -		src_burst = convert_burst(sconfig->src_maxburst);
> -		src_width = convert_buswidth(sconfig->src_addr_width);
> -		dst_burst = convert_burst(sconfig->dst_maxburst ?
> -					sconfig->dst_maxburst : 8);
> -		dst_width = convert_buswidth(sconfig->dst_addr_width !=
> -						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> -				sconfig->dst_addr_width :
> -				DMA_SLAVE_BUSWIDTH_4_BYTES);
> +		if (dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> +			dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		dst_maxburst = dst_maxburst ? dst_maxburst : 8;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	if (src_burst < 0)
> -		return src_burst;
> -	if (src_width < 0)
> -		return src_width;
> -	if (dst_burst < 0)
> -		return dst_burst;
> -	if (dst_width < 0)
> -		return dst_width;
> -
> -	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
> -		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
> -		DMA_CHAN_CFG_DST_BURST(dst_burst) |
> +	if (!(BIT(src_addr_width) & sdev->slave.src_addr_widths))
> +		return -EINVAL;
> +	if (!(BIT(dst_addr_width) & sdev->slave.dst_addr_widths))
> +		return -EINVAL;
> +	if (!(BIT(src_maxburst) & supported_burst_length))
> +		return -EINVAL;
> +	if (!(BIT(dst_maxburst) & supported_burst_length))
> +		return -EINVAL;
> +
> +	src_width = convert_buswidth(src_addr_width);
> +	dst_width = convert_buswidth(dst_addr_width);
> +	dst_burst = convert_burst(dst_maxburst);
> +	src_burst = convert_burst(src_maxburst);

I'm not sure what you're trying to do here. Could you split your patch
by logical change, this doesn't seem related to just supporting the
H3, but a heavier refactoring.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/4a467528/attachment.sig>
