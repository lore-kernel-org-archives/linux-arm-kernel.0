From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Apr 2014 12:04:27 +0530
Subject: [PATCH] dma: fix eDMA driver as a subsys_initcall
In-Reply-To: <1396585675-32729-1-git-send-email-yao.yuan@freescale.com>
References: <1396585675-32729-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140416063427.GK32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 12:27:55PM +0800, Yuan Yao wrote:
> Because of some driver base on DMA, changed the initcall order as subsys_initcall.

Changelog could have mentioned "which" driver and elobrated on it
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>

Applied, nevertheless

-- 
~Vinod
> ---
>  drivers/dma/fsl-edma.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 381e793..b396a7f 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -968,7 +968,17 @@ static struct platform_driver fsl_edma_driver = {
>  	.remove		= fsl_edma_remove,
>  };
>  
> -module_platform_driver(fsl_edma_driver);
> +static int __init fsl_edma_init(void)
> +{
> +	return platform_driver_register(&fsl_edma_driver);
> +}
> +subsys_initcall(fsl_edma_init);
> +
> +static void __exit fsl_edma_exit(void)
> +{
> +	platform_driver_unregister(&fsl_edma_driver);
> +}
> +module_exit(fsl_edma_exit);
>  
>  MODULE_ALIAS("platform:fsl-edma");
>  MODULE_DESCRIPTION("Freescale eDMA engine driver");
> -- 
> 1.8.4
> 
> 

-- 
