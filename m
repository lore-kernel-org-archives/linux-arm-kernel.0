From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Jan 2013 10:49:39 +0000
Subject: [PATCH] ASoC: pxa2xx-ac97: fix oops when codec_driver probe runs
In-Reply-To: <1356704275-3098-1-git-send-email-mikedunn@newsguy.com>
References: <1356704275-3098-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <20130102104939.GA4627@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 06:17:55AM -0800, Mike Dunn wrote:

> -	/* Punt most of the init to the SoC probe; we may need the machine
> -	 * driver to do interesting things with the clocking to get us up
> -	 * and running.
> -	 */
> -	return snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
> -			ARRAY_SIZE(pxa_ac97_dai_driver));
> +	ret = snd_soc_register_dais(&pdev->dev, pxa_ac97_dai_driver,
> +				    ARRAY_SIZE(pxa_ac97_dai_driver));
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "snd_soc_register_dais failed with %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = pxa2xx_ac97_hw_probe(pdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pxa2xx_ac97_hw_probe failed with %d\n",
> +			ret);
> +		snd_soc_unregister_dais(&pdev->dev,
> +					ARRAY_SIZE(pxa_ac97_dai_driver));
> +	}
> +	return ret;

We should be doing all resource acquisition before registering the DAIs,
if anything this patch introduces the potential for additional issues
with the clocks not having been acquired before we try to use them in
the sound card.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130102/b1c84a0d/attachment-0001.sig>
