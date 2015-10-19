From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 19 Oct 2015 14:12:31 +0200
Subject: [PATCH v1 3/4] ASoC: Add codec machine driver for RK3036
In-Reply-To: <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1445256751.29057.12.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-13 at 09:01 +0800, Shunqian Zheng wrote:
> From: ZhengShunQian <zhengsq@rock-chips.com>
> 
> This patch add the machine driver for rk3036.

Does this need a machine driver? Can't the simple-card machine driver
be used for this ? (From the looks of it that would only mean the
clocking setup for the cpu dai would need to move into the i2s driver?)


> RK3036 SoC is integrated with Inno codec,
> this patch should work for all RK3036 board.
> 
> Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
> ---
> ?sound/soc/rockchip/Kconfig???????????|??10 +++
> ?sound/soc/rockchip/Makefile??????????|???2 +
> ?sound/soc/rockchip/rockchip_rk3036.c | 147
> +++++++++++++++++++++++++++++++++++
> ?3 files changed, 159 insertions(+)
> ?create mode 100644 sound/soc/rockchip/rockchip_rk3036.c
> 
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index 5709057..3d48bda 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -33,3 +33,13 @@ config SND_SOC_ROCKCHIP_RT5645
> ?	help
> ?	??Say Y or M here if you want to add support for SoC audio
> on Rockchip
> ?	??boards using the RT5645/RT5650 codec, such as Veyron.
> +
> +config SND_SOC_ROCKCHIP_RK3036
> +	tristate "ASoC support for RK3036 inner codec"
> +	depends on SND_SOC_ROCKCHIP
> +	select SND_SOC_ROCKCHIP_I2S
> +	help
> +	??Say Y or M here if you want to add support for SoC audio
> on Rockchip
> +	??RK3036.
> +
> +
> diff --git a/sound/soc/rockchip/Makefile
> b/sound/soc/rockchip/Makefile
> index e9ba558..9a770c8 100644
> --- a/sound/soc/rockchip/Makefile
> +++ b/sound/soc/rockchip/Makefile
> @@ -4,7 +4,9 @@ snd-soc-rockchip-i2s-objs := rockchip_i2s.o
> ?obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
> ?
> ?snd-soc-rockchip-max98090-objs := rockchip_max98090.o
> +snd-soc-rockchip-rk3036-objs := rockchip_rk3036.o
> ?snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
> ?
> ?obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-
> max98090.o
> +obj-$(CONFIG_SND_SOC_ROCKCHIP_RK3036) += snd-soc-rockchip-rk3036.o
> ?obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
> diff --git a/sound/soc/rockchip/rockchip_rk3036.c
> b/sound/soc/rockchip/rockchip_rk3036.c
> new file mode 100644
> index 0000000..3747d90
> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_rk3036.c
> @@ -0,0 +1,147 @@
> +/*
> + * Machine driver for rk3036 audio codec.
> + *
> + * Copyright (c) 2015, ROCKCHIP CORPORATION.??All rights reserved.
> + *
> + * Author: Zheng ShunQian<zhengsq@rock-chips.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +
> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <sound/soc-dapm.h>
> +
> +static int rk3036_hw_params(struct snd_pcm_substream *substream,
> +			????struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	unsigned int dai_fmt = rtd->dai_link->dai_fmt;
> +	int mclk, ret;
> +
> +	dev_dbg(rtd->dev, "codec machine: %s\n", __func__);
> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set cpu DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (params_rate(params)) {
> +	case 8000:
> +	case 16000:
> +	case 24000:
> +	case 32000:
> +	case 48000:
> +		mclk = 12288000;
> +		break;
> +	case 44100:
> +		mclk = 11289600;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*Set the system clk for codec*/
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
> SND_SOC_CLOCK_OUT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_ops rk3036_ops = {
> +	??.hw_params = rk3036_hw_params,
> +};
> +
> +static int rk30_rk3036_codec_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	return 0;
> +}
> +
> +static struct snd_soc_dai_link rk3036_dai = {
> +	.name = "INNO-RK3036",
> +	.stream_name = "RK3036 CODEC PCM",
> +	.codec_dai_name = "rk3036-codec-dai",
> +	.init = rk30_rk3036_codec_init,
> +	.ops = &rk3036_ops,
> +	/* set codec as slave */
> +	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +		???SND_SOC_DAIFMT_CBS_CFS,
> +};
> +
> +static struct snd_soc_card rockchip_rk3036_snd_card = {
> +	.name = "ROCKCHIP-I2S",
> +	.dai_link = &rk3036_dai,
> +	.num_links = 1,
> +};
> +
> +static int rockchip_rk3036_audio_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &rockchip_rk3036_snd_card;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	platform_set_drvdata(pdev, card);
> +	card->dev = &pdev->dev;
> +
> +	rk3036_dai.codec_of_node = of_parse_phandle(np,
> +			"rockchip,audio-codec", 0);
> +	if (!rk3036_dai.codec_of_node) {
> +		dev_err(&pdev->dev, "Property 'rockchip,audio-codec' 
> "
> +			"missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	rk3036_dai.cpu_of_node = of_parse_phandle(np,
> +			"rockchip,i2s-controller", 0);
> +	if (!rk3036_dai.cpu_of_node) {
> +		dev_err(&pdev->dev, "Property 'rockchip,i2s-
> controller' "
> +			"missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	rk3036_dai.platform_of_node = rk3036_dai.cpu_of_node;
> +
> +	return snd_soc_register_card(card);
> +}
> +
> +static int rockchip_rk3036_audio_remove(struct platform_device
> *pdev)
> +{
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_card(card);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rockchip_rk3036_of_match[] = {
> +		{ .compatible = "rockchip,rk3036-audio", },
> +		{},
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_rk3036_of_match);
> +
> +static struct platform_driver rockchip_rk3036_audio_driver = {
> +	.driver = {
> +		.name???= "rk3036-audio",
> +		.owner??= THIS_MODULE,
> +		.of_match_table =
> of_match_ptr(rockchip_rk3036_of_match),
> +	},
> +	.probe??????= rockchip_rk3036_audio_probe,
> +	.remove?????= rockchip_rk3036_audio_remove,
> +};
> +module_platform_driver(rockchip_rk3036_audio_driver);
> +
> +MODULE_AUTHOR("Rockchip Inc.");
> +MODULE_DESCRIPTION("Rockchip RK3036 Inno codec machine ASoC
> driver");
> +MODULE_LICENSE("GPL");

-- 
Sjoerd Simons
Collabora Ltd.
