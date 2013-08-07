From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 18:12:15 +0200
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <1375870770-14263-7-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <1375870770-14263-7-git-send-email-zonque@gmail.com>
Message-ID: <201308071812.15420.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013, Daniel Mack wrote:
> This patch makes the mmp_pdma controller able to provide DMA resources
> in DT environments.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/dma/mmp_pdma.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 60a1410..d60217a 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_data/mmp_dma.h>
>  #include <linux/dmapool.h>
>  #include <linux/of_device.h>
> +#include <linux/of_dma.h>
>  #include <linux/of.h>
>  #include <linux/dma/mmp-pdma.h>
>  
> @@ -783,6 +784,10 @@ static struct of_device_id mmp_pdma_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
>  
> +static struct of_dma_filter_info mmp_pdma_info = {
> +	.filter_fn = mmp_pdma_filter_fn,
> +};
> +
>  static int mmp_pdma_probe(struct platform_device *op)
>  {
>  	struct mmp_pdma_device *pdev;
> @@ -869,6 +874,19 @@ static int mmp_pdma_probe(struct platform_device *op)
>  		return ret;
>  	}
>  
> +	if (op->dev.of_node) {
> +		mmp_pdma_info.dma_cap = pdev->device.cap_mask;
> +
> +		/* Device-tree DMA controller registration */
> +		ret = of_dma_controller_register(op->dev.of_node,
> +						 of_dma_simple_xlate,
> +						 &mmp_pdma_info);

of_dma_simple_xlate can not be used if there is a chance that multiple instances
of the same dma engine, or multiple different DMA engines are present in the
system. I generally advise against using it.

Please have a look at the changes that Zhangfei Gao proposed in
http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
and see if you can do the same here.

	Arnd
