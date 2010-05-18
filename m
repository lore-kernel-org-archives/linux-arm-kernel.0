From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 18 May 2010 13:37:39 -0500
Subject: [RFC PATCH 3/3] ep93xx i2s snapper cl15 support
In-Reply-To: <4BF21DB0.2070908@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21DB0.2070908@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B0270842697636F14EC80@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 17, 2010 9:55 PM, Ryan Mallon wrote:
> Added support for i2s audio on Snapper CL15
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
> index 51134b0..d4ca5cc 100644
> --- a/arch/arm/mach-ep93xx/snappercl15.c
> +++ b/arch/arm/mach-ep93xx/snappercl15.c
> @@ -157,6 +157,7 @@ static void __init snappercl15_init_machine(void)
>  	ep93xx_register_i2c(&snappercl15_i2c_gpio_data, snappercl15_i2c_data,
>  			    ARRAY_SIZE(snappercl15_i2c_data));
>  	ep93xx_register_fb(&snappercl15_fb_info);
> +	ep93xx_register_i2s(EP93XX_SYSCON_DEVCFG_I2SONAC97);
>  	platform_device_register(&snappercl15_nand_device);
>  }
>  
> diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
> new file mode 100644
> index 0000000..3fae86e
> --- /dev/null
> +++ b/sound/soc/ep93xx/snappercl15.c
> @@ -0,0 +1,186 @@
> +/*
> + * snappercl15.c -- SoC audio for Bluewater Systems Snapper CL15 module
> + *
> + * Copyright (C) 2008 Bluewater Systems Ltd
> + * Author: Ryan Mallon <ryan@bluewatersys.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include <asm/mach-types.h>
> +#include <mach/hardware.h>
> +
> +#include "../codecs/tlv320aic23.h"
> +#include "ep93xx-pcm.h"
> +#include "ep93xx-i2s.h"
> +
> +//#define CODEC_CLOCK 11289600
> +#define CODEC_CLOCK 5644800
> +
> +static int snappercl15_startup(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}
> +
> +static void snappercl15_shutdown(struct snd_pcm_substream *substream)
> +{
> +}
> +
> +static int snappercl15_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	int sdiv, lrdiv, err;
> +
> +	switch (params_rate(params)) {
> +	case 44100: 
> +		sdiv = 4;
> +		lrdiv = 64;
> +		break;
> +		
> +	case 22050: 
> +		sdiv = 4; 
> +		lrdiv = 128; 
> +		break;
> +

These don't look right (unless I'm missing something).

CODEC_CLOCK = 5644800
SCLK = MCLK / sdiv (4) = 1411200
LRCLK = SCLK / lrdiv (64) = 22050 for 44100
LRCLK = SCLK / lrdiv (128) = 11025 for 22050

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBS_CFS);
+
+	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | 
+				  SND_SOC_DAIFMT_NB_IF |		  
+				  SND_SOC_DAIFMT_CBS_CFS);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, 
+				     SND_SOC_CLOCK_IN);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_sysclk(cpu_dai, 0, CODEC_CLOCK, 
+				     SND_SOC_CLOCK_OUT);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_clkdiv(cpu_dai, EP93XX_I2S_SDIV, sdiv);
+	if (err)
+		return err;
+
+	err = snd_soc_dai_set_clkdiv(cpu_dai, EP93XX_I2S_LRDIV, lrdiv);
+	if (err)
+		return err;
+	
+	return 0;
+}
+
+static struct snd_soc_ops snappercl15_ops = {
+	.startup	= snappercl15_startup,
+	.shutdown	= snappercl15_shutdown,
+	.hw_params	= snappercl15_hw_params,
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+
+static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+	printk(KERN_INFO "%s - here\n", __FUNCTION__);
+
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link snappercl15_dai = {
+	.name		= "tlv320aic23",
+	.stream_name	= "AIC23",
+	.cpu_dai	= &ep93xx_i2s_dai,
+	.codec_dai	= &tlv320aic23_dai,
+	.init		= snappercl15_tlv320aic23_init,
+	.ops		= &snappercl15_ops,
+};
+
+static struct snd_soc_card snd_soc_snappercl15 = {
+	.name		= "Snapper CL15",
+	.platform	= &ep93xx_soc_platform,
+	.dai_link	= &snappercl15_dai,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device snappercl15_snd_devdata = {
+	.card		= &snd_soc_snappercl15,
+	.codec_dev	= &soc_codec_dev_tlv320aic23,
+};
+
+static struct platform_device *snappercl15_snd_device;
+
+static int __init snappercl15_init(void)
+{
+	int ret;
+
+	if (!machine_is_snapper_cl15())
+		return -ENODEV;
+
+	snappercl15_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!snappercl15_snd_device)
+		return -ENOMEM;
+	
+	platform_set_drvdata(snappercl15_snd_device, &snappercl15_snd_devdata);
+	snappercl15_snd_devdata.dev = &snappercl15_snd_device->dev;
+	ret = platform_device_add(snappercl15_snd_device);
+	if (ret)
+		platform_device_put(snappercl15_snd_device);
+
+	return ret;
+}
+
+static void __exit snappercl15_exit(void)
+{
+	platform_device_unregister(snappercl15_snd_device);
+}
+
+module_init(snappercl15_init);
+module_exit(snappercl15_exit);
+
+MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
+MODULE_DESCRIPTION("ALSA SoC Snapper CL15");
+MODULE_LICENSE("GPL");
+

Regards,
Hartley
