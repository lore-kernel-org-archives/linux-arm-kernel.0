From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Dec 2011 11:00:41 +0100
Subject: [PATCH 09/19] clock-imx35: fix reboot in internal boot modeg
In-Reply-To: <1323757911-25217-9-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-9-git-send-email-eric@eukrea.com>
Message-ID: <20111213100041.GG27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 07:31:41AM +0100, Eric B?nard wrote:
> commit 8d75a2620dc3e33ce504044c375c443ed7ed4128 disable IIM
> clock after reading silicon revision which will prevent
> reboot in internal boot mode (see comment a few line before)

I'm a bit unsure. The fix you suggest is the least intrusive, but
a proper fix would be to move the mentioned block below the
imx_print_silicon_rev, like this:

	clk_enable(&iim_clk);
	imx_print_silicon_rev("i.MX35", mx35_revision());
	clk_disable(&iim_clk);

	/*
	 * Check if we came up in internal boot mode. If yes, we need
	 * some
	 * extra clocks turned on, otherwise the MX35 boot ROM code will
	 * hang after a watchdog reset.
	 */
	if (!(__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10))) {
		clk_enable(&iim_clk);
		clk_enable(&uart1_clk);
		clk_enable(&scc_clk);
	}

This would also get the clk enable counters right.

Sascha

> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  arch/arm/mach-imx/clock-imx35.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
> index 8116f11..b49a732 100644
> --- a/arch/arm/mach-imx/clock-imx35.c
> +++ b/arch/arm/mach-imx/clock-imx35.c
> @@ -538,7 +538,10 @@ int __init mx35_clocks_init()
>  
>  	clk_enable(&iim_clk);
>  	imx_print_silicon_rev("i.MX35", mx35_revision());
> -	clk_disable(&iim_clk);
> +	/* Don't disable IIM clock if we came up in internal boot mode */
> +	if (__raw_readl(CCM_BASE + CCM_RCSR) & (3 << 10)) {
> +		clk_disable(&iim_clk);
> +	}
>  
>  #ifdef CONFIG_MXC_USE_EPIT
>  	epit_timer_init(&epit1_clk,
> -- 
> 1.7.6.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
