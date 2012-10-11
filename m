From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Oct 2012 18:01:08 +0530
Subject: [PATCH v2 04/13] clk: davinci - common clk driver initialization
In-Reply-To: <1348683037-9705-5-git-send-email-m-karicheri2@ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-5-git-send-email-m-karicheri2@ti.com>
Message-ID: <5076BC0C.3070106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Murali,

I have given this patch a partial review. I suspect this patch will
change much based on the comment I gave for 9/13.

On 9/26/2012 11:40 PM, Murali Karicheri wrote:
> This is the common clk driver initialization function for DaVinci
> SoCs and other SoCs that uses similar hardware architecture.
> Different clocks present in the SoC are passed to this function
> using a clk table and this function initialize the various drivers.
> Existing driver such as clk-fixed-rate, clk-divider, clk-mux and
> DaVinci specific clk drivers are initialized by this function.
> Also adds clock lookup for shared clocks used by various drivers.
> davinci-clock.h declares the various structures used for defining
> the DaVinci clocks.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 
> diff --git a/drivers/clk/davinci/davinci-clock.c b/drivers/clk/davinci/davinci-clock.c
> new file mode 100644
> index 0000000..cbd5201
> --- /dev/null
> +++ b/drivers/clk/davinci/davinci-clock.c
> @@ -0,0 +1,232 @@
> +/*
> + * Clock initialization code for DaVinci devices
> + *
> + * Copyright (C) 2006-2012 Texas Instruments.
> + * Copyright (C) 2008-2009 Deep Root Systems, LLC
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/platform_data/clk-davinci-pll.h>
> +#include <linux/platform_data/clk-keystone-pll.h>
> +#include <linux/platform_data/clk-davinci-psc.h>
> +#include <linux/platform_data/davinci-clock.h>

Needs to be kept sorted.

> +
> +static DEFINE_SPINLOCK(_lock);

No need of the underscore prefix.

> +
> +struct clk *davinci_lookup_clk(struct davinci_clk_lookup *clocks,
> +				const char *con_id)
> +{
> +	struct davinci_clk_lookup *c;
> +
> +	for (c = clocks; c->_clk; c++) {
> +		if (c->con_id && !strcmp(c->con_id, con_id))
> +			return c->clk;
> +	}
> +	return NULL;
> +}

This is a global function, but it is not exported in a header file.
Should this be static instead?

> +
> +#ifdef	CONFIG_CLK_DAVINCI_PLL
> +static void register_davinci_pll_clk(struct davinci_clk_lookup *c,
> +			struct clk_davinci_pll_data *pll_data)
> +{
> +
> +	WARN_ON(!pll_data->phy_pllm);

I don't think it is right to check for zero physical address. It is not
true on any of the DaVinci platforms, but it is possible to design
hardware where physical address of the PLL multipler is zero.

> +	pll_data->pllm = ioremap(pll_data->phy_pllm, 4);
> +	WARN_ON(!pll_data->pllm);

Along with the warning for users, you also need to return an -ENOMEM so
callers are aware? Or you can skip the WARN_ON and simply return -ENOMEM.

> +	if (pll_data->phy_prediv) {
> +		pll_data->prediv = ioremap(pll_data->phy_prediv, 4);
> +		WARN_ON(!pll_data->prediv);
> +	}
> +	if (pll_data->phy_postdiv) {
> +		pll_data->postdiv = ioremap(pll_data->phy_postdiv, 4);
> +		WARN_ON(!pll_data->postdiv);
> +	}

Comments above apply here as well.

> +	c->clk = clk_register_davinci_pll(NULL,
> +			c->_clk->name, c->_clk->parent->name,
> +			pll_data);
> +}
> +#else
> +static void register_davinci_pll_clk(struct davinci_clk_lookup *c,
> +			struct clk_davinci_pll_data *pll_data)
> +{
> +	return;
> +}
> +#endif
> +
> +#ifdef	CONFIG_CLK_KEYSTONE_PLL
> +static void register_keystone_pll_clk(struct davinci_clk_lookup *c,
> +			struct clk_keystone_pll_data *pll_data)
> +{
> +	WARN_ON(!pll_data->phy_pllm);
> +	pll_data->pllm = ioremap(pll_data->phy_pllm, 4);
> +	WARN_ON(!pll_data->pllm);
> +	WARN_ON(!pll_data->phy_main_pll_ctl0);
> +	pll_data->main_pll_ctl0 =
> +		ioremap(pll_data->phy_main_pll_ctl0, 4);
> +	WARN_ON(!pll_data->main_pll_ctl0);
> +	c->clk = clk_register_keystone_pll(NULL,
> +			c->_clk->name, c->_clk->parent->name,
> +			 pll_data);
> +}
> +#else
> +static void register_keystone_pll_clk(struct davinci_clk_lookup *c,
> +			struct clk_keystone_pll_data *pll_data)
> +{
> +	return;
> +}
> +#endif
> +
> +int __init davinci_common_clk_init(struct davinci_clk_lookup *clocks,
> +				struct davinci_dev_lookup *dev_clk_lookups,
> +				u8 num_gpscs, u32 *psc_bases)

psc_bases should be of type phys_add_t.

> +{
> +	void __iomem **base = NULL, *reg;
> +	struct davinci_clk_lookup *c;
> +	struct davinci_clk *_clk;
> +	unsigned long rate;
> +	int i, skip;
> +
> +	WARN_ON(!num_gpscs);

Need to return error if this is hit. In general revisit the need to
return an error wherever you have WARN_ON().

Thanks,
Sekhar
