From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 15:38:36 -0700
Subject: [PATCH 2/5] clk: berlin: add common clk driver for newer SoCs
In-Reply-To: <1442931156-5877-3-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
 <1442931156-5877-3-git-send-email-jszhang@marvell.com>
Message-ID: <20151001223836.GR19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22, Jisheng Zhang wrote:
> +
> +static u8 clk_div[] = {1, 2, 4, 6, 8, 12, 1, 1};
> +
> +static unsigned long berlin_clk_recalc_rate(struct clk_hw *hw,
> +					unsigned long parent_rate)
> +{
> +	u32 val, divider;
> +	struct berlin_clk *clk = to_berlin_clk(hw);
> +
> +	val = readl_relaxed(clk->base);
> +	if (val & CLKD3SWITCH)
> +		divider = 3;
> +	else {
> +		if (val & CLKSWITCH) {
> +			val >>= CLKSEL_SHIFT;
> +			val &= CLKSEL_MASK;
> +			divider = clk_div[val];
> +		} else
> +			divider = 1;
> +	}

How about we drop the clk_div array and use code?

		if (val & CLKSWITCH) {
			val >>= CLKSEL_SHIFT;
			val &= CLKSEL_MASK;
		}

		divider = 1
		if (val < 6)
			divider <<= val;

> +
> +	return parent_rate / divider;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
