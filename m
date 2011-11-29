From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 29 Nov 2011 15:31:55 +0100
Subject: [PATCH v3] pxa2xx_spi: fix memory corruption
In-Reply-To: <1322575504.7024.0.camel@anarsoul-laptop>
References: <201107101609.31405.anarsoul@gmail.com>
 <201107181056.51782.anarsoul@gmail.com>
 <1322575504.7024.0.camel@anarsoul-laptop>
Message-ID: <201111291531.56138.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, 2011-07-18 at 10:56 +0300, Vasily Khoruzhick wrote:
> > On Friday 15 July 2011 05:53:31 Grant Likely wrote:
> > > On Sun, Jul 10, 2011 at 06:18:19PM +0300, Vasily Khoruzhick wrote:
> > > > pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> > > > at same time via spi_alloc_master(), but then calculates
> > > > null_dma_buf pointer incorrectly, and it causes memory corruption
> > > > later if DMA usage is enabled.
> > > > 
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > ---
> > > > v2: - add u8 __null_dma_buf[16] to the end of driver_data structure
> > > > 
> > > >     and use it as null_dma_buf after alignment.
> > > >     - use PTR_ALIGN instead of ALIGN
> > > > 
> > > > v3: - drop (u8 *) cast, use & operator instead, change array name
> > > > 
> > > >  drivers/spi/pxa2xx_spi.c |    9 +++++----
> > > >  1 files changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> > > > index dc25bee..b25fe27 100644
> > > > --- a/drivers/spi/pxa2xx_spi.c
> > > > +++ b/drivers/spi/pxa2xx_spi.c
> > > > @@ -106,6 +106,7 @@ struct driver_data {
> > > > 
> > > >  	int rx_channel;
> > > >  	int tx_channel;
> > > >  	u32 *null_dma_buf;
> > > > 
> > > > +	u8 null_dma_buf_unaligned[16];
> > > 
> > > Don't dma buffers need to be cache-line aligned?
> > 
> > No, on PXA2xx they need to be 8-bytes aligned (according to PXA27x
> > developer's manual)
> > 
> > > How large is the actual transfer?
> > 
> > Looks like 8 bytes, but I'm not sure, I'm not author of driver and did
> > not dig deeply into its code. Just attempting to fix memory corruption.
> > 
> > > Using the __aligned() or __cacheline_aligned
> > > attribute is the correct way to make sure you've got a data buffer
> > > that can be used for DMA mixed with other stuff.  Then you don't need
> > > to fool around with PTR_ALIGN or anything.
> > 
> > Errr, it can't be applied to struct field, right? But driver needs
> > per-device null_dma_buf (there's 3 SPI controllers on PXA2xx)
> > 
> > > g.
> > 
> > Regards
> > Vasily
> 
> So, any chance to see this patch merged?
> 
> Regards
> Vasily

I have no idea, were all problems addressed ?

M
