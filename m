From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 9 Jan 2016 16:48:32 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM,
 Line and Mic inputs
In-Reply-To: <20160106220908.GE9631@lukather>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather>
Message-ID: <20160109164832.515d69b0@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
Hi Mark,

On Wed, 6 Jan 2016 23:09:08 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> I find the sun4i_*_a10 and sun4i highly redundant. If there the same
> define for sun7i, then you know that it's not meant to be used for the
> A20, and that's it.
> 
> My point is also that it will just be an ever growing list of suffixes
> when we will support more SoCs, for example for symbols that might be
> in the A10, not the A20, but the A31.

Okay. I will remove the "_a10" and "_A10" suffixes for v9. 
There are not many places it's used anyway.

> > > Isn't it possible to expose this as two (shared) muxes with different
> > > names to make it clear what will go to the left ADC and what will go
> > > to the right?

That is possible and is working correctly so far. It will probably be in v9.

> Yeah, the case where two widgets share the same bits is handled iirc
> but sharing the controls.

Yeah. The struct kcontrol_new address (of a dapm control) is compared in order 
to find out whether to share the control or not. 

> Judging from ControlNames.txt, the Power Amplifier Volume should
> probably called Headphone Playback Volume then.

Yeah. I'll rename it to "Headphone Playback Volume" for v9.

> > >and it should probably be two different shared controls for mic1 and mic2

Once a control is shared there's just one control to the user.

I now have Mic Playback Volume shared between Left Mixer and Right Mixer 
(Note: was not in v8).
So far so good. (the name will be neither "Left Mixer Mic Playback 
Volume" nor "Right Mixer Mic Playback Volume" but rather "Mic Playback 
Volume" - because of the sharing)

But I can't get having a control for Mic2 Playback Volume that does the same 
as Mic1 Playback Volume (and updates the same register bitrange) to work 
[yet?] instead.

Sharing uses the same control for two different mixers, muxes etc.

The other direction (making two controls which both do the same and update 
each other's value) doesn't seem to be easily available. 
Should I write a _put handler that does it manually?

(Or should that be handled by alsa-lib mixer modules instead?)

Or, come to think of it, did you mean something else?

And something related but different:

Is it possible to merge the "Left Mixer" control and respective 
"Right Mixer" control into one selem in alsamixer?

Because alsamixer actually has support for one-sided muting.

For example:

Left Mixer Left FM Playback Switch and Right Mixer Right FM Playback Switch and 
FM Playback Volume could be one selem "FM Playback". Muting the left mixer left 
fm playback would be done by pressing "," and the right mixer right fm playback 
would be done by pressing ".".

Right now they are 3 different selem for that. So it would help reduce a lot of 
clutter.

(Right Mixer Left DAC Playback Switch - not a typo - would be the odd duck 
 and still be an extra selem)

For Mic there's:
- Left Mixer Mic1 Playback Switch
- Left Mixer Mic2 Playback Switch
- Right Mixer Mic1 Playback Switch
- Right Mixer Mic2 Playback Switch
- Mic Playback Volume

If possible, it could also then be collected together as:
- Mic1 Playback:
    Left Mixer Mic1 Playback Switch, 
    Right Mixer Mic1 Playback Switch, 
    Mic Playback Volume
- Mic2 Playback:
    Left Mixer Mic2 Playback Switch, 
    Right Mixer Mic2 Playback Switch, 
    Mic Playback Volume [note: there it is again]

Is it possible?

Regards,
    Danny
