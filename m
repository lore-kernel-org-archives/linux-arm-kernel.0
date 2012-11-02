From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 2 Nov 2012 12:07:43 +0530
Subject: [PATCH 3/3] ARM: OMAP: Remove plat-omap/common.c
In-Reply-To: <20121101224828.2103.82950.stgit@muffinssi.local>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224828.2103.82950.stgit@muffinssi.local>
Message-ID: <50936A37.3070403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Friday 02 November 2012 04:18 AM, Tony Lindgren wrote:
> This file has only omap_init_consistent_dma_size()
> left that can be moved to plat-omap/dma.c.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/plat-omap/Makefile |    2 +-
>   arch/arm/plat-omap/common.c |   26 --------------------------
>   arch/arm/plat-omap/dma.c    |    8 ++++++++
>   3 files changed, 9 insertions(+), 27 deletions(-)
>   delete mode 100644 arch/arm/plat-omap/common.c
>

[..]

> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index c288b76..00a3a53 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2146,6 +2146,14 @@ static struct platform_driver omap_system_dma_driver = {
>   	},
>   };
>
> +/* This must be called from init_early() */
> +void __init omap_init_consistent_dma_size(void)
> +{
> +#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
> +	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
> +#endif
> +}
> +
Lets not move this in DMA code since the above is really related
to frame buffer. It reserves more DMA area for dma_alloc_coherent()
etc than default 2 MB. Infact, we should no longer need this with
CMA and memblock in place.

Tomi,
Can we not get rid of the above memory reservation ?

Regards
santosh
