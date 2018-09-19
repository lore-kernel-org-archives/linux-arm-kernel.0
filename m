From: leilk.liu@mediatek.com (lei liu)
Date: Wed, 19 Sep 2018 13:50:05 +0800
Subject: [PATCH v3 2/3] spis: mediatek: add spi slave for Mediatek MT2712
In-Reply-To: <20180918163048.GN2471@sirena.org.uk>
References: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
 <1537150762-7072-3-git-send-email-leilk.liu@mediatek.com>
 <20180918163048.GN2471@sirena.org.uk>
Message-ID: <1537336205.27607.23.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
  Thanks for your comments.

On Tue, 2018-09-18 at 09:30 -0700, Mark Brown wrote:
> On Mon, Sep 17, 2018 at 10:19:21AM +0800, Leilk Liu wrote:
> 
> This looks overall pretty good, a few smallish comments below:
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
> 
OK, I'll fix it, thanks.

> >  if SPI_SLAVE
> > +config SPI_SLAVE_MT27XX
> > +	tristate "MediaTek SPI slave device"
> > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > +	help
> > +	  This selects the MediaTek(R) SPI slave device driver.
> > +	  If you want to use MediaTek(R) SPI slave interface,
> > +	  say Y or M here.If you are not sure, say N.
> > +	  SPI slave drivers for Mediatek MT27XX series ARM SoCs.
> >  
> >  config SPI_SLAVE_TIME
> 
> This is a driver not a slave implementation, it should be with the other
> drivers in the Kconfig.  The slave implementations are for the
> functionality that uses the drivers, not the drivers themselves.
> 
OK, I'll fix it, thanks.

> > +	/* set the tx/rx endian */
> > +#ifdef __LITTLE_ENDIAN
> > +	reg_val &= ~SPIS_TX_ENDIAN;
> > +	reg_val &= ~SPIS_RX_ENDIAN;
> > +#else
> > +	reg_val |= SPIS_TX_ENDIAN;
> > +	reg_val |= SPIS_RX_ENDIAN;
> > +#endif
> > +	writel(reg_val, mdata->base + SPIS_CFG_REG);
> 
> This seems weird - it looks like it's changing the endianess of the
> protocol based on the endianness the processor is running in.  What's
> going on here?  I'd expect the driver to be just treating everything as
> a byte stream and letting the protocol driver handle the endianness
> issues, otherwise we might end up with double converions.
> 
OK, I'll set the endian of SPI the same with the processor. Thanks.

> > +		xfer->tx_dma = dma_map_single(dev, (void *)xfer->tx_buf,
> > +					      xfer->len, DMA_TO_DEVICE);
> 
> Why is there a cast to void here?  That's usually a sign that there's a
> type safety issue, the whole point with void is that it's compatible
> with any other pointer.
> 
tx_buf is a const void*, here it need a void * for the dma mapping.
And I'll remove void * from dma_map_single((void *)rx_buf).
Thanks.

> > +static irqreturn_t mtk_spi_slave_interrupt(int irq, void *dev_id)
> > +{
> > +	struct spi_controller *ctlr = dev_id;
> > +	struct mtk_spi_slave *mdata = spi_controller_get_devdata(ctlr);
> > +	struct spi_transfer *trans = mdata->cur_transfer;
> > +	u32 int_status, reg_val, cnt, remainder;
> > +
> > +	int_status = readl(mdata->base + SPIS_IRQ_ST_REG);
> > +	writel(int_status, mdata->base + SPIS_IRQ_CLR_REG);
> > +
> > +	if (!trans)
> > +		return IRQ_HANDLED;
> 
> Are you sure that this is the right thing to do if we get a spurious
> interrupt - the normal thing would be to return IRQ_NONE, possibly
> logging a warning as well?
> 
OK, it should reture IRQ_NONE here, thanks.

> > +	if (int_status & CMD_INVALID_ST)
> > +		dev_err(&ctlr->dev, "cmd invalid\n");
> 
> If there's an interrupt that doesn't have any of the interrupt status
> flags set I'd expect to see a warning and probably IRQ_NONE being
> returned.  That way if the interrupt line is shared we work correctly
> and if something goes wrong and the interrupt gets stuck on then the
> core interrupt code's error handling can kick in.
OK, I'll fix it, thanks.
