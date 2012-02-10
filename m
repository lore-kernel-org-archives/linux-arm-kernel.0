From: Barry.Song@csr.com (Barry Song)
Date: Fri, 10 Feb 2012 05:06:15 +0000
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <20120209152340.GB11249@ponder.secretlab.ca>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120209152340.GB11249@ponder.secretlab.ca>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E99CB93BC5@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,
> > +
> > +struct sirfsoc_spi {
> > +	struct spi_bitbang bitbang;
> > +	struct completion done;
> > +
> > +	u32 irq;
> 
> irq is set once and never used outside the probe function.  Doesn't need
> to be here.

ok
> 
> > +	void __iomem *base;
> > +	u32 ctrl_freq;  /* SPI controller clock speed */
> > +	struct clk *clk;
> > +	int bus_num;
> 
> bus_num is unused

Ok.

> > +
> > +static void spi_sirfsoc_tasklet_tx(unsigned long arg)
> > +{
> > +	struct sirfsoc_spi *sspi = (struct sirfsoc_spi *)arg;
> > +
> > +	/* Fill Tx FIFO while there are left words to be transmitted */
> > +	while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS) &
> > +			SIRFSOC_SPI_FIFO_FULL)) &&
> > +			sspi->left_tx_cnt)
> > +		sspi->tx_word(sspi);
> 
> Potential problem: if for any reason the device stalls and the FULL bit
> doesn't get cleared, then this function will be stuck in a tight loop.  This
> may not be an issue, but it should be considered.

Might timeout check.

> > +
> > +static void spi_sirfsoc_chipselect(struct spi_device *spi, int value)
> > +{
> > +	struct sirfsoc_spi *sspi = spi_master_get_devdata(spi->master);
> > +	struct sirfsoc_spi_ctrldata *ctl_data = spi->controller_data;
> 
> Where does controller_data come from?  It is not set in the driver, and it is
> *not* something that the spi_device driver or the board code is allowed to set.
> 
> If the driver needs controller_data, then it needs to be added to each spi
> device by the spi controller driver when the slave device is registered.
> 
The controller_data is mainly for various kinds of chip selection. We might have a CS pin, a GPIO from prima2, or a GPIO from an extended MCU side by side with prima2.
It seems like you think this driver should handle all different kinds of chip selection support and implement those callbacks in it? And every spi client use DT to describe the CS pin?

-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
