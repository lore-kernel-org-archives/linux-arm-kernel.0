From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Oct 2015 17:47:06 +0800
Subject: [PATCH v4 2/5] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <1444682610-21482-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1444682610-21482-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444682610-21482-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65x0M+5LibdvJvGU0TSF3+WkYDe1gdXr8F=V4-Nypt8Ww@mail.gmail.com>
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

GENMASK, like in patch 1, should be GENMASK(width - 1, 0);

Sorry about the multiple replies.

ChenYu
