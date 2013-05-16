From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 May 2013 11:38:50 +0530
Subject: [PATCH 39/39] dmaengine: ste_dma40: Fetch disabled channels
 from DT
In-Reply-To: <1368611522-9984-40-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-40-git-send-email-lee.jones@linaro.org>
Message-ID: <20130516060850.GI27639@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:52:02AM +0100, Lee Jones wrote:
> Some platforms have channels which are not available for normal use.
> This information is currently passed though platform data in internal
> BSP kernels. Once those platforms land, they'll need to configure them
> appropriately, so we may as well add the infrastructure.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

> ---
>  Documentation/devicetree/bindings/dma/ste-dma40.txt |    2 ++
>  drivers/dma/ste_dma40.c                             |   17 ++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ste-dma40.txt b/Documentation/devicetree/bindings/dma/ste-dma40.txt
> index aa272d8..bea5b73 100644
> --- a/Documentation/devicetree/bindings/dma/ste-dma40.txt
> +++ b/Documentation/devicetree/bindings/dma/ste-dma40.txt
> @@ -11,6 +11,7 @@ Required properties:
>  Optional properties:
>  - dma-channels: Number of channels supported by hardware - if not present
>  		the driver will attempt to obtain the information from H/W
> +- disabled-channels: Channels which can not be used
>  
>  Example:
>  
> @@ -23,6 +24,7 @@ Example:
>  
>  		#dma-cells = <2>;
>  		memcpy-channels  = <56 57 58 59 60>;
> +		disabled-channels  = <12>;
>  		dma-channels = <8>;
>  	};
>  
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 4e528dd..ffac822 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -3482,7 +3482,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
>  			       struct device_node *np)
>  {
>  	struct stedma40_platform_data *pdata;
> -	int num_phy = 0, num_memcpy = 0;
> +	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
>  	const const __be32 *list;
>  
>  	pdata = devm_kzalloc(&pdev->dev,
> @@ -3511,6 +3511,21 @@ static int __init d40_of_probe(struct platform_device *pdev,
>  				   dma40_memcpy_channels,
>  				   num_memcpy);
>  
> +	list = of_get_property(np, "disabled-channels", &num_disabled);
> +	num_disabled /= sizeof(*list);
> +
> +	if (num_disabled > STEDMA40_MAX_PHYS || num_disabled < 0) {
> +		d40_err(&pdev->dev,
> +			"Invalid number of disabled channels specified (%d)\n",
> +			num_disabled);
> +		return -EINVAL;
> +	}
> +
> +	of_property_read_u32_array(np, "disabled-channels",
> +				   pdata->disabled_channels,
> +				   num_disabled);
> +	pdata->disabled_channels[num_disabled] = -1;
> +
>  	pdev->dev.platform_data = pdata;
>  
>  	return 0;
> -- 
> 1.7.10.4
> 
