From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:42:55 +0800
Subject: [PATCH v4 08/15] drm/sun4i: Add LVDS support
In-Reply-To: <b64644e9397ec437ec4d3d16be585b22086cf615.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <b64644e9397ec437ec4d3d16be585b22086cf615.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66ukrD2hYsm3jxz1bWYcYAWUi58i9rZJmhhgt96M5_Jpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 11:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The TCON supports the LVDS interface to output to a panel or a bridge.
> Let's add support for it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/Makefile     |   1 +-
>  drivers/gpu/drm/sun4i/sun4i_lvds.c | 177 ++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_lvds.h |  18 ++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 242 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  29 ++++-
>  5 files changed, 465 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
>

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.h b/drivers/gpu/drm/sun4i/sun4i_lvds.h
> new file mode 100644
> index 000000000000..1b8fad4b82c3
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2015 NextThing Co
> + * Copyright (C) 2015-2017 Free Electrons
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */

SPDX?

> +
> +#ifndef _SUN4I_LVDS_H_
> +#define _SUN4I_LVDS_H_
> +
> +int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon);
> +
> +#endif /* _SUN4I_LVDS_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 46e28ca1f676..777c7348d0cf 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c

[...]

> @@ -698,6 +873,54 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>                 return ret;
>         }
>
> +       /*
> +        * This can only be made optional since we've had DT nodes
> +        * without the LVDS reset properties.
> +        *
> +        * If the property is missing, just disable LVDS, and print a
> +        * warning.
> +        */
> +       tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
> +       if (IS_ERR(tcon->lvds_rst)) {
> +               dev_err(dev, "Couldn't get our reset line\n");
> +               return PTR_ERR(tcon->lvds_rst);
> +       } else if (tcon->lvds_rst) {
> +               has_lvds_rst = true;
> +               reset_control_reset(tcon->lvds_rst);
> +       } else {
> +               has_lvds_rst = false;
> +       }
> +
> +       /*
> +        * This can only be made optional since we've had DT nodes
> +        * without the LVDS reset properties.
> +        *
> +        * If the property is missing, just disable LVDS, and print a
> +        * warning.
> +        */
> +       if (tcon->quirks->has_lvds_pll) {

Care to change these names to match the DT property as well?

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index bd3ad7684870..23db06cdc461 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h

[...]

> @@ -149,6 +173,7 @@ struct sun4i_tcon;
>
>  struct sun4i_tcon_quirks {
>         bool    has_channel_1;  /* a33 does not have channel 1 */
> +       bool    has_lvds_pll;   /* Can we mux the LVDS clock to a PLL? */

This could then read "Does LVDS clock have parent other than TCON clock?"

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Also see my other (late) reply to the previous version.

>         bool    needs_de_be_mux; /* sun6i needs mux to select backend */
>
>         /* callback to handle tcon muxing options */
> @@ -167,6 +192,9 @@ struct sun4i_tcon {
>         struct clk                      *sclk0;
>         struct clk                      *sclk1;
>
> +       /* Possible mux for the LVDS clock */
> +       struct clk                      *lvds_pll;
> +
>         /* Pixel clock */
>         struct clk                      *dclk;
>         u8                              dclk_max_div;
> @@ -174,6 +202,7 @@ struct sun4i_tcon {
>
>         /* Reset control */
>         struct reset_control            *lcd_rst;
> +       struct reset_control            *lvds_rst;
>
>         struct drm_panel                *panel;
>
> --
> git-series 0.9.1
