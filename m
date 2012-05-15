From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 17:00:07 +0100
Subject: [PATCH] MTD: LPC32xx MLC NAND driver
In-Reply-To: <4FB27B24.3030604@antcom.de>
References: <1337091832-10138-1-git-send-email-stigge@antcom.de>
 <20120515143428.GC13860@n2100.arm.linux.org.uk> <4FB27B24.3030604@antcom.de>
Message-ID: <20120515160006.GF13860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 05:49:56PM +0200, Roland Stigge wrote:
> On 05/15/2012 04:34 PM, Russell King - ARM Linux wrote:
> > On Tue, May 15, 2012 at 04:23:52PM +0200, Roland Stigge wrote:
> >> +static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
> >> +			    void *mem, int len, enum dma_transfer_direction dir)
> >> +{
> >> +	struct nand_chip *chip = mtd->priv;
> >> +	struct lpc32xx_nand_host *host = chip->priv;
> >> +	struct dma_async_tx_descriptor *desc;
> >> +	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> >> +	int res;
> >> +	dma_cookie_t cookie;
> >> +
> >> +	host->dma_slave_config.direction = dir;
> >> +	host->dma_slave_config.src_addr = dma;
> >> +	host->dma_slave_config.dst_addr = dma;
> >> +	if (dmaengine_slave_config(host->dma_chan, &host->dma_slave_config)) {
> >> +		dev_err(mtd->dev.parent, "Failed to setup DMA slave\n");
> >> +		return -ENXIO;
> >> +	}
> > 
> > The 'direction' argument should be ignored by all modern DMA engine
> > drivers
> 
> Good - this way, I can move dmaengine_slave_config() to the dma_setup()
> function, i.e., to probe().
> 
> However, I needed to set it there to some initial value (e.g., DMA_DEV_TO_MEM) -
> otherwise the amba-pl08x driver didn't accept it. Is this a bug in the pl08x
> driver?

At some point, pl08x should lose all checking on that...  It should select
the parameters from the DMA slave config at prepare time instead.

> Can we remove the .direction element from the struct dma_slave_config to
> prevent others from making the same mistakes? Or is it useful for sth.
> else still?

That's the intention, but as yet there's been little effort in terms of
patches.  It requires co-operation from all the folk with DMA engine
drivers to sort their stuff out as well...

> >> +
> >> +	sg_init_one(&host->sgl, mem, len);
> >> +
> >> +	res = dma_map_sg(host->dma_chan->device->dev, &host->sgl, 1, dir);
> > 
> > Also note that dma transfer directions and dma data directions are
> > different things.  You shouldn't mix the two.
> 
> Thanks for pointing this out - I wasn't aware that the distinction between the
> two is so important. Also consider e.g.:
> 
> arch/arm/mm/dma-mapping.c:
> /**
>  * dma_map_sg - map a set of SG buffers for streaming mode DMA
>  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
>  * @sg: list of buffers
>  * @nents: number of buffers to map 
>  * @dir: DMA transfer direction
>          ^^^^^^^^^^^^^^^^^^^^^^

This pre-dates DMA engine renaming their 'dma_data_direction' to
'dma_transfer_direction', and it's really unfortunate that it now causes
confusion.

The key thing is the enum type, not the comments.
