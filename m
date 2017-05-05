From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 May 2017 14:36:18 +0200
Subject: [PATCH v6 08/13] drm/sun4i: add support for Allwinner DE2 mixers
In-Reply-To: <522ab8cb2939f0017917c5e9b4065089@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-9-icenowy@aosc.io>
 <20170504130535.6nokhni5a3uxwy66@lukather>
 <522ab8cb2939f0017917c5e9b4065089@aosc.io>
Message-ID: <20170505123618.5vztqx2vdwsgnrxt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 12:50:51AM +0800, icenowy at aosc.io wrote:
> > > +void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
> > > +				int layer, bool enable)
> > > +{
> > > +	u32 val;
> > > +	/* Currently the first UI channel is used */
> > > +	int chan = mixer->cfg->vi_num;
> > > +
> > > +	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
> > > +
> > > +	if (enable)
> > > +		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
> > > +	else
> > > +		val = 0;
> > > +
> > > +	regmap_update_bits(mixer->engine.regs,
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> > > +
> > > +	/* Set the alpha configuration */
> > > +	regmap_update_bits(mixer->engine.regs,
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
> > > +	regmap_update_bits(mixer->engine.regs,
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
> > > +			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
> > > +}
> > 
> > This one too.
> 
> It's called from sun8i_layer.c, so it cannot be static.

Fair enough.

> > > +	/* Set base coordinates */
> > > +	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
> > > +			 state->crtc_x, state->crtc_y);
> > > +	regmap_write(mixer->engine.regs,
> > > +		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
> > > +		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
> > 
> > X and Y are fixed point numbers. You want to keep only the higher 16
> > bits there.
> 
> Do you mean "lower 16 bits"? Thus should I (x & 0xffff) or ((u16)x) ?

Nevermind, I got confused with src_x and src_y.

> P.S. The negative coordinates are broken, how should I deal with it? or
> is the coordinates promised to be not negative?

Adjust the buffer base address, and use a shorter line. You have such
an example in the sun4i code.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170505/d92a20a3/attachment.sig>
