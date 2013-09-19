From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 19 Sep 2013 19:34:03 +0200
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
In-Reply-To: <20130919104028.GI21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <20130919104028.GI21013@sirena.org.uk>
Message-ID: <20130919193403.30ac5764@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Sep 2013 11:40:28 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Sep 19, 2013 at 10:54:37AM +0200, Jean-Francois Moine wrote:
> > This patch adds a simple sound codec which is described by the DT.
> > This codec may be used when no specific codec action is needed.
> 
> Hrm.  I'm generally not enthusiastic about this sort of thing because it
> requires every user of the device to understand the capabilities of the
> device instead of being able to just say they have a device of type X -
> it seems better to type the data in once in a driver and then reference
> it.  That said...

Well, first, the codecs hdmi and dmic have no DT support.
Then, from the Cubox point of vue, the codec hdmi offers playback
and capture while the Cubox has only playback (via the tda998x HDMI
transmitter), and, also, the codec spdif transmitter has a lot of
sample rates while the Dove audio device supports only 44.1, 48 and 96
kHz.

So, instead of adding new hdmi and spdif_transmitter codecs,
I thought it could be useful to have a generic codec with DT support.

On the other hand, as the first use of this codec is for the Cubox,
an other solution could be to have the codec included in the kirkwood
driver (declared by DT as either i2s or s/pdif). This would simplify
the use or not of s/pdif in this driver.

> > +Child 'capture' and 'playback' required properties:
> > +- stream-name: name of the stream
> 
> What does this mean in the binding?

Indeed, the stream name could be implicit (either "Playback" or
"Capture"), but, as the users are aware of it, a more friendly
name is nicer ("S/PDIF Playback").

> > +Formats:
> > +	"s8"
> > +	"u8"
> 
> I'd cut this down to just the PCM formats for now - many of the formats
> you list there aren't terribly well defined even within ALSA, I don't
> think some of them have ever been used at all.  A binding document
> should really document what things mean as well.

I have no idea about which format is used or not, and there is no
explanation about their meanings in the uapi (but I can search them..).

Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

So, what do you think should be the format set?

> > +Rates:
> > +	5512
> > +	8000
> 
> This shouldn't be a list of defined rates, it should allow any number,
> and it should support ranges since while some devices do enumerate
> specific rates simpler devices often just support a continuous range of
> rates.

There cannot be any number because the rates are coded by discrete
values in a bitmap.

For the continuous range, I was thinking about the value '0' followed
by the min and max rates. Have you any other syntax in mind?

> > --- a/sound/soc/generic/Kconfig
> > +++ b/sound/soc/generic/Kconfig
> 
> CODEC drivers should go in codecs.

OK.

> > +#define DRV_NAME "simple-codec"
> 
> Just write the string in the one place where it is used.

OK.

> > +static char *format_tb[] = {
> > +	"s8", "u8", "s16_le", "s16_be",
> > +	"u16_le", "u16_be", "s24_le", "s24_be",
> > +	"u24_le", "u24_be", "s32_le", "s32_be",
> > +	"u32_le", "u32_be", "float_le", "float_be",
> > +
> > +	"float64_le", "float64_be", "iec958_subframe_le", "iec958_subframe_be",
> > +	"mu_law", "a_law", "ima_adpcm", "mpeg",
> > +	"gsm", "", "", "",
> > +	"", "", "", "special",
> 
> This seems a bit obscure and fragile - an explicit lookup table would be
> better I think.

OK.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
