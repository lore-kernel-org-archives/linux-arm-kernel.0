From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 23 Nov 2016 10:14:10 +0900
Subject: [PATCH 1/2] clk: uniphier: add CPU-gear change (cpufreq) support
In-Reply-To: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATUd2bw34a3U0EYgw0Ok7DP3D+nvv0ConF=kBOR+UPCHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


Ping.



2016-10-27 2:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Core support code for CPU frequency changes, which will be used by
> the generic cpufreq driver.
>
> The register view is different from the generic clk-mux; it has
> a separate status register, and an update bit to load the register
> setting.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/clk/uniphier/Makefile               |   3 +
>  drivers/clk/uniphier/clk-uniphier-core.c    |   3 +
>  drivers/clk/uniphier/clk-uniphier-cpugear.c | 115 ++++++++++++++++++++++++++++
>  drivers/clk/uniphier/clk-uniphier.h         |  17 +++-
>  4 files changed, 136 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/uniphier/clk-uniphier-cpugear.c
>
> diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
> index f27b3603..665d1d6 100644
> --- a/drivers/clk/uniphier/Makefile
> +++ b/drivers/clk/uniphier/Makefile
> @@ -1,8 +1,11 @@
>  obj-y  += clk-uniphier-core.o
> +
> +obj-y  += clk-uniphier-cpugear.o
>  obj-y  += clk-uniphier-fixed-factor.o
>  obj-y  += clk-uniphier-fixed-rate.o
>  obj-y  += clk-uniphier-gate.o
>  obj-y  += clk-uniphier-mux.o
> +
>  obj-y  += clk-uniphier-sys.o
>  obj-y  += clk-uniphier-mio.o
>  obj-y  += clk-uniphier-peri.o
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> index 26c53f7..0007218 100644
> --- a/drivers/clk/uniphier/clk-uniphier-core.c
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -27,6 +27,9 @@ static struct clk_hw *uniphier_clk_register(struct device *dev,
>                                         const struct uniphier_clk_data *data)
>  {
>         switch (data->type) {
> +       case UNIPHIER_CLK_TYPE_CPUGEAR:
> +               return uniphier_clk_register_cpugear(dev, regmap, data->name,
> +                                                    &data->data.cpugear);
>         case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
>                 return uniphier_clk_register_fixed_factor(dev, data->name,
>                                                           &data->data.factor);
> diff --git a/drivers/clk/uniphier/clk-uniphier-cpugear.c b/drivers/clk/uniphier/clk-uniphier-cpugear.c
> new file mode 100644
> index 0000000..9bff26e
> --- /dev/null
> +++ b/drivers/clk/uniphier/clk-uniphier-cpugear.c
> @@ -0,0 +1,115 @@
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
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +#include "clk-uniphier.h"
> +
> +#define UNIPHIER_CLK_CPUGEAR_STAT      0       /* status */
> +#define UNIPHIER_CLK_CPUGEAR_SET       4       /* set */
> +#define UNIPHIER_CLK_CPUGEAR_UPD       8       /* update */
> +#define   UNIPHIER_CLK_CPUGEAR_UPD_BIT BIT(0)
> +
> +struct uniphier_clk_cpugear {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +       unsigned int regbase;
> +       unsigned int mask;
> +};
> +
> +#define to_uniphier_clk_cpugear(_hw) \
> +                       container_of(_hw, struct uniphier_clk_cpugear, hw)
> +
> +static int uniphier_clk_cpugear_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct uniphier_clk_cpugear *gear = to_uniphier_clk_cpugear(hw);
> +       int ret;
> +       unsigned int val;
> +
> +       ret = regmap_write_bits(gear->regmap,
> +                               gear->regbase + UNIPHIER_CLK_CPUGEAR_SET,
> +                               gear->mask, index);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_write_bits(gear->regmap,
> +                               gear->regbase + UNIPHIER_CLK_CPUGEAR_SET,
> +                               UNIPHIER_CLK_CPUGEAR_UPD_BIT,
> +                               UNIPHIER_CLK_CPUGEAR_UPD_BIT);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_read_poll_timeout(gear->regmap,
> +                               gear->regbase + UNIPHIER_CLK_CPUGEAR_UPD,
> +                               val, !(val & UNIPHIER_CLK_CPUGEAR_UPD_BIT),
> +                               0, 1);
> +}
> +
> +static u8 uniphier_clk_cpugear_get_parent(struct clk_hw *hw)
> +{
> +       struct uniphier_clk_cpugear *gear = to_uniphier_clk_cpugear(hw);
> +       int num_parents = clk_hw_get_num_parents(hw);
> +       int ret;
> +       unsigned int val;
> +
> +       ret = regmap_read(gear->regmap,
> +                         gear->regbase + UNIPHIER_CLK_CPUGEAR_STAT, &val);
> +       if (ret)
> +               return ret;
> +
> +       val &= gear->mask;
> +
> +       return val < num_parents ? val : -EINVAL;
> +}
> +
> +static const struct clk_ops uniphier_clk_cpugear_ops = {
> +       .determine_rate = __clk_mux_determine_rate,
> +       .set_parent = uniphier_clk_cpugear_set_parent,
> +       .get_parent = uniphier_clk_cpugear_get_parent,
> +};
> +
> +struct clk_hw *uniphier_clk_register_cpugear(struct device *dev,
> +                                        struct regmap *regmap,
> +                                        const char *name,
> +                               const struct uniphier_clk_cpugear_data *data)
> +{
> +       struct uniphier_clk_cpugear *gear;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       gear = devm_kzalloc(dev, sizeof(*gear), GFP_KERNEL);
> +       if (!gear)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &uniphier_clk_cpugear_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = data->parent_names;
> +       init.num_parents = data->num_parents,
> +
> +       gear->regmap = regmap;
> +       gear->regbase = data->regbase;
> +       gear->mask = data->mask;
> +       gear->hw.init = &init;
> +
> +       ret = devm_clk_hw_register(dev, &gear->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &gear->hw;
> +}
> diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
> index 0244dba..9707b0f 100644
> --- a/drivers/clk/uniphier/clk-uniphier.h
> +++ b/drivers/clk/uniphier/clk-uniphier.h
> @@ -20,15 +20,24 @@
>  struct device;
>  struct regmap;
>
> -#define UNIPHIER_CLK_MUX_MAX_PARENTS   8
> +#define UNIPHIER_CLK_CPUGEAR_MAX_PARENTS       16
> +#define UNIPHIER_CLK_MUX_MAX_PARENTS           8
>
>  enum uniphier_clk_type {
> +       UNIPHIER_CLK_TYPE_CPUGEAR,
>         UNIPHIER_CLK_TYPE_FIXED_FACTOR,
>         UNIPHIER_CLK_TYPE_FIXED_RATE,
>         UNIPHIER_CLK_TYPE_GATE,
>         UNIPHIER_CLK_TYPE_MUX,
>  };
>
> +struct uniphier_clk_cpugear_data {
> +       const char *parent_names[UNIPHIER_CLK_CPUGEAR_MAX_PARENTS];
> +       unsigned int num_parents;
> +       unsigned int regbase;
> +       unsigned int mask;
> +};
> +
>  struct uniphier_clk_fixed_factor_data {
>         const char *parent_name;
>         unsigned int mult;
> @@ -58,6 +67,7 @@ struct uniphier_clk_data {
>         enum uniphier_clk_type type;
>         int idx;
>         union {
> +               struct uniphier_clk_cpugear_data cpugear;
>                 struct uniphier_clk_fixed_factor_data factor;
>                 struct uniphier_clk_fixed_rate_data rate;
>                 struct uniphier_clk_gate_data gate;
> @@ -90,7 +100,10 @@ struct uniphier_clk_data {
>                 },                                              \
>         }
>
> -
> +struct clk_hw *uniphier_clk_register_cpugear(struct device *dev,
> +                                            struct regmap *regmap,
> +                                            const char *name,
> +                               const struct uniphier_clk_cpugear_data *data);
>  struct clk_hw *uniphier_clk_register_fixed_factor(struct device *dev,
>                                                   const char *name,
>                         const struct uniphier_clk_fixed_factor_data *data);
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
