From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jan 2010 12:26:12 -0500
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100110172825.GB8639@n2100.arm.linux.org.uk>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020898E7@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 10, 2010 10:28 AM, Russell King wrote:
> Most machine classes want some way to register a block of clk_lookup
> structures, and most do it by implementing a clks_register() type
> function which walks an array, or by open-coding a loop.
> 
> Consolidate all this into clkdev_add_table().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

[snip]

> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index aae5bc0..446b696 100644
> --- a/arch/arm/common/clkdev.c
> +++ b/arch/arm/common/clkdev.c
> @@ -99,6 +99,16 @@ void clkdev_add(struct clk_lookup *cl)
>  }
>  EXPORT_SYMBOL(clkdev_add);
>  
> +void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
> +{
> +	mutex_lock(&clocks_mutex);
> +	while (num--) {
> +		list_add_tail(&cl->node, &clocks);
> +		cl++;
> +	}
> +	mutex_unlock(&clocks_mutex);
> +}
> +
>  #define MAX_DEV_ID	20
>  #define MAX_CON_ID	16
>  
> diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
> index b6ec7c6..7a0690d 100644
> --- a/arch/arm/include/asm/clkdev.h
> +++ b/arch/arm/include/asm/clkdev.h
> @@ -27,4 +27,7 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
>  void clkdev_add(struct clk_lookup *cl);
>  void clkdev_drop(struct clk_lookup *cl);
>  
> +void clkdev_add_table(struct clk_lookup *, size_t);
> +int clk_add_alias(const char *, const char *, char *, struct device *);

clk_add_alias does not seem to be related to this patch.

> +
>  #endif

[snip]

> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 1d0f9d8..bb3c621 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -445,7 +445,6 @@ static void __init ep93xx_dma_clock_init(void)
>  static int __init ep93xx_clock_init(void)
>  {
>  	u32 value;
> -	int i;
>  
>  	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET1);
>  	if (!(value & 0x00800000)) {			/* PLL1 bypassed?  */
> @@ -474,8 +473,7 @@ static int __init ep93xx_clock_init(void)
>  		clk_f.rate / 1000000, clk_h.rate / 1000000,
>  		clk_p.rate / 1000000);
>  
> -	for (i = 0; i < ARRAY_SIZE(clocks); i++)
> -		clkdev_add(&clocks[i]);
> +	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
>  	return 0;
>  }
>  arch_initcall(ep93xx_clock_init);

For ep93xx.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
