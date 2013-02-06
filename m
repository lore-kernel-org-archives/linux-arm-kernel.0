From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 6 Feb 2013 15:14:55 -0600
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
In-Reply-To: <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Message-ID: <5112C7CF.7010606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/06/2013 03:03 PM, Jon Hunter wrote:
> If the device-tree blob is present during boot, then register the SDMA
> controller with the device-tree DMA driver so that we can use device-tree
> to look-up DMA client information.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  drivers/dma/omap-dma.c |   31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 5a31264..a32d81b 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -16,6 +16,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  
>  #include "virt-dma.h"
>  
> @@ -67,6 +69,8 @@ static const unsigned es_bytes[] = {
>  	[OMAP_DMA_DATA_TYPE_S32] = 4,
>  };
>  
> +static struct of_dma_filter_info info;
> +
>  static inline struct omap_dmadev *to_omap_dma_dev(struct dma_device *d)
>  {
>  	return container_of(d, struct omap_dmadev, ddev);
> @@ -621,10 +625,25 @@ static int omap_dma_probe(struct platform_device *pdev)
>  		pr_warn("OMAP-DMA: failed to register slave DMA engine device: %d\n",
>  			rc);
>  		omap_dma_free(od);
> +		return rc;
>  	} else {
>  		platform_set_drvdata(pdev, od);
>  	}

I realise now that I could get rid of the else here and just call
platform_set_drvdata(), if we don't return.

Anyway, I will wait for other comments before changing.

Cheers
Jon
