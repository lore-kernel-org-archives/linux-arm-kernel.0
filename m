From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Thu, 27 May 2010 14:50:05 +0100
Subject: [PATCH v2 2/4] soc/imx: add eukrea-tlv320
In-Reply-To: <1274950737-26498-2-git-send-email-eric@eukrea.com>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<1274950737-26498-2-git-send-email-eric@eukrea.com>
Message-ID: <1274968205.3542.283.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-27 at 10:58 +0200, Eric B?nard wrote:
> Add the necessary files to support the TLV320AIC23B wired in I2S
> on our i.MX platforms.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/imx/Kconfig         |    8 +++
>  sound/soc/imx/Makefile        |    2 +
>  sound/soc/imx/eukrea-tlv320.c |  135 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/imx/eukrea-tlv320.c
> 
> diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
> index 7174b4c..3e27b16 100644
> --- a/sound/soc/imx/Kconfig
> +++ b/sound/soc/imx/Kconfig
> @@ -11,3 +11,11 @@ config SND_IMX_SOC
>  config SND_MXC_SOC_SSI
>  	tristate
>  
> +config SND_SOC_EUKREA_TLV320
> +	bool "Eukrea TLV320"
> +	depends on MACH_EUKREA_MBIMX27_BASEBOARD
> +	select SND_IMX_SOC
> +	select SND_SOC_TLV320AIC23
> +	help
> +	  Enable I2S based access to the TLV320AIC23B codec attached
> +	  to the SSI4 interface
> diff --git a/sound/soc/imx/Makefile b/sound/soc/imx/Makefile
> index 9f8bb92..28d4b1e 100644
> --- a/sound/soc/imx/Makefile
> +++ b/sound/soc/imx/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_SND_IMX_SOC) += snd-soc-imx.o
>  # i.MX Machine Support
>  snd-soc-phycore-ac97-objs := phycore-ac97.o
>  obj-$(CONFIG_SND_SOC_PHYCORE_AC97) += snd-soc-phycore-ac97.o
> +snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
> +obj-$(CONFIG_SND_SOC_EUKREA_TLV320) += snd-soc-eukrea-tlv320.o
> diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
> new file mode 100644
> index 0000000..968380a
> --- /dev/null
> +++ b/sound/soc/imx/eukrea-tlv320.c
> @@ -0,0 +1,135 @@
> +/*
> + * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
> + *
> + * Copyright 2010 Eric B?nard, Eukr?a Electromatique <eric@eukrea.com>
> + *
> + * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
> + * which is Copyright 2009 Simtec Electronics
> + * and on sound/soc/imx/phycore-ac97.c which is
> + * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> + * 
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <asm/mach-types.h>
> +
> +#include "../codecs/tlv320aic23.h"
> +#include "imx-ssi.h"
> +
> +#define CODEC_CLOCK 12000000
> +
> +static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +				  SND_SOC_DAIFMT_NB_NF |
> +				  SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret) {
> +		pr_err("%s: failed set cpu dai format\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +				  SND_SOC_DAIFMT_NB_NF |
> +				  SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret) {
> +		pr_err("%s: failed set codec dai format\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
> +				     CODEC_CLOCK, SND_SOC_CLOCK_OUT);
> +	if (ret) {
> +		pr_err("%s: failed setting codec sysclk\n", __func__);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> +				SND_SOC_CLOCK_IN);
> +	if (ret) {
> +		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_ops eukrea_tlv320_snd_ops = {
> +	.hw_params	= eukrea_tlv320_hw_params,
> +};
> +
> +static struct snd_soc_dai_link eukrea_tlv320_dai = {
> +	.name		= "tlv320aic23",
> +	.stream_name	= "TLV320AIC23",
> +	.codec_dai	= &tlv320aic23_dai,
> +	.ops		= &eukrea_tlv320_snd_ops,
> +};
> +
> +static struct snd_soc_card eukrea_tlv320 = {
> +	.name		= "cpuimx-audio",
> +	.platform	= &imx_soc_platform,
> +	.dai_link	= &eukrea_tlv320_dai,
> +	.num_links	= 1,
> +};
> +
> +static struct snd_soc_device eukrea_tlv320_snd_devdata = {
> +	.card		= &eukrea_tlv320,
> +	.codec_dev	= &soc_codec_dev_tlv320aic23,
> +};
> +
> +static struct platform_device *eukrea_tlv320_snd_device;
> +
> +static int __init eukrea_tlv320_init(void)
> +{
> +	int ret;
> +
> +	if (!machine_is_eukrea_cpuimx27())
> +		/* return happy. We might run on a totally different machine */
> +		return 0;
> +
> +	eukrea_tlv320_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!eukrea_tlv320_snd_device)
> +		return -ENOMEM;
> +
> +	eukrea_tlv320_dai.cpu_dai = &imx_ssi_pcm_dai[0];

Any reason why this is not defined above ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
