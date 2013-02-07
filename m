From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 14:39:13 +0000
Subject: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
In-Reply-To: <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Message-ID: <201302071439.13720.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013, Jon Hunter wrote:
> +static struct of_dma_filter_info info;

Both members of this structure are constant, so you can just initialize it here,
and it would be nice to give it a more descriptive name, such as omap_dmadev_info.

>  static struct platform_driver omap_dma_driver = {
>  	.probe	= omap_dma_probe,
>  	.remove	= omap_dma_remove,
>  	.driver = {
>  		.name = "omap-dma-engine",
>  		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(omap_dma_match)
>  	},
>  };

please end the new line with a comma.
  
> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
>  {
>  	int rc = platform_driver_register(&omap_dma_driver);
>  
> -	if (rc == 0) {
> +	if ((rc == 0) && (!of_have_populated_dt())) {
>  		pdev = platform_device_register_full(&omap_dma_dev_info);
>  		if (IS_ERR(pdev)) {
>  			platform_driver_unregister(&omap_dma_driver);

There is already a patch in linux-next that makes this obsolete.
The device is now registered in arch/arm/mach-omap2/dma.c, so
I guess you have to change that location now.

	Arnd
