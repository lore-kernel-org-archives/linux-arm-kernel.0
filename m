From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Oct 2012 22:52:48 +0200
Subject: [PATCH] video: imxfb: Do not crash on reboot
In-Reply-To: <1349703336-8105-1-git-send-email-fabio.estevam@freescale.com>
References: <1349703336-8105-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121008205248.GU1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 10:35:36AM -0300, Fabio Estevam wrote:
> Issuing a "reboot" command after the LCD times out causes the following
> warnings:
> 
> Requesting system reboot

[...]

> 
> This happens because "reboot" triggers imxfb_shutdown(), which calls
> imxfb_disable_controller with the clocks already disabled.
> 
> To prevent this, add a clock enabled status so that we can check if the clocks
> are enabled before disabling them. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/imxfb.c |   19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index f3363b2..6acf98a 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -134,6 +134,7 @@ struct imxfb_info {
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_ahb;
>  	struct clk		*clk_per;
> +	int			enabled;
>  
>  	/*
>  	 * These are the addresses we mapped
> @@ -530,9 +531,12 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  	 */
>  	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
>  
> -	clk_prepare_enable(fbi->clk_ipg);
> -	clk_prepare_enable(fbi->clk_ahb);
> -	clk_prepare_enable(fbi->clk_per);
> +	if (!fbi->enabled) {
> +		clk_prepare_enable(fbi->clk_ipg);
> +		clk_prepare_enable(fbi->clk_ahb);
> +		clk_prepare_enable(fbi->clk_per);
> +		fbi->enabled = 1;
> +	}
>  
>  	if (fbi->backlight_power)
>  		fbi->backlight_power(1);
> @@ -551,9 +555,12 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  
>  	writel(0, fbi->regs + LCDC_RMCR);
>  
> -	clk_disable_unprepare(fbi->clk_per);
> -	clk_disable_unprepare(fbi->clk_ipg);
> -	clk_disable_unprepare(fbi->clk_ahb);
> +	if (fbi->enabled) {
> +		clk_disable_unprepare(fbi->clk_per);
> +		clk_disable_unprepare(fbi->clk_ipg);
> +		clk_disable_unprepare(fbi->clk_ahb);
> +		fbi->enabled = 0;
> +	}

I think the complete functions should be protected, not only the clocks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
