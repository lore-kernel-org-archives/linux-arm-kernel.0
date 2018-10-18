From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Oct 2018 11:55:28 +0300
Subject: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
In-Reply-To: <20181018073327.64942-10-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io>
 <20181018073327.64942-10-icenowy@aosc.io>
Message-ID: <4168274.Gmp9JTCfJR@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

Thank you for the patch.

On Thursday, 18 October 2018 10:33:27 EEST Icenowy Zheng wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The panels shipped with Allwinner devices are very "generic", i.e.
> they do not have model numbers or reliable sources of information
> for the timings (that we know of) other than the fex files shipped
> on them. The dot clock frequency provided in the fex files have all
> been rounded to the nearest MHz, as that is the unit used in them.
> 
> We were using the simple panel "urt,umsh-8596md-t" as a substitute
> for the A13 Q8 tablets in the absence of a specific model for what
> may be many different but otherwise timing compatible panels. This
> was usable without any visual artifacts or side effects, until the
> dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
> rgb: Validate the clock rate").
> 
> The reason this check fails is because the dotclock frequency for
> this model is 33.26 MHz, which is not achievable with our dot clock
> hardware, and the rate returned by clk_round_rate deviates slightly,
> causing the driver to reject the display mode.
> 
> The LCD panels have some tolerance on the dot clock frequency, even
> if it's not specified in their datasheets.
> 
> This patch adds a 5% tolerence to the dot clock check.

Why do you think this shouldn't be merged ?

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_rgb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> b/drivers/gpu/drm/sun4i/sun4i_rgb.c index bf068da6b12e..23bdc449eacc 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -92,13 +92,14 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct
> drm_encoder *crtc,
> 
>  	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
> 
> +	/* Check against a 5% tolerance for the dot clock */
>  	tcon->dclk_min_div = 6;
>  	tcon->dclk_max_div = 127;
>  	rounded_rate = clk_round_rate(tcon->dclk, rate);
> -	if (rounded_rate < rate)
> +	if (rounded_rate < rate * 19 / 20 )
>  		return MODE_CLOCK_LOW;
> 
> -	if (rounded_rate > rate)
> +	if (rounded_rate > rate * 21 / 20)
>  		return MODE_CLOCK_HIGH;
> 
>  	DRM_DEBUG_DRIVER("Clock rate OK\n");

-- 
Regards,

Laurent Pinchart
