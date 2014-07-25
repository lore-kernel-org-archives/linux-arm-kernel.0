From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 25 Jul 2014 11:22:49 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <5574058.fMy2hcvT92@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <20140724140620.GP1857@lahna.fi.intel.com>
 <20140725071138.GU1857@lahna.fi.intel.com>
 <5574058.fMy2hcvT92@wuerfel>
Message-ID: <20140725082249.GX1857@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 09:58:42AM +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 10:11:38 Mika Westerberg wrote:
> > On Thu, Jul 24, 2014 at 05:06:20PM +0300, Mika Westerberg wrote:
> > > > On a related note, there seems to be a bug in this driver, which
> > > > attempts to set the slave_id through dmaengine_slave_config(), which
> > > > is wrong in both cases, ACPI and filter functions.
> > > 
> > > Good point. We will fix this, thanks.
> > 
> > I take that back. How we are supposed to set the slave_id if we don't
> > have request line information available (from ACPI or DT)?
> 
> If you don't have the request line information, you are screwed and you
> can't set it from either the filter function or slave_config.
> 
> However, it looks like you do have it, at least this is what the
> code tells me:
> 
> static struct pxa_spi_info spi_info_configs[] = {
>         [PORT_CE4100] = {
> 		...
>         },
>         [PORT_BYT] = {
>                 .type = LPSS_SSP,
>                 .port_id = 0,
>                 .num_chipselect = 1,
>                 .tx_slave_id = 0,
>                 .tx_chan_id = 0,
>                 .rx_slave_id = 1,
>                 .rx_chan_id = 1,
>         },
> };

That's right we do have it.

> All you need to do is change your filter function to take the
> slave id from pxa_spi_info and stick it in there, e.g.
> 
> static bool pxa2xx_spi_dw_dma_filter(struct dma_chan *chan, void *param)
> {       
>         const struct pxa2xx_spi_master *pdata = param;
>         struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
>         
>         dwc->request_line = fargs->req;
>         dwc->src_master = 0;
>         dwc->dst_master = 0;
>         
>         return 1;
> }           

Oh man. That makes pxa2xx_spi dependent on a certain specific DMA engine
driver.

> Note that the filter function by definition is specific to the dma
> controller, not the dma slave (that's why most people define it in
> the dmaengine driver), and the pxa2xx_spi_dma_filter() function used
> in spi-pxa2xx-dma.c looks like it was written for another dma engine:

I wonder what's the rationale that passing slave_id with
dma_slave_config is wrong? The current code works fine with that and is
is independent of the DMA engine driver (even though we know that it is
going to be dw-dma).

The dw-dma handles slave_id in its implementation of
dmaengine_slave_config().
