From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 01 Jul 2013 23:48:17 +0200
Subject: armada_drm clock selection - try 2
In-Reply-To: <20130701203009.633A8FAAD5@dev.laptop.org>
References: <20130701203009.633A8FAAD5@dev.laptop.org>
Message-ID: <51D1F921.9050608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 10:30 PM, Daniel Drake wrote:
> Here is a new patch which should incorporate all your previous feedback.
> Now each variant passes clock info to the main driver via a new
> armada_clk_info structure.
>
> A helper function in the core lets each variant find the best clock.
> As you suggested we first try external ("dedicated") clocks, where we can
> change the rate to find an exact match. We fall back on looking at the rates
> of the other clocks and we return the clock that provides us with the closest
> match after integer division (rejecting those that don't bring us within 1%).
>
> There is still the possibility that two CRTCs on the same device end up using
> the same clock, so I added a usage counter to each clock to prevent the rate
> from being changed by another CRTC.
>
> This is compile-tested only - but after your feedback I will add the
> remaining required hacks and test it on XO.
>
> diff --git a/drivers/gpu/drm/armada/armada_510.c b/drivers/gpu/drm/armada/armada_510.c
> index a016888..7dff2dc 100644
> --- a/drivers/gpu/drm/armada/armada_510.c
> +++ b/drivers/gpu/drm/armada/armada_510.c
> @@ -17,12 +17,29 @@
>
>   static int armada510_init(struct armada_private *priv, struct device *dev)
>   {
> -	priv->extclk[0] = devm_clk_get(dev, "ext_ref_clk_1");
> +	struct armada_clk_info *clk_info = devm_kzalloc(dev,
> +		sizeof(struct armada_clk_info) * 4, GFP_KERNEL);
>
> -	if (IS_ERR(priv->extclk[0])&&  PTR_ERR(priv->extclk[0]) == -ENOENT)
> -		priv->extclk[0] = ERR_PTR(-EPROBE_DEFER);
> +	if (!clk_info)
> +		return -ENOMEM;
>
> -	return PTR_RET(priv->extclk[0]);
> +	/* External clocks */
> +	clk_info[0].clk = devm_clk_get(dev, "ext_ref_clk_0");
> +	clk_info[0].is_dedicated = true;

Daniel,

I guess "extclk0" and "extclk1" should be sufficient for clock names.
Also, they are not dedicated as you can have CRTC0 and CRTC1 use e.g.
extclk0 simultaneously. See below for .is_dedicated in general.

[...]
> diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada/armada_drm.h
> index e8c4f80..4fe8ec5 100644
> --- a/drivers/gpu/drm/armada/armada_drm.h
> +++ b/drivers/gpu/drm/armada/armada_drm.h
> @@ -55,6 +55,20 @@ void armada_drm_vbl_event_remove_unlocked(struct armada_crtc *,
>   	__e->fn = _f;					\
>   } while (0)
>
> +struct armada_clk_info {
> +	struct clk *clk;
> +
> +	/* If this clock is dedicated to us, we can change its rate without
> +	 * worrying about any other users in other parts of the system. */
> +	bool is_dedicated;
> +
> +	/* However, we cannot share the same dedicated clock between two CRTCs
> +	 * if each CRTC wants a different rate. Track the number of users. */
> +	int usage_count;

You can share the same clock between two CRTCs. Just consider CRTC1
using a mode with half pixel clock as CRTC0. Not that I think this will
ever happen, but it is possible.

> +	/* The bits in the SCLK register that select this clock */
> +	uint32_t sclk;
> +};
>
>   struct armada_private;
>
> @@ -77,7 +91,8 @@ struct armada_private {
>   	struct drm_fb_helper	*fbdev;
>   	struct armada_crtc	*dcrtc[2];
>   	struct drm_mm		linear;
> -	struct clk		*extclk[2];
> +	int			num_clks;
> +	struct armada_clk_info	*clk_info;
>   	struct drm_property	*csc_yuv_prop;
>   	struct drm_property	*csc_rgb_prop;
>   	struct drm_property	*colorkey_prop;
> @@ -99,6 +114,9 @@ void __armada_drm_queue_unref_work(struct drm_device *,
>   void armada_drm_queue_unref_work(struct drm_device *,
>   	struct drm_framebuffer *);
>
> +struct armada_clk_info *armada_drm_find_best_clock(struct armada_private *priv,
> +	long rate, int *divider);
> +
>   extern const struct drm_mode_config_funcs armada_drm_mode_config_funcs;
>
>   int armada_fbdev_init(struct drm_device *);
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index e0a08e9..411d56f 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -16,6 +16,97 @@
>   #include "armada_ioctl.h"
>   #include "armada_ioctlP.h"
>
> +/* Find the best clock and integer divisor for a given rate.
> + * NULL is returned when no clock can be found.
> + * When the return value is non-NULL, the divider output variable is set
> + * appropriately, and the clock is returned in prepared state. */
> +struct armada_clk_info *armada_drm_find_best_clock(struct armada_private *priv,
> +	long rate, int *divider)

I prefer not to try to find the best clock (source) at all. Let the
user pass the clock name by e.g. platform_data (or DT) and just try to
get the requested pixclk or a integer multiple of it. You will never be
able to find the best clock for all use cases.

Just figure out, if integer division is sufficient to get requested
pixclk and clk_set_rate otherwise. This may be useful for current mode
running at 148.5MHz (1080p50) and new mode at 74.25MHz (1080i50, 720p).

> +{
> +	int i;
> +	int div;
> +	long residue;
> +	long res_max;
> +	long ref;
> +	struct armada_clk_info *ret = NULL;
> +
> +	/* Look for an unused dedicated clock (e.g. an external clock with
> +	 * no other users) which can provide the desired rate exactly. In this
> +	 * case we can change the clock rate to meet our needs. */
> +	for (i = 0; i<  priv->num_clks; i++) {
> +		struct armada_clk_info *clkinfo =&priv->clk_info[i];
> +		struct clk *candidate = clkinfo->clk;
> +		if (IS_ERR(candidate))
> +			continue;
> +
> +		if (!clkinfo->is_dedicated || clkinfo->usage_count>  0)
> +			continue;
> +
> +		if (clk_prepare(candidate))
> +			continue;
> +
> +		ref = clk_round_rate(candidate, rate);
> +		if (ref == rate) {
> +			*divider = 1;
> +			clk_set_rate(candidate, ref);
> +			return clkinfo;
> +
> +		}
> +		clk_unprepare(candidate);
> +	}
> +
> +	/* Fallback: look for a clock that can bring us within 1% of the
> +	 * desired rate when an integer divider is applied. In this case we
> +	 * do not change the clock's rate because the clock may be shared with
> +	 * other elements. */

Just use clk_set_rate and don't try to make any assumptions. If the
clock you get back is way out of requested pixclk either fail or
just take what you get. HD/SD TV modes usually don't work with wrong
pixclk while VESA modes do.

Audio clock over HDMI will be broken and vert refresh will be wrong but
it is nothing you can check here. Otherwise, I think the patch is going
in the right direction.

Maybe, also clk API should be extended someday to allow to get min/max
frequency range. That will allow us to rule out some modes in a
mode_valid callback based on the pixclk rate.

Sebastian
