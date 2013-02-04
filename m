From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Feb 2013 17:43:54 +0000
Subject: [PATCH] ARM: SAMSUNG: dma: Remove unnecessary code
In-Reply-To: <1359967675-624-1-git-send-email-padma.v@samsung.com>
References: <1359967675-624-1-git-send-email-padma.v@samsung.com>
Message-ID: <201302041743.55029.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 February 2013, Padmavathi Venna wrote:
> diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
> index 71d58dd..ec0d731 100644
> --- a/arch/arm/plat-samsung/dma-ops.c
> +++ b/arch/arm/plat-samsung/dma-ops.c
> @@ -23,23 +23,15 @@ static unsigned samsung_dmadev_request(enum dma_ch dma_ch,
>  				struct device *dev, char *ch_name)
>  {
>  	dma_cap_mask_t mask;
> -	void *filter_param;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(param->cap, mask);
>  
> -	/*
> -	 * If a dma channel property of a device node from device tree is
> -	 * specified, use that as the fliter parameter.
> -	 */
> -	filter_param = (dma_ch == DMACH_DT_PROP) ?
> -		(void *)param->dt_dmach_prop : (void *)dma_ch;
> -
>  	if (dev->of_node)
>  		return (unsigned)dma_request_slave_channel(dev, ch_name);
>  	else
>  		return (unsigned)dma_request_channel(mask, pl330_filter,
> -							filter_param);
> +							(void *)dma_ch);
>  }

This still looks wrong to me, because the pl330_filter function now tkes
a struct dma_pl330_filter_args pointer argument, not dma_ch name.

	Arnd
