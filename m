From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 05 May 2017 16:16:29 +0800
Subject: [PATCH v2 14/20] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <59bdbadc4d3adc6d75c2cef38df0af332bd313db.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <59bdbadc4d3adc6d75c2cef38df0af332bd313db.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <3683ca88e5dd7ab9f26f1c12beb15cb8@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-05-03 19:59?Maxime Ripard ???
> It appears that the total vertical resolution needs to be doubled when
> we're not in interlaced. Make sure that is the case.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 0f91ec8a4b26..efa079c1a3f5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -272,9 +272,9 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
>  	/* Set vertical display timings */
>  	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
>  	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
> -			 mode->vtotal, bp);
> +			 mode->crtc_vtotal, bp);
>  	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
> -		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
> +		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->crtc_vtotal * 2) |

For TVE the value should directly be mode->vtotal, but not
mode->crtc_vtotal * 2.

vtotal is 625 when PAL. crtc_vtotal is thus 312, but if we restore the
vtotal value by doubling crtv_vtotal, we got 624, which will lead to
instability of the image displayed. (the image will loop to go higher
and then go lower, because wrong vtotal value)

Tested on patched H3 TV encoder.

I used a logic slightly changed from your v1 code:

```
	val = mode->vtotal;
	if (!(mode->flags & DRM_MODE_FLAG_INTERLACE))
		val = val * 2;
	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
		     SUN4I_TCON1_BASIC4_V_TOTAL(val) |
		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
```

>  		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
> 
>  	/* Set Hsync and Vsync length */
