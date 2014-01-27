From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:42:03 +0000
Subject: [PATCH 2/4] ASoC: tda998x: add a codec driver for TDA998x
In-Reply-To: <a62784e8778d06512d49a24dcf59ff9e45839902.1390813481.git.moinejf@free.fr>
References: <cover.1390813480.git.moinejf@free.fr>
 <a62784e8778d06512d49a24dcf59ff9e45839902.1390813481.git.moinejf@free.fr>
Message-ID: <20140127204203.GX11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 07:45:36PM +0100, Jean-Francois Moine wrote:

>  	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
>  	select SND_SOC_TAS5086 if I2C
> +	select SND_SOC_TDA998X if I2C

> +config SND_SOC_TDA998X
> +	tristate
> +	depends on OF
> +	default y if DRM_I2C_NXP_TDA998X=y
> +	default m if DRM_I2C_NXP_TDA998X=m
> +

These two things don't seem to agree with each other, and I expect this
breaks the build for ALL_CODECS.

> +static void tda_get_encoder(struct tda_priv *priv)
> +{
> +	struct snd_soc_codec *codec = priv->codec;
> +	struct device_node *np;
> +	struct i2c_client *i2c_client;
> +	static const struct of_device_id tda_dt[] = {
> +		{ .compatible = "nxp,tda998x" },
> +		{ },
> +	};
> +
> +	/* search the tda998x device */
> +	np = of_find_matching_node_and_match(NULL, tda_dt, NULL);
> +	if (!np || !of_device_is_available(np)) {
> +		dev_err(codec->dev, "No tda998x in DT\n");
> +		return;
> +	}
> +	i2c_client = of_find_i2c_device_by_node(np);
> +	of_node_put(np);
> +	if (!i2c_client) {
> +		dev_err(codec->dev, "no tda998x i2c client\n");
> +		return;
> +	}
> +	if (!i2c_get_clientdata(i2c_client)) {
> +		dev_err(codec->dev, "tda998x not initialized\n");
> +		return;
> +	}
> +
> +	priv->i2c_client = i2c_client;
> +}

The normal way of doing this would be to make the device a MFD - that
way the frameworks make sure probe ordering and so on are sorted out.
Other than that this looks basically OK, a few small comments below.

> +	/* give the audio input type and ports to the HDMI encoder */
> +	format = start ? priv->dai_id : 0;

It's not clear to me what the above is doing (I think I know but it
requires thinking about rather than being clear).

> +static const struct snd_soc_dai_driver tda998x_dai[] = {
> +    {
> +	.name = "i2s-hifi",

Coding style, indents are tabs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/f42da9a3/attachment-0001.sig>
