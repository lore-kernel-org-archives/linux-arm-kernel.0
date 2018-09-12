From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Sep 2018 20:29:45 +0800
Subject: [PATCH 19/27] drm/sun4i: Add support for H6 DW HDMI controller
In-Reply-To: <20180902072643.4917-20-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-20-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67XJoJGQjF6bELkiRGnkG=ZumvScDb8_3j_yUi7nhuQtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> H6 has DW HDMI 2.0 controller v2.12a.
>
> It supports 4K at 60 Hz and HDCP 2.2.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> index 16a0c7a88ea8..44143c9f20d0 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -43,6 +43,16 @@ sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
>         return MODE_OK;
>  }
>
> +static enum drm_mode_status
> +sun8i_dw_hdmi_mode_valid_h6(struct drm_connector *connector,
> +                           const struct drm_display_mode *mode)
> +{
> +       if (mode->clock > 600000)

600 MHz seems slightly arbitrary. AFAIK the dot clock for 4K 60Hz is 594 MHz?
A comment on this limit would be nice.

> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
>  {
>         return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> @@ -220,12 +230,20 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
> +       .mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> +};
> +

Please "version" sort the SoC families and models.

>  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
>         .mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
>         .set_rate = true,
>  };
>
>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> +       {
> +               .compatible = "allwinner,sun50i-h6-dw-hdmi",
> +               .data = &sun50i_h6_quirks,
> +       },

Here also.

Once fixed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>         {
>                 .compatible = "allwinner,sun8i-a83t-dw-hdmi",
>                 .data = &sun8i_a83t_quirks,
> --
> 2.18.0
>
