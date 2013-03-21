From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 21 Mar 2013 18:23:44 +0530
Subject: [PATCH] dmaengine:sirf:take clock and enable it while probing
In-Reply-To: <1363595623-6887-1-git-send-email-Barry.Song@csr.com>
References: <1363595623-6887-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130321125344.GT10326@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 04:33:43PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> there is hardcode which enabled the clock of dmaengine before,
> this patch takes the clock by standard clock API and enable it
> in probe.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
Applied thanks

> ---
>  drivers/dma/sirf-dma.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 1d627e2..c439529 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> +#include <linux/clk.h>
>  #include <linux/sirfsoc_dma.h>
>  
>  #include "dmaengine.h"
> @@ -78,6 +79,7 @@ struct sirfsoc_dma {
>  	struct sirfsoc_dma_chan		channels[SIRFSOC_DMA_CHANNELS];
>  	void __iomem			*base;
>  	int				irq;
> +	struct clk			*clk;
>  	bool				is_marco;
>  };
>  
> @@ -639,6 +641,12 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>  		return -EINVAL;
>  	}
>  
> +	sdma->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(sdma->clk)) {
> +		dev_err(dev, "failed to get a clock.\n");
> +		return PTR_ERR(sdma->clk);
> +	}
> +
>  	ret = of_address_to_resource(dn, 0, &res);
>  	if (ret) {
>  		dev_err(dev, "Error parsing memory region!\n");
> @@ -698,6 +706,8 @@ static int sirfsoc_dma_probe(struct platform_device *op)
>  
>  	tasklet_init(&sdma->tasklet, sirfsoc_dma_tasklet, (unsigned long)sdma);
>  
> +	clk_prepare_enable(sdma->clk);
> +
>  	/* Register DMA engine */
>  	dev_set_drvdata(dev, sdma);
>  	ret = dma_async_device_register(dma);
> @@ -720,6 +730,7 @@ static int sirfsoc_dma_remove(struct platform_device *op)
>  	struct device *dev = &op->dev;
>  	struct sirfsoc_dma *sdma = dev_get_drvdata(dev);
>  
> +	clk_disable_unprepare(sdma->clk);
>  	dma_async_device_unregister(&sdma->dma);
>  	free_irq(sdma->irq, sdma);
>  	irq_dispose_mapping(sdma->irq);
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
