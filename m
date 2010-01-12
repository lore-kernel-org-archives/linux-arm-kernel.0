From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 02:36:54 +0000
Subject: [PATCH 2/3] ARM: SAMSUNG: Make clk_default_setrate and
	clk_ops_def_setrate visible
In-Reply-To: <1263203065-29250-1-git-send-email-kgene.kim@samsung.com>
References: <1263203065-29250-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100112023654.GB18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 06:44:25PM +0900, Kukjin Kim wrote:
> This patch makes clk_default_setrate and clk_ops_def_setrate available
> to code outside plat-samsung clock code.

Please incluse a fix for arch/arm/plat-s5pc1xx/clock.c which now fails
to build due to the following:

arch/arm/plat-s5pc1xx/clock.c:68: error: static declaration of 'clk_default_setrate' follows non-static declaration
arch/arm/plat-samsung/include/plat/clock.h:78: error: previous declaration of 'clk_default_setrate' was here
 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-samsung/clock.c              |    4 ++--
>  arch/arm/plat-samsung/include/plat/clock.h |    3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
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
