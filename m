From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Apr 2013 14:33:15 +0100
Subject: [PATCH] of: Set the DMA mask to 64 bits on ARM LPAE systems
In-Reply-To: <1366764649-10342-1-git-send-email-lauraa@codeaurora.org>
References: <1366764649-10342-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130425133315.GA7157@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 01:50:49AM +0100, Laura Abbott wrote:
> By default on ARM systems, the coherent DMA mask (lowest
> address) is set to ~0 or 0xFFFFFFFFFFFFFFFF. Currently,
> of_platform_device_create_pdata sets the coherent DMA mask to
> 32 bits. This prevents coherent dma allocations from working by default
> without clients setting the DMA mask. Rather than make every client
> on an LPAE system set the mask, set the mask to a 64 bit value on
> ARM LPAE systems.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  drivers/of/platform.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 0970505..18b69c1 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -214,7 +214,11 @@ struct platform_device *of_platform_device_create_pdata(
>  #if defined(CONFIG_MICROBLAZE)
>  	dev->archdata.dma_mask = 0xffffffffUL;
>  #endif
> +#ifdef CONFIG_ARM_LPAE
> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> +#else
>  	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +#endif

I wouldn't add CONFIG_ARM_LPAE checks in here, you can use
CONFIG_ARCH_DMA_ADDR_T_64BIT (types.h uses this for the dma_addr_t
definition).

-- 
Catalin
