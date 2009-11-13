From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Nov 2009 08:52:10 +0100
Subject: [PATCH] [ARM] IMX: don't disable the uart clock if DEBUG_LL
	uses it
In-Reply-To: <1258062989-14493-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1258062989-14493-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091113075210.GF30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 10:56:29PM +0100, Uwe Kleine-K?nig wrote:
> Before the clock was left enabled only for DEBUG_LL_CONSOLE which
> requires an additional patch to exist at all.  With this patch applied
> DEBUG_LL_CONSOLE depends on DEBUG_LL, so this doesn't break.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx2/clock_imx21.c |    2 +-
>  arch/arm/mach-mx2/clock_imx27.c |    2 +-
>  arch/arm/mach-mx3/clock-imx35.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
> index eede798..91901b5 100644
> --- a/arch/arm/mach-mx2/clock_imx21.c
> +++ b/arch/arm/mach-mx2/clock_imx21.c
> @@ -1000,7 +1000,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
>  	clk_enable(&per_clk[0]);
>  	clk_enable(&gpio_clk);
>  
> -#ifdef CONFIG_DEBUG_LL_CONSOLE
> +#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)

If Catalins/my early printk patch goes in, wouldn't it be better to do
a

#if defined(CONFIG_EARLY_PRINTK) && !defined(CONFIG_DEBUG_ICEDCC)

here?


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
