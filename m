From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 02 Dec 2013 19:10:55 +0100
Subject: [alsa-devel] [PATCH 3/3] ASoC: ux500: Dynamically fill DAI driver
 data on probe
In-Reply-To: <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
Message-ID: <529CCD2F.3060206@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 07:00 PM, Lee Jones wrote:
[...]
> +void ux500_msp_populate_dai_drv(struct snd_soc_dai_driver *ux500_msp_dai_drv)
> +{
> +	ux500_msp_dai_drv->probe                 = ux500_msp_dai_probe;
> +	ux500_msp_dai_drv->suspend               = NULL;
> +	ux500_msp_dai_drv->resume                = NULL;
> +	ux500_msp_dai_drv->playback.channels_min = UX500_MSP_MIN_CHANNELS;
> +	ux500_msp_dai_drv->playback.channels_max = UX500_MSP_MAX_CHANNELS;
> +	ux500_msp_dai_drv->playback.rates        = UX500_I2S_RATES;
> +	ux500_msp_dai_drv->playback.formats      = UX500_I2S_FORMATS;
> +	ux500_msp_dai_drv->capture.channels_min  = UX500_MSP_MIN_CHANNELS;
> +	ux500_msp_dai_drv->capture.channels_max  = UX500_MSP_MAX_CHANNELS;
> +	ux500_msp_dai_drv->capture.rates         = UX500_I2S_RATES;
> +	ux500_msp_dai_drv->capture.formats       = UX500_I2S_FORMATS;
> +	ux500_msp_dai_drv->ops                   = ux500_msp_dai_ops;
>  };

You can just use the same static driver for all devices. No need to
dynamically allocate it.

>  
>  static const struct snd_soc_component_driver ux500_msp_component = {
> @@ -809,6 +742,7 @@ static const struct snd_soc_component_driver ux500_msp_component = {
>  static int ux500_msp_drv_probe(struct platform_device *pdev)
>  {
>  	struct ux500_msp_i2s_drvdata *drvdata;
> +	struct snd_soc_dai_driver *ux500_msp_dai_drv;
>  	int ret = 0;
>  
>  	dev_dbg(&pdev->dev, "%s: Enter (pdev->name = %s).\n", __func__,
> @@ -863,8 +797,18 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>  	}
>  	dev_set_drvdata(&pdev->dev, drvdata);
>  
> +	ux500_msp_dai_drv = devm_kzalloc(&pdev->dev,
> +					 sizeof(*ux500_msp_dai_drv),
> +					 GFP_KERNEL);
> +	if (!ux500_msp_dai_drv) {
> +		ret = -ENOMEM;
> +		goto err_init_msp;
> +	}
> +
> +	ux500_msp_populate_dai_drv(ux500_msp_dai_drv);
> +
>  	ret = snd_soc_register_component(&pdev->dev, &ux500_msp_component,
> -					 &ux500_msp_dai_drv[drvdata->msp->id], 1);
> +					 ux500_msp_dai_drv, 1);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
>  			__func__, drvdata->msp->id);
> 
