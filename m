From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Sep 2013 19:05:40 +0100
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130919193403.30ac5764@armhf>
References: <20130919105437.75e0f0a3@armhf>
 <20130919104028.GI21013@sirena.org.uk>
 <20130919193403.30ac5764@armhf>
Message-ID: <20130919180540.GH21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 07:34:03PM +0200, Jean-Francois Moine wrote:

> Well, first, the codecs hdmi and dmic have no DT support.
> Then, from the Cubox point of vue, the codec hdmi offers playback
> and capture while the Cubox has only playback (via the tda998x HDMI
> transmitter), and, also, the codec spdif transmitter has a lot of
> sample rates while the Dove audio device supports only 44.1, 48 and 96
> kHz.

All those restrictions should be constrained by either the machine
binding or the driver for the SoC side though.  I do see why you might
want this, I'm just a bit ambivalent about the merits.

> So, instead of adding new hdmi and spdif_transmitter codecs,
> I thought it could be useful to have a generic codec with DT support.

> On the other hand, as the first use of this codec is for the Cubox,
> an other solution could be to have the codec included in the kirkwood
> driver (declared by DT as either i2s or s/pdif). This would simplify
> the use or not of s/pdif in this driver.

That'd work too.

> > > +Child 'capture' and 'playback' required properties:
> > > +- stream-name: name of the stream

> > What does this mean in the binding?

> Indeed, the stream name could be implicit (either "Playback" or
> "Capture"), but, as the users are aware of it, a more friendly
> name is nicer ("S/PDIF Playback").

So you need to say that it's for display purposes.

> I have no idea about which format is used or not, and there is no
> explanation about their meanings in the uapi (but I can search them..).

> Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
> and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

> So, what do you think should be the format set?

PCM plus IEC seems fine, it's more the more obscure formats that ring
alarm bells.

> > > +Rates:
> > > +	5512
> > > +	8000

> > This shouldn't be a list of defined rates, it should allow any number,
> > and it should support ranges since while some devices do enumerate
> > specific rates simpler devices often just support a continuous range of
> > rates.

> There cannot be any number because the rates are coded by discrete
> values in a bitmap.

Not quite - _KNOT and _CONTINUOUS are options in that bitmap...  in
any case this would be a Linux implementation thing.

> For the continuous range, I was thinking about the value '0' followed
> by the min and max rates. Have you any other syntax in mind?

That'd probably work, not sure if there's a more idiomatic way of doing
that in DT though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/2ddd1c55/attachment-0001.sig>
