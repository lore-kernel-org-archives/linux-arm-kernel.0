From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 28 Oct 2015 10:12:09 +1100
Subject: [linux-sunxi] [PATCH v4 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
Message-ID: <CAGRGNgW9nVJvAcaduF0y1ptbpLA-3MkR4LCYvh-n1=mtxTyqfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Wed, Oct 28, 2015 at 3:50 AM, Jens Kuske <jenskuske@gmail.com> wrote:
> The H3 clock control unit is similar to the those of other sun8i family
> members like the A23.
>
> It adds a new bus gates clock similar to the simple gates, but with a
> different parent clock for each single gate.
> Some of the gates use the new AHB2 clock as parent, whose clock source
> is muxable between AHB1 and PLL6/2. The documentation isn't totally clear
> about which devices belong to AHB2 now, especially USB EHIC/OHIC, so it
> is mostly based on Allwinner kernel source code.
>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
>  drivers/clk/sunxi/Makefile                        |   1 +
>  drivers/clk/sunxi/clk-sun8i-bus-gates.c           | 111 ++++++++++++++++++++++
>  drivers/clk/sunxi/clk-sunxi.c                     |   9 +-
>  4 files changed, 122 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/sunxi/clk-sun8i-bus-gates.c
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 8a47b77..d303dec 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -28,6 +28,7 @@ Required properties:
>         "allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
>         "allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
>         "allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
> +       "allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
>         "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>         "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
>         "allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
> @@ -55,6 +56,7 @@ Required properties:
>         "allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
>         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
> +       "allwinner,sun8i-h3-bus-gates-clk" - for the bus gates on H3
>         "allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>         "allwinner,sun4i-a10-mmc-clk" - for the MMC clock
>         "allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index cb4c299..f520af6 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -10,6 +10,7 @@ obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
> +obj-y += clk-sun8i-bus-gates.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
>  obj-y += clk-sun9i-mmc.o
> diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
> new file mode 100644
> index 0000000..ad605fa
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
> + *
> + * Based on clk-simple-gates.c, which is:
> + * Copyright 2015 Maxime Ripard
> + *
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
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +static DEFINE_SPINLOCK(gates_lock);
> +
> +static void __init sun8i_h3_bus_gates_init(struct device_node *node)
> +{
> +       const char *clocks[] = { "ahb1", "ahb2", "apb1", "apb2" };
> +       enum { AHB1, AHB2, APB1, APB2 } clk_parent;
> +       struct clk_onecell_data *clk_data;
> +       const char *clk_name;
> +       struct property *prop;
> +       struct resource res;
> +       void __iomem *clk_reg;
> +       void __iomem *reg;
> +       const __be32 *p;
> +       int number, i;
> +       u8 clk_bit;
> +       u32 index;
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg))
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(clocks); i++) {
> +               index = of_property_match_string(node, "clock-names", clocks[i]);
> +               if (index < 0)
> +                       return;
> +
> +               clocks[i] = of_clk_get_parent_name(node, index);
> +       }
> +
> +       clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
> +       if (!clk_data)
> +               goto err_unmap;
> +
> +       number = of_property_count_u32_elems(node, "clock-indices");
> +       of_property_read_u32_index(node, "clock-indices", number - 1, &number);
> +
> +       clk_data->clks = kcalloc(number + 1, sizeof(struct clk *), GFP_KERNEL);
> +       if (!clk_data->clks)
> +               goto err_free_data;
> +
> +       i = 0;
> +       of_property_for_each_u32(node, "clock-indices", prop, p, index) {
> +               of_property_read_string_index(node, "clock-output-names",
> +                                             i, &clk_name);
> +
> +               if (index == 17 || (index >= 29 && index <= 31))
> +                       clk_parent = AHB2;
> +               else if (index <= 63 || index >= 128)
> +                       clk_parent = AHB1;
> +               else if (index >= 64 && index <= 95)
> +                       clk_parent = APB1;
> +               else if (index >= 96 && index <= 127)
> +                       clk_parent = APB2;

A way to make this reusable in the future might be to encode it in a
structure like:

static const struct bus_clock_paths sun8i_h3_bus_clock_paths __initdata = {
        {.parent = 2, .min = 17, .max = 17}, /* index 17 is from AHB2 */
        {.parent = 2, .min = 29, .max = 31}, /* AHB2 bank */
        {.parent = 1, .min = 63, .max = 128}, /* AHB1 bank */
...
        {}
};

Then the code here can be reused for other clocks like this in the
future without too much bloat. (And this would potentially could be
generic enough for other platforms.)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
