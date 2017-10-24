From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 24 Oct 2017 11:45:20 +0300
Subject: [PATCH v4] drm: bridge: Add THS8134A/B support to dumb VGA DAC
In-Reply-To: <20171020125412.25988-1-linus.walleij@linaro.org>
References: <20171020125412.25988-1-linus.walleij@linaro.org>
Message-ID: <13720071.DIiUQShqpX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Friday, 20 October 2017 15:54:12 EEST Linus Walleij wrote:
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
> ChangeLog v3->v4:
> - Actually have the code syntactically correct and compiling :(
>   (Kconfig mistake.)
>   (...)
>   AS      usr/initramfs_data.o
>   AR      usr/built-in.o
>   CC      drivers/gpu/drm/bridge/dumb-vga-dac.o
>   AR      drivers/gpu/drm/bridge/built-in.o
>   AR      drivers/gpu/drm/built-in.o
>   AR      drivers/gpu/built-in.o
>   AR      drivers/built-in.o
>   (...)
> ChangeLog v2->v3:
> - Move const specifier.
> - Cut one line of code assigning bus flags.
> - Preserve the "ti,ths8135" compatible for elder device trees.
> ChangeLog v1->v2:
> - Alphabetize includes
> - Use a u32 with the bus polarity flags and just encode the
>   polarity using the DRM define directly.
> - Rename vendor_data to vendor_info.
> - Simplify assignment of the flag as it is just a simple
>   u32 now.
> - Probe all TI variants on the "ti,ths813x" wildcard for now,
>   we only need to know that the device is in this family to
>   set the clock edge flag right.
> ---
>  drivers/gpu/drm/bridge/dumb-vga-dac.c | 53 +++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 831a606c4706..92d1fe93a012
> 100644
> --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
> +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
> @@ -11,6 +11,7 @@
>   */
> 
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/regulator/consumer.h>
> 
> @@ -19,9 +20,18 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> 
> +/**
> + * struct vga_dac_info - characteristics of the DAC
> + * @clk_edge_latch: this defines the clock edge latch for the variant
> + */
> +struct vga_dac_info {
> +	u32 clk_edge_latch;
> +};
> +
>  struct dumb_vga {
>  	struct drm_bridge	bridge;
>  	struct drm_connector	connector;
> +	const struct vga_dac_info *variant;
> 
>  	struct i2c_adapter	*ddc;
>  	struct regulator	*vdd;
> @@ -55,6 +65,7 @@ static int dumb_vga_get_modes(struct drm_connector
> *connector) }
> 
>  	drm_mode_connector_update_edid_property(connector, edid);
> +	connector->display_info.bus_flags |= vga->variant->clk_edge_latch;
>  	return drm_add_edid_modes(connector, edid);
> 
>  fallback:
> @@ -67,6 +78,8 @@ static int dumb_vga_get_modes(struct drm_connector
> *connector) /* And prefer a mode pretty much anyone can handle */
>  	drm_set_preferred_mode(connector, 1024, 768);
> 
> +	connector->display_info.bus_flags |= vga->variant->clk_edge_latch;
> +
>  	return ret;
>  }
> 
> @@ -183,6 +196,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
>  	if (!vga)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, vga);
> +	vga->variant = of_device_get_match_data(&pdev->dev);
> 
>  	vga->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
>  	if (IS_ERR(vga->vdd)) {
> @@ -226,10 +240,43 @@ static int dumb_vga_remove(struct platform_device
> *pdev) return 0;
>  }
> 
> +static const struct vga_dac_info default_dac_variant = {
> +	/*
> +	 * These DACs read data on the negative edge. For example in the
> +	 * ADV7123 datasheet (revision D, page 8) there is a timing diagram
> +	 * making this clear. So consequently we need to latch the data
> +	 * on the positive edge.
> +	 */
> +	.clk_edge_latch = DRM_BUS_FLAG_PIXDATA_POSEDGE,

I've checked the datasheet (sorry for not having done so before), and the 
timing diagram on page 8 of revision D shows to me that data is sampled on the 
rising edge of the clock, not the falling edge.

I've checked the schematics of the Renesas boards that use the ADV7123 and 
they route the clock directly from the SoC to the DAC without any inverter or 
other logic on the signal. The R-Car DU driver currently outputs data on the 
rising edge of the clock. However, the DU has an internal delay of 8.5ns 
between the rising clock edge and the data output, which is smaller than the 
0.2ns setup time of the ADV7123. That's why the current code works on Renesas 
boards, and likely why it also works with the existing users of the THS8135.

DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it 
doesn't match how the ADV7123 operates. Using DRM_BUS_FLAG_PIXDATA_NEGEDGE 
would match the hardware, but would break display for some modes, depending on 
the display clock frequency as the internal 8.5ns output delay applied to a 
falling clock edge would fall right into the 1.7ns setup + hold time window of 
the ADV7123 around the rising edge. I can't test this right now as I don't 
have local access to boards using the ADV7123, but from a quick calculation 
that ignores the PCB transmission delay modes with frequencies between 57MHz 
and 71MHz could break if the data was output on the falling edge of the clock.

Now I'm not sure how to solve this properly. In the general case we need to 
take into account the clock frequency, the output delay of the transmitter, 
the PCB transmission delay, the setup + hold times of the receiver, and the 
sampling clock edge of the receiver to decide what edge to use on the 
transmitter side. Some transmitters can also configure the output delay, which 
can be useful but complicates things further.

The more I think about it the more I believe that the 
DRM_BUS_FLAG_PIXDATA_POSEDGE and DRM_BUS_FLAG_PIXDATA_NEGEDGE flags are not 
the right way to pass information between bridges and display controllers. 
Reporting the sampling edge and the setup + hold window would allow the 
display engine driver to compute its output parameters, instead of trying to 
infer in the bridge driver how the display engine operates.

> +};
> +
> +static const struct vga_dac_info ti_ths_dac_variant = {
> +	/*
> +	 * The TI DACs read the data on the positive edge of the CLK,
> +	 * so consequently we need to latch the data on the negative
> +	 * edge.
> +	 */
> +	.clk_edge_latch = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
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
> +		/* Some trees contain just this compatible and no "ti,ths813x" */
> +		.compatible = "ti,ths8135",
> +		.data = &ti_ths_dac_variant,
> +	},
> +	{
> +		.compatible = "ti,ths813x",
> +		.data = &ti_ths_dac_variant,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dumb_vga_match);

-- 
Regards,

Laurent Pinchart
