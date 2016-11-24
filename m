From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 24 Nov 2016 23:15:47 +0800
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <20161124112231.4297-1-wens@csie.org>
References: <20161124112231.4297-1-wens@csie.org>
Message-ID: <112031480000547@web1h.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



24.11.2016, 19:27, "Chen-Yu Tsai" <wens@csie.org>:
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

Tested by me on an A33 Q8 tablet with 800x480 LCD and 
"urt,umsh-8596md-t" compatible.

The tablet is Aoson M751S.

Works properly with sun4i-drm, with my pll-mipi patch applied.

>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> The few LCD panel datasheets I found did not list minimums or maximums
> for the dot clock rate. The 5% tolerance is just something I made up.
> The point is to be able to use our dot clock, which doesn't have the
> resolution needed to generate the exact clock rate requested. AFAIK
> the sun4i driver is one of the strictest ones with regards to the dot
> clock frequency. Some drivers don't even check it.
>
> The clock rate given in vendor fex files are already rounded down to
> MHz resolution. I doubt not using the exact rate as specified in simple
> panels would cause any issues. But my experience is limited here.
> Feedback on this is requested.
>
> ---
> ?drivers/gpu/drm/sun4i/sun4i_rgb.c | 5 +++--
> ?1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index d198ad7e5323..66ad86afa561 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -93,11 +93,12 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
>
> ?????????DRM_DEBUG_DRIVER("Vertical parameters OK\n");
>
> + /* Check against a 5% tolerance for the dot clock */
> ?????????rounded_rate = clk_round_rate(tcon->dclk, rate);
> - if (rounded_rate < rate)
> + if (rounded_rate < rate * 19 / 20)
> ?????????????????return MODE_CLOCK_LOW;
>
> - if (rounded_rate > rate)
> + if (rounded_rate > rate * 21 / 20)
> ?????????????????return MODE_CLOCK_HIGH;
>
> ?????????DRM_DEBUG_DRIVER("Clock rate OK\n");
> --
> 2.10.2
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
