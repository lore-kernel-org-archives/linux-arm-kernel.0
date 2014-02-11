From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Feb 2014 12:48:44 +0000
Subject: [PATCH 3/7] sound: soc: add ASoC board driver for Armada 370 DB
In-Reply-To: <1391102051-5319-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140211124844.GO13533@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 06:14:07PM +0100, Thomas Petazzoni wrote:

> +	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS;
> +	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0)
> +		return ret;

Set .dai_fmt in the DAI link.

> +static int a370db_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_enable_pin(dapm, "Out Jack");
> +	snd_soc_dapm_enable_pin(dapm, "In Jack");

No need to do this, everything defaults to enabled.

> +
> +	card->dev = &pdev->dev;
> +
> +	return snd_soc_register_card(card);
> +}

devm_snd_soc_register_card().

> +static const struct of_device_id a370db_dt_ids[] = {
> +	{ .compatible = "marvell,a370db-audio" },
> +	{ },
> +};

No binding document for this, and you should be using DT to look up the
controller and CODEC rather than hard coding their names (which may
change in future when instantiated from DT, especially the platform
device).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/3e85d280/attachment.sig>
