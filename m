From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 May 2015 19:03:07 +0800
Subject: [PATCH 4/8] clk: sunxi: codec clock support
In-Reply-To: <1430565879-28113-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v672-fdVi1iC=OTmYtY+rkzd95-KuVHZKAKA0peNvqBf2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
>
> The codec clock on sun4i, sun5i and sun7i is a simple gate with PLL2 as
> parent. Add a driver for such a clock.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/Makefile        |  1 +
>  drivers/clk/sunxi/clk-a10-codec.c | 45 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-a10-codec.c
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index eb36c38d4120..6fa845e13067 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -3,6 +3,7 @@
>  #
>
>  obj-y += clk-sunxi.o clk-factors.o
> +obj-y += clk-a10-codec.o
>  obj-y += clk-a10-hosc.o
>  obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
> diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
> new file mode 100644
> index 000000000000..aaeccf8cde39
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-a10-codec.c
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright 2013 Emilio L?pez
> + *
> + * Emilio L?pez <emilio@elopez.com.ar>
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
> +#include <linux/clkdev.h>

This one is not needed.

Otherwise:

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define SUN4I_CODEC_GATE       31
> +
> +static void __init sun4i_codec_clk_setup(struct device_node *node)
> +{
> +       struct clk *clk;
> +       const char *clk_name = node->name, *parent_name;
> +       void __iomem *reg;
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg))
> +               return;
> +
> +       of_property_read_string(node, "clock-output-names", &clk_name);
> +       parent_name = of_clk_get_parent_name(node, 0);
> +
> +       clk = clk_register_gate(NULL, clk_name, parent_name,
> +                               CLK_SET_RATE_PARENT, reg,
> +                               SUN4I_CODEC_GATE, 0, NULL);
> +
> +       if (!IS_ERR(clk))
> +               of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +}
> +CLK_OF_DECLARE(sun4i_codec, "allwinner,sun4i-a10-codec-clk",
> +              sun4i_codec_clk_setup);
> --
> 2.3.6
>
