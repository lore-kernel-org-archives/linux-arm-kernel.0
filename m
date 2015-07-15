From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jul 2015 16:48:23 -0700
Subject: [PATCH 1/3] drivers: clk: st: Support for enable/disable in
 Clockgen PLLs
In-Reply-To: <1436443060-12866-2-git-send-email-gabriel.fernandez@linaro.org>
References: <1436443060-12866-1-git-send-email-gabriel.fernandez@linaro.org>
 <1436443060-12866-2-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150715234823.GT30412@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09, Gabriel Fernandez wrote:
> @@ -270,6 +285,73 @@ static int clkgen_pll_is_enabled(struct clk_hw *hw)
>  	return !poweroff;
>  }
>  
> +static int __clkgen_pll_enable(struct clk_hw *hw)
> +{
> +	struct clkgen_pll *pll = to_clkgen_pll(hw);
> +	unsigned long timeout;
> +	int ret = 0;
> +
> +	if (clkgen_pll_is_enabled(hw))
> +		return 0;
> +
> +	CLKGEN_WRITE(pll, pdn_ctrl, 0);
> +
> +	timeout = jiffies + msecs_to_jiffies(10);

Jiffies isn't guaranteed to increment here because
.enable/.disable is called with irqs disabled and if this is the
only CPU running it won't be getting interrupts to update
jiffies.

> +
> +	while (!clkgen_pll_is_locked(hw)) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +		cpu_relax();
> +	}
> +
> +	pr_debug("%s:%s enabled\n", __clk_get_name(hw->clk), __func__);
> +
> +	return ret;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
