From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Dec 2012 16:13:22 -0800
Subject: [PATCH 1/2] ARM: l2x0: Only set .set_debug on PL310 r3p0 and
 earlier
In-Reply-To: <1355351150-15942-1-git-send-email-robherring2@gmail.com>
References: <1355351150-15942-1-git-send-email-robherring2@gmail.com>
Message-ID: <20121214001321.GK4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [121212 14:28]:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> PL310 errata work-arounds using .set_debug function are only needed on
> r3p0 and earlier, so check the rev and only set .set_debug on older revs.
> 
> Avoiding debug register accesses fixes aborts on non-secure platforms
> like highbank. It is assumed that non-secure platforms needing these
> work-arounds have already implemented .set_debug with secure monitor
> calls.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Nice, works for me:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mm/cache-l2x0.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 8a97e64..6cf2fd1 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -334,7 +334,8 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
>  		/* Unmapped register. */
>  		sync_reg_offset = L2X0_DUMMY_REG;
>  #endif
> -		outer_cache.set_debug = pl310_set_debug;
> +		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L2X0_CACHE_ID_RTL_R3P0)
> +			outer_cache.set_debug = pl310_set_debug;
>  		break;
>  	case L2X0_CACHE_ID_PART_L210:
>  		ways = (aux >> 13) & 0xf;
> -- 
> 1.7.10.4
> 
