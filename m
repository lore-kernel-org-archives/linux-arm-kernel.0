From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 9 Jul 2012 14:20:52 +0530
Subject: [PATCH v2 02/14] ARM: OMAP: counter-32k: Select the CR register
 offset using the IP scheme.
In-Reply-To: <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4FFA9B6C.7050003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> From: R Sricharan <r.sricharan@ti.com>
> 
> OMAP socs has a legacy and a highlander version of the
> 32k sync counter IP. The register offsets vary between the
> highlander and the legacy scheme. So use the 'SCHEME'
> bits(30-31) of the revision register to distinguish between


Just for my understanding, can we get further information on SCHEME
bit-fields? What kind of information we have it here.

I may need this info to pass on to design team here.

Thanks,
Vaibhav
> the two versions and choose the CR register offset accordingly.
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/counter_32k.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 2132c4f..dbf1e03 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -29,7 +29,10 @@
>  #include <plat/clock.h>
>  
>  /* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> -#define OMAP2_32KSYNCNT_CR_OFF		0x10
> +#define OMAP2_32KSYNCNT_REV_OFF		0x0
> +#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
> +#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
> +#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
>  
>  /*
>   * 32KHz clocksource ... always available, on pretty most chips except
> @@ -84,9 +87,16 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
>  	int ret;
>  
>  	/*
> -	 * 32k sync Counter register offset is at 0x10
> +	 * 32k sync Counter IP register offsets vary between the
> +	 * highlander version and the legacy ones.
> +	 * The 'SCHEME' bits(30-31) of the revision register is used
> +	 * to identify the version.
>  	 */
> -	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
> +	if (__raw_readl(vbase + OMAP2_32KSYNCNT_REV_OFF) &
> +						OMAP2_32KSYNCNT_REV_SCHEME)
> +		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
> +	else
> +		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
>  
>  	/*
>  	 * 120000 rough estimate from the calculations in
> 
