From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Mar 2018 15:38:25 +0800
Subject: [PATCH 1/3] drm/sun4i: tcon: Reduce the scope of the LVDS error a
 bit
In-Reply-To: <20180221125703.4595-1-maxime.ripard@bootlin.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66vnba4UPvdGS6ber2N2HRANVLAzDArBTApFJ1Su-Gr7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 8:57 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> The current logic to deal with old DT missing the LVDS properties doesn't
> take into account whether the LVDS output is supported in the first place,
> resulting in spurious error messages on SoCs where it doesn't even matter.
>
> Introduce a new TCON flag to list if LVDS is supported at all to prevent
> this from happening.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 86 ++++++++++++++++++++------------------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>  2 files changed, 46 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3c15cf24b503..6ff0e2e84e81 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -870,52 +870,56 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>                 return ret;
>         }
>
> -       /*
> -        * This can only be made optional since we've had DT nodes
> -        * without the LVDS reset properties.
> -        *
> -        * If the property is missing, just disable LVDS, and print a
> -        * warning.
> -        */
> -       tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
> -       if (IS_ERR(tcon->lvds_rst)) {
> -               dev_err(dev, "Couldn't get our reset line\n");
> -               return PTR_ERR(tcon->lvds_rst);
> -       } else if (tcon->lvds_rst) {
> -               has_lvds_rst = true;
> -               reset_control_reset(tcon->lvds_rst);
> -       } else {
> -               has_lvds_rst = false;
> -       }
> +       if (tcon->quirks->supports_lvds) {
> +               /*
> +                * This can only be made optional since we've had DT
> +                * nodes without the LVDS reset properties.
> +                *
> +                * If the property is missing, just disable LVDS, and
> +                * print a warning.
> +                */
> +               tcon->lvds_rst = devm_reset_control_get_optional(dev, "lvds");
> +               if (IS_ERR(tcon->lvds_rst)) {
> +                       dev_err(dev, "Couldn't get our reset line\n");
> +                       return PTR_ERR(tcon->lvds_rst);
> +               } else if (tcon->lvds_rst) {
> +                       has_lvds_rst = true;
> +                       reset_control_reset(tcon->lvds_rst);
> +               } else {
> +                       has_lvds_rst = false;
> +               }
>
> -       /*
> -        * This can only be made optional since we've had DT nodes
> -        * without the LVDS reset properties.
> -        *
> -        * If the property is missing, just disable LVDS, and print a
> -        * warning.
> -        */
> -       if (tcon->quirks->has_lvds_alt) {
> -               tcon->lvds_pll = devm_clk_get(dev, "lvds-alt");
> -               if (IS_ERR(tcon->lvds_pll)) {
> -                       if (PTR_ERR(tcon->lvds_pll) == -ENOENT) {
> -                               has_lvds_alt = false;
> +               /*
> +                * This can only be made optional since we've had DT
> +                * nodes without the LVDS reset properties.

This comment doesn't match the code following it. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +                *
> +                * If the property is missing, just disable LVDS, and
> +                * print a warning.
> +                */
> +               if (tcon->quirks->has_lvds_alt) {
> +                       tcon->lvds_pll = devm_clk_get(dev, "lvds-alt");
> +                       if (IS_ERR(tcon->lvds_pll)) {
> +                               if (PTR_ERR(tcon->lvds_pll) == -ENOENT) {
> +                                       has_lvds_alt = false;
> +                               } else {
> +                                       dev_err(dev, "Couldn't get the LVDS PLL\n");
> +                                       return PTR_ERR(tcon->lvds_pll);
> +                               }
>                         } else {
> -                               dev_err(dev, "Couldn't get the LVDS PLL\n");
> -                               return PTR_ERR(tcon->lvds_pll);
> +                               has_lvds_alt = true;
>                         }
> -               } else {
> -                       has_lvds_alt = true;
>                 }
> -       }
>
> -       if (!has_lvds_rst || (tcon->quirks->has_lvds_alt && !has_lvds_alt)) {
> -               dev_warn(dev,
> -                        "Missing LVDS properties, Please upgrade your DT\n");
> -               dev_warn(dev, "LVDS output disabled\n");
> +               if (!has_lvds_rst ||
> +                   (tcon->quirks->has_lvds_alt && !has_lvds_alt)) {
> +                       dev_warn(dev, "Missing LVDS properties, Please upgrade your DT\n");
> +                       dev_warn(dev, "LVDS output disabled\n");
> +                       can_lvds = false;
> +               } else {
> +                       can_lvds = true;
> +               }
> +       } else {
>                 can_lvds = false;
> -       } else {
> -               can_lvds = true;
>         }
>
>         ret = sun4i_tcon_init_clocks(dev, tcon);
> @@ -1134,7 +1138,7 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
>  };
>
>  static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
> -       /* nothing is supported */
> +       .supports_lvds          = true,
>  };
>
>  static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index b761c7b823c5..278700c7bf9f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -175,6 +175,7 @@ struct sun4i_tcon_quirks {
>         bool    has_channel_1;  /* a33 does not have channel 1 */
>         bool    has_lvds_alt;   /* Does the LVDS clock have a parent other than the TCON clock? */
>         bool    needs_de_be_mux; /* sun6i needs mux to select backend */
> +       bool    supports_lvds;   /* Does the TCON support an LVDS output? */
>
>         /* callback to handle tcon muxing options */
>         int     (*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);
> --
> 2.14.3
>
