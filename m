From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 10 Sep 2014 16:19:22 +0200
Subject: [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine driver
In-Reply-To: <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <20140910161922.73951f38@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dmitry Lavnikevich wrote:
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt
> new file mode 100644
> index 000000000000..9e6c4443f40f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt
> @@ -0,0 +1,27 @@
> +Audio complex for i.MX6 boards with tlv320aic3x audio codecs.
> +
> +Required properties:
> +- compatible : "fsl,imx-audio-tlv320aic3x"
> +- model : The user-visible name of this sound complex.
> +- ssi-controller : The phandle of the SSI controller.
> +- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
> +- mux-ext-port : The external port of the i.MX audio muxer.
>
fsl,mux-{int,ext}-port?

> diff --git a/sound/soc/fsl/imx-tlv320aic3x.c b/sound/soc/fsl/imx-tlv320aic3x.c
> new file mode 100644
> index 000000000000..f38c68911953
> --- /dev/null
> +++ b/sound/soc/fsl/imx-tlv320aic3x.c
> @@ -0,0 +1,177 @@
> +/*
> + * Copyright 2014 Dmitry Lavnikevich,
> + * SaM Solutions <d.lavnikevich@sam-solutions.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include "../codecs/tlv320aic3x.h"
> +#include "imx-audmux.h"
> +#include "imx-ssi.h"
> +
> +#define CODEC_CLOCK 19200000
> +
I guess this might be board specific and thus best passed via a clock
property in DT.

> +/* machine dapm widgets */
> +static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
> +	SND_SOC_DAPM_LINE("Line Out", NULL),
> +	SND_SOC_DAPM_LINE("Speaker", NULL),
> +	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> +	SND_SOC_DAPM_LINE("Line In", NULL),
> +};
> +
> +static int imx_audmux_config(int int_port, int ext_port)
> +{
> +	unsigned int ptcr, pdcr;
> +
> +	int_port--;
> +	ext_port--;
> +	ptcr = IMX_AUDMUX_V2_PTCR_TFSDIR |
> +		IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> +		IMX_AUDMUX_V2_PTCR_TCLKDIR |
> +		IMX_AUDMUX_V2_PTCR_TCSEL(ext_port);
> +	pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port);
> +	imx_audmux_v2_configure_port(int_port, ptcr, pdcr);
> +
> +	ptcr = 0;
> +	pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(int_port);
> +	imx_audmux_v2_configure_port(ext_port, ptcr, pdcr);
> +
> +	return 0;
> +}
>
This function could be static void ...

> +
> +/* Logic for a aic3x as connected on a imx */
s/ a / an /g

> +static int imx_aic3x_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	int ret;
> +
> +	ret = snd_soc_dai_set_sysclk(rtd->codec_dai, 0, CODEC_CLOCK,
> +		SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>
> +}
> +
> +static struct snd_soc_dai_link imx_tlv320_dai = {
> +	.name = "HiFi",
> +	.stream_name = "HiFi",
> +	.codec_dai_name = "tlv320aic3x-hifi",
> +	.init = &imx_aic3x_init,
> +	.dai_fmt = SND_SOC_DAIFMT_I2S |
> +		SND_SOC_DAIFMT_NB_NF |
> +		SND_SOC_DAIFMT_CBM_CFM,
> +};
> +
> +static struct snd_soc_card imx_tlv320_card = {
> +	.num_links = 1,
> +	.owner = THIS_MODULE,
> +	.dai_link = &imx_tlv320_dai,
> +	.dapm_widgets = aic3x_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(aic3x_dapm_widgets),
> +};
> +
> +static int imx_tlv320_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *ssi_np, *codec_np;
> +	struct platform_device *ssi_pdev;
> +	struct i2c_client *codec_dev;
> +	int int_port, ext_port;
> +	int ret = 0;
> +
Useless variable initialization.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
