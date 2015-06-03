From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 3 Jun 2015 16:50:21 -0700
Subject: [PATCH v5 2/4] clk: zx: add clock support to zx296702
In-Reply-To: <1432867178-5913-1-git-send-email-jun.nie@linaro.org>
References: <1432867178-5913-1-git-send-email-jun.nie@linaro.org>
Message-ID: <20150603235021.GC490@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29, Jun Nie wrote:
> diff --git a/drivers/clk/zte/clk-pll.c b/drivers/clk/zte/clk-pll.c
> new file mode 100644
> index 0000000..422ef25
> --- /dev/null
> +++ b/drivers/clk/zte/clk-pll.c
> @@ -0,0 +1,184 @@
> +/*
> + * Copyright 2014 Linaro Ltd.
> + * Copyright (C) 2014 ZTE Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>

Do you need this include?

> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
[...]
> +
> +static int hw_to_idx(struct clk_zx_pll *zx_pll)
> +{
> +	const struct zx_pll_config *config = zx_pll->lookup_table;
> +	u32 hw_cfg0, hw_cfg1;
> +	int i;
> +
> +	hw_cfg0 = readl_relaxed(zx_pll->reg_base);
> +	hw_cfg1 = readl_relaxed(zx_pll->reg_base + CFG0_CFG1_OFFSET);
> +
> +	/* For matching the value in lookup table */
> +	hw_cfg0 &= ~LOCK_FLAG;
> +	hw_cfg0 |= POWER_DOWN;
> +
> +	for (i = 0; i < zx_pll->count; i++) {
> +		if (hw_cfg0 == config[i].cfg0 && hw_cfg1 == config[i].cfg1)
> +			return i;
> +	}
> +
> +	return -1;

How about a real error code? -EINVAL?

> +}
> +
[...]
> +
> +static int zx_pll_enable(struct clk_hw *hw)
> +{
> +	struct clk_zx_pll *zx_pll = to_clk_zx_pll(hw);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +	u32 reg;
> +
> +	reg = readl_relaxed(zx_pll->reg_base);
> +	writel_relaxed(reg & ~POWER_DOWN, zx_pll->reg_base);
> +
> +	return readl_relaxed_poll_timeout(zx_pll->reg_base, reg,
> +					  reg & LOCK_FLAG, 0, 100);
> +

This is odd. A return and then more code?

> +	while (!(readl_relaxed(zx_pll->reg_base) & LOCK_FLAG)) {
> +		if (time_after(jiffies, timeout)) {
> +			pr_err("clk %s enable timeout\n",
> +				__clk_get_name(hw->clk));
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
