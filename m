From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Jul 2017 11:41:36 +0800
Subject: [PATCH 10/18] drm/sun4i: tcon: Move out the tcon0 common setup
In-Reply-To: <45529eeddc5d5eab9bcfa74982343eeb36fe11f6.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <45529eeddc5d5eab9bcfa74982343eeb36fe11f6.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65TfUKyWg=vxWP-YhM3Be1i=N1OmNTO16aFk2VTCg4VXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some channel0 setup has to be done, no matter what the output interface is
> (RGB, CPU, LVDS). Move that code into a common function in order to avoid
> duplication.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index a3bbf9994cfa..f051862d635e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -125,15 +125,26 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
>         return delay;
>  }
>
> -static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
> -                                struct drm_display_mode *mode)
> +static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
> +                                       struct drm_display_mode *mode)
> +{
> +       /* Configure the dot clock */
> +       clk_set_rate_protect(tcon->dclk, mode->crtc_clock * 1000);

I'd prefer not changing APIs in a code move. It also means we could
apply this sooner than later. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +
> +       /* Set the resolution */
> +       regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> +                    SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
> +                    SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
> +}
> +
> +static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> +                                    struct drm_display_mode *mode)
>  {
>         unsigned int bp, hsync, vsync;
>         u8 clk_delay;
>         u32 val = 0;
>
> -       /* Configure the dot clock */
> -       clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
> +       sun4i_tcon0_mode_set_common(tcon, mode);
>
>         /* Adjust clock delay */
>         clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
> @@ -141,11 +152,6 @@ static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
>                            SUN4I_TCON0_CTL_CLK_DELAY_MASK,
>                            SUN4I_TCON0_CTL_CLK_DELAY(clk_delay));
>
> -       /* Set the resolution */
> -       regmap_write(tcon->regs, SUN4I_TCON0_BASIC0_REG,
> -                    SUN4I_TCON0_BASIC0_X(mode->crtc_hdisplay) |
> -                    SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
> -
>         /*
>          * This is called a backporch in the register documentation,
>          * but it really is the back porch + hsync
> @@ -295,7 +301,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
>  {
>         switch (encoder->encoder_type) {
>         case DRM_MODE_ENCODER_NONE:
> -               sun4i_tcon0_mode_set(tcon, mode);
> +               sun4i_tcon0_mode_set_rgb(tcon, mode);
>                 break;
>         case DRM_MODE_ENCODER_TVDAC:
>                 /*
> --
> git-series 0.9.1
