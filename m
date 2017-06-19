From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Jun 2017 17:19:10 +0100
Subject: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22 codec driver
In-Reply-To: <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 17, 2017 at 10:09:34PM +0800, Shawn Guo wrote:

> +	/* Mute control */
> +	SOC_DOUBLE("Playback Master Mute", AUD96P22_MUTE_2, 0, 1, 1, 0),
> +	SOC_DOUBLE("Headset Mute", AUD96P22_MUTE_2, 4, 5, 1, 0),

As covered in ControlNames.txt mute and other on/off controls should be
named ending in Switch so UIs know what to do with them.

> +static int aud96p22_startup(struct snd_pcm_substream *substream,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct aud96p22_priv *priv = snd_soc_codec_get_drvdata(dai->codec);
> +	struct regmap *regmap = priv->regmap;
> +
> +	/* Overall power-up */
> +	regmap_update_bits(regmap, AUD96P22_PD_0, PD_0_PDZ, PD_0_PDZ);

Why is this not done with DAPM?

> +	/* Reset ADC and DAC path */
> +	regmap_write(regmap, AUD96P22_RESET, 0x0);
> +	regmap_write(regmap, AUD96P22_RESET, 0x3);

What does this mean?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170619/43a45f64/attachment.sig>
