From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 15:07:25 -0700
Subject: [RFC PATCH 2/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <1432327273-6810-3-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432327273-6810-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150604220725.GT676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22, Daniel Thompson wrote:
> +
> +#include <linux/clk.h>

Are you using this include?

> +#include <linux/clkdev.h>

Are you using this include?

> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include <linux/debugfs.h>

Are you using this include?

> +
> +static long clk_apb_mul_round_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long *prate)
> +{
> +	struct clk_apb_mul *am = to_clk_apb_mul(hw);
> +	unsigned long mult = 1;
> +
> +	if (readl(base + STM32F4_RCC_CFGR) & BIT(am->bit_idx))
> +		mult *= 2;

Isn't this the same as mult = 2? I guess we could rely on the
compiler to figure out this one.

> +
> +	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
> +		unsigned long best_parent = rate / mult;
> +
> +		*prate =
> +		    __clk_round_rate(__clk_get_parent(hw->clk), best_parent);
> +	}
> +
> +	return *prate * mult;
> +}
> +
> +static int clk_apb_mul_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{

Why don't we need to do anything here?

> +	return 0;
> +}
> +
> +static struct clk_ops clk_apb_mul_factor_ops = {

const?

> +	.round_rate = clk_apb_mul_round_rate,
> +	.set_rate = clk_apb_mul_set_rate,
> +	.recalc_rate = clk_apb_mul_recalc_rate,
> +};
> +
> +struct clk *clk_register_apb_mul(struct device *dev, const char *name,
> +				 const char *parent_name, unsigned long flags,
> +				 u8 bit_idx)
> +{
> +	struct clk_apb_mul *am;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +
> +	am = kzalloc(sizeof(*am), GFP_KERNEL);
> +	if (!am)
> +		return ERR_PTR(-ENOMEM);
> +
> +	am->bit_idx = bit_idx;
> +	am->hw.init = &init;
> +
> +	init.name = name;
> +	init.ops = &clk_apb_mul_factor_ops;
> +	init.flags = flags | CLK_IS_BASIC;

Is it basic?

> +	init.parent_names = &parent_name;
> +	init.num_parents = 1;
> +
> +	clk = clk_register(dev, &am->hw);
> +
> +	if (IS_ERR(clk))
> +		kfree(am);
> +
> +	return clk;
> +}
> +
> +static const char __initdata *sys_parents[] =   { "hsi", NULL, "pll" };

__initdata goes after the []

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
