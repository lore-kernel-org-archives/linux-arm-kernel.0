From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Aug 2010 07:27:50 +0200
Subject: [PATCH] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100811001931.GA4626@local>
References: <20100811001931.GA4626@local>
Message-ID: <20100811052749.GA7803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hans,

On Wed, Aug 11, 2010 at 02:19:33AM +0200, Hans J. Koch wrote:
> If a watchdog reset occurs after booting in internal boot mode, the i.MX35
> won't boot anymore. The boot ROM code seems to assume that some clocks are
> turned on (they are after a power-on reset). This patch turns on the
> necessary clocks.
> 
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>
> ---
>  arch/arm/mach-mx3/clock-imx35.c |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> index d3af0fd..671acb6 100644
> --- a/arch/arm/mach-mx3/clock-imx35.c
> +++ b/arch/arm/mach-mx3/clock-imx35.c
> @@ -485,7 +485,7 @@ static struct clk_lookup lookups[] = {
>  
>  int __init mx35_clocks_init()
>  {
> -	unsigned int ll = 0;
> +	unsigned int ll = 0, cgr2, cgr3;
>  
>  #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
>  	ll = (3 << 16);
> @@ -499,8 +499,22 @@ int __init mx35_clocks_init()
>  	__raw_writel((3 << 18), CCM_BASE + CCM_CGR0);
>  	__raw_writel((3 << 2) | (3 << 4) | (3 << 6) | (3 << 8) | (3 << 16),
>  			CCM_BASE + CCM_CGR1);
> -	__raw_writel((3 << 26) | ll, CCM_BASE + CCM_CGR2);
> -	__raw_writel(0, CCM_BASE + CCM_CGR3);
> +
> +	/* Check if we came up in internal boot mode. If yes, we need some
<nitpick> /* on an extra line please. </nitpick>

> +	 * extra clocks turned on, otherwise the MX35 boot ROM code will
> +	 * hang after a watchdog reset.
> +	 */
Better move the comment into the else branch below.

> +	if (__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10)) {
Can you please introduce a symbol for (3 << 10)?.

> +		cgr2 = (3 << 26);
> +		cgr3 = 0;
> +	} else {
> +		/* Additionally turn on UART1, SCC, and IIM clocks */
really UART1?

> +		cgr2 = (3 << 26) | (3 << 16) | (3 << 4);
> +		cgr3 = (3 << 2);
> +	}
I would prefer having symbolic names here, too, but this affects not
only your patch.  Will put it on my todo list.

Is it sensible to assume that the machine will boot in internal boot
mode again iff it came up this time in internal boot mode?  (I assume
yes, still I would reword the comment.  Something like the following?:

	In internal boot mode the MX35 boot ROM code seems to assume
	that UART1, SCC, and IIM clocks are on and hangs if they are
	not.  These are enabled by hardware after a power-on reset, but
	not after a watchdog reset.  So enable them here.
)

> +
> +	__raw_writel(cgr2 | ll, CCM_BASE + CCM_CGR2);
hmm, can you make this:

-	unsigned int ll = 0;
+	unsigned int cgr2 = 3 << 26, cgr3 = 0;
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	cgr2 |= 3 << 16;
 #endif
 ...
-...
+	if (!__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10)) {
+		/*
+		 * ...
+		 */
+		cgr2 |= 3 << 16 | 3 << 4;
+		cgr3 |= 3 << 2;
+	}
+
+	__raw_writel(cgr2, CCM_BASE + CCM_CGR2);
+	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);


> +	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
>  
>  	mxc_timer_init(&gpt_clk,
>  			MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
