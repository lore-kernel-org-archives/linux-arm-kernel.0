From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 31 Oct 2012 17:59:34 +0530
Subject: [PATCH v3 01/11] clk: davinci - add main PLL clock driver
In-Reply-To: <1351181518-11882-2-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <509119AE.6050505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

On 10/25/2012 9:41 PM, Murali Karicheri wrote:
> This is the driver for the main PLL clock hardware found on DM SoCs.
> This driver borrowed code from arch/arm/mach-davinci/clock.c and
> implemented the driver as per common clock provider API. The main PLL
> hardware typically has a multiplier, a pre-divider and a post-divider.
> Some of the SoCs has the divider fixed meaning they can not be
> configured through a register. HAS_PREDIV and HAS_POSTDIV flags are used
> to tell the driver if a hardware has these dividers present or not.
> Driver is configured through the struct clk_pll_data that has the
> SoC specific clock data.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---

> diff --git a/drivers/clk/davinci/clk-pll.c b/drivers/clk/davinci/clk-pll.c

> +static unsigned long clk_pllclk_recalc(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	struct clk_pll *pll = to_clk_pll(hw);
> +	struct clk_pll_data *pll_data = pll->pll_data;
> +	u32 mult = 1, prediv = 1, postdiv = 1;

No need to initialize mult here. I gave this comment last time around as
well.

> +	unsigned long rate = parent_rate;
> +
> +	mult = readl(pll_data->reg_pllm);
> +
> +	/*
> +	 * if fixed_multiplier is non zero, multiply pllm value by this
> +	 * value.
> +	 */
> +	if (pll_data->fixed_multiplier)
> +		mult =  pll_data->fixed_multiplier *
> +				(mult & pll_data->pllm_mask);
> +	else
> +		mult = (mult & pll_data->pllm_mask) + 1;

Hmm, this is interpreting the 'mult' register field differently in both
cases. In one case it is 'actual multiplier - 1' and in other case it is
the 'actual multiplier' itself. Can we be sure that the mult register
definition will change whenever there is a fixed multiplier in the PLL
block? I don't think any of the existing DaVinci devices have a fixed
multiplier. Is this on keystone?

> +struct clk *clk_register_davinci_pll(struct device *dev, const char *name,
> +			const char *parent_name,
> +			struct clk_pll_data *pll_data)
> +{
> +	struct clk_init_data init;
> +	struct clk_pll *pll;
> +	struct clk *clk;
> +
> +	if (!pll_data)
> +		return ERR_PTR(-ENODEV);

-EINVAL? Clearly you are treating NULL value as an invalid argument here.

Thanks,
Sekhar
