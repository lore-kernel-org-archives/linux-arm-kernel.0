From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 14:59:17 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <Pine.LNX.4.64.1306071214200.11277@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <1370008605-3745603-2-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.64.1306071214200.11277@axis700.grange>
Message-ID: <2024464.67s93nOUnz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 12:22:15 Guennadi Liakhovetski wrote:

> >  arch/arm/mach-shmobile/board-ag5evm.c          |  4 ++--
> >  arch/arm/mach-shmobile/board-ap4evb.c          |  8 ++++----
> >  arch/arm/mach-shmobile/board-armadillo800eva.c |  8 ++++----
> >  arch/arm/mach-shmobile/board-kzm9g.c           |  8 ++++----
> >  arch/arm/mach-shmobile/board-mackerel.c        | 12 ++++++------
> >  drivers/mmc/host/sh_mobile_sdhi.c              | 20 +++-----------------
> >  drivers/mmc/host/tmio_mmc_dma.c                |  6 ++----
> >  include/linux/mfd/tmio.h                       |  2 --
> >  include/linux/mmc/sh_mobile_sdhi.h             |  5 +++--
> >  9 files changed, 28 insertions(+), 45 deletions(-)
> 
> Aren't you forgetting about arch/sh?

Right, sorry about that. I was assuming that sh_mobile_sdhi is only used on
ARM, which was clearly incorrect.

> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> > index 47bdb8f..caad28e 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -290,8 +290,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
> >  		if (!host->chan_tx)
> >  			return;
> >  
> > -		if (pdata->dma->chan_priv_tx)
> > -			cfg.slave_id = pdata->dma->slave_id_tx;
> > +		cfg.slave_id = 0; /* already set */
> >  		cfg.direction = DMA_MEM_TO_DEV;
> >  		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
> >  		cfg.src_addr = 0;
> > @@ -308,8 +307,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
> >  		if (!host->chan_rx)
> >  			goto ereqrx;
> >  
> > -		if (pdata->dma->chan_priv_rx)
> > -			cfg.slave_id = pdata->dma->slave_id_rx;
> > +		cfg.slave_id = 0;
> 
> slave_id is needed for the DMAC driver to configure slave DMA. And this 
> _is_ the current mainstreem method (in the non-DT case) to configure slave 
> DMA, AFAIK. In the non-DT case the filter function is used to verify, 
> whether this slave can be served with this channel, and 
> dmaengine_slave_config() is used to actually configure the channel for 
> slave DMA.

I think that is a flaw in the dmaengine driver. I don't actually know how
any dma-engine driver could use dmaengine_slave_config to pick the request
line, since that is something the driver should not know at the time
it calls dmaengine_slave_config().

It's probably best to change the shdma driver to just ignore the slave_id
value in slave_config, like most other drivers to. I don't see how that
could possibly work when used from a portable slave driver.

	Arnd
