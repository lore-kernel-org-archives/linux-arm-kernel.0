From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 14 Jan 2010 04:09:11 +0000
Subject: [PATCH v2 2/3] ARM: SAMSUNG: Make clk_default_setrate and
	clk_ops_def_setrate visible
In-Reply-To: <1263441023-28090-1-git-send-email-kgene.kim@samsung.com>
References: <1263441023-28090-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100114040911.GR18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 12:50:23PM +0900, Kukjin Kim wrote:
> This patch makes clk_default_setrate and clk_ops_def_setrate available
> to code outside plat-samsung clock code.

Thanks, applied to next-samsung-clock.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-s5pc1xx/clock.c              |   16 +++-------------
>  arch/arm/plat-samsung/clock.c              |    4 ++--
>  arch/arm/plat-samsung/include/plat/clock.h |    3 +++
>  3 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/plat-s5pc1xx/clock.c
> index cc21a8b..aec0305 100644
> --- a/arch/arm/plat-s5pc1xx/clock.c
> +++ b/arch/arm/plat-s5pc1xx/clock.c
> @@ -64,16 +64,6 @@ struct clk clk_54m = {
>  	.rate		= 54000000,
>  };
>  
> -static int clk_default_setrate(struct clk *clk, unsigned long rate)
> -{
> -	clk->rate = rate;
> -	return 0;
> -}
> -
> -static struct clk_ops clk_ops_default_setrate = {
> -	.set_rate	= clk_default_setrate,
> -};
> -
>  static int clk_dummy_enable(struct clk *clk, int enable)
>  {
>  	return 0;
> @@ -86,7 +76,7 @@ struct clk clk_hd0 = {
>  	.parent		= NULL,
>  	.ctrlbit	= 0,
>  	.enable		= clk_dummy_enable,
> -	.ops		= &clk_ops_default_setrate,
> +	.ops		= &clk_ops_def_setrate,
>  };
>  
>  struct clk clk_pd0 = {
> @@ -95,7 +85,7 @@ struct clk clk_pd0 = {
>  	.rate		= 0,
>  	.parent		= NULL,
>  	.ctrlbit	= 0,
> -	.ops		= &clk_ops_default_setrate,
> +	.ops		= &clk_ops_def_setrate,
>  	.enable		= clk_dummy_enable,
>  };
>  
> @@ -705,7 +695,7 @@ void __init s5pc1xx_register_clocks(void)
>  	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
>  
>  	s3c_register_clocks(s5pc100_init_clocks,
> -			    ARRAY_SIZE(s5pc100_init_clocks);
> +			    ARRAY_SIZE(s5pc100_init_clocks));
>  
>  	clkp = s5pc100_init_clocks_disable;
>  	size = ARRAY_SIZE(s5pc100_init_clocks_disable);
> diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
> index 9194af9..0c746ae 100644
> --- a/arch/arm/plat-samsung/clock.c
> +++ b/arch/arm/plat-samsung/clock.c
> @@ -225,13 +225,13 @@ EXPORT_SYMBOL(clk_set_parent);
>  
>  /* base clocks */
>  
> -static int clk_default_setrate(struct clk *clk, unsigned long rate)
> +int clk_default_setrate(struct clk *clk, unsigned long rate)
>  {
>  	clk->rate = rate;
>  	return 0;
>  }
>  
> -static struct clk_ops clk_ops_def_setrate = {
> +struct clk_ops clk_ops_def_setrate = {
>  	.set_rate	= clk_default_setrate,
>  };
>  
> diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> index bd41f82..22e0114 100644
> --- a/arch/arm/plat-samsung/include/plat/clock.h
> +++ b/arch/arm/plat-samsung/include/plat/clock.h
> @@ -75,6 +75,9 @@ extern struct clk clk_h2;
>  extern struct clk clk_27m;
>  extern struct clk clk_48m;
>  
> +extern int clk_default_setrate(struct clk *clk, unsigned long rate);
> +extern struct clk_ops clk_ops_def_setrate;
> +
>  /* exports for arch/arm/mach-s3c2410
>   *
>   * Please DO NOT use these outside of arch/arm/mach-s3c2410
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
