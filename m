From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 05:34:19 +0000
Subject: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
In-Reply-To: <20180710152912.GE3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180710152912.GE3219@vkoul-mobl>
Message-ID: <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Robin,
> 
> On 11-07-18, 00:23, Robin Gong wrote:
> > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > '0xffff'.
> 
> latter part should be its own patch. Never mix things
Okay, I will split it even for this minor change.
> 
> > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > +	struct sdma_engine *sdma = sdmac->sdma;
> > +	int channel = sdmac->channel;
> > +	size_t count;
> > +	int i = 0, param;
> > +	struct sdma_buffer_descriptor *bd;
> > +	struct sdma_desc *desc;
> > +
> > +	if (!chan || !len)
> > +		return NULL;
> > +
> > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> > +		&dma_src, &dma_dst, len, channel);
> > +
> > +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len /
> SDMA_BD_MAX_CNT
> > +					+ 1);
> 
> this looks quite odd to read consider:
> 
>         esc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
>                                  len / SDMA_BD_MAX_CNT + 1);
> 
Okay, will fix on v2.
> > +	if (!desc)
> > +		goto err_out;
> > +
> > +	do {
> > +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);
> > +		bd = &desc->bd[i];
> > +		bd->buffer_addr = dma_src;
> > +		bd->ext_buffer_addr = dma_dst;
> > +		bd->mode.count = count;
> > +		desc->chn_count += count;
> > +
> > +		switch (sdmac->word_size) {
> > +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> 
> This looks wrong, we are in memcpy, there is no SLAVE so no SLAVE widths..
> 
Okay, will remove check bus width.
> >  static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
> >  		struct dma_chan *chan, struct scatterlist *sgl,
> >  		unsigned int sg_len, enum dma_transfer_direction direction, @@
> > -1344,9 +1431,9 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_slave_sg(
> >
> >  		count = sg_dma_len(sg);
> >
> > -		if (count > 0xffff) {
> > +		if (count > SDMA_BD_MAX_CNT) {
> >  			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg
> entry exceeded: %d > %d\n",
> > -					channel, count, 0xffff);
> > +					channel, count, SDMA_BD_MAX_CNT);
> 
> these changes dont belong to this patch
Will split in v2.
> 
> > @@ -1486,6 +1573,8 @@ static int sdma_config(struct dma_chan *chan,
> >  		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16)
> &
> >  			SDMA_WATERMARK_LEVEL_HWML;
> >  		sdmac->word_size = dmaengine_cfg->dst_addr_width;
> > +	} else if (dmaengine_cfg->direction == DMA_MEM_TO_MEM) {
> > +		sdmac->word_size = dmaengine_cfg->dst_addr_width;
> 
> same here too, we are in .device_config which deals with slave. Not memcpy!
Will remove it.
> 
> >  	} else {
> >  		sdmac->per_address = dmaengine_cfg->dst_addr;
> >  		sdmac->watermark_level = dmaengine_cfg->dst_maxburst * @@
> -1902,6
> > +1991,7 @@ static int sdma_probe(struct platform_device *pdev)
> >
> >  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
> >  	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
> >
> >  	INIT_LIST_HEAD(&sdma->dma_device.channels);
> >  	/* Initialize channel parameters */
> > @@ -1968,9 +2058,11 @@ static int sdma_probe(struct platform_device
> *pdev)
> >  	sdma->dma_device.dst_addr_widths = SDMA_DMA_BUSWIDTHS;
> >  	sdma->dma_device.directions = SDMA_DMA_DIRECTIONS;
> >  	sdma->dma_device.residue_granularity =
> > DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
> >  	sdma->dma_device.device_issue_pending = sdma_issue_pending;
> >  	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
> > -	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
> > +	sdma->dma_device.copy_align = DMAENGINE_ALIGN_4_BYTES;
> > +	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
> 
> this line should not be part of this patch
> 
> --
> ~Vinod
