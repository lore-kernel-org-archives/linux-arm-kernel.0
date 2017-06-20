From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:59:17 -0700
Subject: [PATCH 4/9] clk: imx: add pllv4 support
In-Reply-To: <1494856763-6543-5-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170620015917.GO4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Dong Aisheng wrote:
>  obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
> diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
> new file mode 100644
> index 0000000..502da64
> --- /dev/null
> +++ b/drivers/clk/imx/clk-pllv4.c
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP
> + *
> + * Author: Dong Aisheng <aisheng.dong@nxp.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +/* PLL Control Status Register (xPLLCSR) */
> +#define PLL_CSR_OFFSET		0x0
> +#define PLL_VLD			BIT(24)
> +#define PLL_EN			BIT(0)
> +
> +/* PLL Configuration Register (xPLLCFG) */
> +#define PLL_CFG_OFFSET		0x08
> +#define BP_PLL_MULT		16
> +#define BM_PLL_MULT		(0x7f << 16)
> +
> +/* PLL Numerator Register (xPLLNUM) */
> +#define PLL_NUM_OFFSET		0x10
> +
> +/* PLL Denominator Register (xPLLDENOM) */
> +#define PLL_DENOM_OFFSET	0x14
> +
> +struct clk_pllv4 {
> +	struct clk_hw	hw;
> +	void __iomem	*base;
> +};
> +
> +/* Valid PLL MULT Table */
> +static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
> +
> +#define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
> +
> +static int clk_pllv4_wait_lock(struct clk_pllv4 *pll)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(5);
> +
> +	/* Wait for PLL to lock */
> +	do {
> +		if (readl_relaxed(pll->base  + PLL_CSR_OFFSET) & PLL_VLD)
> +			break;
> +		if (time_after(jiffies, timeout))
> +			break;
> +			usleep_range(50, 500);
> +	} while (1);
> +
> +	return readl_relaxed(pll->base + PLL_CSR_OFFSET) & PLL_VLD ?
> +	       0 : -ETIMEDOUT;

Use readl_poll_timeout() instead?

> +}
> +
> +static int clk_pllv4_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_pllv4 *pll = to_clk_pllv4(hw);
> +
> +	if (readl_relaxed(pll->base) & PLL_EN)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
> +					   unsigned long parent_rate)
> +{
> +	struct clk_pllv4 *pll = to_clk_pllv4(hw);
> +	u32 div;
> +
> +	div = (readl_relaxed(pll->base + PLL_CFG_OFFSET)
> +	       & BM_PLL_MULT) >> BP_PLL_MULT;

Put that on multiple lines please:

	div = readl_relaxed(pll->base + PLL_CFG_OFFSET);
	div &= BM_PLL_MULT;
	div >>= BP_PLL_MULT; /* Why BP this time? */

> +
> +	return parent_rate * div;
> +}
> +
> +static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long *prate)
> +{
> +	unsigned long parent_rate = *prate;
> +	unsigned long round_rate, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +		round_rate = parent_rate * pllv4_mult_table[i];
> +		if (rate >= round_rate)
> +			return round_rate;
> +	}
> +
> +	return round_rate;
> +}
> +
> +static bool clk_pllv4_is_valid_mult(unsigned int mult)
> +{
> +	int i;
> +
> +	/* check if mult is in valid MULT table */
> +	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +		if (pllv4_mult_table[i] == mult)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
> +			      unsigned long parent_rate)
> +{
> +	struct clk_pllv4 *pll = to_clk_pllv4(hw);
> +	u32 val, mult;
> +
> +	if (clk_pllv4_is_enabled(hw)) {
> +		WARN(1, "clk_pllv4: can't change rate when pll is enabled");
> +		return -EINVAL;

Sad, CLK_SET_RATE_GATE isn't working for you I suppose?

> +	}
> +
> +	mult = rate / parent_rate;
> +
> +	if (clk_pllv4_is_valid_mult(mult))
> +		return -EINVAL;
> +
> +	val = readl_relaxed(pll->base + PLL_CFG_OFFSET);
> +	val &= ~BM_PLL_MULT;
> +	val |= mult << BP_PLL_MULT;
> +	writel_relaxed(val, pll->base + PLL_CFG_OFFSET);
> +
> +	return 0;
> +}
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
