From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Oct 2015 17:14:57 +0800
Subject: [PATCH v4 2/5] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <CAGb2v67ovfL_VVq2184+k0uMMnPKPqHMAb4rTn5hBGfPv1h1Lg@mail.gmail.com>
References: <1444682610-21482-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444682610-21482-3-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67ovfL_VVq2184+k0uMMnPKPqHMAb4rTn5hBGfPv1h1Lg@mail.gmail.com>
Message-ID: <CAGb2v67bVA=qjM0C3OD8LFtd7uB9CZnNxkhyOYehW6PSujPCpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 5:10 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Oct 13, 2015 at 4:43 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> The PLL2 on the A10 and later SoCs is the clock used for all the audio
>> related operations.
>>
>> This clock has a somewhat complex output tree, with three outputs (2X, 4X
>> and 8X) with a fixed divider from the base clock, and an output (1X) with a
>> post divider.
>>
>> However, we can simplify things since the 1X divider can be fixed, and we
>> end up by having a base clock not exposed to any device (or at least
>> directly, since the 4X output doesn't have any divider), and 4 fixed
>> divider clocks that will be exposed.
>>
>> This clock seems to have been introduced, at least in this form, in the
>> revision B of the A10, but we don't have any information on the clock used
>> on the revision A.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  drivers/clk/sunxi/Makefile                 |   1 +
>>  drivers/clk/sunxi/clk-a10-pll2.c           | 188 +++++++++++++++++++++++++++++
>>  include/dt-bindings/clock/sun4i-a10-pll2.h |  53 ++++++++
>>  3 files changed, 242 insertions(+)
>>  create mode 100644 drivers/clk/sunxi/clk-a10-pll2.c
>>  create mode 100644 include/dt-bindings/clock/sun4i-a10-pll2.h
>>
>> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
>> index f5a35b82cc1a..c658a18ba7cb 100644
>> --- a/drivers/clk/sunxi/Makefile
>> +++ b/drivers/clk/sunxi/Makefile
>> @@ -4,6 +4,7 @@
>>
>>  obj-y += clk-sunxi.o clk-factors.o
>>  obj-y += clk-a10-hosc.o
>> +obj-y += clk-a10-pll2.o
>>  obj-y += clk-a20-gmac.o
>>  obj-y += clk-mod0.o
>>  obj-y += clk-simple-gates.o
>> diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
>> new file mode 100644
>> index 000000000000..b877cc6c3622
>> --- /dev/null
>> +++ b/drivers/clk/sunxi/clk-a10-pll2.c
>> @@ -0,0 +1,188 @@
>> +/*
>> + * Copyright 2013 Emilio L?pez
>> + * Emilio L?pez <emilio@elopez.com.ar>
>> + *
>> + * Copyright 2015 Maxime Ripard
>> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +
>> +#include <dt-bindings/clock/sun4i-a10-pll2.h>
>> +
>> +#define SUN4I_PLL2_ENABLE              31
>> +
>> +#define SUN4I_PLL2_PRE_DIV_SHIFT       0
>> +#define SUN4I_PLL2_PRE_DIV_WIDTH       5
>> +#define SUN4I_PLL2_PRE_DIV_MASK                GENMASK(SUN4I_PLL2_PRE_DIV_WIDTH, 0)
>> +
>> +#define SUN4I_PLL2_N_SHIFT             8
>> +#define SUN4I_PLL2_N_WIDTH             7
>> +#define SUN4I_PLL2_N_MASK              GENMASK(SUN4I_PLL2_N_WIDTH, 0)
>> +
>> +#define SUN4I_PLL2_POST_DIV_SHIFT      26
>> +#define SUN4I_PLL2_POST_DIV_WIDTH      4
>> +#define SUN4I_PLL2_POST_DIV_MASK       GENMASK(SUN4I_PLL2_POST_DIV_WIDTH, 0)
>> +
>> +#define SUN4I_PLL2_POST_DIV_VALUE      4
>> +
>> +#define SUN4I_PLL2_OUTPUTS             4
>> +
>> +static DEFINE_SPINLOCK(sun4i_a10_pll2_lock);
>> +
>> +static void __init sun4i_pll2_setup(struct device_node *node)
>> +{
>> +       const char *clk_name = node->name, *parent;
>> +       struct clk **clks, *base_clk, *prediv_clk;
>> +       struct clk_onecell_data *clk_data;
>> +       struct clk_multiplier *mult;
>> +       struct clk_gate *gate;
>> +       void __iomem *reg;
>> +       u32 val;
>> +
>> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>> +       if (IS_ERR(reg))
>> +               return;
>> +
>> +       clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>> +       if (!clk_data)
>> +               goto err_unmap;
>> +
>> +       clks = kcalloc(SUN4I_PLL2_OUTPUTS, sizeof(struct clk *), GFP_KERNEL);
>> +       if (!clks)
>> +               goto err_free_data;
>> +
>> +       parent = of_clk_get_parent_name(node, 0);
>> +       prediv_clk = clk_register_divider(NULL, "pll2-prediv",
>> +                                         parent, 0, reg,
>> +                                         SUN4I_PLL2_PRE_DIV_SHIFT,
>> +                                         SUN4I_PLL2_PRE_DIV_WIDTH,
>> +                                         CLK_DIVIDER_ONE_BASED |
>> +                                         CLK_DIVIDER_ALLOW_ZERO,
>
> According to the A10 manual, the prediv is zero based, but allows zero.
> So you should just have CLK_DIVIDER_ALLOW_ZERO here.

My bad, I misread the description in clk-provider.h. Your code is indeed
correct.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> The rest looks good.
