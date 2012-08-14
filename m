From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 14 Aug 2012 14:17:18 +0200
Subject: [alsa-devel] [PATCH 08/22] ASoC: codecs: Enable AB8500 CODEC
 for	Device Tree
In-Reply-To: <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
Message-ID: <s5h628lu0q9.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu,  9 Aug 2012 16:47:34 +0100,
Lee Jones wrote:
> @@ -2407,6 +2464,30 @@ static int ab8500_codec_probe(struct snd_soc_codec *codec)
>  	/* Setup AB8500 according to board-settings */
>  	pdata = (struct ab8500_platform_data *)dev_get_platdata(dev->parent);
>  
> +	if (np) {
> +		if (!pdata)
> +			pdata = devm_kzalloc(dev,
> +					sizeof(struct ab8500_platform_data),
> +					GFP_KERNEL);
> +
> +		if (!pdata->codec)

The NULL check of pdata must be before pdata->codec access.


Takashi

> +			pdata->codec
> +				= devm_kzalloc(dev,
> +					sizeof(struct ab8500_codec_platform_data),
> +					GFP_KERNEL);
> +
> +		if (!(pdata && pdata->codec))
> +			return -ENOMEM;
> +
> +		ab8500_codec_of_probe(dev, np, pdata->codec);
> +
> +	} else {
> +		if (!(pdata && pdata->codec)) {
> +			dev_err(dev, "No codec platform data or DT found\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	/* Inform SoC Core that we have our own I/O arrangements. */
>  	codec->control_data = (void *)true;
>  
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
