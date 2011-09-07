From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Sep 2011 20:21:42 +0200
Subject: [PATCH v2 2/3] ARM: mx28evk: set a initial clock rate for saif
In-Reply-To: <1315403858-9904-3-git-send-email-b29396@freescale.com>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-3-git-send-email-b29396@freescale.com>
Message-ID: <20110907182142.GY28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 09:57:37PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> 
> ---
> No changes since v1.
> 
> Note this patch still needs another patch from Wolfram to work.
> I send out it in this series as
> [PATCH 3/3] arm: mxs: disable clock-gates when setting saif-clocks
If your patch 2 depends on patch 3 there is something fishy.

> 
> As discussed with Wolfram, that patch may still have some later work
> to do. However, we just send out it for testers to work first.
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index f0c7cb6..33cc2ff 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -826,6 +826,15 @@ int __init mx28_clocks_init(void)
>  	clk_set_parent(&saif0_clk, &pll0_clk);
>  	clk_set_parent(&saif1_clk, &pll0_clk);
>  
> +	/*
> +	 * Set an initial clk rate for saif's internal logic to work properly,
> +	 * this is especially for the saif working on EXTMASTER mode that who
> +	 * uses other saif's BITCLK&LRCLK but it still needs a basic clk which
> +	 * should be bigger enough for its internal logic.
This is not a proper (German) English sentence. Maybe this is better?:

	Set an initial clock rate for the saif internal logic to work
	properly. This is important when working in EXTMASTER mode that
	uses the other saif's BITCLK&LRCLK but it still needs a basic
	clock which should be fast enough for the internal logic.

> +	 */
> +	clk_set_rate(&saif0_clk, 24000000);
> +	clk_set_rate(&saif1_clk, 24000000);
> +
Do you need to check for clk_set_rate returning -ESOMETHING here?

Uwe
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
