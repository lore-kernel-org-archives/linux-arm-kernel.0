From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 18 Dec 2017 10:51:00 +0200
Subject: [PATCH 2/4 v5] drm/bridge: Provide a way to embed timing info in
 bridges
In-Reply-To: <20171215121047.3650-3-linus.walleij@linaro.org>
References: <20171215121047.3650-1-linus.walleij@linaro.org>
 <20171215121047.3650-3-linus.walleij@linaro.org>
Message-ID: <5295758.aGqmmxpzro@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

Thank you for the patch.

On Friday, 15 December 2017 14:10:45 EET Linus Walleij wrote:
> After some discussion and failed patch sets trying to convey
> the right timing information between the display engine and
> a bridge using the connector, I try instead to use an optional
> timing information container in the bridge itself, so that
> display engines can retrieve it from any bridge and use it to
> determine how to drive outputs.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog ->v5:
> - New patch
> ---
>  include/drm/drm_bridge.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 682d01ba920c..3bf34f7c90d4 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -30,6 +30,7 @@
> 
>  struct drm_bridge;
>  struct drm_panel;
> +struct drm_bridge_timings;

Could you keep these alphabetically sorted ?

> 
>  /**
>   * struct drm_bridge_funcs - drm_bridge control functions
> @@ -222,6 +223,22 @@ struct drm_bridge_funcs {
>  	void (*enable)(struct drm_bridge *bridge);
>  };
> 
> +/**
> + * struct drm_bridge_timings - timing information for the bridge
> + * @sampling_edge: whether the bridge samples the digital input signal from
> the
> + * display engine on the positive or negative edge of the clock - false
> means
> + * negative edge, true means positive edge.

Would it be clearer to reuse the DRM_BUS_FLAG_PIXDATA_*EDGE flags here ?

> + * @setup_time_ps: the time in picoseconds the input data lines must be
> stable
> + * before the clock edge
> + * @hold_time_ps: the time in picoseconds taken for the bridge to sample
> the
> + * input signal after the rising or falling edge

I'd write s/rising or falling edge/clock edge/ to be consistent with the 
setup_time_ps description (and because that's also clearer in my opinion). If 
you want to explicitly tell which clock edge, you could write "the clock 
sampling edge" for both.

The rest of the patch looks good to me.

> + */
> +struct drm_bridge_timings {
> +	bool sampling_edge;
> +	u32 setup_time_ps;
> +	u32 hold_time_ps;
> +};
> +
>  /**
>   * struct drm_bridge - central DRM bridge control structure
>   * @dev: DRM device this bridge belongs to
> @@ -229,6 +246,8 @@ struct drm_bridge_funcs {
>   * @next: the next bridge in the encoder chain
>   * @of_node: device node pointer to the bridge
>   * @list: to keep track of all added bridges
> + * @timings: the timing specification for the bridge, if any (may
> + * be NULL)
>   * @funcs: control functions
>   * @driver_private: pointer to the bridge driver's internal context
>   */
> @@ -240,6 +259,7 @@ struct drm_bridge {
>  	struct device_node *of_node;
>  #endif
>  	struct list_head list;
> +	const struct drm_bridge_timings *timings;
> 
>  	const struct drm_bridge_funcs *funcs;
>  	void *driver_private;

-- 
Regards,

Laurent Pinchart
