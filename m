From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Feb 2017 19:17:58 +0800
Subject: [PATCH v1 3/3] ASoC: zx-96p22: add zte's aud96p22 controller
 driver
In-Reply-To: <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
 <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170216111756.GD8398@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:55:10PM +0800, Baoyou Xie wrote:
> This patch adds aud96p22 controller driver for zte's SoC family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

s/controller/codec in patch subject.

> ---
>  sound/soc/codecs/Kconfig       |   4 +
>  sound/soc/codecs/Makefile      |   2 +
>  sound/soc/codecs/zx_aud96p22.c | 588 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 594 insertions(+)
>  create mode 100644 sound/soc/codecs/zx_aud96p22.c
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index cfc108e..120af32 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1116,4 +1116,8 @@ config SND_SOC_TPA6130A2
>  	tristate "Texas Instruments TPA6130A2 headphone amplifier"
>  	depends on I2C
>  
> +config SND_SOC_ZX96P22
> +	tristate "ZTE Inner AUD96P22 CODEC"
> +	depends on I2C
> +
>  endmenu
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 2624c73..dbc3818 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -219,6 +219,7 @@ snd-soc-wm9705-objs := wm9705.o
>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> +snd-soc-zx96p22-objs := zx_aud96p22.o
>  # Amp
>  snd-soc-max9877-objs := max9877.o
>  snd-soc-max98504-objs := max98504.o
> @@ -444,6 +445,7 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
>  obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
>  obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
>  obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
> +obj-$(CONFIG_SND_SOC_ZX96P22)	+= snd-soc-zx96p22.o
>  
>  # Amp
>  obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
> diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
> new file mode 100644
> index 0000000..f2979df
> --- /dev/null
> +++ b/sound/soc/codecs/zx_aud96p22.c
> @@ -0,0 +1,588 @@
> +/*
> + * ZTE's audio 96p22 driver
> + *
> + * Copyright (C) 2017 ZTE Ltd
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include <sound/pcm.h>
> +
> +#define BGPIO64				(64)

GPIO resource is a board level configuration, which might be different
from one board to another.  Instead of hard-coding, it should be
retrieved from device tree.

> +#define snd_kcontrol_dev(kcontrol)	\
> +		((struct device *)((kcontrol)->private_value))
> +
> +struct i2c_reg {
> +	unsigned char addr;
> +	unsigned char high_data;
> +	unsigned char low_data;
> +};
> +
> +struct zx_aud96p22_info {
> +	struct device   *dev;

One space is good enough between type and variable.

> +	int gpio;
> +	bool capture;
> +};
> +
> +static struct i2c_reg i2c_dac_master_volume_table[] = {
> +	{ 0x34, 0xe7, 0xe7 },
> +};
> +
> +static struct i2c_reg i2c_adc_master_volume_table[] = {
> +	{ 0x24, 0xbf, 0xbf },
> +};
> +
> +static struct i2c_reg i2c_dac_headset_volume_table[] = {
> +	{ 0x38, 0x0d, 0x0d },
> +};
> +
> +static struct i2c_reg i2c_dac_sleep_table[] = {
> +	{ 0x18, 0x00, 0x00 }, //play power down

/* single line comment */ please.

> +};
> +
> +static struct i2c_reg i2c_dac_wakeup_table[] = {
> +	{ 0x18, 0x00, 0xff }, //play power up
> +};
> +
> +static struct i2c_reg i2c_adc_sleep_table[] = {
> +	{ 0x16, 0x00, 0x00 }, //record power down
> +};
> +
> +static struct i2c_reg i2c_adc_wakeup_table[] = {
> +	{ 0x16, 0x00, 0x0f }, //record power up
> +};
> +
> +static struct i2c_reg i2c_codec_start_table[] = {
> +	{ 0x15, 0x00, 0x00 }, //power down control
> +	{ 0x47, 0x00, 0x00 }, //record path slect
> +	{ 0x24, 0xbf, 0xbf }, //record volume control
> +	{ 0x26, 0x30, 0x30 }, //record pga volume control
> +	{ 0xc8, 0x00, 0x00 }, //ALC control
> +	{ 0xce, 0x00, 0xf5 }, //record noise gate
> +	{ 0xf3, 0x00, 0xc0 }, //dac noise dithe
> +	{ 0xcd, 0x00, 0x20 }, //max record volume
> +	{ 0x15, 0x00, 0x01 }, //power down control
> +	{ 0x18, 0x00, 0xff }, //play power  control
> +	{ 0x16, 0x00, 0x0f }, //record power up
> +	{ 0x19, 0x00, 0x04 }, //power down control
> +	{ 0x02, 0x00, 0x05 }, //ext clock slect
> +	{ 0x01, 0x00, 0x05 }, //ext clock slect
> +	{ 0x00, 0x00, 0x00 }, //adc dpz reset
> +	{ 0x00, 0x00, 0x03 }, //dac dpz reset
> +	{ 0x04, 0x00, 0x40 }, //clk div
> +	{ 0x05, 0x00, 0x04 }, //clk div0x4
> +	{ 0x06, 0x00, 0x40 }, //clk div
> +	{ 0x07, 0x00, 0x04 }, //clk div 0x4
> +	{ 0x03, 0x00, 0x01 }, //slave 16bit i2s
> +	{ 0x00, 0x00, 0x00 }, //adc dpz reset
> +	{ 0x00, 0x00, 0x03 }, //dac dpz reset
> +};

<snip>

I skipped the code in between, and will review them in the next version,
since most of them needs update anyway to use regmap interface.

> +static int zx_aud96p22_i2c_probe(struct i2c_client *i2c_client,
> +				const struct i2c_device_id *id)
> +{
> +	int ret = 0;
> +	struct device *pdev = &i2c_client->dev;

'pdev' is usually used for struct platform_device type.  Please use
'dev' here.

> +
> +	if (!i2c_client)
> +		return -ENODEV;
> +
> +	ret = snd_soc_register_codec(pdev, &zx_aud96p22_driver,
> +				&zx_aud96p22_dai, 1);
> +
> +	return ret;
> +}
> +
> +static int zx_aud96p22_i2c_remove(struct i2c_client *i2c_client)
> +{
> +	struct device *pdev = &i2c_client->dev;

Ditto

Shawn

> +
> +	snd_soc_unregister_codec(pdev);
> +
> +	return 0;
> +}
> +
> +const struct of_device_id zx_aud96p22_of_dt_ids[] = {
> +	{ .compatible = "zte,zx-aud96p22", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, zx_aud96p22_of_dt_ids);
> +
> +static struct i2c_driver aud96p22_i2c_driver = {
> +	.driver = {
> +		.name = "zx-aud96p22",
> +		.of_match_table = zx_aud96p22_of_dt_ids,
> +	},
> +	.probe = zx_aud96p22_i2c_probe,
> +	.remove = zx_aud96p22_i2c_remove,
> +};
> +module_i2c_driver(aud96p22_i2c_driver);
> +
> +MODULE_DESCRIPTION("ZTE ASoC AUD96P22 driver");
> +MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
