From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 02 Dec 2011 17:59:49 +0900
Subject: [PATCH] ARM: EXYNOS: Enable MDMA driver
In-Reply-To: <1322466688-10272-1-git-send-email-boojin.kim@samsung.com>
References: <1322466688-10272-1-git-send-email-boojin.kim@samsung.com>
Message-ID: <04fa01ccb0d0$befbf050$3cf3d0f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Boojin Kim [mailto:boojin.kim at samsung.com]
> Sent: Monday, November 28, 2011 4:51 PM
> To: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org
> Cc: Kukjin Kim; Boojin Kim
> Subject: [PATCH] ARM: EXYNOS: Enable MDMA driver
> 
> This patch adds MDMA platform data and enables MDMA for DMA memcpy
> operation
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/clock.c                   |    8 +++++
>  arch/arm/mach-exynos/dma.c                     |   35
++++++++++++++++++++++++
>  arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
>  arch/arm/mach-exynos/include/mach/map.h        |    3 +-
>  arch/arm/plat-samsung/include/plat/dma-pl330.h |    8 +++++
>  5 files changed, 55 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
> index 5d8d483..28e2842 100644
> --- a/arch/arm/mach-exynos/clock.c
> +++ b/arch/arm/mach-exynos/clock.c
> @@ -782,6 +782,13 @@ static struct clk clk_pdma1 = {
>  	.ctrlbit	= (1 << 1),
>  };
> 
> +static struct clk clk_mdma1 = {
> +	.name		= "dma",
> +	.devname	= "dma-pl330.2",
> +	.enable		= exynos4_clk_ip_image_ctrl,
> +	.ctrlbit	= ((1 << 8) | (1 << 5) | (1 << 2)),
> +};
> +
>  struct clk *clkset_group_list[] = {
>  	[0] = &clk_ext_xtal_mux,
>  	[1] = &clk_xusbxti,
> @@ -1294,6 +1301,7 @@ static struct clksrc_clk *sysclks[] = {
>  static struct clk *clk_cdev[] = {
>  	&clk_pdma0,
>  	&clk_pdma1,
> +	&clk_mdma1,
>  };
> 
>  static struct clksrc_clk *clksrc_cdev[] = {
> diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
> index b10fcd2..e89329e 100644
> --- a/arch/arm/mach-exynos/dma.c
> +++ b/arch/arm/mach-exynos/dma.c
> @@ -139,6 +139,38 @@ struct amba_device exynos4_device_pdma1 = {
>  	.periphid = 0x00041330,
>  };
> 
> +u8 mdma_peri[] = {
> +	DMACH_MTOM_0,
> +	DMACH_MTOM_1,
> +	DMACH_MTOM_2,
> +	DMACH_MTOM_3,
> +	DMACH_MTOM_4,
> +	DMACH_MTOM_5,
> +	DMACH_MTOM_6,
> +	DMACH_MTOM_7,
> +};
> +
> +struct dma_pl330_platdata exynos4_mdma_pdata = {
> +	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
> +	.peri_id = mdma_peri,
> +};
> +
> +struct amba_device exynos4_device_mdma = {
> +	.dev = {
> +		.init_name = "dma-pl330.2",
> +		.dma_mask = &dma_dmamask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +		.platform_data = &exynos4_mdma_pdata,
> +	},
> +	.res = {
> +		.start = EXYNOS4_PA_MDMA1,
> +		.end = EXYNOS4_PA_MDMA1 + SZ_4K,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	.irq = {IRQ_MDMA1, NO_IRQ},
> +	.periphid = 0x00041330,
> +};
> +
>  static int __init exynos4_dma_init(void)
>  {
>  	if (of_have_populated_dt())
> @@ -152,6 +184,9 @@ static int __init exynos4_dma_init(void)
>  	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
>  	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
> 
> +	dma_cap_set(DMA_MEMCPY, exynos4_mdma_pdata.cap_mask);
> +	amba_device_register(&exynos4_device_mdma, &iomem_resource);
> +
>  	return 0;
>  }
>  arch_initcall(exynos4_dma_init);
> diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-
> exynos/include/mach/irqs.h
> index 713dd52..f7d73b1 100644
> --- a/arch/arm/mach-exynos/include/mach/irqs.h
> +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> @@ -43,6 +43,8 @@
>  #define IRQ_EINT15		IRQ_SPI(31)
>  #define IRQ_EINT16_31		IRQ_SPI(32)
> 
> +#define IRQ_MDMA0		IRQ_SPI(33)
> +#define IRQ_MDMA1		IRQ_SPI(34)
>  #define IRQ_PDMA0		IRQ_SPI(35)
>  #define IRQ_PDMA1		IRQ_SPI(36)
>  #define IRQ_TIMER0_VIC		IRQ_SPI(37)
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-
> exynos/include/mach/map.h
> index 058541d..03e2c99 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -67,7 +67,8 @@
>  #define EXYNOS4_PA_TWD			0x10500600
>  #define EXYNOS4_PA_L2CC			0x10502000
> 
> -#define EXYNOS4_PA_MDMA			0x10810000
> +#define EXYNOS4_PA_MDMA0		0x10810000
> +#define EXYNOS4_PA_MDMA1		0x12840000
>  #define EXYNOS4_PA_PDMA0		0x12680000
>  #define EXYNOS4_PA_PDMA1		0x12690000
> 
> diff --git a/arch/arm/plat-samsung/include/plat/dma-pl330.h
> b/arch/arm/plat-samsung/include/plat/dma-pl330.h
> index c5eaad5..ecf23a8 100644
> --- a/arch/arm/plat-samsung/include/plat/dma-pl330.h
> +++ b/arch/arm/plat-samsung/include/plat/dma-pl330.h
> @@ -82,6 +82,14 @@ enum dma_ch {
>  	DMACH_SLIMBUS4_TX,
>  	DMACH_SLIMBUS5_RX,
>  	DMACH_SLIMBUS5_TX,
> +	DMACH_MTOM_0,
> +	DMACH_MTOM_1,
> +	DMACH_MTOM_2,
> +	DMACH_MTOM_3,
> +	DMACH_MTOM_4,
> +	DMACH_MTOM_5,
> +	DMACH_MTOM_6,
> +	DMACH_MTOM_7,
>  	/* END Marker, also used to denote a reserved channel */
>  	DMACH_MAX,
>  };
> --
> 1.7.1

Looks ok, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
