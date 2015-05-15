From: jcliang@chromium.org (Ricky Liang)
Date: Fri, 15 May 2015 14:16:47 +0800
Subject: [PATCH v2] clk: mediatek: Export CPU mux clocks for CPU frequency
 control
In-Reply-To: <1429521950-16431-1-git-send-email-pi-cheng.chen@linaro.org>
References: <1429521950-16431-1-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <CAAJzSMc8r3ctr5_=C7LLNSWjXfw26yP2eVBWUeMoa943ZaLavw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 5:25 PM, pi-cheng.chen <pi-cheng.chen@linaro.org> wrote:
> This patch adds CPU mux clocks which are used by Mediatek cpufreq driver for
> intermediate clock source switching. It is based on v11 of common clock support
> for Mediatek MT8135 and MT8173[1]
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/335967.html
>
> Changes in v2:
> - Remove use of .determine_rate callback
>
> Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/clk/mediatek/Makefile          |   2 +-
>  drivers/clk/mediatek/clk-cpumux.c      | 122 +++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-cpumux.h      |  31 +++++++++
>  drivers/clk/mediatek/clk-mt8173.c      |  23 +++++++
>  include/dt-bindings/clock/mt8173-clk.h |   4 +-
>  5 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-cpumux.c
>  create mode 100644 drivers/clk/mediatek/clk-cpumux.h
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 8e4b2a4..299917a 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -1,4 +1,4 @@
> -obj-y += clk-mtk.o clk-pll.o clk-gate.o
> +obj-y += clk-mtk.o clk-pll.o clk-gate.o clk-cpumux.o
>  obj-$(CONFIG_RESET_CONTROLLER) += reset.o
>  obj-y += clk-mt8135.o
>  obj-y += clk-mt8173.o
> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> new file mode 100644
> index 0000000..dc14074
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/slab.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-cpumux.h"
> +
> +static inline struct mtk_clk_cpumux *to_clk_mux(struct clk_hw *_hw)
> +{
> +       return container_of(_hw, struct mtk_clk_cpumux, hw);
> +}
> +
> +static u8 clk_cpumux_get_parent(struct clk_hw *hw)
> +{
> +       struct mtk_clk_cpumux *mux = to_clk_mux(hw);
> +       int num_parents = __clk_get_num_parents(hw->clk);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, mux->reg, &val);
> +
> +       val >>= mux->shift;
> +       val &= mux->mask;
> +
> +       if (val >= num_parents)
> +               return -EINVAL;
> +
> +       return val;
> +}
> +
> +static int clk_cpumux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct mtk_clk_cpumux *mux = to_clk_mux(hw);
> +       u32 mask, val;
> +
> +       val = index << mux->shift;
> +       mask = mux->mask << mux->shift;
> +
> +       return regmap_update_bits(mux->regmap, mux->reg, mask, val);
> +}
> +
> +static struct clk_ops clk_cpumux_ops = {
> +       .get_parent = clk_cpumux_get_parent,
> +       .set_parent = clk_cpumux_set_parent,
> +};
> +
> +static struct clk *mtk_clk_register_cpumux(const struct mtk_composite *mux,
> +                                          struct regmap *regmap)
> +{
> +       struct mtk_clk_cpumux *cpumux;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       cpumux = kzalloc(sizeof(*cpumux), GFP_KERNEL);
> +       if (!cpumux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = mux->name;
> +       init.ops = &clk_cpumux_ops;
> +       init.parent_names = mux->parent_names;
> +       init.num_parents = mux->num_parents;

To be safe, please set

  init.flags = mux->flags;

here

> +
> +       cpumux->reg = mux->mux_reg;
> +       cpumux->shift = mux->mux_shift;
> +       cpumux->mask = (BIT(mux->mux_width) - 1);
> +       cpumux->regmap = regmap;
> +       cpumux->hw.init = &init;
> +
> +       clk = clk_register(NULL, &cpumux->hw);
> +       if (IS_ERR(clk))
> +               kfree(cpumux);
> +
> +       return clk;
> +}
> +
> +int mtk_clk_register_cpumuxes(struct device_node *node,
> +                             const struct mtk_composite *clks, int num,
> +                             struct clk_onecell_data *clk_data)
> +{
> +       int i;
> +       struct clk *clk;
> +       struct regmap *regmap;
> +
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       regmap = syscon_node_to_regmap(node);
> +       if (IS_ERR(regmap)) {
> +               pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
> +                      PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               const struct mtk_composite *mux = &clks[i];
> +
> +               clk = mtk_clk_register_cpumux(mux, regmap);
> +               if (IS_ERR(clk)) {
> +                       pr_err("Failed to register clk %s: %ld\n",
> +                              mux->name, PTR_ERR(clk));
> +                       continue;
> +               }
> +
> +               clk_data->clks[mux->id] = clk;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
> new file mode 100644
> index 0000000..b82ad20
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DRV_CLK_CPUMUX_H
> +#define __DRV_CLK_CPUMUX_H
> +
> +#include <linux/regmap.h>
> +
> +struct mtk_clk_cpumux {
> +       struct clk_hw   hw;
> +       struct regmap   *regmap;
> +       u32             reg;
> +       u32             mask;
> +       u8              shift;
> +};
> +
> +int mtk_clk_register_cpumuxes(struct device_node *node,
> +                             const struct mtk_composite *clks, int num,
> +                             struct clk_onecell_data *clk_data);
> +#endif /* __DRV_CLK_CPUMUX_H */
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 0584554..745f9d9 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -19,6 +19,7 @@
>
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-cpumux.h"
>
>  #include <dt-bindings/clock/mt8173-clk.h>
>
> @@ -517,6 +518,20 @@ static const char * const i2s3_b_ck_parents[] __initconst = {
>         "apll2_div5"
>  };
>
> +static const char * const ca53_parents[] __initconst = {
> +       "clk26m",
> +       "armca7pll",
> +       "mainpll",
> +       "univpll"
> +};
> +
> +static const char * const ca57_parents[] __initconst = {
> +       "clk26m",
> +       "armca15pll",
> +       "mainpll",
> +       "univpll"
> +};
> +
>  static const struct mtk_composite top_muxes[] __initconst = {
>         /* CLK_CFG_0 */
>         MUX(TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
> @@ -589,6 +604,11 @@ static const struct mtk_composite top_muxes[] __initconst = {
>         MUX(TOP_I2S3_B_CK_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
>  };
>
> +static const struct mtk_composite cpu_muxes[] __initconst = {
> +       MUX(INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
> +       MUX(INFRA_CA57SEL, "infra_ca57_sel", ca57_parents, 0x0000, 2, 2),
> +};
> +
>  static void __init mtk_init_clk_topckgen(void __iomem *top_base,
>                 struct clk_onecell_data *clk_data)
>  {
> @@ -745,6 +765,9 @@ static void __init mtk_infrasys_init(struct device_node *node)
>         mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
>                                                 clk_data);
>
> +       mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
> +                                               clk_data);
> +
>         r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>         if (r)
>                 pr_err("%s(): could not register clock provider: %d\n",
> diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> index e648b28..2503b03 100644
> --- a/include/dt-bindings/clock/mt8173-clk.h
> +++ b/include/dt-bindings/clock/mt8173-clk.h
> @@ -187,7 +187,9 @@
>  #define INFRA_CEC              9
>  #define INFRA_PMICSPI          10
>  #define INFRA_PMICWRAP         11
> -#define INFRA_NR_CLK           12
> +#define INFRA_CA53SEL          12
> +#define INFRA_CA57SEL          13
> +#define INFRA_NR_CLK           14
>
>  /* PERI_SYS */
>
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
