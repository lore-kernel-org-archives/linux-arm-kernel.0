From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Feb 2016 16:07:13 -0800
Subject: [PATCH v2] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <1451298003-28841-1-git-send-email-yamada.masahiro@socionext.com>
References: <1451298003-28841-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160226000713.GO28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28, Masahiro Yamada wrote:
> This is the initial commit for the UniPhier clock drivers, including
> support for PH1-sLD3, PH1-LD4, PH1-Pro4, PH1-sLD8, PH1-Pro5, and
> ProXstream2/PH1-LD6b.
> 
> To improve the code maintainability, the driver consists of common
> functions (clk-uniphier-core.c) and clock data arrays needed to
> support each SoC.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Where's the DT binding? Also, can these clks be registered from a
platform device driver instead of from 
> 
> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
> new file mode 100644
> index 0000000..7606f27
> --- /dev/null
> +++ b/drivers/clk/uniphier/Kconfig
> @@ -0,0 +1,35 @@
> +menuconfig CLK_UNIPHIER
> +	bool "Clock drivers for UniPhier SoCs"
> +	depends on ARCH_UNIPHIER

Can we have COMPILE_TEST here?

> +	depends on OF
> +	default y

And then default ARCH_UNIPHIER instead.

> +	help
> +	  Supports clock drivers for UniPhier SoCs.
> +
> +if CLK_UNIPHIER
> +
> +config CLK_UNIPHIER_PH1_SLD3
> +	bool "Clock driver for UniPhier PH1-sLD3 SoC"
> +	default y

These would all become default ARCH_UNIPHIER as well.
> +
> +config CLK_UNIPHIER_PH1_LD4
> +	bool "Clock driver for UniPhier PH1-LD4 SoC"
> +	default y
> +
> +config CLK_UNIPHIER_PH1_PRO4
> +	bool "Clock driver for UniPhier PH1-Pro4 SoC"
> +	default y
> +
> +config CLK_UNIPHIER_PH1_SLD8
> +	bool "Clock driver for UniPhier PH1-sLD8 SoC"
> +	default y
> +
> +config CLK_UNIPHIER_PH1_PRO5
> +	bool "Clock driver for UniPhier PH1-Pro5 SoC"
> +	default y
> +
> +config CLK_UNIPHIER_PROXSTREAM2
> +	bool "Clock driver for UniPhier ProXstream2/PH1-LD6b SoC"
> +	default y
> +
> +endif
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c

Maybe this patch can be split between core code and SoC specific
data? That way we can focus on the core code without wading
through all the random clk data arrays.

> new file mode 100644
> index 0000000..8680101
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -0,0 +1,151 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
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
> +#define pr_fmt(fmt)		"uniphier-clk: " fmt
> +
> +#include <linux/clk-provider.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk-uniphier.h"
> +
> +static void __init uniphier_clk_update_parent_name(struct device_node *np,
> +						   const char **parent_name)
> +{
> +	const char *new_name;
> +	int index;
> +
> +	if (!parent_name || !*parent_name)
> +		return;
> +
> +	if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
> +		return;
> +
> +	index = of_property_match_string(np, "clock-names",
> +				*parent_name + strlen(UNIPHIER_CLK_EXT));

If possible please don't use clock-names to set up clock
hierarchy.

> +	new_name = of_clk_get_parent_name(np, index);
> +	if (new_name)
> +		*parent_name = new_name;
> +}
> +
> +static struct clk * __init uniphier_clk_register(struct device_node *np,
> +						 void __iomem *regbase,
> +					  struct uniphier_clk_init_data *idata)
> +{
> +	int i;
> +
> +	switch (idata->type) {
> +	case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
> +		uniphier_clk_update_parent_name(np,
> +					&idata->data.factor.parent_name);
> +		return clk_register_fixed_factor(NULL, idata->name,
> +						 idata->data.factor.parent_name,
> +						 CLK_SET_RATE_PARENT,
> +						 idata->data.factor.mult,
> +						 idata->data.factor.div);
> +	case UNIPHIER_CLK_TYPE_FIXED_RATE:
> +		return clk_register_fixed_rate(NULL, idata->name, NULL,
> +					       CLK_IS_ROOT,
> +					       idata->data.rate.fixed_rate);
> +	case UNIPHIER_CLK_TYPE_GATE:
> +		uniphier_clk_update_parent_name(np,
> +						&idata->data.gate.parent_name);
> +		return clk_register_gate(NULL, idata->name,
> +					 idata->data.gate.parent_name,
> +					 idata->data.gate.parent_name ?
> +					 CLK_SET_RATE_PARENT : CLK_IS_ROOT,
> +					 regbase + idata->data.gate.reg,
> +					 idata->data.gate.bit_idx, 0, NULL);
> +	case UNIPHIER_CLK_TYPE_MUX:
> +		for (i = 0; i < idata->data.mux.num_parents; i++)
> +			uniphier_clk_update_parent_name(np,
> +					&idata->data.mux.parent_names[i]);
> +		return clk_register_mux(NULL, idata->name,
> +					idata->data.mux.parent_names,
> +					idata->data.mux.num_parents,
> +					CLK_SET_RATE_PARENT,
> +					regbase + idata->data.mux.reg,
> +					idata->data.mux.shift,
> +					ilog2(idata->data.mux.num_parents),
> +					0, NULL);
> +	default:
> +		WARN(1, "unsupported clock type\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +}
> +
> +int __init uniphier_clk_init(struct device_node *np,
> +			     struct uniphier_clk_init_data *idata)
> +{
> +	struct clk_onecell_data *clk_data;
> +	struct uniphier_clk_init_data *p;
> +	void __iomem *regbase;
> +	int max_index = 0;
> +	int ret;
> +
> +	regbase = of_iomap(np, 0);

If not a platform device, use of_io_request_and_map()?

> +	if (!regbase)
> +		return -ENOMEM;
> +
> +	for (p = idata; p->name; p++)
> +		max_index = max(max_index, p->output_index);
> +
> +	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	clk_data->clk_num = max_index + 1;
> +	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
> +				 GFP_KERNEL);
> diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
> new file mode 100644
> index 0000000..05277b6
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier.h
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
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
> +#ifndef __CLK_UNIPHIER_H__
> +#define __CLK_UNIPHIER_H__
> +
> +#include <linux/kernel.h>

What's this include for?

> +
> +#define UNIPHIER_CLK_EXT	"[EXT]"
> +
> +enum uniphier_clk_type {
> +	UNIPHIER_CLK_TYPE_FIXED_FACTOR,
> +	UNIPHIER_CLK_TYPE_FIXED_RATE,
> +	UNIPHIER_CLK_TYPE_GATE,
> +	UNIPHIER_CLK_TYPE_MUX,
> +};
> +
> +struct uniphier_clk_fixed_factor_data {
> +	const char *parent_name;
> +	unsigned int mult;
> +	unsigned int div;
> +};
> +
> +struct uniphier_clk_fixed_rate_data {
> +	unsigned long fixed_rate;
> +};
> +
> +struct uniphier_clk_gate_data {
> +	const char *parent_name;
> +	unsigned int reg;
> +	u8 bit_idx;
> +};
> +
> +struct uniphier_clk_mux_data {
> +	const char *parent_names[4];
> +	u8 num_parents;
> +	unsigned int reg;
> +	u8 shift;
> +};
> +
> +struct uniphier_clk_init_data {
> +	const char *name;
> +	enum uniphier_clk_type type;
> +	int output_index;
> +	union {
> +		struct uniphier_clk_fixed_factor_data factor;
> +		struct uniphier_clk_fixed_rate_data rate;
> +		struct uniphier_clk_gate_data gate;
> +		struct uniphier_clk_mux_data mux;
> +	} data;
> +	struct clk *clk;

Probably need to forward declare this struct.

> +};
> +
> +int uniphier_clk_init(struct device_node *np,

Same for device_node.

> +		      struct uniphier_clk_init_data *idata);
> +
> +#endif /* __CLK_UNIPHIER_H__ */
> -- 
> 1.9.1
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
