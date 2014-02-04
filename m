From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 13:30:14 +0000
Subject: [PATCH v3 2/5] ASoC: tda998x: add a codec driver for the TDA998x
In-Reply-To: <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
 <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
Message-ID: <20140204133014.GA22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 26, 2014 at 07:45:36PM +0100, Jean-Francois Moine wrote:

> +	/* load the optional CODEC */
> +	of_platform_populate(np, NULL, NULL, &client->dev);
> +

Why is this using of_platform_populate()?  That's a very odd way of
doing things.

> +config SND_SOC_TDA998X
> +	tristate
> +	depends on OF
> +	default y if DRM_I2C_NXP_TDA998X=y
> +	default m if DRM_I2C_NXP_TDA998X=m
> +

Make this visible if it can be selected from DT so it can be used with
generic cards.

> +static int tda_get_encoder(struct tda_priv *priv)
> +{
> +	struct snd_soc_codec *codec = priv->codec;
> +	struct device_node *np;
> +
> +	/* get the parent tda998x device */
> +	np = of_get_parent(codec->dev->of_node);
> +	if (!np || !of_device_is_compatible(np, "nxp,tda998x")) {
> +		dev_err(codec->dev, "no or bad parent!\n");
> +		return -EINVAL;
> +	}
> +	priv->i2c_client = of_find_i2c_device_by_node(np);
> +	of_node_put(np);
> +	return 0;
> +}

Why does this need to be checked like this?  We don't normally have this
sort of code to check that the parent is correct.

> +static int tda_start_stop(struct tda_priv *priv)
> +{
> +	int port;
> +
> +	/* give the audio parameters to the HDMI encoder */
> +	if (priv->dai_id == AFMT_I2S)
> +		port = priv->ports[0];
> +	else
> +		port = priv->ports[1];
> +	tda998x_audio_update(priv->i2c_client, priv->dai_id, port);
> +	return 0;
> +}

What does this actually do?  No information is being passed in to the
core function here, not even any information on if it's starting or
stopping.  Looking at the rest of the code I can't help thinking it
might be clearer to inline this possibly with a lookup helper, the code
is very small and the lack of parameters makes it hard to follow.

> +static const struct snd_soc_dapm_route tda_routes[] = {
> +	{ "hdmi-out", NULL, "HDMI I2S Playback" },
> +	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
> +};

S/PDIF.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/c0356e5e/attachment-0001.sig>
