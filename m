From: robherring2@gmail.com (Rob Herring)
Date: Mon, 10 Dec 2012 10:30:01 -0600
Subject: [PATCH] OF: update coherent_dma_mask
In-Reply-To: <1355141369-30030-1-git-send-email-subash.rp@samsung.com>
References: <1355141369-30030-1-git-send-email-subash.rp@samsung.com>
Message-ID: <50C60E09.8050805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2012 06:09 AM, Subash Patel wrote:
> This patch is tested in ARM:exynos5250 with LPAE enabled. The coherent_dma_mask
> needs to be defined to DMA_BIT_MASK(64) as dma-mapping API's check it against
> 64-bit mask.
> 
> Signed-off-by: Subash Patel <subash.rp@samsung.com>
> ---
>  drivers/of/platform.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 9bdeaf30..3c5417b 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -214,7 +214,7 @@ struct platform_device *of_platform_device_create_pdata(
>  #if defined(CONFIG_MICROBLAZE)
>  	dev->archdata.dma_mask = 0xffffffffUL;
>  #endif
> -	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>  	dev->dev.bus = &platform_bus_type;
>  	dev->dev.platform_data = platform_data;

This is assuming all masters support 64-bit addressing which is probably
not universally valid. This really needs to be determined from the DT
and there's been recent patches to do this[1] although they need more work.

[1] - https://lkml.org/lkml/2012/12/4/54

Rob
