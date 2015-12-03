From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Dec 2015 16:38:29 +0100
Subject: [PATCH 4/4] dmaengine: edma: Add support for DMA filter mapping
 to slave devices
In-Reply-To: <1449153192-9082-5-git-send-email-peter.ujfalusi@ti.com>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
 <1449153192-9082-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <2675730.x1sS4Fa4y8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 16:33:12 Peter Ujfalusi wrote:
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 0675e268d577..46b305ea0d21 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -2297,6 +2297,12 @@ static int edma_probe(struct platform_device *pdev)
>                 edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
>         }
>  
> +       if (info->slave_map) {
> +               ecc->dma_slave.filter_map.map = info->slave_map;
> +               ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
> +               ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
> +       }
> +
> 

Just a minor comment here: I think all three assignments can be done
unconditionally. As I mentioned before, I'd also remove 'struct dma_filter'
and put the three members in struct dma_device directly. In fact, the
filter function can go with the other function pointers for consistency.

	Arnd
