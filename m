From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 17:04:43 +0100
Subject: [PATCH 2/3] plat-nomadik: Added suspend/resume support for MTU
	timer.
In-Reply-To: <1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <20100902160443.GR26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Added suspend/resume support for MTU timer."

Present tense, as it is describing what the patch is doing rather than
what has been done in the past?

On Thu, Sep 02, 2010 at 09:30:32AM +0200, Jonas Aaberg wrote:
> +static void nmdk_timer_reset(void)
> +{
> +	u32 cr = MTU_CRn_32BITS | MTU_CRn_ENA;
> +	struct clk *clk0;
> +
> +	clk0 = clk_get_sys("mtu0", NULL);
> +
> +	clk_enable(clk0);
> +
> +	if (clk_get_rate(clk0) > (16 << 20))

16 * 1048576 = 16.777216MHz

> +}
> +
> +#ifdef CONFIG_PM
> +void nmdk_timer_suspend(void)
> +{
> +	struct clk *clk0;
...
> +	clk0 = clk_get_sys("mtu0", NULL);
> +
> +	clk_disable(clk0);
> +}
>  void __init nmdk_timer_init(void)
>  {
>  	unsigned long rate;
>  	struct clk *clk0;
> -	u32 cr;
>  
> +	/*
> +	 * On MTU block 0: timer0 is used as source,
> +	 * timer1 is used for events.
> +	 */
>  	clk0 = clk_get_sys("mtu0", NULL);
>  	BUG_ON(IS_ERR(clk0));
>  
> -	clk_enable(clk0);
> -

Given all these calls to clk_get_sys() vs the 4 bytes consumed by having
a static clk0 pointer, is it really worth repeatedly using clk_get_sys() ?
Wouldn't the static pointer be more efficient?

>  	/*
> -	 * Tick rate is 2.4MHz for Nomadik and 110MHz for ux500:
> +	 * Tick rate is 2.4MHz for Nomadik and 100 or 133MHz for ux500:
>  	 * use a divide-by-16 counter if it's more than 16MHz
>  	 */
> -	cr = MTU_CRn_32BITS;;
>  	rate = clk_get_rate(clk0);
> -	if (rate > 16 << 20) {
> +	if (rate > (16 << 20))

n << 20 doesn't give you MHz, so this code doesn't match the comments.
Do you mean 16MHz or 16.777216MHz ?
