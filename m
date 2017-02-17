From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 17 Feb 2017 18:45:51 +0530
Subject: [PATCH 4/4] ARM: davinci: add pdata-quirks for da850-evm vpif
 display
In-Reply-To: <1487269285-6948-5-git-send-email-bgolaszewski@baylibre.com>
References: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
 <1487269285-6948-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <42c3c8dc-9681-0f4b-e43c-ae95197c727d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2017 11:51 PM, Bartosz Golaszewski wrote:
> Similarly to vpif capture: we need to register the vpif display driver
> and the corresponding adv7343 encoder in pdata-quirks as the DT
> support is not complete - there isn't currently a way to define the
> output_routing in the V4L2 drivers (c.f. s_routing) via DT.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/mach-davinci/pdata-quirks.c | 69 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
> index 3ca773f..c659c76 100644
> --- a/arch/arm/mach-davinci/pdata-quirks.c
> +++ b/arch/arm/mach-davinci/pdata-quirks.c

> +#endif /* IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) */
>  
> +#if IS_ENABLED(CONFIG_DA850_UI_SD_VIDEO_PORT)
> +static struct adv7343_platform_data adv7343_pdata = {
> +	.mode_config = {
> +		.dac = { 1, 1, 1 },
> +	},
> +	.sd_config = {
> +		.sd_dac_out = { 1 },
> +	},
> +};
> +
> +static struct vpif_subdev_info da850_vpif_subdev[] = {
> +	{
> +		.name = "adv7343",
> +		.board_info = {
> +			I2C_BOARD_INFO("adv7343", 0x2a),
> +			.platform_data = &adv7343_pdata,
> +		},
> +	},
> +};
> +
> +static const struct vpif_output da850_ch0_outputs[] = {
> +	{
> +		.output = {
> +			.index = 0,
> +			.name = "Composite",
> +			.type = V4L2_OUTPUT_TYPE_ANALOG,
> +			.capabilities = V4L2_OUT_CAP_STD,
> +			.std = V4L2_STD_ALL,
> +		},
> +		.subdev_name = "adv7343",
> +		.output_route = ADV7343_COMPOSITE_ID,
> +	},
> +	{
> +		.output = {
> +			.index = 1,
> +			.name = "S-Video",
> +			.type = V4L2_OUTPUT_TYPE_ANALOG,
> +			.capabilities = V4L2_OUT_CAP_STD,
> +			.std = V4L2_STD_ALL,
> +		},
> +		.subdev_name = "adv7343",
> +		.output_route = ADV7343_SVIDEO_ID,
> +	},
> +};
> +
> +static struct vpif_display_config da850_vpif_display_config = {
> +	.subdevinfo   = da850_vpif_subdev,
> +	.subdev_count = ARRAY_SIZE(da850_vpif_subdev),
> +	.chan_config[0] = {
> +		.outputs = da850_ch0_outputs,
> +		.output_count = ARRAY_SIZE(da850_ch0_outputs),
> +	},
> +	.card_name    = "DA850/OMAP-L138 Video Display",
> +};
> +#endif /* defined(CONFIG_DA850_UI_SD_VIDEO_PORT) */
> +
> +#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) || IS_ENABLED(CONFIG_DA850_UI_SD_VIDEO_PORT)
>  static void __init da850_vpif_legacy_init(void)
>  {
>  	int ret;
> @@ -119,8 +178,16 @@ static void __init da850_vpif_legacy_init(void)
>  	if (ret)
>  		pr_warn("%s: VPIF capture setup failed: %d\n",
>  			__func__, ret);
> +
> +	/* LCDK doesn't support VPIF display */
> +	if (of_machine_is_compatible("ti,da850-evm")) {
> +		ret = da850_register_vpif_display(&da850_vpif_display_config);

This fails to build when CONFIG_DA850_UI_SD_VIDEO_PORT is switched off.
Probably means you need separate functions for registering capture and
display parts.

I haven't reviewed rest of the patchset yet. Just noticed these while
applying them for some testing. You may want to wait sometime before
sending the next version.

Thanks,
Sekhar
