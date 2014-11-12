From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Nov 2014 22:29:02 +0000
Subject: [PATCH 2/4 V2] ASoC: Samsung: Add arndale_rt5631 machine driver
In-Reply-To: <1415781339-16089-3-git-send-email-krishna.md@samsung.com>
References: <1415781339-16089-1-git-send-email-krishna.md@samsung.com>
 <1415781339-16089-3-git-send-email-krishna.md@samsung.com>
Message-ID: <20141112222902.GV3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 02:05:37PM +0530, Krishna Mohan Dani wrote:

> +	bfs = 32;
> +
> +	rfs = 256;
> +
> +	rclk = params_rate(params) * rfs;
> +
> +	psr = 4;
> +
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
> +					0, SND_SOC_CLOCK_OUT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
> +					0, SND_SOC_CLOCK_OUT);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0, rclk, SND_SOC_CLOCK_OUT);
> +	if (ret < 0)
> +		return ret;

Would it make more sense to push the rate configuration into the I2S
controller driver, it doesn't look very board specific?  Ideally the I2S
driver would be smart enough by default to be used with the simple-card
driver.

> +static int arndale_alc5631_init_paiftx(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_sync(dapm);
> +
> +	return 0;
> +}

This does nothing and can be removed.

> +static struct snd_soc_card arndale = {
> +	.name = "Arndale-I2S",
> +	.dai_link = arndale_dai,
> +	.num_links = ARRAY_SIZE(arndale_dai),
> +};

Please give the card a more specific name like "Arndale RT5631" and
similarly update the symbol names, there are other modules for the
Arndale board.

> +	ret = snd_soc_register_card(card);

devm_snd_soc_register_card().

> +
> +	if (ret)

Extra blank line here after the function call.

> +MODULE_AUTHOR("Claude <claude@insignal.co.kr>");

You're saying Claude is the author but there is no signoff from him.  It
is very important to get signoffs from all authors.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/ca1044ea/attachment.sig>
