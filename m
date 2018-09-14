From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Sep 2018 12:34:47 +0300
Subject: [PATCH v2 3/8] drm/bridge: simplify bridge timing info
In-Reply-To: <20180912183222.25414-4-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-4-stefan@agner.ch>
Message-ID: <1573320.Q96Iu7qNKK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wednesday, 12 September 2018 21:32:17 EEST Stefan Agner wrote:
> Bridges are typically connected to a parallel display signal with
> pixel clock, sync signals and data lines. Parallel display signals
> are also used in lower-end embedded display panels. For parallel
> display panels we currently do not specify setup/hold times. From
> discussions on the mailing list it seems not convincing that this
> is currently really required for bridges either.
> 
> Remove setup/hold timings again to better align timing information
> of displays and briges.

The setup and hold timings were the result of a long discussion with Linux 
Walleij, who was confronted with a system that didn't work properly unless he 
flipped the clock polarity. His initial patch contradicted the bridge 
datasheet, and after investigating we found out that timings played a major 
role.

In a nutshell, given the setup and hold time requirements, the polarity on the 
driving side depends on the pixel clock frequency. As the frequency increases, 
when the half clock period reaches the setup time, you can't latch on the 
opposite edge anymore or you will violate the setup time. The component 
connected to the bridge thus needs to select a driving edge based on the 
sampling edge of the bridge, on the bridge's setup time requirement, and on 
the pixel clock frequency.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 17 +++++------------
>  include/drm/drm_bridge.h              | 14 --------------
>  2 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index d5aa0f931ef2..b2309ad228cf
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -229,14 +229,14 @@ static int dumb_vga_remove(struct platform_device
> *pdev) /*
>   * We assume the ADV7123 DAC is the "default" for historical reasons
>   * Information taken from the ADV7123 datasheet, revision D.
> - * NOTE: the ADV7123EP seems to have other timings and need a new timings
> - * set if used.
>   */
>  static const struct drm_bridge_timings default_dac_timings = {
> -	/* Timing specifications, datasheet page 7 */
> +	/*
> +	 * From Timing diagram, datasheet page 7. The bridge samples
> +	 * on pixel clocks positive edge, hence the display controller
> +	 * should drive signals on the negative edge.
> +	 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	.setup_time_ps = 500,
> -	.hold_time_ps = 1500,
>  };
> 
>  /*
> @@ -246,10 +246,6 @@ static const struct drm_bridge_timings
> default_dac_timings = { static const struct drm_bridge_timings
> ti_ths8134_dac_timings = { /* From timing diagram, datasheet page 9 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	/* From datasheet, page 12 */
> -	.setup_time_ps = 3000,
> -	/* I guess this means latched input */
> -	.hold_time_ps = 0,
>  };
> 
>  /*
> @@ -259,9 +255,6 @@ static const struct drm_bridge_timings
> ti_ths8134_dac_timings = { static const struct drm_bridge_timings
> ti_ths8135_dac_timings = { /* From timing diagram, datasheet page 14 */
>  	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> -	/* From datasheet, page 16 */
> -	.setup_time_ps = 2000,
> -	.hold_time_ps = 500,
>  };
> 
>  static const struct of_device_id dumb_vga_match[] = {
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 45e90f4b46c3..1a1d08350eaf 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -251,20 +251,6 @@ struct drm_bridge_timings {
>  	 * &drm_display_info->bus_flags.
>  	 */
>  	u32 input_bus_flags;
> -	/**
> -	 * @setup_time_ps:
> -	 *
> -	 * Defines the time in picoseconds the input data lines must be
> -	 * stable before the clock edge.
> -	 */
> -	u32 setup_time_ps;
> -	/**
> -	 * @hold_time_ps:
> -	 *
> -	 * Defines the time in picoseconds taken for the bridge to sample the
> -	 * input signal after the clock edge.
> -	 */
> -	u32 hold_time_ps;
>  };
> 
>  /**


-- 
Regards,

Laurent Pinchart
