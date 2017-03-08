From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Mar 2017 12:25:59 +0800
Subject: [PATCH 11/15] drm/sun4i: tcon: Fix tcon channel 1 backporch
 calculation
In-Reply-To: <475aeed1da40d46d8e50420c281a74c32b78c730.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <475aeed1da40d46d8e50420c281a74c32b78c730.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64gJ13DB3UxfG7DnJCzE+CZ02repkX8=iOQASsHw2cG5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> It seems like what's called a backporch in the datasheet is actually the
> backporch plus the sync period. Fix that in our driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 93249c5ab1e4..e44217fb4f6f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -240,15 +240,14 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
>                      SUN4I_TCON1_BASIC2_Y(mode->crtc_vdisplay));
>
>         /* Set horizontal display timings */
> -       bp = mode->crtc_htotal - mode->crtc_hsync_end;
> +       bp = mode->crtc_htotal - mode->crtc_hsync_start;
>         DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
>                          mode->htotal, bp);
>         regmap_write(tcon->regs, SUN4I_TCON1_BASIC3_REG,
>                      SUN4I_TCON1_BASIC3_H_TOTAL(mode->crtc_htotal) |
>                      SUN4I_TCON1_BASIC3_H_BACKPORCH(bp));
>
> -       /* Set vertical display timings */

Why remove the comment?

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> -       bp = mode->crtc_vtotal - mode->crtc_vsync_end;
> +       bp = mode->crtc_vtotal - mode->crtc_vsync_start;
>         DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
>                          mode->vtotal, bp);
>         regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
> --
> git-series 0.8.11
