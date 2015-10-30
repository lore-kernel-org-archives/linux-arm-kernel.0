From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Oct 2015 14:32:01 -0700
Subject: [PATCH 02/19] clk: sunxi: Add PLL3 clock
In-Reply-To: <1446214865-3972-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151030213155.GH19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30, Maxime Ripard wrote:
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index a9e1a5885846..40c32ffd912c 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -9,8 +9,9 @@ obj-y += clk-a10-mod1.o
>  obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
> -obj-y += clk-sun4i-display.o
>  obj-y += clk-simple-gates.o
> +obj-y += clk-sun4i-display.o

Put this in the right place in patch 1 please.

> +obj-y += clk-sun4i-pll3.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
>  obj-y += clk-sun9i-mmc.o
> diff --git a/drivers/clk/sunxi/clk-sun4i-pll3.c b/drivers/clk/sunxi/clk-sun4i-pll3.c
> new file mode 100644
> index 000000000000..7ea178bf19fa
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun4i-pll3.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright 2015 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>

#include <linux/of.h> for of_property_read_string()

> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN4I_A10_PLL3_GATE_BIT	31
[...]
> +
> +	clk = clk_register_composite(NULL, clk_name,
> +				     &parent, 1,
> +				     NULL, NULL,
> +				     &mult->hw, &clk_factor_ops,
> +				     &gate->hw, &clk_gate_ops,
> +				     0);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: Couldn't register the clock\n", clk_name);
> +		goto free_mult;
> +	}
> +
> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);

I hope this doesn't fail.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
