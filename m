From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 06:33:20 +0000
Subject: [PATCH] ARM: SAMSUNG: Add check to ensure that clksrc_clk does
	have multiple clock sources
In-Reply-To: <1263792616-19507-1-git-send-email-thomas.ab@samsung.com>
References: <1263792616-19507-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20100118063320.GL10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 02:30:16PM +0900, Thomas Abraham wrote:
> Adds a additional check in s3c_set_clksrc function to ensure that the clksrc_clk
> does have a choice of multiple clock sources. In addition to this, a check is
> added to ensure that a parent is assigned to the clksrc_clk in case it does not
> have a choice of parent clocks.

Applied to next-samsung-clock2.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-samsung/clock-clksrc.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
> index 33c633a..98c6b88 100644
> --- a/arch/arm/plat-samsung/clock-clksrc.c
> +++ b/arch/arm/plat-samsung/clock-clksrc.c
> @@ -129,11 +129,16 @@ void __init_or_cpufreq s3c_set_clksrc(struct clksrc_clk *clk, bool announce)
>  {
>  	struct clksrc_sources *srcs = clk->sources;
>  	u32 mask = bit_mask(clk->reg_src.shift, clk->reg_src.size);
> -	u32 clksrc = 0;
> +	u32 clksrc;
>  
> -	if (clk->reg_src.reg)
> -		clksrc = __raw_readl(clk->reg_src.reg);
> +	if (!clk->reg_src.reg) {
> +		if (!clk->clk.parent)
> +			printk(KERN_ERR "%s: no parent clock specified\n",
> +				clk->clk.name);
> +		return;
> +	}
>  
> +	clksrc = __raw_readl(clk->reg_src.reg);
>  	clksrc &= mask;
>  	clksrc >>= clk->reg_src.shift;
>  
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
