From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 6 Jan 2016 10:39:51 +0800
Subject: [PATCH RFC 1/2] clk: sunxi: Add sun8i display support
In-Reply-To: <9cc33c3701844a07c43ee6c0c1072be4e2073cc1.1452021349.git.moinejf@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
 <9cc33c3701844a07c43ee6c0c1072be4e2073cc1.1452021349.git.moinejf@free.fr>
Message-ID: <CAGb2v66mhbRKPTYDfLe8Tf6-otvy5a7J9K35Bwxc6_-y0a+avw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First of all, please include the clk subsystem maintainers and the
linux-clk mailing list for all clk related patches.

On Wed, Jan 6, 2016 at 2:28 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> Add the clock types which are used by the sun8i family for video.

These clocks first appeared in the A31.

> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/clk/sunxi/Makefile            |   1 +
>  drivers/clk/sunxi/clk-sun8i-display.c | 247 ++++++++++++++++++++++++++++++++++

Please split this into 2 patches, and 2 files: one for PLL3, named
clk-sun6i-pll3.c, and one for the display mod clocks, named
clk-sun6i-display.c

>  2 files changed, 258 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun8i-display.c
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index cb4c299..145c078 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -10,6 +10,7 @@ obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
> +obj-y += clk-sun8i-display.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
>  obj-y += clk-sun9i-mmc.o
> diff --git a/drivers/clk/sunxi/clk-sun8i-display.c b/drivers/clk/sunxi/clk-sun8i-display.c
> new file mode 100644
> index 0000000..eded572
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun8i-display.c
> @@ -0,0 +1,247 @@
> +/*
> + * Copyright 2015 Jean-Francois Moine <moinejf@free.fr>
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
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/rational.h>
> +#include <linux/delay.h>
> +
> +static DEFINE_SPINLOCK(sun8i_display_lock);
> +
> +/* PLL3 (video) and PLL10 (de) */
> +struct clk_fact {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +};
> +#define to_clk_fact(_hw) container_of(_hw, struct clk_fact, hw)

What does fact stand for?

> +
> +#define SUN8I_PLL3_MSHIFT      0
> +#define SUN8I_PLL3_MMASK       0x0f

You can use GENMASK for these. Note that GENMASK is inclusive on both ends.

> +#define SUN8I_PLL3_NSHIFT      8
> +#define SUN8I_PLL3_NMASK       0x7f
> +#define SUN8I_PLL3_MODE_SEL    0x01000000
> +#define SUN8I_PLL3_FRAC_CLK    0x02000000

Please use the BIT() macros.

> +
> +static int sun8i_pll3_get_fact(unsigned long rate,
> +                       unsigned long parent_rate,
> +                       unsigned long *n, unsigned long *m)
> +{
> +       if (rate == 297000000)
> +               return 1;
> +       if (rate == 270000000)
> +               return 0;
> +       rational_best_approximation(rate, parent_rate,
> +                               SUN8I_PLL3_NMASK + 1, SUN8I_PLL3_MMASK + 1,
> +                               n, m);
> +       return -1;
> +}
> +
> +static unsigned long sun8i_pll3_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct clk_fact *fact = to_clk_fact(hw);
> +       u32 reg;
> +       u32 n, m;
> +
> +       reg = readl(fact->reg);
> +       if (reg & SUN8I_PLL3_MODE_SEL) {
> +               n = (reg >> SUN8I_PLL3_NSHIFT) & SUN8I_PLL3_NMASK;
> +               m = (reg >> SUN8I_PLL3_MSHIFT) & SUN8I_PLL3_MMASK;
> +               return parent_rate / (m + 1) * (n + 1);
> +       }
> +       if (reg & SUN8I_PLL3_FRAC_CLK)
> +               return 297000000;
> +       return 270000000;
> +}
> +
> +static long sun8i_pll3_round_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long *parent_rate)
> +{
> +       int frac;
> +       unsigned long n, m;
> +
> +       frac = sun8i_pll3_get_fact(rate, *parent_rate, &n, &m);
> +       if (frac == 1)
> +               return 297000000;
> +       if (frac == 0)
> +               return 270000000;
> +       return (*parent_rate * n) / m;

The ordering is different from the one in recalc_rate. Considering
integer rounding, would the results be different?

> +}
> +
> +static int sun8i_pll3_set_rate(struct clk_hw *hw, unsigned long rate,
> +                       unsigned long parent_rate)
> +{
> +       struct clk_fact *fact = to_clk_fact(hw);
> +       u32 reg;
> +       int frac;
> +       unsigned long n, m;
> +
> +       reg = readl(fact->reg) &
> +                       ~(SUN8I_PLL3_MODE_SEL |
> +                         SUN8I_PLL3_FRAC_CLK |
> +                         (SUN8I_PLL3_NMASK << SUN8I_PLL3_NSHIFT) |
> +                         (SUN8I_PLL3_MMASK << SUN8I_PLL3_MSHIFT));
> +
> +       frac = sun8i_pll3_get_fact(rate, parent_rate, &n, &m);
> +       if (frac == 1)
> +               reg |= SUN8I_PLL3_FRAC_CLK;     /* 297MHz */
> +       else if (frac == 0)
> +               ;                               /* 270MHz */
> +       else
> +               reg |= SUN8I_PLL3_MODE_SEL |
> +                       ((n - 1) << SUN8I_PLL3_NSHIFT) |
> +                       ((m - 1) << SUN8I_PLL3_MSHIFT);
> +
> +       writel(reg, fact->reg);
> +
> +       /* delay 500us so pll stabilizes */
> +       __delay(500);

Bit 28 indicates PLL lock, please use readl_poll_timeout() to check it.

> +
> +       return 0;
> +}
> +
> +static const struct clk_ops clk_sun8i_pll3_fact_ops = {
> +       .recalc_rate = sun8i_pll3_recalc_rate,
> +       .round_rate = sun8i_pll3_round_rate,
> +       .set_rate = sun8i_pll3_set_rate,
> +};
> +
> +static void __init sun8i_pll3_setup(struct device_node *node)
> +{
> +       const char *clk_name = node->name, *parent;
> +       struct clk_fact *fact;
> +       struct clk_gate *gate;
> +       void __iomem *reg;
> +       struct clk *clk;
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +       parent = of_clk_get_parent_name(node, 0);
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg)) {
> +               pr_err("%s: Could not map the clock registers\n", clk_name);
> +               return;
> +       }
> +
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return;

You should call release_mem_region() to release the iomem region you
requested with of_io_request_and_map().

> +
> +       gate->reg = reg;
> +       gate->bit_idx = 31;
> +       gate->lock = &sun8i_display_lock;
> +
> +       fact = kzalloc(sizeof(*fact), GFP_KERNEL);
> +       if (!fact)
> +               goto free_gate;
> +
> +       fact->reg = reg;
> +
> +       clk = clk_register_composite(NULL, clk_name,
> +                                    &parent, 1,
> +                                    NULL, NULL,
> +                                    &fact->hw, &clk_sun8i_pll3_fact_ops,
> +                                    &gate->hw, &clk_gate_ops,
> +                                    0);
> +       if (IS_ERR(clk)) {
> +               pr_err("%s: Couldn't register the clock\n", clk_name);
> +               goto free_fact;
> +       }
> +
> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);

Would this fail?

> +
> +       return;
> +
> +free_fact:
> +       kfree(fact);
> +free_gate:
> +       kfree(gate);
> +}
> +
> +CLK_OF_DECLARE(sun8i_pll3, "allwinner,sun8i-pll3-clk", sun8i_pll3_setup);
> +
> +/* DE, TCON0, TVE, HDMI, DEINTERLACE  */
> +static void __init sun8i_display_setup(struct device_node *node)
> +{
> +       const char *clk_name = node->name;
> +       const char *parents[2];

There are as many as six parents for display mod clocks on A31.
A23/A33 mod clocks have holes in there parent array, as some
PLLs are missing. We may need a different driver to deal with
that.

> +       struct clk_mux *mux = NULL;
> +       struct clk_divider *div;
> +       struct clk_gate *gate;
> +       void __iomem *reg;
> +       struct clk *clk;
> +       int n;
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg)) {
> +               pr_err("%s: Could not map the clock registers\n", clk_name);
> +               return;
> +       }
> +
> +       n = of_clk_parent_fill(node, parents, ARRAY_SIZE(parents));
> +
> +       if (n > 1) {                            /* many possible sources */
> +               mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +               if (!mux)
> +                       return;

release_mem_region().

> +               mux->reg = reg;
> +               mux->shift = 24;
> +               mux->mask = 0x07;

Macros for these, please.

> +               mux->lock = &sun8i_display_lock;
> +       }
> +
> +       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               goto free_gate;

Label name is confusing. Another "free_mux" wouldn't harm.

> +
> +       gate->reg = reg;
> +       gate->bit_idx = 31;
> +       gate->lock = &sun8i_display_lock;
> +
> +       div = kzalloc(sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               goto free_gate;
> +
> +       div->reg = reg;
> +       div->shift = 0;
> +       div->width = 4;

Macros, please.

> +       div->lock = &sun8i_display_lock;
> +
> +       clk = clk_register_composite(NULL, clk_name,
> +                                    parents, n,
> +                                    mux ? &mux->hw : NULL, &clk_mux_ops,
> +                                    &div->hw, &clk_divider_ops,
> +                                    &gate->hw, &clk_gate_ops,
> +                                    0);
> +       if (IS_ERR(clk)) {
> +               pr_err("%s: Couldn't register the clock\n", clk_name);
> +               goto free_div;
> +       }
> +
> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);

Would this fail?

> +
> +       return;
> +
> +free_div:
> +       kfree(div);
> +free_gate:
> +       kfree(gate);
> +       kfree(mux);
> +}
> +
> +CLK_OF_DECLARE(sun8i_display, "allwinner,sun8i-display-clk", sun8i_display_setup);
> --
> 2.6.4


Regards
ChenYu
