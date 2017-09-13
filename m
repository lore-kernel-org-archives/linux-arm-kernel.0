From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 13 Sep 2017 03:06:40 +0300
Subject: [PATCH 2/2] drm: bridge: Add THS8134A/B support to dumb VGA DAC
In-Reply-To: <20170901094058.4387-1-linus.walleij@linaro.org>
References: <20170901094058.4387-1-linus.walleij@linaro.org>
Message-ID: <3001628.JnWTq76DAb@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Friday, 1 September 2017 12:40:58 EEST Linus Walleij wrote:
> This extends the dumb VGA DAC bridge to handle the THS8134A
> and THS8134B VGA DACs in addition to those already handled.
> 
> The THS8134A, THS8134B and as it turns out also THS8135 need to
> have data clocked out at the negative edge of the clock pulse,
> since they clock it into the DAC at the positive edge (so by
> then it needs to be stable) so we need some extra logic to flag
> this on the connector to the driver.
> 
> The semantics of the flag DRM_BUS_FLAG_PIXDATA_NEGEDGE in
> <drm/drm_connector.h> clearly indicates that this flag tells
> when to *drive* the data, not when the receiver *reads* it,
> so the TI variants needs to be handled like this.
> 
> Introduce a variant struct and contain the information there,
> and add a bit of helpful comments about how this works so
> people will get it right when adding new DACs or connectiong
> new display drivers to DACs.
> 
> The fact that THS8135 might be working on some systems today
> is probably due to the fact that the display driver cannot
> configure when the data is clocked out and the electronics
> have simply been designed around it so it works anyways.
> 
> The phenomenon is very real on the ARM reference designs using
> PL111 where the hardware can control which edge to push out
> the data.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 62 ++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 831a606c4706..6c2fdcb4fde1
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -12,6 +12,7 @@
> 
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
> +#include <linux/of_device.h>

Nitpicking, could you keep header files alphabetically sorted ?

>  #include <linux/regulator/consumer.h>
> 
>  #include <drm/drmP.h>
> @@ -19,9 +20,20 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> 
> +/**
> + * struct vga_dac_variant - characteristics of the DAC

Nitpicking again, I'd call that vga_dac_info, but it's up to you.

> + * @posedge_clk: this DAC latches data into the DAC on the positive
> + *	edge of the clock pulse, which means that display controllers
> + *	need to clock it out on the negative edge
> + */
> +struct vga_dac_variant {
> +	bool posedge_clk;

How about using DRM_BUS_FLAG_PIXDATA_NEGEDGE and DRM_BUS_FLAG_PIXDATA_POSEDGE 
explicitly instead of a bool ? For additional readability you could also 
rename the field to clk_edge_latch (or something similar), to remove the 
drive/latch ambiguity.

> +};
> +
>  struct dumb_vga {
>  	struct drm_bridge	bridge;
>  	struct drm_connector	connector;
> +	struct vga_dac_variant const *variant;
> 
>  	struct i2c_adapter	*ddc;
>  	struct regulator	*vdd;
> @@ -67,6 +79,18 @@ static int dumb_vga_get_modes(struct drm_connector
> *connector) /* And prefer a mode pretty much anyone can handle */
>  	drm_set_preferred_mode(connector, 1024, 768);
> 
> +	if (vga->variant->posedge_clk)
> +		/*
> +		 * If the DAC latches the data into its registers on the
> +		 * positive edge of the clock, the display driver needs to
> +		 * drive the data out on the negative edge so it is
> +		 * stable at the positive edge, so as to avoid flicker.

That's only true if there's no inverter on the board :-) I wonder how that 
could be modelled though.

> +		 * Tell the driver that we want data on the negative edge
> +		 */
> +		connector->display_info.bus_flags |=
> +			DRM_BUS_FLAG_PIXDATA_NEGEDGE;
> +
>  	return ret;
>  }
> 
> @@ -183,6 +207,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
>  	if (!vga)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, vga);
> +	vga->variant = of_device_get_match_data(&pdev->dev);
> 
>  	vga->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
>  	if (IS_ERR(vga->vdd)) {
> @@ -226,10 +251,41 @@ static int dumb_vga_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> +static const struct vga_dac_variant default_dac_variant = {
> +	/*
> +	 * These DACs read data on the negative edge. For example in the
> +	 * ADV7123 datasheet (revision D, page 8) there is a timing diagram
> +	 * making this clear.
> +	 */
> +	.posedge_clk = false,
> +};
> +
> +static const struct vga_dac_variant ti_ths_dac_variant = {
> +	/* The TI DACs read the data on the positive edge of the CLK */
> +	.posedge_clk = true,
> +};
> +
>  static const struct of_device_id dumb_vga_match[] = {
> -	{ .compatible = "dumb-vga-dac" },
> -	{ .compatible = "adi,adv7123" },
> -	{ .compatible = "ti,ths8135" },
> +	{
> +		.compatible = "dumb-vga-dac",
> +		.data = &default_dac_variant,
> +	},
> +	{
> +		.compatible = "adi,adv7123",
> +		.data = &default_dac_variant,
> +	},
> +	{
> +		.compatible = "ti,ths8134a",
> +		.data = &ti_ths_dac_variant,
> +	},
> +	{
> +		.compatible = "ti,ths8134b",
> +		.data = &ti_ths_dac_variant,
> +	},
> +	{
> +		.compatible = "ti,ths8135",
> +		.data = &ti_ths_dac_variant,
> +	},

I wonder whether a generic compatible string for the TI THS813x would make 
sense. I haven't checked the datasheets, but if they're compatible from a 
software point of view, it would be nice not to patch the driver for every 
model (especially if there's more than those three).

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dumb_vga_match);

-- 
Regards,

Laurent Pinchart
