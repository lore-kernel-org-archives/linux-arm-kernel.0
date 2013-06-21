From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 00:14:16 +0200
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <CAD=GYpY4koXd9f6_ijQfDHsiULD4d53cdu=9X421WXSAit_YQg@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306212044.26677.arnd@arndb.de>
 <CAD=GYpY4koXd9f6_ijQfDHsiULD4d53cdu=9X421WXSAit_YQg@mail.gmail.com>
Message-ID: <201306220014.16427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> Hi Arnd,
> 
> On Fri, Jun 21, 2013 at 1:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 21 June 2013, Joel A Fernandes wrote:
> >> I think we are talking about different things, I agree the 'select
> >> DMADEVICES' can be dropped but lets please keep the default y option
> >> (not adding new select statements, just saying that if someone select
> >> DMADEVICES in menuconfig and if they're ARCH_OMAP=1 , then default to
> >> EDMA). This will simply allow people to have a default. Thanks.
> >
> > Yes, that's ok.
> 
> Ok, thanks. I will follow up with a patch in my next submissions that builds it.
> 
> Perhaps a:
> default y if 'ARCH_OMAP2PLUS'
> 
> and leave the existing as it is...
> default n if  'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2'
> 
> would make most sense to me. Basically EDMA is seen on current and all
> new OMAP2PLUS.

Ok

> > config TI_EDMA
> >         tristate "TI EDMA support"
> >         default m if 'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2
> >         select DMA_ENGINE
> >         select DMA_VIRTUAL_CHANNELS
> 
> 
> MMC depends on EDMA specially on AM33xx there's no PIO mode AFAIK. The
> 'm' option will require some initramfs to load the module when needing
> to MMC boot, I suggest lets leave it as y.
> 

Ah, right: you still export a filter function from the edma driver
and use it in slave drivers:

drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
drivers/spi/spi-davinci.c:      dspi->dma_rx = dma_request_channel(mask, edma_filter_fn,
drivers/spi/spi-davinci.c:      dspi->dma_tx = dma_request_channel(mask, edma_filter_fn,

As long as this is the case, you have to be careful with the dependencies
to make sure that davinci_mmc and spi-davinci either depend on TI_EDMA, or
edma_filter_fn gets defined to NULL when you are building for a DT-only platform.

	Arnd
