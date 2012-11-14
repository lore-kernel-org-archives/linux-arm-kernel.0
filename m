From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Nov 2012 21:55:56 -0600
Subject: [PATCH 01/17] of: add dma-mask binding
In-Reply-To: <1352710357-3265-2-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
 <1352710357-3265-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <50A3164C.3070301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 02:52 AM, Wenyou Yang wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> This will allow each device to specify its dma-mask for this we use the
> coherent_dma_mask as pointer. By default the dma-mask will be set to
> DMA_BIT_MASK(32).

Do you really have a use case this is not DMA_BIT_MASK(32)?

> The microblaze architecture hook is drop
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: grant.likely at secretlab.ca
> Cc: rob.herring at calxeda.com
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
>  drivers/of/platform.c |   23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b80891b..31ed405 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -130,6 +130,21 @@ void of_device_make_bus_id(struct device *dev)
>  	dev_set_name(dev, "%s.%d", node->name, magic - 1);
>  }
>  
> +static void of_get_dma_mask(struct device *dev, struct device_node *np)
> +{
> +	const __be32 *prop;
> +	int len;
> +
> +	prop = of_get_property(np, "dma-mask", &len);

dma-ranges may work for this purpose.

> +
> +	dev->dma_mask = &dev->coherent_dma_mask;

I don't really know, but I suspect this is wrong.

> +
> +	if (!prop)
> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	else
> +		dev->coherent_dma_mask = of_read_number(prop, len / 4);
> +}
> +
>  /**
>   * of_device_alloc - Allocate and initialize an of_device
>   * @np: device node to assign to device
> @@ -171,10 +186,8 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  		WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq);
>  	}
>  
> +	of_get_dma_mask(&dev->dev, np);
>  	dev->dev.of_node = of_node_get(np);
> -#if defined(CONFIG_MICROBLAZE)
> -	dev->dev.dma_mask = &dev->archdata.dma_mask;
> -#endif
>  	dev->dev.parent = parent;
>  
>  	if (bus_id)
> @@ -211,10 +224,6 @@ struct platform_device *of_platform_device_create_pdata(
>  	if (!dev)
>  		return NULL;
>  
> -#if defined(CONFIG_MICROBLAZE)
> -	dev->archdata.dma_mask = 0xffffffffUL;
> -#endif
> -	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  	dev->dev.bus = &platform_bus_type;
>  	dev->dev.platform_data = platform_data;
>  
> 
