From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Sep 2010 09:41:08 +0900
Subject: [PATCH 2/4] ARM: Samsung: s5p-fimc: fix dma coherent mask
In-Reply-To: <1283745044-15514-3-git-send-email-m.szyprowski@samsung.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<1283745044-15514-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <000301cb4fb7$b4448530$1ccd8f90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> FIMC driver uses DMA_coherent allocator, which requires proper dma mask
> to be set.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/dev-fimc0.c |    2 ++
>  arch/arm/plat-s5p/dev-fimc1.c |    2 ++
>  arch/arm/plat-s5p/dev-fimc2.c |    2 ++
>  3 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
> index d3f1a9b..9f26096 100644
> --- a/arch/arm/plat-s5p/dev-fimc0.c
> +++ b/arch/arm/plat-s5p/dev-fimc0.c
> @@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc0 = {
>  	.id		= 0,
>  	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
>  	.resource	= s5p_fimc0_resource,
> +	.dev.dma_mask	  = &s5p_device_fimc0.dev.coherent_dma_mask,
> +	.dev.coherent_dma_mask = 0xffffffffUL,

Ok...but I prefer following style :-)
Could you please re-submit your this patch?

diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
index d3f1a9b..cb1ff4d 100644
--- a/arch/arm/plat-s5p/dev-fimc0.c
+++ b/arch/arm/plat-s5p/dev-fimc0.c
@@ -28,9 +28,15 @@ static struct resource s5p_fimc0_resource[] = {
        },
 };

+static u64 s5p_fimc_dma_mask = DMA_BIT_MASK(32);
+
 struct platform_device s5p_device_fimc0 = {
 	.name		= "s5p-fimc",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5p_fimc0_resource),
 	.resource	= s5p_fimc0_resource,
+	.dev		= {
+		.dma_mask		= &s5p_fimc_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
 };

>  };
> diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
> index 41bd698..4149c49 100644
> --- a/arch/arm/plat-s5p/dev-fimc1.c
> +++ b/arch/arm/plat-s5p/dev-fimc1.c
> @@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc1 = {
>  	.id		= 1,
>  	.num_resources	= ARRAY_SIZE(s5p_fimc1_resource),
>  	.resource	= s5p_fimc1_resource,
> +	.dev.dma_mask	  = &s5p_device_fimc1.dev.coherent_dma_mask,
> +	.dev.coherent_dma_mask = 0xffffffffUL,
>  };
> diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
> index dfddeda..ced9097 100644
> --- a/arch/arm/plat-s5p/dev-fimc2.c
> +++ b/arch/arm/plat-s5p/dev-fimc2.c
> @@ -33,4 +33,6 @@ struct platform_device s5p_device_fimc2 = {
>  	.id		= 2,
>  	.num_resources	= ARRAY_SIZE(s5p_fimc2_resource),
>  	.resource	= s5p_fimc2_resource,
> +	.dev.dma_mask	  = &s5p_device_fimc2.dev.coherent_dma_mask,
> +	.dev.coherent_dma_mask = 0xffffffffUL,
>  };
> --
> 1.7.2.2

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
