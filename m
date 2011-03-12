From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Mar 2011 09:57:08 +0000
Subject: [PATCH 02/10] ux500: Adding new board files for snowball.
In-Reply-To: <201103121050.00140.arnd@arndb.de>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-3-git-send-email-mathieu.poirier@linaro.org>
	<201103121050.00140.arnd@arndb.de>
Message-ID: <20110312095708.GA739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2011 at 10:50:00AM +0100, Arnd Bergmann wrote:
> The patch looks good. One question though:
> 
> > +
> > +static struct pl022_ssp_controller ssp0_platform_data = {
> > +	.bus_id = 0,
> > +#ifdef CONFIG_STE_DMA40
> > +	.enable_dma = 1,
> > +	.dma_filter = stedma40_filter,
> > +	.dma_rx_param = &ssp0_dma_cfg_rx,
> > +	.dma_tx_param = &ssp0_dma_cfg_tx,
> > +#else
> > +	.enable_dma = 0,
> > +#endif
> > +	/* on this platform, gpio 31,142,144,214 &
> > +	 * 224 are connected as chip selects
> > +	 */
> > +	.num_chipselect = 5,
> > +};
> 
> You have a lot of #ifdef CONFIG_STE_DMA40. Is that something
> that realistically would be disabled for many users?
> 
> If not, you could simply "select STE_DMA40" from the board
> Kconfig symbol and make all these unconditional.

Or have the PL022 driver treat failure to claim DMA as a soft failure and
fall back to PIO - and get rid of the .enable_dma thing - which is what
other primecell drivers do.  That way you can keep the initializers there
and leave it to the driver to sort out whether it wants to use DMA or not
depending on whether all the bits are available.
