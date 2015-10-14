From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Oct 2015 17:10:59 +0800
Subject: [PATCH v4 2/5] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <1444682610-21482-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1444682610-21482-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444682610-21482-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67ovfL_VVq2184+k0uMMnPKPqHMAb4rTn5hBGfPv1h1Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 4:43 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The PLL2 on the A10 and later SoCs is the clock used for all the audio
> related operations.
>
> This clock has a somewhat complex output tree, with three outputs (2X, 4X
> and 8X) with a fixed divider from the base clock, and an output (1X) with a
> post divider.
>
> However, we can simplify things since the 1X divider can be fixed, and we
> end up by having a base clock not exposed to any device (or at least
> directly, since the 4X output doesn't have any divider), and 4 fixed
> divider clocks that will be exposed.
>
> This clock seems to have been introduced, at least in this form, in the
> revision B of the A10, but we don't have any information on the clock used
> on the revision A.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/Makefile                 |   1 +
>  drivers/clk/sunxi/clk-a10-pll2.c           | 188 +++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun4i-a10-pll2.h |  53 ++++++++
>  3 files changed, 242 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
>  create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index f5a35b82cc1a..c658a18ba7cb 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -4,6 +4,7 @@
>
>  obj-y += clk-sunxi.o clk-factors.o
>  obj-y += clk-a10-hosc.o
> +obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
> diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
> new file mode 100644
> index 000000000000..b877cc6c3622
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-a10-pll2.c
> @@ -0,0 +1,188 @@
> +/*
> + * Copyright 2013 Emilio L?pez
> + * Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * Copyright 2015 Maxime Ripard
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
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/sun4i-a10-pll2.h>
> +
> +#define SUN4I_PLL2_ENABLE              31
> +
> +#define SUN4I_PLL2_PRE_DIV_SHIFT       0
> +#define SUN4I_PLL2_PRE_DIV_WIDTH       5
> +#define SUN4I_PLL2_PRE_DIV_MASK                GENMASK(SUN4I_PLL2_PRE_DIV_WIDTH, 0)
> +
> +#define SUN4I_PLL2_N_SHIFT             8
> +#define SUN4I_PLL2_N_WIDTH             7
> +#define SUN4I_PLL2_N_MASK              GENMASK(SUN4I_PLL2_N_WIDTH, 0)
> +
> +#define SUN4I_PLL2_POST_DIV_SHIFT      26
> +#define SUN4I_PLL2_POST_DIV_WIDTH      4
> +#define SUN4I_PLL2_POST_DIV_MASK       GENMASK(SUN4I_PLL2_POST_DIV_WIDTH, 0)
> +
> +#define SUN4I_PLL2_POST_DIV_VALUE      4
> +
> +#define SUN4I_PLL2_OUTPUTS             4
> +
> +static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
> +
> +static void __init sun4i_pll2_setup(struct device_node *node)
> +{
> +       const char *clk_name = node->name, *parent;
> +       struct clk **clks, *base_clk, *prediv_clk;
> +       struct clk_onecell_data *clk_data;
> +       struct clk_multiplier *mult;
> +       struct clk_gate *gate;
> +       void __iomem *reg;
> +       u32 val;
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg))
> +               return;
> +
> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
> +       if (!clk_data)
> +               goto err_unmap;
> +
> +       clks = kcalloc(SUN4I_PLL2_OUTPUTS, sizeof(struct clk *), GFP_KERNEL);
> +       if (!clks)
> +               goto err_free_data;
> +
> +       parent = of_clk_get_parent_name(node, 0);
> +       prediv_clk = clk_register_divider(NULL, "pll2-prediv",
> +                                         parent, 0, reg,
> +                                         SUN4I_PLL2_PRE_DIV_SHIFT,
> +                                         SUN4I_PLL2_PRE_DIV_WIDTH,
> +                                         CLK_DIVIDER_ONE_BASED |
> +                                         CLK_DIVIDER_ALLOW_ZERO,

According to the A10 manual, the prediv is zero based, but allows zero.
So you should just have CLK_DIVIDER_ALLOW_ZERO here.

The rest looks good.

ChenYu

> +                                         &sun4i_a10_pll2_lock);
> +       if (!prediv_clk) {
> +               pr_err("Couldn't register the prediv clock\n");
> +               goto err_free_array;
> +       }
> +
> +       /* Setup the gate part of the PLL2 */
> +       gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> +       if (!gate)
> +               goto err_unregister_prediv;
> +
> +       gate->reg = reg;
> +       gate->bit_idx = SUN4I_PLL2_ENABLE;
> +       gate->lock = &sun4i_a10_pll2_lock;
> +
> +       /* Setup the multiplier part of the PLL2 */
> +       mult = kzalloc(sizeof(struct clk_multiplier), GFP_KERNEL);
> +       if (!mult)
> +               goto err_free_gate;
> +
> +       mult->reg = reg;
> +       mult->shift = SUN4I_PLL2_N_SHIFT;
> +       mult->width = 7;
> +       mult->flags = CLK_MULTIPLIER_ZERO_BYPASS |
> +                       CLK_MULTIPLIER_ROUND_CLOSEST;
> +       mult->lock = &sun4i_a10_pll2_lock;
> +
> +       parent = __clk_get_name(prediv_clk);
> +       base_clk = clk_register_composite(NULL, "pll2-base",
> +                                         &parent, 1,
> +                                         NULL, NULL,
> +                                         &mult->hw, &clk_multiplier_ops,
> +                                         &gate->hw, &clk_gate_ops,
> +                                         CLK_SET_RATE_PARENT);
> +       if (!base_clk) {
> +               pr_err("Couldn't register the base multiplier clock\n");
> +               goto err_free_multiplier;
> +       }
> +
> +       parent = __clk_get_name(base_clk);
> +
> +       /*
> +        * PLL2-1x
> +        *
> +        * This is supposed to have a post divider, but we won't need
> +        * to use it, we just need to initialise it to 4, and use a
> +        * fixed divider.
> +        */
> +       val = readl(reg);
> +       val &= ~(SUN4I_PLL2_POST_DIV_MASK << SUN4I_PLL2_POST_DIV_SHIFT);
> +       val |= SUN4I_PLL2_POST_DIV_VALUE << SUN4I_PLL2_POST_DIV_SHIFT;
> +       writel(val, reg);
> +
> +       of_property_read_string_index(node, "clock-output-names",
> +                                     SUN4I_A10_PLL2_1X, &clk_name);
> +       clks[SUN4I_A10_PLL2_1X] = clk_register_fixed_factor(NULL, clk_name,
> +                                                           parent,
> +                                                           CLK_SET_RATE_PARENT,
> +                                                           1,
> +                                                           SUN4I_PLL2_POST_DIV_VALUE);
> +       WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_1X]));
> +
> +       /*
> +        * PLL2-2x
> +        *
> +        * This clock doesn't use the post divider, and really is just
> +        * a fixed divider from the PLL2 base clock.
> +        */
> +       of_property_read_string_index(node, "clock-output-names",
> +                                     SUN4I_A10_PLL2_2X, &clk_name);
> +       clks[SUN4I_A10_PLL2_2X] = clk_register_fixed_factor(NULL, clk_name,
> +                                                           parent,
> +                                                           CLK_SET_RATE_PARENT,
> +                                                           1, 2);
> +       WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_2X]));
> +
> +       /* PLL2-4x */
> +       of_property_read_string_index(node, "clock-output-names",
> +                                     SUN4I_A10_PLL2_4X, &clk_name);
> +       clks[SUN4I_A10_PLL2_4X] = clk_register_fixed_factor(NULL, clk_name,
> +                                                           parent,
> +                                                           CLK_SET_RATE_PARENT,
> +                                                           1, 1);
> +       WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_4X]));
> +
> +       /* PLL2-8x */
> +       of_property_read_string_index(node, "clock-output-names",
> +                                     SUN4I_A10_PLL2_8X, &clk_name);
> +       clks[SUN4I_A10_PLL2_8X] = clk_register_fixed_factor(NULL, clk_name,
> +                                                           parent,
> +                                                           CLK_SET_RATE_PARENT,
> +                                                           2, 1);
> +       WARN_ON(IS_ERR(clks[SUN4I_A10_PLL2_8X]));
> +
> +       clk_data->clks = clks;
> +       clk_data->clk_num = SUN4I_PLL2_OUTPUTS;
> +       of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +
> +       return;
> +
> +err_free_multiplier:
> +       kfree(mult);
> +err_free_gate:
> +       kfree(gate);
> +err_unregister_prediv:
> +       clk_unregister_divider(prediv_clk);
> +err_free_array:
> +       kfree(clks);
> +err_free_data:
> +       kfree(clk_data);
> +err_unmap:
> +       iounmap(reg);
> +}
> +CLK_OF_DECLARE(sun4i_pll2, "allwinner,sun4i-a10-pll2-clk", sun4i_pll2_setup);
> diff --git a/include/dt-bindings/clock/sun4i-a10-pll2.h b/include/dt-bindings/clock/sun4i-a10-pll2.h
> new file mode 100644
> index 000000000000..071c8112d531
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun4i-a10-pll2.h
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright 2015 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_
> +#define __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_
> +
> +#define SUN4I_A10_PLL2_1X      0
> +#define SUN4I_A10_PLL2_2X      1
> +#define SUN4I_A10_PLL2_4X      2
> +#define SUN4I_A10_PLL2_8X      3
> +
> +#endif /* __DT_BINDINGS_CLOCK_SUN4I_A10_PLL2_H_ */
> --
> 2.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
