From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:38:18 +0000
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304133818.GE3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:20:01PM +0800, Shawn Guo wrote:

> +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> +						  SND_SOC_DAIFMT_NB_NF |
> +						  SND_SOC_DAIFMT_CBM_CFM);

Initialise this from the card.  

Since none of the startup is dynamic it should all be done on DAI init
rather than rerun each time audio is started.

> +	/* Add soc-audio device */
> +	data->soc_audio_pdev = platform_device_alloc("soc-audio", -1);
> +	if (!data->soc_audio_pdev) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}

No, use snd_soc_register_card().  soc-audio has been deprecated since
2.6.38.

> +static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
> +{
> +	struct imx_sgtl5000_data *data = dev_get_drvdata(&pdev->dev);
> +
> +	platform_device_unregister(data->pcm_audio_pdev);

This looks like there's a problem with the bindings, why are you
registering the DMA device from the card?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/059a2179/attachment.sig>
