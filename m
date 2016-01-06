From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jan 2016 23:09:08 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20151228040649.475a742f@dayas>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
Message-ID: <20160106220908.GE9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 04:06:49AM +0100, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Sun, 27 Dec 2015 19:21:57 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Mon, Dec 21, 2015 at 12:34:16PM +0100, Danny Milosavljevic wrote:
> > > This is the second part, actually adding FM, Line and Mic inputs.
> > 
> > Again, having a meaningful and standalone commit log would be nice.
> 
> Okay, will elaborate some more in v9.
> 
> > > +#define SUN4I_CODEC_ADC_ACTL_PREG1_A10			(25)
> > > +#define SUN4I_CODEC_ADC_ACTL_PREG2_A10			(23)
> > 
> > Why the A10 suffix?
> 
> The sun4i*_a10 names are for things that work on A10 but not on A20.
> This way whoever touches the driver later can know for which things he has
> to consider multiple cases.
> Otherwise he will have no indication that he is using a bit index where 
> there sometimes is no bit (or, worse, the wrong bit).
> 
> It's intended to be used like this:
> 
> sun4i_foo_a10
> 	foo is sun4i_foo_a10 on A10 (only).
> sun4i_foo
> 	foo is sun4i_foo on A10 and also on future chips (like A20).
> sun7i_foo
> 	foo is sun7i_foo on A20 and (hopefully) also on future chips.

I find the sun4i_*_a10 and sun4i highly redundant. If there the same
define for sun7i, then you know that it's not meant to be used for the
A20, and that's it.

My point is also that it will just be an ever growing list of suffixes
when we will support more SoCs, for example for symbols that might be
in the A10, not the A20, but the A31.

> > > +static const char * const sun4i_codec_capture_source[] = {
> > > +	"Line-In",
> > > +	"FM",
> > > +	"Mic1",
> > > +	"Mic2",
> > > +	"Mic1,Mic2",
> > > +	"Mic1+Mic2",
> > > +	"Output Mixer",
> > > +	"Line-In,Mic1",
> > > +};
> > > +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> > > +			    SUN4I_CODEC_ADC_ACTL,
> > > +			    SUN4I_CODEC_ADC_ACTL_ADCIS,
> > > +			    sun4i_codec_capture_source);
> > 
> > Isn't it possible to expose this as two (shared) muxes with different
> > names to make it clear what will go to the left ADC and what will go
> > to the right?
> 
> I don't know how to do that. I'll try to find out.
> 
> (It would be best if someone who knows how that should act did the alsamixer 
> testing later too, though)
> 
> Can two muxes use the same bit in the hardware without problems?
> Or do you mean reuse the same mux instance? (I think _new1 always creates 
> a new instance from each struct kcontrol_new automatically).

Yeah, the case where two widgets share the same bits is handled iirc
but sharing the controls.

> > The power amplifier is only for the playback, so there's no need to
> > differentiate between playback and capture. The current name was fine.
> 
> "Power Amplifier Volume" shows up as Capture control in alsamixer as well.
> It isn't supposed to be a Capture control.
> > > +	/* Line-In, FM, Mic1, Mic2 */ \
> > > +	SOC_SINGLE_TLV("Line-In Playback Volume", \
> ...
> > > +	SOC_SINGLE_TLV("FM Playback Volume", \
> ...
> > > +	SOC_SINGLE_TLV("Mic Playback Volume", \
> ...
> > 
> > Those are not volume it's gain, 
> 
> We tried to call the things ..." Gain" before and it was difficult to do, 
> with some breakage along the way, see below.
> Also, Mark said they should be named ..." Volume" (see 
> <https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg15126.html>).

Ah, my bad.

Judging from ControlNames.txt, the Power Amplifier Volume should
probably called Headphone Playback Volume then.

> >and it should probably be two different shared controls for mic1 and mic2.
> 
> I'll try...
> 
> >> "Capture Source"
> > This one is the ADC Gain. Please name it that way.
> 
> Unfortunately, the strings have meaning to asoc and alsa-lib and you can't go 
> renaming them like that without breaking things. The names were carefully 
> chosen to make it actually work properly without having to patch alsa-lib and 
> parts of ASoC core (which I did before and have since reverted).
> 
> In this case, there's a special case in upstream alsa-lib:
> 
> alsa-lib-1.0.28:
> ./src/mixer/simple_none.c:	if (strcmp(name, "Capture Source") == 0) {
> ...
> 
> I'm not totally against naming them like you suggested - but know that you 
> are requiring changes in alsa-lib as well then - or presumably breaking the 
> user's workflow.
> 
> For example the (upstream) "Capture Source" special case in alsa-lib adds 
> radio-button-like things to the respective elements. 
> You can switch to one of the inputs by pressing Space while its gain element 
> is selected.
> In the mic case, it's the mic preamplier gain that you press Space on - if it's 
> indeed shown as a Capture control...

No, you're totally right, I just entirely missed that ControlNames
files you pointed me to.

Thanks,
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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/db58f132/attachment.sig>
