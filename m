From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 20 May 2018 11:57:49 +1000
Subject: [linux-sunxi] [PATCH 10/15] drm/sun4i: Add support for R40 TV
 TCONs
In-Reply-To: <20180519183127.2718-11-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-11-jernej.skrabec@siol.net>
Message-ID: <CAGRGNgWumzhiiwJenOXRuRN0i-_2uY=YR5L+9m70HW2ibF=C7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Sun, May 20, 2018 at 4:31 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 display pipeline has a lot of possible configurations. HDMI can be
> connected to 2 different TCONs (out of 4) and mixers can be connected to
> any TCON. All this must be configured in TCON TOP.
>
> Along with definition of TCON capabilities also add mux callback, which
> can configure this complex pipeline.
>
> For now, only TCON TV is supported.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 39 ++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index e0c562ce1c22..81b9551e4f78 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1274,6 +1274,31 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
>         return 0;
>  }
>
> +static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
> +                                    const struct drm_encoder *encoder,
> +                                    int index)
> +{
> +       if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS)
> +               sun8i_tcon_top_set_hdmi_src(tcon->tcon_top, index);
> +
> +       sun8i_tcon_top_de_config(tcon->tcon_top, tcon->id,
> +                                tcon_type_tv, index);
> +
> +       return 0;
> +}
> +
> +static int sun8i_r40_tcon_tv_set_mux_0(struct sun4i_tcon *tcon,
> +                                      const struct drm_encoder *encoder)
> +{
> +       return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 0);
> +}
> +
> +static int sun8i_r40_tcon_tv_set_mux_1(struct sun4i_tcon *tcon,
> +                                      const struct drm_encoder *encoder)
> +{
> +       return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 1);
> +}

Are TCON-TOPs going to be a common thing in new SoCs from Allwinner?
If so, maybe we should add an index to the TCON quirks and have a
common TCON-TOP set_mux function.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
