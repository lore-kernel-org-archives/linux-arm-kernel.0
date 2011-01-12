From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Jan 2011 14:13:32 +0100
Subject: [PATCH] mxcmmc: use dmaengine API
In-Reply-To: <20110112102632.GX11039@n2100.arm.linux.org.uk>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
	<1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
	<20110112102632.GX11039@n2100.arm.linux.org.uk>
Message-ID: <20110112131332.GW12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 10:26:32AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 12, 2011 at 11:09:56AM +0100, Sascha Hauer wrote:
> > +	host->dma_nents = dma_map_sg(mmc_dev(host->mmc), data->sg,
> > +				     data->sg_len,  host->dma_dir);
> 
> As recently discussed, you don't need to save dma_nents - the value to
> be passed to dma_unmap_sg() is data->sg_len, not host->dma_nents.
> 
> You should also do the map/unmap against the DMA engine device (which
> is the device actually doing DMA) rather than the peripheral (which is
> only the recipient of DMA).  The reason is - while the peripheral can
> see the DMA controller, the peripheral may be able to see all RAM but
> the DMA controller may have an IOMMU or limited view of RAM.

ok.

> 
> > +static int mxcmci_setup_dma(struct mmc_host *mmc)
> > +{
> > +	struct mxcmci_host *host = mmc_priv(mmc);
> > +	struct dma_slave_config *config = &host->dma_slave_config;
> > +
> > +	config->direction = DMA_FROM_DEVICE;
> 
> I would like to get some concensus on removing config->direction from
> the slave configuration entirely - and make all the fields below
> refer purely to the peripheral device parameters.  At the moment,
> the API allows them to be used ambiguously.

OK, I can remove this as it's unused by the dma driver anyway (and in
fact I wondered what purpose this field has while writing the dma
drivers)

> 
> > @@ -794,7 +823,7 @@ static int mxcmci_probe(struct platform_device *pdev)
> >  	mmc->max_blk_size = 2048;
> >  	mmc->max_blk_count = 65535;
> >  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
> > -	mmc->max_seg_size = mmc->max_req_size;
> > +	mmc->max_seg_size = 65535;
> 
> You can get this from the DMA parameters for the DMA engine device:
> 
> 	mmc->max_seg_size = dma_get_max_seg_size(dev);
> 
> where 'dev' is the DMA engine struct device - chan->dma_device->dev.

I prepared a patch to set the segment size in the i.MX DMA drivers.

> 
> Also just spotted this left in your patch:
> > +	if (!mxcmci_use_dma(host))
> > +		return 0;
> > +
> >  	for_each_sg(data->sg, sg, data->sg_len, i) {
> >  		if (sg->offset & 3 || sg->length & 3) {
> > 			host->do_dma = 0;
> 
> Shouldn't this be a decision made by the DMA engine rather than the
> driver?  Having looked at the MMCI code also doing this, I think this
> should cause prep_slave_sg() to return NULL if it can't handle the
> scatterlist.  On MMCI, we fall back to PIO if prep_slave_sg() returns
> NULL.

I prepared a patch which checks for invalid addresses and lengths in the
DMA drivers.

I'd like to push this patch like it is until the two points above are
solved upstream (with the other points fixed of course).

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
