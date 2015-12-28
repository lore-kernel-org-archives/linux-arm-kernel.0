From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Mon, 28 Dec 2015 04:06:49 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM,
 Line and Mic inputs
In-Reply-To: <20151227182157.GI30359@lukather>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather>
Message-ID: <20151228040649.475a742f@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Sun, 27 Dec 2015 19:21:57 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Mon, Dec 21, 2015 at 12:34:16PM +0100, Danny Milosavljevic wrote:
> > This is the second part, actually adding FM, Line and Mic inputs.
> 
> Again, having a meaningful and standalone commit log would be nice.

Okay, will elaborate some more in v9.

> > +#define SUN4I_CODEC_ADC_ACTL_PREG1_A10			(25)
> > +#define SUN4I_CODEC_ADC_ACTL_PREG2_A10			(23)
> 
> Why the A10 suffix?

The sun4i*_a10 names are for things that work on A10 but not on A20.
This way whoever touches the driver later can know for which things he has
to consider multiple cases.
Otherwise he will have no indication that he is using a bit index where 
there sometimes is no bit (or, worse, the wrong bit).

It's intended to be used like this:

sun4i_foo_a10
	foo is sun4i_foo_a10 on A10 (only).
sun4i_foo
	foo is sun4i_foo on A10 and also on future chips (like A20).
sun7i_foo
	foo is sun7i_foo on A20 and (hopefully) also on future chips.

In this case these defines are for PREG for A10 only.
The A20+ PREG are in the PHONE_CAL register, at other indices.

> Are you using that PHONEOUT stuff anywhere?

Nope.

I was just including all the bits of the register because I usually aim for 
completeness by ensuring that there are no gaps in the bit index ranges. 

With all the stripping out of the bit range comments that won't be possible 
anymore anyway, so I'll just get rid of the PHONEOUT defines in v9, too.

> There's no need to give your sources here.

Ok, will remove.

For the record, there are multiple versions of each of the documents 
and if you pick the wrong ones it will look as if there were more 
differences between A10 and A20 than there actually are.

> > +static const char * const sun4i_codec_capture_source[] = {
> > +	"Line-In",
> > +	"FM",
> > +	"Mic1",
> > +	"Mic2",
> > +	"Mic1,Mic2",
> > +	"Mic1+Mic2",
> > +	"Output Mixer",
> > +	"Line-In,Mic1",
> > +};
> > +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> > +			    SUN4I_CODEC_ADC_ACTL,
> > +			    SUN4I_CODEC_ADC_ACTL_ADCIS,
> > +			    sun4i_codec_capture_source);
> 
> Isn't it possible to expose this as two (shared) muxes with different
> names to make it clear what will go to the left ADC and what will go
> to the right?

I don't know how to do that. I'll try to find out.

(It would be best if someone who knows how that should act did the alsamixer 
testing later too, though)

Can two muxes use the same bit in the hardware without problems?
Or do you mean reuse the same mux instance? (I think _new1 always creates 
a new instance from each struct kcontrol_new automatically).

> The power amplifier is only for the playback, so there's no need to
> differentiate between playback and capture. The current name was fine.

"Power Amplifier Volume" shows up as Capture control in alsamixer as well.
It isn't supposed to be a Capture control.

> > +	/* Line-In, FM, Mic1, Mic2 */ \
> > +	SOC_SINGLE_TLV("Line-In Playback Volume", \
...
> > +	SOC_SINGLE_TLV("FM Playback Volume", \
...
> > +	SOC_SINGLE_TLV("Mic Playback Volume", \
...
> 
> Those are not volume it's gain, 

We tried to call the things ..." Gain" before and it was difficult to do, 
with some breakage along the way, see below.
Also, Mark said they should be named ..." Volume" (see 
<https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg15126.html>).

>and it should probably be two different shared controls for mic1 and mic2.

I'll try...

>> "Capture Source"
> This one is the ADC Gain. Please name it that way.

Unfortunately, the strings have meaning to asoc and alsa-lib and you can't go 
renaming them like that without breaking things. The names were carefully 
chosen to make it actually work properly without having to patch alsa-lib and 
parts of ASoC core (which I did before and have since reverted).

In this case, there's a special case in upstream alsa-lib:

alsa-lib-1.0.28:
./src/mixer/simple_none.c:	if (strcmp(name, "Capture Source") == 0) {
...

I'm not totally against naming them like you suggested - but know that you 
are requiring changes in alsa-lib as well then - or presumably breaking the 
user's workflow.

For example the (upstream) "Capture Source" special case in alsa-lib adds 
radio-button-like things to the respective elements. 
You can switch to one of the inputs by pressing Space while its gain element 
is selected.
In the mic case, it's the mic preamplier gain that you press Space on - if it's 
indeed shown as a Capture control...

> And those two are not capture volume, it's the pre-amplifier gain.

I know. There has been a previous small discussion in v4 about that and it's 
really not that easy.

For example for problems with loopback gain see:
<https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg15115.html>

Summary: you have to patch Linux/sound/soc/soc-ops.c and 
alsa-lib-1.0.28/src/mixer/simple_none.c to allow controls that don't end 
in " Volume" to be sliders... and, in some cases, to be visible at all.

> Having all the inputs and all the outputs grouped together would be
> nice.

Yeah, I'll do that in v9.

> The right and left mixer routes should be in the matching sections.
> Ditto.
> Ditto.

Yeah, I'll do that in v9 and add a comment instead.

> > +	/* ADC Capturing Sources */
> 
> "ADC Input Routes"

Yeah, I'll do that in v9.

> You should also have routes from the ADC Input to the Left and Right ADCs

Yeah, I'll do that in v9.

> [should be named] "Mic1 Pre-Amplifier Gain", "Mic2 Pre-Amplifier Gain".

It cannot be selected for recording then since it's not a Capture control.

These things are interdependent, even crossing syscall boundary.

Regards,
   Danny
