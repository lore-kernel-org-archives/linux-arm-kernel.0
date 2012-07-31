From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 31 Jul 2012 19:43:58 +0200
Subject: [PATCH] ARM: imx35: don't disable the uart clock when DEBUG_LL
 is in use
In-Reply-To: <1343742279-29570-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343742279-29570-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120731174358.GC30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:44:39PM +0200, Uwe Kleine-K?nig wrote:
> Otherwise printch et al. and printk with earlyprintk and keep_bootcon
> becomes unfunctional when the clk framework disables all unused clocks.

Why don't you use the regular console? Letting the clock framework
disable the clocks was pretty much intentional.

Sascha

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-imx/clk-imx35.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index c6422fb..83d614c 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -271,6 +271,10 @@ int __init mx35_clocks_init()
>  	 */
>  	clk_prepare_enable(clk[scc_gate]);
>  
> +	/* Assert that the UART clock keeps running if DEBUG_LL is in use */
> +	if (IS_ENABLED(CONFIG_DEBUG_IMX31_IMX35_UART))
> +		clk_prepare_enable(clk[uart1_gate]);
> +
>  	imx_print_silicon_rev("i.MX35", mx35_revision());
>  
>  #ifdef CONFIG_MXC_USE_EPIT
> -- 
> 1.7.10.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
