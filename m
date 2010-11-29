From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 29 Nov 2010 10:58:33 +0100
Subject: [PATCH] prevent 'BUG: sleeping function called from invalid
	context' in arch_reset()
In-Reply-To: <19699.29070.822244.938508@ipc1.ka-ro>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-4-git-send-email-shawn.guo@freescale.com>
	<19695.32386.279224.624305@ipc1.ka-ro>
	<20101126095733.GA27637@pengutronix.de>
	<19695.36407.793411.550458@ipc1.ka-ro>
	<20101126113255.GC27637@pengutronix.de>
	<19699.29070.822244.938508@ipc1.ka-ro>
Message-ID: <20101129095833.GB20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Mon, Nov 29, 2010 at 10:25:34AM +0100, Lothar Wa?mann wrote:
> arch_reset() may be called from interrupt context (e.g. induced by
> SYSRQ-B), thus clk_get() and clk_enable() must not be called from
> within arch_reset(). Move these calls to mxc_arch_reset_init().
I wonder if SYSRQ-B is the only way to trigger that.  And if yes if that
could be "fixed" to allow sleeping?!

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
> diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> index c3972c5..9b02251 100644
> --- a/arch/arm/plat-mxc/system.c
> +++ b/arch/arm/plat-mxc/system.c
> @@ -53,11 +53,6 @@ void arch_reset(char mode, const char *cmd)
>  	if (cpu_is_mx1()) {
>  		wcr_enable = (1 << 0);
>  	} else {
> -		struct clk *clk;
> -
> -		clk = clk_get_sys("imx-wdt.0", NULL);
> -		if (!IS_ERR(clk))
> -			clk_enable(clk);
>  		wcr_enable = (1 << 2);
>  	}
>  
> @@ -78,5 +73,14 @@ void arch_reset(char mode, const char *cmd)
>  
>  void mxc_arch_reset_init(void __iomem *base)
>  {
> +	struct clk *clk;
> +
>  	wdog_base = base;
> +
> +	if (cpu_is_mx1())
> +		return;
> +
> +	clk = clk_get_sys("imx-wdt.0", NULL);
> +	if (!IS_ERR(clk))
> +		clk_enable(clk);
>  }
Unrelated to this patch, I wonder why this isn't named "imx2-wdt.0".  I
just checked, the driver (drivers/watchdog/imx2_wdt.c) uses clk_get_sys,
too.  IMHO we should rename that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
