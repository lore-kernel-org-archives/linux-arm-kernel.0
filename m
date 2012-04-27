From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Apr 2012 20:03:32 +0100
Subject: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
In-Reply-To: <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
 <CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
Message-ID: <20120427190332.GG28062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 09:00:22PM +0200, Linus Walleij wrote:
> On Mon, Apr 23, 2012 at 6:05 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Add DMA engine support to the OMAP HSMMC driver. ?This supplements the
> > private DMA API implementation contained within this driver, and the
> > driver can be switched at build time between using DMA engine and the
> > private DMA API.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Great,
> 
> > +#if 1
> > + ? ? ? ? ? ? ? sig = host->dma_line_rx;
> > + ? ? ? ? ? ? ? host->rx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > + ? ? ? ? ? ? ? if (!host->rx_chan) {
> > + ? ? ? ? ? ? ? ? ? ? ? dev_warn(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", sig);
> > + ? ? ? ? ? ? ? }
> > +#endif
> > +#if 1
> > + ? ? ? ? ? ? ? sig = host->dma_line_tx;
> > + ? ? ? ? ? ? ? host->tx_chan = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > + ? ? ? ? ? ? ? if (!host->tx_chan) {
> > + ? ? ? ? ? ? ? ? ? ? ? dev_warn(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", sig);
> > + ? ? ? ? ? ? ? }
> > +#endif
> 
> Are these development artifacts?

Read the commit message. ;)

They're there (and removed by the next patch) so that the driver can
be easily switched between DMA engine and the private DMA API.  Simply
change the relevant #if to zero at build time.

I don't think it warrants config symbols or trying to do it via module
params as its just a stepping stone through the process.
