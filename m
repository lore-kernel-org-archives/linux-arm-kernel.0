From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Mar 2017 11:51:39 +0800
Subject: [PATCH 10/15] drm/sun4i: tcon: Switch mux on only for composite
In-Reply-To: <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67iTOV-=u5rReu6_wi6NFoCoJkbJKshTpmFYUmJ=ggKUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Even though that mux is undocumented, it seems like it needs to be set to 1
> when using composite, and 0 when using HDMI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index d2335f109601..93249c5ab1e4 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -268,11 +268,16 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
>                            SUN4I_TCON_GCTL_IOMAP_MASK,
>                            SUN4I_TCON_GCTL_IOMAP_TCON1);
>
> +       if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
> +               val = 1;
> +       else
> +               val = 0;
> +
>         /*
>          * FIXME: Undocumented bits
>          */
>         if (tcon->quirks->has_unknown_mux)
> -               regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
> +               regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);

We might want to do this the other way around, i.e. exporting

    int sun4i_tcon_mux_set(struct drm_device *drm, int encoder_type,
                           int pipeline)

and have downstream encoders call it. For the A31, the mux is not exclusively
used for channel 1; there is a mux setting for MIPI DSI as well, but AFAIK
DSI is connected to channel 0.

Additionally, the mux registers are only valid in the first TCON, meaning
it must available be active in 2 pipeline chips. It's also why we'd pass
"struct drm_device *" instead of "struct sun4i_tcon *".


Regards
ChenYu

>  }
>  EXPORT_SYMBOL(sun4i_tcon1_mode_set);
>
> --
> git-series 0.8.11
