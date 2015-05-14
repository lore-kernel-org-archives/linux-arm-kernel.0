From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 17:43:51 +0800
Subject: [PATCH 3/8] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <1430565879-28113-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64jVksA5rapnAPn9yefEeXnfFw5FwdnXPP0G9FvzWnVBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
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
>  drivers/clk/sunxi/clk-a10-pll2.c           | 176 +++++++++++++++++++++++++++++
>  include/dt-bindings/clock/sun4i-a10-pll2.h |  53 +++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
>  create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index 058f273d6154..eb36c38d4120 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -4,6 +4,7 @@
>
>  obj-y += clk-sunxi.o clk-factors.o
>  obj-y += clk-a10-hosc.o
> +obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
>  obj-y += clk-sun8i-mbus.o
> diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
> new file mode 100644
> index 000000000000..4d0369626dba
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-a10-pll2.c
> @@ -0,0 +1,176 @@
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
> +#include "clk-factors.h"
> +
> +#define SUN4I_PLL2_ENABLE              31
> +#define SUN4I_PLL2_POST_DIV            26
> +#define SUN4I_PLL2_POST_DIV_MASK       0xF
> +#define SUN4I_PLL2_N                   8
> +#define SUN4I_PLL2_N_MASK              0x7F
> +#define SUN4I_PLL2_PRE_DIV             0
> +#define SUN4I_PLL2_PRE_DIV_MASK                0x1F
> +
> +#define SUN4I_PLL2_POST_DIV_VALUE      21
> +#define SUN4I_PLL2_PRE_DIV_VALUE       4
> +
> +#define SUN4I_PLL2_OUTPUTS             4
> +
> +static void sun4i_a10_get_pll2_base_factors(u32 *freq, u32 parent_rate,
> +                                           u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +       /*
> +        * Normalize the frequency to a multiple of (24 MHz / Fixed
> +        * PRE-DIV)
> +        */
> +       *freq = round_down(*freq, parent_rate / SUN4I_PLL2_PRE_DIV_VALUE);
> +
> +       /* We were called to round the frequency, we can return */
> +       if (!n)
> +               return;
> +
> +       *n = *freq * SUN4I_PLL2_PRE_DIV_VALUE / parent_rate;
> +
> +       /*
> +        * Even though the pre-divider can be changed, we don't really
> +        * care and we can just fix it to 4.
> +        */
> +       *m = SUN4I_PLL2_PRE_DIV_VALUE;
> +}
> +
> +static struct clk_factors_config sun4i_a10_pll2_base_config = {
> +       .mshift = SUN4I_PLL2_PRE_DIV,
> +       .mwidth = 5,
> +       .nshift = SUN4I_PLL2_N,
> +       .nwidth = 7,
> +
> +       .m_zero = 1,
> +       .n_zero = 1,
> +};
> +
> +static const struct factors_data sun4i_a10_pll2_base_data __initconst = {
> +       .enable = SUN4I_PLL2_ENABLE,
> +       .table = &sun4i_a10_pll2_base_config,
> +       .getter = sun4i_a10_get_pll2_base_factors,
> +       .name = "pll2-base",
> +};
> +
> +static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
> +
> +static void __init sun4i_pll2_setup(struct device_node *node)
> +{
> +       const char *clk_name = node->name, *parent;
> +       struct clk_onecell_data *clk_data;
> +       struct clk **clks, *base_clk;
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
> +       base_clk = sunxi_factors_register(node, &sun4i_a10_pll2_base_data,
> +                                         &sun4i_a10_pll2_lock, reg);

Why aren't you using divs_clk for this? It seems right for the job.

ChenYu

> +       if (!base_clk) {
> +               pr_err("Couldn't register the base factor clock\n");
> +               goto err_free_array;
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
> +       val &= ~(SUN4I_PLL2_POST_DIV_MASK << SUN4I_PLL2_POST_DIV);
> +       val |= SUN4I_PLL2_POST_DIV_VALUE << SUN4I_PLL2_POST_DIV;
> +       writel(val, reg);
> +
> +       of_property_read_string_index(node, "clock-output-names",
> +                                     SUN4I_A10_PLL2_1X, &clk_name);
> +       clks[SUN4I_A10_PLL2_1X] = clk_register_fixed_factor(NULL, clk_name,
> +                                                           parent,
> +                                                           CLK_SET_RATE_PARENT,
> +                                                           1, 4);
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
> +err_free_array:
> +       kfree(clks);
> +err_free_data:
> +       kfree(clk_data);
> +err_unmap:
> +       iounmap(reg);
> +}
> +CLK_OF_DECLARE(sun4i_pll2, "allwinner,sun4i-a10-b-pll2-clk", sun4i_pll2_setup);
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
> 2.3.6
>
