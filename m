From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 11:17:40 -0700
Subject: [PATCHv6 3/3] clk: socfpga: stratix10: add clock driver for
 Stratix10 platform
In-Reply-To: <1519656455-14629-3-git-send-email-dinguyen@kernel.org>
References: <1519656455-14629-1-git-send-email-dinguyen@kernel.org>
 <1519656455-14629-3-git-send-email-dinguyen@kernel.org>
Message-ID: <152148346040.242365.18406406194344107023@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dinh Nguyen (2018-02-26 06:47:35)
> diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
> index 9146c20..87ef977 100644
> --- a/drivers/clk/socfpga/Makefile
> +++ b/drivers/clk/socfpga/Makefile
> @@ -1,6 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
> +ifeq ($(CONFIG_ARCH_SOCFPGA),y)

Ugh, any chance to make this better if we get three?

>  obj-y += clk.o
>  obj-y += clk-gate.o
>  obj-y += clk-pll.o
>  obj-y += clk-periph.o
>  obj-y += clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
> +else
> +obj-y += clk-s10.o
> +obj-y += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
> +endif
> diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
> new file mode 100644
> index 0000000..5b09aef
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-gate-s10.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier:    GPL-2.0
> +/*
> + * Copyright (C) 2017, Intel Corporation
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include "clk.h"
> +
> +#define SOCFPGA_CS_PDBG_CLK    "cs_pdbg_clk"

Drop the define? It's used once.

> +#define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
> +
> +static unsigned long socfpga_gate_clk_recalc_rate(struct clk_hw *hwclk,
> +                                                 unsigned long parent_rate)
> +{
> +       struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +       u32 div = 1, val;
> +
> +       if (socfpgaclk->fixed_div) {
> +               div = socfpgaclk->fixed_div;
> +       } else if (socfpgaclk->div_reg) {
> +               val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
> +               val &= GENMASK(socfpgaclk->width - 1, 0);
> +               div = (1 << val);
> +       }
> +       return parent_rate / div;
> +}
> +
> +static unsigned long socfpga_dbg_clk_recalc_rate(struct clk_hw *hwclk,
> +                                                 unsigned long parent_rate)
> +{
> +       struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +       u32 div = 1, val;
> +
> +       val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
> +       val &= GENMASK(socfpgaclk->width - 1, 0);
> +       div = (1 << val);
> +       div = div ? 4 : 1;
> +
> +       return parent_rate / div;
> +}
> +
> +static u8 socfpga_gate_get_parent(struct clk_hw *hwclk)
> +{
> +       struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> +       u32 mask;
> +       u8 parent = 0;
> +
> +       if (socfpgaclk->bypass_reg) {
> +               mask = (0x1 << socfpgaclk->bypass_shift);
> +               parent = ((readl(socfpgaclk->bypass_reg) & mask) >>
> +                         socfpgaclk->bypass_shift);
> +       }
> +       return parent;
> +}
> +
> +static struct clk_ops gateclk_ops = {

const?

> +       .recalc_rate = socfpga_gate_clk_recalc_rate,
> +       .get_parent = socfpga_gate_get_parent,
> +};
> +
> +static struct clk_ops dbgclk_ops = {

const?

> +       .recalc_rate = socfpga_dbg_clk_recalc_rate,
> +       .get_parent = socfpga_gate_get_parent,
> +};
> +
> +struct clk *s10_register_gate(char *name, const char *parent_name,
> +                             const char * const *parent_names,
> +                             u8 num_parents, unsigned long flags,
> +                             void __iomem *regbase, unsigned long gate_reg,
> +                             unsigned long gate_idx, unsigned long div_reg,
> +                             unsigned long div_offset, u8 div_width,
> +                             unsigned long bypass_reg, u8 bypass_shift,
> +                             u8 fixed_div)
> +{
> +       struct clk *clk;
> +       struct socfpga_gate_clk *socfpga_clk;
> +       struct clk_init_data init;
> +
> +       socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
> +       if (WARN_ON(!socfpga_clk))

Allocation failures already print a nice stack so maybe just return NULL
if nothing allocates.

> +               return NULL;
> +
> +       socfpga_clk->hw.reg = regbase + gate_reg;
> +       socfpga_clk->hw.bit_idx = gate_idx;
> +
> +       gateclk_ops.enable = clk_gate_ops.enable;
> +       gateclk_ops.disable = clk_gate_ops.disable;
> +
> +       socfpga_clk->fixed_div = fixed_div;
> +
> +       if (div_reg)
> +               socfpga_clk->div_reg = regbase + div_reg;
> +       else
> +               socfpga_clk->div_reg = NULL;
> +
> +       socfpga_clk->width = div_width;
> +       socfpga_clk->shift = div_offset;
> +
> +       if (bypass_reg)
> +               socfpga_clk->bypass_reg = regbase + bypass_reg;
> +       else
> +               socfpga_clk->bypass_reg = NULL;
> +       socfpga_clk->bypass_shift = bypass_shift;
> +
> +       if (streq(name, SOCFPGA_CS_PDBG_CLK))
> +               init.ops = &dbgclk_ops;
> +       else
> +               init.ops = &gateclk_ops;
> +
> +       init.name = name;
> +       init.flags = flags;
> +
> +       init.num_parents = num_parents;
> +       init.parent_names = parent_names ? parent_names : &parent_name;
> +       socfpga_clk->hw.hw.init = &init;
> +
> +       clk = clk_register(NULL, &socfpga_clk->hw.hw);
> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(socfpga_clk);
> +               return NULL;
> +       }
> +
> +       return clk;
> +}
> diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
> new file mode 100644
> index 0000000..31572cb
> --- /dev/null
> +++ b/drivers/clk/socfpga/clk-s10.c
> @@ -0,0 +1,319 @@
[...]
> +
> +static int s10_clk_register_pll(const struct stratix10_pll_clock *clks,
> +                                int nums, struct stratix10_clock_data *data)
> +{
> +       struct clk *clk;
> +       void __iomem *base = data->base;
> +       int i;
> +
> +       for (i = 0; i < nums; i++) {
> +               clk = s10_register_pll(clks[i].name, clks[i].parent_names,
> +                                   clks[i].num_parents,
> +                                   clks[i].flags, base,
> +                                   clks[i].offset);
> +               if (IS_ERR(clk)) {
> +                       pr_err("%s: failed to register clock %s\n",
> +                              __func__, clks[i].name);
> +                       continue;
> +               }
> +               data->clk_data.clks[clks[i].id] = clk;
> +       }
> +
> +       return 0;
> +}
> +
> +struct stratix10_clock_data *__socfpga_s10_clk_init(struct device_node *np,

static?

> +                                                   int nr_clks)
> +{
> +       struct stratix10_clock_data *clk_data;
> +       struct clk **clk_table;
> +       void __iomem *base;
> +
> +       base = of_iomap(np, 0);
> +       if (!base) {
> +               pr_err("%s: failed to map clock registers\n", __func__);
> +               goto err;
> +       }
> +
> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               goto err;
> +
> +       clk_data->base = base;
> +       clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
> +       if (!clk_table)
> +               goto err_data;
> +
> +       clk_data->clk_data.clks = clk_table;
> +       clk_data->clk_data.clk_num = nr_clks;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
> +       return clk_data;
> +
> +err_data:
> +       kfree(clk_data);
> +err:
> +       return NULL;
> +}
> +
> +
> +void __init socfpga_s10_init(struct device_node *node)

static?

> +{
> +       struct stratix10_clock_data *clk_data;
> +
> +       clk_data = __socfpga_s10_clk_init(node, STRATIX10_NUM_CLKS);
> +       if (!clk_data)
> +               return;
> +
> +       s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
> +
> +       s10_clk_register_c_perip(s10_main_perip_c_clks,
> +                                ARRAY_SIZE(s10_main_perip_c_clks), clk_data);
> +
> +       s10_clk_register_cnt_perip(s10_main_perip_cnt_clks,
> +                                  ARRAY_SIZE(s10_main_perip_cnt_clks),
> +                                  clk_data);
> +
> +       s10_clk_register_gate(s10_gate_clks, ARRAY_SIZE(s10_gate_clks),
> +                             clk_data);
> +}
> +
> +CLK_OF_DECLARE(stratix10_clock, "intel,stratix10-clkmgr", socfpga_s10_init);

Can it be a platform device? We prefer those over the CLK_OF_DECLARE
style.

> diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
> new file mode 100644
> index 0000000..10f1532
> --- /dev/null
> +++ b/drivers/clk/socfpga/stratix10-clk.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier:    GPL-2.0 */
> +/*
> + * Copyright (C) 2017, Intel Corporation
> + */
> +
> +#ifndef        __STRATIX10_CLK_H
> +#define        __STRATIX10_CLK_H
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>

Why include this? And why clk-provider.h?

> +
> +struct platform_device;

Why?

> +
> +struct stratix10_clock_data {
> +       struct clk_onecell_data clk_data;
> +       void __iomem            *base;
> +};
