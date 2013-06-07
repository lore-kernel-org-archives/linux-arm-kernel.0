From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 7 Jun 2013 15:01:45 +0200 (CEST)
Subject: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform
 code
In-Reply-To: <5005140.iWFVfXL6XN@wuerfel>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.64.1306071222250.11277@axis700.grange>
 <5005140.iWFVfXL6XN@wuerfel>
Message-ID: <Pine.LNX.4.64.1306071455300.11277@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Arnd Bergmann wrote:

> On Friday 07 June 2013 12:25:11 Guennadi Liakhovetski wrote:
> > >  /* SDHI0 */
> > >  static struct sh_mobile_sdhi_info sdhi0_info = {
> > > +#ifdef CONFIG_SH_DMAE_BASE
> > 
> > Right, that's the problem, I think. Don't think we want these #ifdefs in 
> > all shdma users - under arch/arm and arch/sh. That's why I think we need 
> > my fix in the first place to fix the compile breakage. After that we can 
> > think about improving DMA slave driver decoupling from specific DMAC 
> > drivers - if at all needed.
> > 
> > >       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> > >       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> > > +     .dma_filter     = shdma_chan_filter,
> > > +#endif
> 
> Well, the problem is that you check the value of dma_slave_rx/tx in order
> to find out whether you should do DMA in the driver. If the filter
> function is NULL but the values are positive, I think the driver won't
> actually fall back to PIO mode but just fail.

So far the tmio_mmc_request_dma() function has only one caller - SDHI. 
Even worse - tmio_mmc_dma.o is only built for SDHI. With SDHI the filter 
function cannot be NULL, it is hard-coded. When we change that, then we'll 
take care of the problem. So far we just have to fix the breakage.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
