From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Aug 2016 17:25:07 -0700
Subject: [PATCH v6 1/2] clk: uniphier: add core support code for UniPhier
 clock driver
In-Reply-To: <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160819002507.GS361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02, Masahiro Yamada wrote:
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> new file mode 100644
> index 0000000..d6dfa4d
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-uniphier.h"
> +
> +static struct clk_hw *uniphier_clk_register(struct device *dev,
> +					    struct regmap *regmap,
> +					const struct uniphier_clk_data *data)
> +{
> +	switch (data->type) {
> +	case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
> +		return uniphier_clk_register_fixed_factor(dev, data->name,
> +							  &data->data.factor);
> +	case UNIPHIER_CLK_TYPE_FIXED_RATE:
> +		return uniphier_clk_register_fixed_rate(dev, data->name,
> +							&data->data.rate);
> +	case UNIPHIER_CLK_TYPE_GATE:
> +		return uniphier_clk_register_gate(dev, regmap, data->name,
> +						  &data->data.gate);
> +	case UNIPHIER_CLK_TYPE_MUX:
> +		return uniphier_clk_register_mux(dev, regmap, data->name,
> +						 &data->data.mux);
> +	default:
> +		dev_err(dev, "unsupported clock type\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +}
> +
> +static const struct of_device_id uniphier_clk_match[] = {
> +	{ /* sentinel */ }

Looks funny but I guess we'll fill this in later so it's ok.

> +};
> +MODULE_DEVICE_TABLE(of, uniphier_clk_match);
> +
> +int uniphier_clk_probe(struct platform_device *pdev)

static?

> +{
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct clk_hw_onecell_data *hw_data;
> +	struct device_node *parent;
> +	struct regmap *regmap;
> +	const struct uniphier_clk_data *p;
> +	int clk_num = 0;
> +
> +	match = of_match_node(uniphier_clk_match, dev->of_node);
> +	if (!match)
> +		return -ENODEV;

We can use of_driver_match_device() to make this simpler.

> +
> +	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> +	regmap = syscon_node_to_regmap(parent);
> +	of_node_put(parent);

devm_get_regmap(dev->parent) should work then? Why do we need to
use OF APIs?

> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap (error %ld)\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	for (p = match->data; p->name; p++)
> +		clk_num = max(clk_num, p->idx + 1);
> +
> +	hw_data = devm_kzalloc(dev,
> +			sizeof(*hw_data) + clk_num * sizeof(struct clk_hw *),
> +			GFP_KERNEL);
> +	if (!hw_data)
> +		return -ENOMEM;
> +
> +	hw_data->num = clk_num;
> +
> +	for (p = match->data; p->name; p++) {
> +		struct clk_hw *hw;
> +
> +		dev_dbg(dev, "register %s (index=%d)\n", p->name, p->idx);
> +		hw = uniphier_clk_register(dev, regmap, p);
> +		if (IS_ERR(hw)) {
> +			dev_err(dev, "failed to register %s (error %ld)\n",
> +				p->name, PTR_ERR(hw));
> +			return PTR_ERR(hw);
> +		}
> +
> +		if (p->idx >= 0)
> +			hw_data->hws[p->idx] = hw;
> +	}
> +
> +	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +				      hw_data);
> +}
> +
> +int uniphier_clk_remove(struct platform_device *pdev)

static?

> +{
> +	of_clk_del_provider(pdev->dev.of_node);
> +
> +	return 0;
> +}
> diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-factor.c b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
> new file mode 100644
> index 0000000..d64ea61
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
> +#include <linux/device.h>
> +
> +#include "clk-uniphier.h"
> +
> +struct clk_hw *uniphier_clk_register_fixed_factor(struct device *dev,
> +						  const char *name,
> +			const struct uniphier_clk_fixed_factor_data *data)
> +{
> +	struct clk_fixed_factor *fix;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	fix = devm_kzalloc(dev, sizeof(*fix), GFP_KERNEL);
> +	if (!fix)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &clk_fixed_factor_ops;
> +	init.flags = data->parent_name ? CLK_SET_RATE_PARENT : 0;
> +	init.flags |= CLK_IS_BASIC;

Please don't use CLK_IS_BASIC unless you need it. So far we've
kept it to OMAP and I'm hoping to delete it.

> +	init.parent_names = data->parent_name ? &data->parent_name : NULL;
> +	init.num_parents = data->parent_name ? 1 : 0;
> +
> +	fix->mult = data->mult;
> +	fix->div = data->div;
> +	fix->hw.init = &init;
> +
> +	ret = devm_clk_hw_register(dev, &fix->hw);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return &fix->hw;
> +}
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
