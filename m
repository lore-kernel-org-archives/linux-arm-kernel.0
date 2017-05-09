From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 May 2017 22:19:19 +0200
Subject: [PATCH v6 08/13] drm/sun4i: add support for Allwinner DE2 mixers
In-Reply-To: <185C1948-541D-4198-9A56-E3F0DFF08734@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-9-icenowy@aosc.io>
 <20170504130535.6nokhni5a3uxwy66@lukather>
 <522ab8cb2939f0017917c5e9b4065089@aosc.io>
 <20170505123618.5vztqx2vdwsgnrxt@lukather>
 <185C1948-541D-4198-9A56-E3F0DFF08734@aosc.io>
Message-ID: <20170509201919.ubzhiyntdwf6wlog@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 08:39:31PM +0800, Icenowy Zheng wrote:
> >> > > +	/* Set base coordinates */
> >> > > +	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
> >> > > +			 state->crtc_x, state->crtc_y);
> >> > > +	regmap_write(mixer->engine.regs,
> >> > > +		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
> >> > > +		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
> >> > 
> >> > X and Y are fixed point numbers. You want to keep only the higher
> >16
> >> > bits there.
> >> 
> >> Do you mean "lower 16 bits"? Thus should I (x & 0xffff) or ((u16)x) ?
> >
> >Nevermind, I got confused with src_x and src_y.
> >
> >> P.S. The negative coordinates are broken, how should I deal with it?
> >or
> >> is the coordinates promised to be not negative?
> >
> >Adjust the buffer base address, and use a shorter line. You have such
> >an example in the sun4i code.
> 
> Are they these two lines:
> ```
> paddr += (state->src_x >> 16) * bpp;
> paddr += (state->src_y >> 16) * fb->pitches[0];
> ```
> 
> I think I copied them here, so I don't need to mind this problem any
> more, right?

Hmmm, yes, probably. That's pretty easy to test anyway, you just need
to set up a plane with a negative base coordinate.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170509/71b0d7f6/attachment.sig>
