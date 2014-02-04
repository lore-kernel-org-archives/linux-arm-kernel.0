From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 17:54:10 +0000
Subject: [PATCH v3 2/5] ASoC: tda998x: add a codec driver for the TDA998x
In-Reply-To: <20140204181605.5b837a70@armhf>
References: <cover.1391274627.git.moinejf@free.fr>
 <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr>
 <20140204133014.GA22609@sirena.org.uk>
 <20140204181605.5b837a70@armhf>
Message-ID: <20140204175410.GL22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 06:16:05PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > +	/* load the optional CODEC */
> > > +	of_platform_populate(np, NULL, NULL, &client->dev);

> > Why is this using of_platform_populate()?  That's a very odd way of
> > doing things.

> The i2c does not populate the subnodes in the DT. I did not find why,
> but, what is sure is that if of_platform_populate() is not called, the
> tda CODEC module is not loaded.

You shouldn't be representing this as a separate node in the DT unless
there really is a distinct and reusable IP, otherwise you're putting
Linux implementation details in there.  Describe the hardware, not the
implemementation.

> You may find an other example in drivers/mfd/twl-core.c.

The TWL drivers aren't always a shining example of how to do things -
they were one of the earliest MFDs so there's warts in there.

> > > +config SND_SOC_TDA998X
> > > +	tristate
> > > +	depends on OF
> > > +	default y if DRM_I2C_NXP_TDA998X=y
> > > +	default m if DRM_I2C_NXP_TDA998X=m

> > Make this visible if it can be selected from DT so it can be used with
> > generic cards.

> I don't understand. The tda CODEC can only be used with the TDA998x I2C
> driver. It might have been included in the tda998x source as well.

You shouldn't have the default settings there at all, that's not the
normal idiom for MFDs.  I'd also not expect to have to build the CODEC
driver just because I built the DRM component.

> Now, the CODEC is declared inside the tda998x as a node child. But, in
> a bad DT, the tda CODEC could be declared anywhere, even inside a other
> DRM I2C slave encoder, in which case, bad things would happen...

So, part of the problem here is that this is being explicitly declared
in the DT leading to more sources for error.

> > What does this actually do?  No information is being passed in to the
> > core function here, not even any information on if it's starting or
> > stopping.  Looking at the rest of the code I can't help thinking it
> > might be clearer to inline this possibly with a lookup helper, the code
> > is very small and the lack of parameters makes it hard to follow.

> I thought it was simple enough. The function tda_start_stop() is called
> from 2 places:

It's not at all obvious - _audio_update() isn't a terribly descriptive
name, just looking at that function by itself I had no idea what it was
supposed to be doing.

> - on audio start in tda_startup with the audio type (DAI id)
> 	priv->dai_id = dai->id;

> - on audio stop with a null audio type
> 	priv->dai_id = 0;		/* streaming stop */

> On stream start, the DAI id is never null, as explained in the patch 1:

> 	The audio format values in the encoder configuration interface  are
> 	changed to non null values so that the value 0 is used in the audio
> 	function to indicate that audio streaming is stopped.

> and on streaming stop the port is not meaningful.

> I will add a null item in the enum (AFMT_NO_AUDIO).

So we can't use both streams simultaneously then?  That's a bit sad.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/037aca8f/attachment.sig>
