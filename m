From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 12:28:27 +0800
Subject: [PATCH] clk: imx: increase AXI clock rate to 264MHz for i.MX6UL
In-Reply-To: <1438870436-16061-1-git-send-email-b20788@freescale.com>
References: <1438870436-16061-1-git-send-email-b20788@freescale.com>
Message-ID: <20150906042827.GC30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:13:56PM +0800, Anson Huang wrote:
> On i.MX6UL, AXI clock rate's design target is 264MHz, but by default
> it is only set to 198MHz which is NOT good enough for performance,
> this patch increases AXI clock rate from 198MHz to 264MHz to meet
> the design target, this is done by switching its parent clock
> "periph" from 396MHz PFD to 528MHz PLL.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.

But please remember to copy not only linux-clk list but also clk maintainers Michael
and Stephen for future i.MX clock patches.

Shawn

> ---
>  drivers/clk/imx/clk-imx6ul.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index aaa3665..01718d0 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -407,6 +407,24 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	clk_data.clk_num = ARRAY_SIZE(clks);
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  
> +	/*
> +	 * Lower the AHB clock rate before changing the parent clock source,
> +	 * as AHB clock rate can NOT be higher than 133MHz, but its parent
> +	 * will be switched from 396MHz PFD to 528MHz PLL in order to increase
> +	 * AXI clock rate, so we need to lower AHB rate first to make sure at
> +	 * any time, AHB rate is <= 133MHz.
> +	 */
> +	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
> +
> +	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_CLK2]);
> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE], clks[IMX6UL_CLK_PLL2_BUS]);
> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_PRE]);
> +
> +	/* Make sure AHB rate is 132MHz  */
> +	clk_set_rate(clks[IMX6UL_CLK_AHB], 132000000);
> +
>  	/* set perclk to from OSC */
>  	clk_set_parent(clks[IMX6UL_CLK_PERCLK_SEL], clks[IMX6UL_CLK_OSC]);
>  
> -- 
> 1.9.1
> 
