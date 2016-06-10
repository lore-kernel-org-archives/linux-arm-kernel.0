From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Jun 2016 01:37:55 +0100
Subject: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
In-Reply-To: <20160609210515.GI5242@lukather>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
 <20160609210515.GI5242@lukather>
Message-ID: <20160610003755.GC7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 11:05:15PM +0200, Maxime Ripard wrote:
> On Thu, Jun 02, 2016 at 11:26:51AM +0100, Mark Brown wrote:
> > > +static int sun4i_i2s_params_to_sr(struct snd_pcm_hw_params *params)
> > > +{
> > > +	switch (params_width(params)) {
> > > +	case 16:
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}

> > The switch statement here and in the _wss() function look weird because
> > they don't have default cases.  Since there's only one user of both
> > functions it seems better to have the switch statements inline anyway.

> I don't know, maybe it's just me, but I really find it cleaner that
> way, and the compiler will probably inline it anyway. If you insist,
> I'll change it though.

Yes, it's really not helping here.

> > > +	for (i = 0; sun4i_i2s_mclk_div[i].div; i++) {
> > > +		const struct sun4i_i2s_clk_div *mdiv = sun4i_i2s_mclk_div + i;

> > Why not just write these as normal array lookups?

> By normal, you mean using ARRAY_SIZE()?

array[index].

> > > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > > +{
> > > +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);

> > > +	/* Enable the whole hardware block */
> > > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > +		     SUN4I_I2S_CTRL_GL_EN);

> > Runtime PM?  It also seems like this is something that ought to be
> > covered in the suspend and resume callbacks.

> runtime_pm is supported, and uses the regmap cache to keep those
> changes.

No, my point is that I'd expect to see the block powered off on suspend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/79102099/attachment.sig>
