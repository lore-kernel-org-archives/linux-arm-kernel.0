From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 19:22:59 +0800
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <20140910102105.GR2601@sirena.org.uk>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <20140910102105.GR2601@sirena.org.uk>
Message-ID: <20140910112258.GA30794@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 11:21:05AM +0100, Mark Brown wrote:
> On Wed, Sep 10, 2014 at 09:30:04AM +0800, Robin Gong wrote:
> 
> > +static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
> > +			 struct spi_transfer *transfer)
> > +{
> > +	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
> > +
> > +	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->rx_wml)
> > +	    && (transfer->len > spi_imx->tx_wml))
> > +		spi_imx->usedma = true;
> > +	else
> > +		spi_imx->usedma = false;
> > +
> > +	return spi_imx->usedma;
> > +}
> 
> This isn't going to work, anything that looks at the usedma flag will
> see the result of the last thing that was checked which may or may not
> be the transfer that it's handling.  The driver should check to see if
> the core mapped the transfer for DMA.
Yes, you're right. I should use "transfer->tx_sg->sgl == NULL" or
"transfer->rx_sg->sgl == NULL" instead of usedma flag in driver, right?
