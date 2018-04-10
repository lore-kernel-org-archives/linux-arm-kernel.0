From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 10 Apr 2018 10:32:12 +0200
Subject: [PATCH v2 2/2] clk: at91: Fix for PLL set_rate changes not
 being actually written to PLL peripheral bits
In-Reply-To: <20180410001649.GA62245@hak8or>
References: <20180410001649.GA62245@hak8or>
Message-ID: <20180410103212.7bb1d48c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On Mon, 9 Apr 2018 20:16:49 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> When a USB device is connected to the USB host port on the SAM9N12 then
> you get "-62" error which seems to indicate USB replies from the device
> are timing out. Looking around, I saw the USB bus was running at half
> speed. Going further, it seems that in ..._set_rate() the PLL wasn't
> actually being adjusted. Writing the multiplier and divider values to
> the peripheral fixes the bus running at half speed.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> ---
>  drivers/clk/at91/clk-pll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 534961766ae5..db7155fe9346 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -288,6 +288,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	pll->div = div;
>  	pll->mul = mul;
>  
> +	// Set the PLL as per above div and mil values.
					    ^ mul

Please do not use C++-style comments, use /* comment */ instead.

> +	regmap_update_bits(pll->regmap, AT91_CKGR_PLLBR,

You hardcode the PLL ID here. What if this function if called for PLLA?

> +		AT91_PMC_DIV | AT91_PMC_MUL,

You should use PLL_MUL_MASK(layout) and PLL_DIV_MASK to do that.

> +		(div << 0) | (mul << 16));

This is wrong. The clk has the CLK_SET_RATE_GATE set, which means the
rate cannot be updated if the PLL is not gated, and if you look at
clk_pll_prepare(), you'll see that div and mul fields are updated
there. Now, maybe there's a bug in clk_pll_prepare(), but
clk_pll_set_rate() is definitely not the place where we want ->div and
->mul to be written to the register.

> +
> +	pr_debug("clk-pll: setting new rate, (%lu hz / %u) * %u = %lu hz\n",
> +		parent_rate, div, mul, rate);
> +
>  	return 0;
>  }
>  

Regards,

Boris
