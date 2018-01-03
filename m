From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 3 Jan 2018 09:20:45 -0800
Subject: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add db820c machine
 driver
In-Reply-To: <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
Message-ID: <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2017 09:34 AM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> uThis patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/Kconfig   |   9 +++-
>  sound/soc/qcom/apq8096.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 sound/soc/qcom/apq8096.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index ecd1e4ba834d..748ccc3edefa 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -72,7 +72,6 @@ config SND_SOC_QDSP6_ASM_DAI
>  	tristate
>  	default n
>  
> -
>  config SND_SOC_QDSP6
>  	tristate "SoC ALSA audio driver for QDSP6"
>  	select SND_SOC_QDSP6_AFE
> @@ -87,3 +86,11 @@ config SND_SOC_QDSP6
>  	 This will enable sound soc platform specific
>  	 audio drivers. This includes q6asm, q6adm,
>  	 q6afe interfaces to DSP using apr.
> +
> +config SND_SOC_MSM8996
> +	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
> +	select SND_SOC_QDSP6V2
> +	default n
> +	help
> +	 To add support for SoC audio on MSM8996 and APQ8096 boards
> +
> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
> new file mode 100644
> index 000000000000..5b2036317f71
> --- /dev/null
> +++ b/sound/soc/qcom/apq8096.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (c) 2017 The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/clk.h>

No clk usage though?

> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <sound/soc.h>
[...]
> +static struct snd_soc_dai_link msm8996_dai_links[] = {
> +	/* FrontEnd DAI Links */
> +	{
> +		.name		= "MultiMedia1 Playback",
> +		.stream_name	= "MultiMedia1",
> +		.cpu_dai_name	= "MM_DL1",
> +		.platform_name	= "q6asm_dai",
> +		.dynamic	= 1,
> +		.dpcm_playback	= 1,
> +
> +		.codec_dai_name	= "snd-soc-dummy-dai",
> +		.codec_name = "snd-soc-dummy",
> +	},
> +	/* Backend DAI Links */
> +	{
> +		.name		= "HDMI Playback",
> +		.stream_name	= "q6afe_dai",
> +		.cpu_dai_name	= "HDMI",
> +		.platform_name	= "q6routing",
> +		.no_pcm		= 1,
> +		.dpcm_playback	= 1,
> +		.be_hw_params_fixup = msm8996_be_hw_params_fixup,
> +		.codec_dai_name	= "i2s-hifi",
> +		.codec_name = "hdmi-audio-codec.0.auto",
> +	},
> +};
> +
> +static int apq8096_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device *dev = card->dev;
> +	int ret;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret)
> +		dev_err(dev, "Error parsing card name: %d\n", ret);

So this prints an error, and the caller also prints an error when it
fails. Double error messages?

> +
> +	return ret;
> +}
> +
> +static int msm_snd_apq8096_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct snd_soc_card *card;
> +
> +	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	card->dev = &pdev->dev;
> +
> +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));

Why do we need to do this? Can you add some sort of comment in the code
about why?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
