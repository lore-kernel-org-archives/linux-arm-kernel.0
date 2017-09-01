From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Fri, 1 Sep 2017 05:04:54 +0200
Subject: [PATCH 1/3] dmaengine: sun6i: Correct DMA support on H3
In-Reply-To: <20170831145135.c6a2wubcf6xu34tz@flea.lan>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
 <20170830233609.13855-2-stefan.bruens@rwth-aachen.de>
 <20170831145135.c6a2wubcf6xu34tz@flea.lan>
Message-ID: <a649f98d4ac44abc873c5110ce9363e5@rwthex-w2-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Donnerstag, 31. August 2017 16:51:35 CEST Maxime Ripard wrote:
> Hi,
> 
> On Thu, Aug 31, 2017 at 01:36:07AM +0200, Stefan Br?ns wrote:
> > +/* Between SoC generations, there are some significant differences:
> > + * - A23 added a clock gate register
> > + * - the H3 burst length field has a different offset
> > + */
> 
> This is not the proper comment style.
> 
> > +enum dmac_variant {
> > +	DMAC_VARIANT_A31,
> > +	DMAC_VARIANT_A23,
> > +	DMAC_VARIANT_H3,
> > +};
> > +
> 
> And this is redundant with what we already have in our structures.

Actually, its not. For H3, there are currently at least 3 register compatible 
SoCs: H5 is identical, R40 has 16 dma channels, A64 has 8 channels. So if the 
current config structure is kept, we need 3 different compatible strings. Same 
for the A23, which is register compatible to e.g. A83t and V3s, but with 
different numbers of DMA channels.

So either you decorate the code with a cascade of

if ((of_is_compatible(..A23..) || of_is_compatible(..A83T..) || ...) {
} else if ((of_is_compatible(..H3..) || of_is_compatible(..A64..) || ...) {
} else { /* A31 */
}

in a number of places, or you do it just once.

> 
> >  /*
> >  
> >   * Hardware channels / ports representation
> >   *
> > 
> > @@ -101,6 +116,7 @@ struct sun6i_dma_config {
> > 
> >  	u32 nr_max_channels;
> >  	u32 nr_max_requests;
> >  	u32 nr_max_vchans;
> > 
> > +	enum dmac_variant dmac_variant;
> > 
> >  };
> >  
> >  /*
> > 
> > @@ -240,8 +256,12 @@ static inline s8 convert_burst(u32 maxburst)
> > 
> >  	switch (maxburst) {
> >  	
> >  	case 1:
> >  		return 0;
> > 
> > +	case 4:
> > +		return 1;
> > 
> >  	case 8:
> >  		return 2;
> > 
> > +	case 16:
> > +		return 3;
> > 
> >  	default:
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > @@ -249,11 +269,7 @@ static inline s8 convert_burst(u32 maxburst)
> > 
> >  static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
> >  {
> > 
> > -	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
> > -	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
> > -		return -EINVAL;
> > -
> > -	return addr_width >> 1;
> > +	return ilog2(addr_width);
> > 
> >  }
> 
> This isn't really the same operation. There should be some explanation
> about why it's the right thing to do.

For 1, 2 and 4 it is the same. The correct register value for 8 bytes, 
supported by H3, H5, A64 and R40, is 3.

> 
> >  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> > 
> > @@ -499,45 +515,58 @@ static int set_config(struct sun6i_dma_dev *sdev,
> > 
> >  			enum dma_transfer_direction direction,
> >  			u32 *p_cfg)
> >  
> >  {
> > 
> > +	enum dma_slave_buswidth src_addr_width, dst_addr_width;
> > +	u32 src_maxburst, dst_maxburst, supported_burst_length;
> > 
> >  	s8 src_width, dst_width, src_burst, dst_burst;
> > 
> > +	src_addr_width = sconfig->src_addr_width;
> > +	dst_addr_width = sconfig->dst_addr_width;
> > +	src_maxburst = sconfig->src_maxburst;
> > +	dst_maxburst = sconfig->dst_maxburst;
> > +
> > +	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3)
> > +		supported_burst_length = BIT(1) | BIT(4) | BIT(8) | BIT(16);
> > +	else
> > +		supported_burst_length = BIT(1) | BIT(8);
> 
> This could be stored in the structure for example.

Which one? sun6i_dma_dev? sun6i_dma_config?
 
> >  	switch (direction) {
> > 
> >  	case DMA_MEM_TO_DEV:
> > -		src_burst = convert_burst(sconfig->src_maxburst ?
> > -					sconfig->src_maxburst : 8);
> > -		src_width = convert_buswidth(sconfig->src_addr_width !=
> > -						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> > -				sconfig->src_addr_width :
> > -				DMA_SLAVE_BUSWIDTH_4_BYTES);
> > -		dst_burst = convert_burst(sconfig->dst_maxburst);
> > -		dst_width = convert_buswidth(sconfig->dst_addr_width);
> > +		if (src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > +			src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +		src_maxburst = src_maxburst ? src_maxburst : 8;
> > 
> >  		break;
> >  	
> >  	case DMA_DEV_TO_MEM:
> > -		src_burst = convert_burst(sconfig->src_maxburst);
> > -		src_width = convert_buswidth(sconfig->src_addr_width);
> > -		dst_burst = convert_burst(sconfig->dst_maxburst ?
> > -					sconfig->dst_maxburst : 8);
> > -		dst_width = convert_buswidth(sconfig->dst_addr_width !=
> > -						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
> > -				sconfig->dst_addr_width :
> > -				DMA_SLAVE_BUSWIDTH_4_BYTES);
> > +		if (dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > +			dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +		dst_maxburst = dst_maxburst ? dst_maxburst : 8;
> > 
> >  		break;
> >  	
> >  	default:
> >  		return -EINVAL;
> >  	
> >  	}
> > 
> > -	if (src_burst < 0)
> > -		return src_burst;
> > -	if (src_width < 0)
> > -		return src_width;
> > -	if (dst_burst < 0)
> > -		return dst_burst;
> > -	if (dst_width < 0)
> > -		return dst_width;
> > -
> > -	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
> > -		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
> > -		DMA_CHAN_CFG_DST_BURST(dst_burst) |
> > +	if (!(BIT(src_addr_width) & sdev->slave.src_addr_widths))
> > +		return -EINVAL;
> > +	if (!(BIT(dst_addr_width) & sdev->slave.dst_addr_widths))
> > +		return -EINVAL;
> > +	if (!(BIT(src_maxburst) & supported_burst_length))
> > +		return -EINVAL;
> > +	if (!(BIT(dst_maxburst) & supported_burst_length))
> > +		return -EINVAL;
> > +
> > +	src_width = convert_buswidth(src_addr_width);
> > +	dst_width = convert_buswidth(dst_addr_width);
> > +	dst_burst = convert_burst(dst_maxburst);
> > +	src_burst = convert_burst(src_maxburst);
> 
> I'm not sure what you're trying to do here. Could you split your patch
> by logical change, this doesn't seem related to just supporting the
> H3, but a heavier refactoring.

Untangling 3 independent steps - handling of DMA_SLAVE_BUSWIDTH_UNDEFINED, 
range checking, and conversion to register value. As the valid ranges depend 
on the controller, the code is much easier to read if the range check is done 
first, and then the conversion.

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
