From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 2 May 2013 20:49:38 +0530
Subject: [PATCH] dmaengine: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <1365660568-2588-1-git-send-email-Barry.Song@csr.com>
References: <1365660568-2588-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130502151938.GK1960@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 02:09:28PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> if we initilize dma driver by module_init, there are still many devices
> which will be initilized earlier than dma. these devices will fail to
> get dma channel.
> this moves dmaengine earlier than device_initcall and make dma available
> for all devices.
> 
> Reported-by: Renwei Wu <Renwei.Wu@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
Applied thanks, this is what many drivers in susystem do...

--
~Vinod
> ---
>  drivers/dma/sirf-dma.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 1d627e2..c35fa34 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -742,7 +742,18 @@ static struct platform_driver sirfsoc_dma_driver = {
>  	},
>  };
>  
> -module_platform_driver(sirfsoc_dma_driver);
> +static __init int sirfsoc_dma_init(void)
> +{
> +	return platform_driver_register(&sirfsoc_dma_driver);
> +}
> +
> +static void __exit sirfsoc_dma_exit(void)
> +{
> +	platform_driver_unregister(&sirfsoc_dma_driver);
> +}
> +
> +subsys_initcall(sirfsoc_dma_init);
> +module_exit(sirfsoc_dma_exit);
>  
>  MODULE_AUTHOR("Rongjun Ying <rongjun.ying@csr.com>, "
>  	"Barry Song <baohua.song@csr.com>");
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
