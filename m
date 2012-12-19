From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Wed, 19 Dec 2012 10:40:53 +0530
Subject: [PATCH] ARM: cache-l2x0.c: Apply the workaround to r3p0 only
In-Reply-To: <20121030100227.GA8260@bnru04>
References: <20121030100227.GA8260@bnru04>
Message-ID: <20121219051052.GA15163@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On Tue, Oct 30, 2012 at 11:02:32 +0100, srinidhi kasagar wrote:
> The PL310 bug 753970 should be applied only to r3p0
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  arch/arm/mm/cache-l2x0.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 2a8e380..7925734 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -311,6 +311,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>  	u32 aux;
>  	u32 cache_id;
>  	u32 way_size = 0;
> +	u32 l2x0_revision;
>  	int ways;
>  	const char *type;
>  
> @@ -331,8 +332,12 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>  			ways = 8;
>  		type = "L310";
>  #ifdef CONFIG_PL310_ERRATA_753970
> -		/* Unmapped register. */
> -		sync_reg_offset = L2X0_DUMMY_REG;
> +		 /* FIXME: make sense to have dt support for L2 Erratas? */
> +		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
> +				L2X0_CACHE_ID_RTL_MASK;
> +		if (l2x0_revision == L2X0_CACHE_ID_RTL_R3P0)
> +			/* Unmapped register. */
> +			sync_reg_offset = L2X0_DUMMY_REG;
>  #endif
>  		outer_cache.set_debug = pl310_set_debug;
>  		break;

What is your thought on this? The platforms like x540 shares mostly the same code as 
of 8500 but Cortex and PL310 revisions are upgraded, and consequently since we manage the
the single defconfig for both these platforms, the compile time options for enabling
ARM/PL310 ERRATAs are not really working out.

This is the first cut, and I see the same issue even with the ERRATA PL310_ERRATA_769419
or the commit 11ed0ba1754841316d4095478944300acf19acc3

regards/srinidhi
