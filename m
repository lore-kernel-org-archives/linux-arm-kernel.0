From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Feb 2012 12:40:14 -0700
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120209152340.GB11249@ponder.secretlab.ca>
 <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
Message-ID: <20120213194014.GG11077@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 05:06:15AM +0000, Barry Song wrote:
> Hi Grant,
> > > +
> > > +struct sirfsoc_spi {
> > > +	struct spi_bitbang bitbang;
> > > +	struct completion done;
> > > +
> > > +	u32 irq;
> > 
> > irq is set once and never used outside the probe function.  Doesn't need
> > to be here.
> 
> ok
> > 
> > > +	void __iomem *base;
> > > +	u32 ctrl_freq;  /* SPI controller clock speed */
> > > +	struct clk *clk;
> > > +	int bus_num;
> > 
> > bus_num is unused
> 
> Ok.
> 
> > > +
> > > +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
> > > +{
> > > +	struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
> > > +
> > > +	/* Fill Tx FIFO while there are left words to be transmitted */
> > > +	while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
> > > +			SIRFSOC_SPI_FIFO_FULL)) &&
> > > +			sspi->left_tx_cnt)
> > > +		sspi->tx_word(sspi);
> > 
> > Potential problem: if for any reason the device stalls and the FULL bit
> > doesn't get cleared, then this function will be stuck in a tight loop.  This
> > may not be an issue, but it should be considered.
> 
> Might timeout check.
> 
> > > +
> > > +static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
> > > +{
> > > +	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
> > > +	struct sirfsoc_spi_ctrldata *ctl_data = spi->controller_data;
> > 
> > Where does controller_data come from?  It is not set in the driver, and it is
> > *not* something that the spi_device driver or the board code is allowed to set.
> > 
> > If the driver needs controller_data, then it needs to be added to each spi
> > device by the spi controller driver when the slave device is registered.
> > 
> The controller_data is mainly for various kinds of chip selection. We might have a CS pin, a GPIO from prima2, or a GPIO from an extended MCU side by side with prima2.
> It seems like you think this driver should handle all different kinds of chip selection support and implement those callbacks in it? And every spi client use DT to describe the CS pin?

What I am saying is that controller_data should not be prepopulated at
spi_device registration time.  That pointer is 'owned' by the spi controller
and if it is used, should be set by the spi_master.

If the spi_master needs a controller_data pointer, then that data should
either be passed to the spi_master via the spi_master's platform_data, or it
should be decoded from the device tree.  In either case, it is the
responsibility of the spi_master driver to set the value of controller_data
for each of its spi_device children.

Does that make sense?

g.
