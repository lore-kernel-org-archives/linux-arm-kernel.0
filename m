From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 19:53:34 +0100
Subject: [PATCH 2/2] ASoC: samsung: Add machine driver for odroidx2
In-Reply-To: <1400759708-25831-2-git-send-email-s.nawrocki@samsung.com>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
 <1400759708-25831-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140522185334.GT12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 01:55:08PM +0200, Sylwester Nawrocki wrote:
> From: Chen Zhen <zhen1.chen@samsung.com>
> 
> This machine driver primary defines the audio path, the supported
> data formats and sample frequency.

I guess it can't yet, it would have been good to explain that in the
changelog for the bindings (and include the binding in this patch...).

> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
> +					| SND_SOC_DAIFMT_NB_NF
> +					| SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
> +					| SND_SOC_DAIFMT_NB_NF
> +					| SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret < 0)
> +		return ret;

These are constant, set these in the dai_link.

> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 3, MAX98090_MCLK_FREQ,
> +				     SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(codec_dai->dev,
> +			"Unable to switch to FLL1: %d\n", ret);
> +		return ret;
> +	}

So's this - also what is 3?  Set it on init.

> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_OPCLK,
> +					0, MOD_OPCLK_PCLK);

Similarly for the rest of the function.

> +	return snd_soc_register_card(card);

devm_snd_soc_register_card().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/6fab8e38/attachment.sig>
