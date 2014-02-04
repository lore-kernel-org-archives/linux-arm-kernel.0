From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 4 Feb 2014 18:16:05 +0100
Subject: [PATCH v3 2/5] ASoC: tda998x: add a codec driver for the TDA998x
In-Reply-To: <20140204133014.GA22609@sirena.org.uk>
References: <cover.1391274627.git.moinejf@free.fr>
 <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
 <20140204133014.GA22609@sirena.org.uk>
Message-ID: <20140204181605.5b837a70@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Feb 2014 13:30:14 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Sun, Jan 26, 2014 at 07:45:36PM +0100, Jean-Francois Moine wrote:
> 
> > +	/* load the optional CODEC */
> > +	of_platform_populate(np, NULL, NULL, &client->dev);
> > +
> 
> Why is this using of_platform_populate()?  That's a very odd way of
> doing things.

The i2c does not populate the subnodes in the DT. I did not find why,
but, what is sure is that if of_platform_populate() is not called, the
tda CODEC module is not loaded.

You may find an other example in drivers/mfd/twl-core.c.

> > +config SND_SOC_TDA998X
> > +	tristate
> > +	depends on OF
> > +	default y if DRM_I2C_NXP_TDA998X=y
> > +	default m if DRM_I2C_NXP_TDA998X=m
> > +
> 
> Make this visible if it can be selected from DT so it can be used with
> generic cards.

I don't understand. The tda CODEC can only be used with the TDA998x I2C
driver. It might have been included in the tda998x source as well.

> > +static int tda_get_encoder(struct tda_priv *priv)
> > +{
> > +	struct snd_soc_codec *codec = priv->codec;
> > +	struct device_node *np;
> > +
> > +	/* get the parent tda998x device */
> > +	np = of_get_parent(codec->dev->of_node);
> > +	if (!np || !of_device_is_compatible(np, "nxp,tda998x")) {
> > +		dev_err(codec->dev, "no or bad parent!\n");
> > +		return -EINVAL;
> > +	}
> > +	priv->i2c_client = of_find_i2c_device_by_node(np);
> > +	of_node_put(np);
> > +	return 0;
> > +}
> 
> Why does this need to be checked like this?  We don't normally have this
> sort of code to check that the parent is correct.

In my previous submit, the tda CODEC was not declared inside the
tda998x I2c device, so, its location was searched from  phandle.

Now, the CODEC is declared inside the tda998x as a node child. But, in
a bad DT, the tda CODEC could be declared anywhere, even inside a other
DRM I2C slave encoder, in which case, bad things would happen...

> > +static int tda_start_stop(struct tda_priv *priv)
> > +{
> > +	int port;
> > +
> > +	/* give the audio parameters to the HDMI encoder */
> > +	if (priv->dai_id == AFMT_I2S)
> > +		port = priv->ports[0];
> > +	else
> > +		port = priv->ports[1];
> > +	tda998x_audio_update(priv->i2c_client, priv->dai_id, port);
> > +	return 0;
> > +}
> 
> What does this actually do?  No information is being passed in to the
> core function here, not even any information on if it's starting or
> stopping.  Looking at the rest of the code I can't help thinking it
> might be clearer to inline this possibly with a lookup helper, the code
> is very small and the lack of parameters makes it hard to follow.

I thought it was simple enough. The function tda_start_stop() is called
from 2 places:

- on audio start in tda_startup with the audio type (DAI id)
	priv->dai_id = dai->id;

- on audio stop with a null audio type
	priv->dai_id = 0;		/* streaming stop */

On stream start, the DAI id is never null, as explained in the patch 1:

	The audio format values in the encoder configuration interface  are
	changed to non null values so that the value 0 is used in the audio
	function to indicate that audio streaming is stopped.

and on streaming stop the port is not meaningful.

I will add a null item in the enum (AFMT_NO_AUDIO).

> > +static const struct snd_soc_dapm_route tda_routes[] = {
> > +	{ "hdmi-out", NULL, "HDMI I2S Playback" },
> > +	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
> > +};
> 
> S/PDIF.

Did you ever try that with debugfs?

BTW, this patch series may be delayed for some time: the tda998x driver
has to be reworked for DT support.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
