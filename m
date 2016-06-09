From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 23:05:15 +0200
Subject: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
In-Reply-To: <20160602102651.GF2282@sirena.org.uk>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
Message-ID: <20160609210515.GI5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jun 02, 2016 at 11:26:51AM +0100, Mark Brown wrote:
> > +static int sun4i_i2s_params_to_sr(struct snd_pcm_hw_params *params)
> > +{
> > +	switch (params_width(params)) {
> > +	case 16:
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> The switch statement here and in the _wss() function look weird because
> they don't have default cases.  Since there's only one user of both
> functions it seems better to have the switch statements inline anyway.

I don't know, maybe it's just me, but I really find it cleaner that
way, and the compiler will probably inline it anyway. If you insist,
I'll change it though.


> > +	for (i = 0; sun4i_i2s_mclk_div[i].div; i++) {
> > +		const struct sun4i_i2s_clk_div *mdiv = sun4i_i2s_mclk_div + i;
> 
> Why not just write these as normal array lookups?

By normal, you mean using ARRAY_SIZE()?

> > +	/* Enable the first output line */
> > +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> > +			   SUN4I_I2S_CTRL_SDO_EN(0));
> > +
> > +	/* Enable the first two channels */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
> > +		     SUN4I_I2S_TX_CHAN_SEL(2));
> > +
> > +	/* Map them to the two first samples coming in */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
> > +		     SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));
> 
> We don't undo these if setup fails...  do them once on probe?

Yep

> > +static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> > +{
> > +        struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > +	u32 val;
> 
> More tab/space damage, there seems to be quite a bit in the rest of the
> driver.

Indeed, sorry for that.

> > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > +{
> > +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > +
> > +	/* Enable the whole hardware block */
> > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > +		     SUN4I_I2S_CTRL_GL_EN);
> 
> Runtime PM?  It also seems like this is something that ought to be
> covered in the suspend and resume callbacks.

runtime_pm is supported, and uses the regmap cache to keep those
changes.

suspend and resume is not supported for that SoC yet, so I couldn't
test it properly (and isn't that redundant with runtime_pm?)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/c64d7622/attachment.sig>
