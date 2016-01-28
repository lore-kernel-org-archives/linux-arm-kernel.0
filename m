From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 14:32:13 +0800
Subject: [PATCH 1/1] imx25: Fix LCD pixelclock configuration
In-Reply-To: <1450902610-27224-1-git-send-email-csotoalonso@gmail.com>
References: <1450902610-27224-1-git-send-email-csotoalonso@gmail.com>
Message-ID: <20160128063213.GJ9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 09:30:10PM +0100, Carlos Soto wrote:
> Set LCDC base clock (per_7) parent clock to UPLL clock.
> This is needed to allow finer resolution in pixelclock
> 
> Signed-off-by: Carlos Soto <csotoalonso@gmail.com>
> ---
>  drivers/clk/imx/clk-imx25.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> index c4c141c..656340e 100644
> --- a/drivers/clk/imx/clk-imx25.c
> +++ b/drivers/clk/imx/clk-imx25.c
> @@ -238,6 +238,12 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
>  	clk_set_parent(clk[per5_sel], clk[ahb]);
>  
>  	/*
> +	 * set LCDC base clock (per 7) to highest possible frequency (UPLL)
> +	 * to get best resolution for pixel clock
> +	 */
> +	clk_set_parent(clk[per7_sel], clk[upll]);

This can be done in device tree via assigned-clock-parents without the
need of touching kernel.

Shawn

> +
> +	/*
>  	 * Let's initially set up CLKO parent as ipg, since this configuration
>  	 * is used on some imx25 board designs to clock the audio codec.
>  	 */
> -- 
> 1.7.10.4
> 
> 
