From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 10:13:41 -0700
Subject: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
In-Reply-To: <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jianxin Pan (2018-10-17 22:07:25)
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index 305ee30..f96314d 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -113,8 +113,25 @@ static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
>                                   clk_div_mask(div->width) << div->shift, val);
>  };
>  
> -/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */
> +static void clk_regmap_div_init(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk = to_clk_regmap(hw);
> +       struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
> +       unsigned int val;
> +       int ret;
> +
> +       ret = regmap_read(clk->map, div->offset, &val);
> +       if (ret)
> +               return;
>  
> +       val &= (clk_div_mask(div->width) << div->shift);
> +       if (!val)
> +               regmap_update_bits(clk->map, div->offset,
> +                                  clk_div_mask(div->width) << div->shift,
> +                                  clk_div_mask(div->width));
> +}
> +
> +/* Would prefer clk_regmap_div_ro_ops but clashes with qcom */

We should add a patch to rename the symbol for qcom, i.e.
qcom_clk_regmap_div_ro_ops, and then any symbols in this directory
should be meson_clk_regmap_div_ro_ops.

Or we should just give up and squash the regmap implementations together
into a new clk_regmap set of ops.

>  const struct clk_ops clk_regmap_divider_ops = {
>         .recalc_rate = clk_regmap_div_recalc_rate,
>         .round_rate = clk_regmap_div_round_rate,
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 0000000..5555e3f
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>

clk-provider.h instead of clk.h?

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> +
> +
[...]
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
> +                                 char *suffix, const char *parent,
> +                                 unsigned long flags,
> +                                 const struct clk_ops *ops, void *data)
> +{
> +       struct clk_init_data init;
> +       struct clk_regmap *clk;
> +
> +       init.ops = ops;
> +       init.flags = flags;
> +       init.parent_names = (const char* const []){ parent, };

Can't we just assign &parent here?

> +       init.num_parents = 1;
> +
> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +       if (IS_ERR(clk))
> +               dev_err(dev, "Core %s clock registration failed\n", suffix);
> +
> +       return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct clk_hw_onecell_data *onecell_data;
> +       struct device *dev = &pdev->dev;
> +       struct mmc_clkc_data *data;
> +       struct regmap *map;
> +       struct clk_regmap *mux, *div, *core, *rx, *tx;
> +
> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);

Nitpick: Drop the cast.

> +       if (!data)
> +               return -ENODEV;
> +
> +       map = syscon_node_to_regmap(dev->of_node);
