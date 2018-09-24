From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 24 Sep 2018 08:47:03 +0200
Subject: [PATCH v8 4/5] clk: imx: add imx composite clock
In-Reply-To: <1537531894-18499-5-git-send-email-abel.vesa@nxp.com>
References: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
 <1537531894-18499-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <20180924064703.GY4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On Fri, Sep 21, 2018 at 03:11:33PM +0300, Abel Vesa wrote:
> Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one composite clock,
> but we need to deal with both predivider and divider at the same time and
> therefore we add the imx_clk_composite_divider_ops and register the composite
> clock with those.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/imx/Makefile        |   1 +
>  drivers/clk/imx/clk-composite.c | 156 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk.h           |  14 ++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-composite.c
> 
> +static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
> +					unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	unsigned long prediv_rate;
> +	unsigned long flags = 0;
> +	int prediv_value;
> +	int div_value;
> +	u32 val;
> +
> +	prediv_value = divider_get_val(rate, parent_rate, NULL,
> +				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +	if (prediv_value < 0)
> +		return prediv_value;
> +
> +	prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
> +
> +	div_value = divider_get_val(rate, prediv_rate, NULL,
> +				PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
> +	if (div_value < 0)
> +		return div_value;

Does this work with expected accuracy? Consider the best divider you are
looking for is 9. With the above you'll end up with a predivider of 8
and a postdivider of 1 instead of the optimum divider values of 3 and 3.

I think you have to iterate over all possible divider combinations and
then use the best one found. The original divider code does this, albeit
a little obfuscated.

You have to do the same in round_rate aswell.

Sorry, I missed that when I last looked at it in v6.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
