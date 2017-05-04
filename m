From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 12:07:46 +0800
Subject: [PATCH v2 14/20] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <59bdbadc4d3adc6d75c2cef38df0af332bd313db.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <59bdbadc4d3adc6d75c2cef38df0af332bd313db.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64mHfj8MLTtvdJCs7h76uMmq-uJuaSEPoQ5CAv-nyrTNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> It appears that the total vertical resolution needs to be doubled when
> we're not in interlaced. Make sure that is the case.

I think the total vertical resolution needs to be doubled in all cases.
It just happens that you should've been using mode->crtc_vtotal, which
is halved when the mode is interlaced. Instead you used mode->vtotal,
which is double the actual scan resolution in interlaced mode.

ChenYu

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 0f91ec8a4b26..efa079c1a3f5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -272,9 +272,9 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
>         /* Set vertical display timings */
>         bp = mode->crtc_vtotal - mode->crtc_vsync_start;
>         DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
> -                        mode->vtotal, bp);
> +                        mode->crtc_vtotal, bp);
>         regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
> -                    SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
> +                    SUN4I_TCON1_BASIC4_V_TOTAL(mode->crtc_vtotal * 2) |
>                      SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
>
>         /* Set Hsync and Vsync length */
> --
> git-series 0.8.11
