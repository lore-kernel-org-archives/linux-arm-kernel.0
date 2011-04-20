From: mayur@ti.com (Janorkar, Mayuresh)
Date: Wed, 20 Apr 2011 19:05:11 +0530
Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
In-Reply-To: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033D7EB768@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Gulati, Shweta
> Sent: Wednesday, April 20, 2011 2:55 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Gulati, Shweta; Nayak, Rajendra;
> Paul Wamsley
> Subject: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
> 
> From: Gulati, Shweta <shweta.gulati@ti.com>
> 
> Core Clk Tree shows incorrect Clk rates at OPP50, as
> in commit e07f469d284ca3d1f5dcf5438c22982be98bc071
> calling of 'recalc' in API clk_set_rate is unintentionally
> removed, because of which clock's tree rates get goofed
> up when DVFS happens. This Patch adds recalc API back.

I see that the patch is not adding API back.
It is adding a call to the API.

> 
> Tested on OMAP3630 SDP Board.
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Wamsley <paul@pwsan.com>
> ---
>  arch/arm/plat-omap/clock.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index c9122dd..5a0d06b 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -130,8 +130,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
> 
>  	spin_lock_irqsave(&clockfw_lock, flags);
>  	ret = arch_clock->clk_set_rate(clk, rate);
> -	if (ret == 0)
> +	if (ret == 0) {

checking if (!ret) is an intelligent way.
But it is an individual's choice.

> +		if (clk->recalc)
> +			clk->rate = clk->recalc(clk);
>  		propagate_rate(clk);
> +	}
>  	spin_unlock_irqrestore(&clockfw_lock, flags);
> 
>  	return ret;
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
