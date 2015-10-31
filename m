From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 31 Oct 2015 18:28:16 +0800
Subject: [PATCH 01/19] clk: sunxi: Add display clock
In-Reply-To: <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65uzLgKkxKh9RN58w1FZGRJKSbMFmdhZxnRzCdCArBuPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A10 SoCs and its relatives has a special clock controller to drive the
> display engines (both frontend and backend).
>
> Add a driver for it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/Makefile            |   1 +
>  drivers/clk/sunxi/clk-sun4i-display.c | 199 ++++++++++++++++++++++++++++++++++
>  2 files changed, 200 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-display.c
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index cb4c299214ce..a9e1a5885846 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -9,6 +9,7 @@ obj-y += clk-a10-mod1.o
>  obj-y += clk-a10-pll2.o
>  obj-y += clk-a20-gmac.o
>  obj-y += clk-mod0.o
> +obj-y += clk-sun4i-display.o
>  obj-y += clk-simple-gates.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
> diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
> new file mode 100644
> index 000000000000..f13b095c6d7a
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun4i-display.c
> @@ -0,0 +1,199 @@
> +/*
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
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#define SUN4I_A10_DISPLAY_PARENTS      3

Can we change this to 4, so we can reuse this for TCON clocks on sun4i/sun7i?

Thanks

ChenYu

> +#define SUN4I_A10_DISPLAY_GATE_BIT     31
> +#define SUN4I_A10_DISPLAY_RESET_BIT    30
> +#define SUN4I_A10_DISPLAY_MUX_MASK     3
> +#define SUN4I_A10_DISPLAY_MUX_SHIFT    24
> +#define SUN4I_A10_DISPLAY_DIV_WIDTH    4
> +#define SUN4I_A10_DISPLAY_DIV_SHIFT    0
