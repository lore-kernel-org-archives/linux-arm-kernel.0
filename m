From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 09:27:49 +0200
Subject: [PATCH v3] video: imxfb: Do not crash on reboot
In-Reply-To: <1349789541-5159-1-git-send-email-fabio.estevam@freescale.com>
References: <1349789541-5159-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121010072749.GK27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 10:32:21AM -0300, Fabio Estevam wrote:
> Issuing a "reboot" command after the LCD times out causes the following
> warnings:
> 
> This happens because "reboot" triggers imxfb_shutdown(), which calls
> imxfb_disable_controller with the clocks already disabled.
> 
> To prevent this, add a clock enabled status so that we can check if the clocks
> are enabled before disabling them. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v2:
> - Use a better naming for the clk enabled variable

This is probably due to Uwes comment. At that time the enabled variable
tracked the clk state. Now it tracks the state of the whole controller,
so indeed enabled or maybe fb_enabled would be better.

Anyway, this is only nitpicking, so:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> - Return immediately in imxfb_enable_controller/imxfb_disable_controller
> if the the clocks are already enabled/disabled.
> Changes since v1:
> - Protect the whole function instead of only the clocks
>  drivers/video/imxfb.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index cf2688d..e0d770f 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -134,6 +134,7 @@ struct imxfb_info {
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_ahb;
>  	struct clk		*clk_per;
> +	int			clks_enabled;
>  
>  	/*
>  	 * These are the addresses we mapped
> @@ -513,6 +514,9 @@ static void imxfb_exit_backlight(struct imxfb_info *fbi)
>  
>  static void imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	if (fbi->clks_enabled)
> +		return;
> +
>  	pr_debug("Enabling LCD controller\n");
>  
>  	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
> @@ -533,6 +537,7 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  	clk_prepare_enable(fbi->clk_ipg);
>  	clk_prepare_enable(fbi->clk_ahb);
>  	clk_prepare_enable(fbi->clk_per);
> +	fbi->clks_enabled = 1;
>  
>  	if (fbi->backlight_power)
>  		fbi->backlight_power(1);
> @@ -542,6 +547,9 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
>  {
> +	if (!fbi->clks_enabled)
> +		return;
> +
>  	pr_debug("Disabling LCD controller\n");
>  
>  	if (fbi->backlight_power)
> @@ -552,6 +560,7 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  	clk_disable_unprepare(fbi->clk_per);
>  	clk_disable_unprepare(fbi->clk_ipg);
>  	clk_disable_unprepare(fbi->clk_ahb);
> +	fbi->clks_enabled = 0;
>  
>  	writel(0, fbi->regs + LCDC_RMCR);
>  }
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
