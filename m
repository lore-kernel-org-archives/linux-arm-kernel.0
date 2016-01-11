From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jan 2016 10:37:18 +0000
Subject: [PATCH] drm: arm-hdlcd: remove DMA_CMA select
In-Reply-To: <4194408.X82ccDjh5X@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
Message-ID: <20160111103718.GA13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 03:09:10PM +0100, Arnd Bergmann wrote:
> The newly added DRM_HDLCD driver tries to select DMA_CMA, but that is
> not necessarily possible, as not all configurations contain HAVE_DMA_CONTIGUOUS:
> 
> warning: (DRM_HDLCD) selects DMA_CMA which has unmet direct dependencies (HAVE_DMA_CONTIGUOUS && CMA)
> drivers/built-in.o: In function `dma_alloc_from_contiguous':
> :(.text+0x1dee00): undefined reference to `cma_alloc'
> drivers/built-in.o: In function `dma_release_from_contiguous':
> :(.text+0x1dee24): undefined reference to `cma_release'
> 
> This removes the 'select' statement. It is not needed because CMA is meant
> to transparently change the behavior of dma_alloc_coherent to make it succeed
> for larger allocations, but there is no actual build-time dependency, and
> the driver can still work without CMA in many cases.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1561e558334d ("drm: Add support for ARM's HDLCD controller.")

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Arnd, are you going to send these corrections yourself or should I pull them
into my tree (possibly squashing them before sending the pull request to
Dave Airlie) ?

Best regards,
Liviu

> ---
> Found on ARM randconfig builds with yesterday's linux-next
> 
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index 5e8c8a86860b..2f4d3b7fb871 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -10,7 +10,6 @@ config DRM_HDLCD
>  	depends on DRM_ARM
>  	depends on COMMON_CLK
>  	select COMMON_CLK_SCPI
> -	select DMA_CMA
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER
>  	help
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
