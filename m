From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 31 Oct 2015 18:19:59 +0800
Subject: [PATCH 03/19] clk: sunxi: Add TCON channel0 clock
In-Reply-To: <1446214865-3972-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66hjH_GpkXpHdpCM+mUv-CgvqxJNFzsoRJ5MWp04b+jew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The TCON is a controller generating the timings to output videos signals,
> acting like both a CRTC and an encoder.
>
> It has two channels depending on the output, each channel being driven by
> its own clock (and own clock controller).
>
> Add a driver for the channel 0 clock.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/Makefile             |   1 +
>  drivers/clk/sunxi/clk-sun4i-tcon-ch0.c | 173 +++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch0.c
>
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index 40c32ffd912c..7821b2b63d58 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -12,6 +12,7 @@ obj-y += clk-mod0.o
>  obj-y += clk-simple-gates.o
>  obj-y += clk-sun4i-display.o
>  obj-y += clk-sun4i-pll3.o
> +obj-y += clk-sun4i-tcon-ch0.o
>  obj-y += clk-sun8i-mbus.o
>  obj-y += clk-sun9i-core.o
>  obj-y += clk-sun9i-mmc.o
> diff --git a/drivers/clk/sunxi/clk-sun4i-tcon-ch0.c b/drivers/clk/sunxi/clk-sun4i-tcon-ch0.c
> new file mode 100644
> index 000000000000..db10cfb94a1d
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-sun4i-tcon-ch0.c
> @@ -0,0 +1,173 @@
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
> +#define SUN4I_A10_TCON_CH0_PARENTS     4
> +
> +#define SUN4I_A10_TCON_CH0_GATE_BIT    31
> +#define SUN4I_A10_TCON_CH0_RESET_SHIFT 29

This is sun5i specific.

A10s manual says bit 30 is the LCD reset, while bit 29 is the TV encoder reset.
A13/R8 don't mention TCON_CH0 clock. A10/A20 have no separate TV encoder reset.

Please rename the clock.

ChenYu

> +#define SUN4I_A10_TCON_CH0_MUX_MASK    3
> +#define SUN4I_A10_TCON_CH0_MUX_SHIFT   24
> +
> +struct reset_data {
> +       void __iomem                    *reg;
> +       spinlock_t                      *lock;
> +       struct reset_controller_dev     rcdev;
> +};
> +
> +static DEFINE_SPINLOCK(sun4i_a10_tcon_ch0_lock);
> +
