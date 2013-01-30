From: bhutchings@solarflare.com (Ben Hutchings)
Date: Wed, 30 Jan 2013 01:34:07 +0000
Subject: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <51086A17.1090707@gmail.com>
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <20744.25884.660535.514911@pilspetsen.it.uu.se>
 <51086A17.1090707@gmail.com>
Message-ID: <1359509647.4144.36.camel@bwh-desktop.uk.solarflarecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 19:32 -0500, Xi Wang wrote:
> On 1/29/13 7:11 PM, Mikael Pettersson wrote:
> > A git bisect identified the following as the culprit:
> > 
> >   > From 1a4901177574083c35fafc24c4d151c2a7c7647c Mon Sep 17 00:00:00 2001
> >   > From: Xi Wang <xi.wang@gmail.com>
> >   > Date: Sat, 17 Nov 2012 20:25:09 +0000
> >   > Subject: [PATCH] ixp4xx_eth: avoid calling dma_pool_create() with NULL dev
> >   >
> >   > Use &port->netdev->dev instead of NULL since dma_pool_create() doesn't
> >   > allow NULL dev.
> >   >
> >   > Signed-off-by: Xi Wang <xi.wang@gmail.com>
> >   > Cc: Andrew Morton <akpm@linux-foundation.org>
> >   > Signed-off-by: David S. Miller <davem@davemloft.net>
> >   > ---
> >   >  drivers/net/ethernet/xscale/ixp4xx_eth.c |    8 +++++---
> >   >  1 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > Reverting this unbreaks ixp4xx_eth on my ixp4xx machine with kernels
> > 3.7.0 and 3.8-rc5.
> 
> Thanks.  The problem was that in init_queues(), the dma_pool_create()
> call requires a non-null dev.
> 
>   dma_pool = dma_pool_create(DRV_NAME, ??, ...);
> 
> What do you think would work here?

For DMA purposes I would expect the right device to be the parent bus
device, i.e. port->netdev->dev.parent.  The driver might also need to
set its DMA masks.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
