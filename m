From: xi.wang@gmail.com (Xi Wang)
Date: Tue, 29 Jan 2013 19:32:23 -0500
Subject: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <20744.25884.660535.514911@pilspetsen.it.uu.se>
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <20744.25884.660535.514911@pilspetsen.it.uu.se>
Message-ID: <51086A17.1090707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/13 7:11 PM, Mikael Pettersson wrote:
> A git bisect identified the following as the culprit:
> 
>   > From 1a4901177574083c35fafc24c4d151c2a7c7647c Mon Sep 17 00:00:00 2001
>   > From: Xi Wang <xi.wang@gmail.com>
>   > Date: Sat, 17 Nov 2012 20:25:09 +0000
>   > Subject: [PATCH] ixp4xx_eth: avoid calling dma_pool_create() with NULL dev
>   >
>   > Use &port->netdev->dev instead of NULL since dma_pool_create() doesn't
>   > allow NULL dev.
>   >
>   > Signed-off-by: Xi Wang <xi.wang@gmail.com>
>   > Cc: Andrew Morton <akpm@linux-foundation.org>
>   > Signed-off-by: David S. Miller <davem@davemloft.net>
>   > ---
>   >  drivers/net/ethernet/xscale/ixp4xx_eth.c |    8 +++++---
>   >  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> Reverting this unbreaks ixp4xx_eth on my ixp4xx machine with kernels
> 3.7.0 and 3.8-rc5.

Thanks.  The problem was that in init_queues(), the dma_pool_create()
call requires a non-null dev.

  dma_pool = dma_pool_create(DRV_NAME, ??, ...);

What do you think would work here?
