From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 5 Sep 2017 09:04:53 +0100
Subject: [PATCH v6 06/12] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170902195414.3699-7-robert.jarzmik@free.fr>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-7-robert.jarzmik@free.fr>
Message-ID: <20170905080453.d624xdn7c3l4kpwv@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 Sep 2017, Robert Jarzmik wrote:

> The WM9705, WM9712 and WM9713 are highly integrated codecs, with an
> audio codec, DAC and ADC, GPIO unit and a touchscreen interface.
> 
> Historically the support was spread across drivers/input/touchscreen and
> sound/soc/codecs. The sharing was done through ac97 bus sharing. This
> model will not withstand the new AC97 bus model, where codecs are
> discovered on runtime.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> Since v3:
>  - added a "depends on AC97_BUS_NEW" Kconfig statement
>  - added default values for wm9705, wm9712 per Charles's comment
> Since v4:
>  - added Charles's ack
> Since v5:
>  - took into account Lee's comments
> ---
>  drivers/mfd/Kconfig        |  14 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/wm97xx-core.c  | 379 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/wm97xx.h |  25 +++
>  4 files changed, 419 insertions(+)
>  create mode 100644 drivers/mfd/wm97xx-core.c
>  create mode 100644 include/linux/mfd/wm97xx.h

[...]

> +static struct mfd_cell wm9705_cells[] = {
> +	{
> +		.name = "wm9705-codec",
> +	},
> +	{
> +		.name = "wm97xx-ts",
> +	},
> +};

Nit: These should be one line entries:

     {	   .name = "wm9705-codec"	},
     { 	   .name = "wm97xx-ts"		},

[...]

> +static struct mfd_cell wm9712_cells[] = {
> +	{
> +		.name = "wm9712-codec",
> +	},
> +	{
> +		.name = "wm97xx-ts",
> +	},
> +};

As above.

[...]

> +static struct mfd_cell wm9713_cells[] = {
> +	{
> +		.name = "wm9713-codec",
> +	},
> +	{
> +		.name = "wm97xx-ts",
> +	},
> +};

And again.

> +static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
> +{
> +	struct wm97xx_priv *wm97xx;
> +	const struct regmap_config *config;
> +	struct wm97xx_platform_data *codec_pdata;
> +	struct mfd_cell *cells;
> +	int ret = 0, nb_cells, i;
> +	struct wm97xx_pdata *pdata = snd_ac97_codec_get_platdata(adev);
> +
> +	wm97xx = devm_kzalloc(ac97_codec_dev2dev(adev),
> +			      sizeof(*wm97xx), GFP_KERNEL);
> +	if (!wm97xx)
> +		return -ENOMEM;
> +
> +	wm97xx->dev = ac97_codec_dev2dev(adev);
> +	wm97xx->ac97 = snd_ac97_compat_alloc(adev);
> +	if (IS_ERR(wm97xx->ac97))
> +		return PTR_ERR(wm97xx->ac97);
> +
> +
> +	ac97_set_drvdata(adev, wm97xx);
> +	dev_info(wm97xx->dev, "wm97xx core found, id=0x%x\n",
> +		 adev->vendor_id);
> +
> +	codec_pdata = &wm97xx->codec_pdata;
> +	codec_pdata->ac97 = wm97xx->ac97;
> +	codec_pdata->batt_pdata = pdata->batt_pdata;
> +
> +	switch (adev->vendor_id) {
> +	case WM9705_VENDOR_ID:
> +		config = &wm9705_regmap_config;
> +		cells = wm9705_cells;
> +		nb_cells = ARRAY_SIZE(wm9705_cells);
> +		break;
> +	case WM9712_VENDOR_ID:
> +		config = &wm9712_regmap_config;
> +		cells = wm9712_cells;
> +		nb_cells = ARRAY_SIZE(wm9712_cells);
> +		break;
> +	case WM9713_VENDOR_ID:
> +		config = &wm9713_regmap_config;
> +		cells = wm9713_cells;
> +		nb_cells = ARRAY_SIZE(wm9713_cells);
> +		break;
> +	default:
> +		config = NULL;

goto an error label here.

> +	}
> +
> +	for (i = 0; i < nb_cells; i++) {
> +		cells[i].platform_data = codec_pdata;
> +		cells[i].pdata_size = sizeof(*codec_pdata);
> +	}
> +
> +	if (config) {
> +		codec_pdata->regmap =
> +			devm_regmap_init_ac97(wm97xx->ac97, config);
> +		if (IS_ERR(codec_pdata->regmap))
> +			ret = PTR_ERR(codec_pdata->regmap);

Remove the if and do this regardless.

> +	} else {
> +		ret = -ENODEV;
> +	}

remove this.

> +	if (!ret)
> +		ret = devm_mfd_add_devices(wm97xx->dev, PLATFORM_DEVID_NONE,
> +					   cells, nb_cells, NULL, 0, NULL);

Remove the if and do this regardless.

No need to allocate to a variable.  Just return the result directly.

> +	if (ret)
> +		snd_ac97_compat_release(wm97xx->ac97);

Place this in the error path, under the goto label.

> +	return ret;
> +}

Once fixed, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
