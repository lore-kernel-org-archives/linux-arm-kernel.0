From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 09:51:21 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <5222EFE5.3010306@metafoo.de>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130901064216.GN6617@n2100.arm.linux.org.uk> <5222EFE5.3010306@metafoo.de>
Message-ID: <20130901085121.GO6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 09:42:29AM +0200, Lars-Peter Clausen wrote:
> Lets try to wrap up the situation:
> 
> * The hardware has one audio stream, but two DAIs, one for SPDIF one for
> I2S. The same audio stream is sent to both DAIs at the same time (It is
> possible though to disable one or both of the DAIs).

More or less.  To be more clear: audio DMA commences when either one or
both outputs are enabled, and stops when both are disabled.

This is why either only one can be enabled, or if both are to be enabled,
both enable bits must be set in one register write, and when disabled,
both bits must be cleared in one register write.

So, lets say for argument sake that you wanted to go from disabled to a
single output, then to dual output, back to single output, and finally
back to disabled.  You would need this sequence:

- enable single output
...
- disable single output
- wait for audio unit to indicate not busy
- enable both outputs
...
- disable both outputs
- wait for audio unit to indicate not busy
- enable single output
...
- disable single output
- wait for audio unit to indicate not busy

> * This is something new and not supported by classical ASoC.
> 
> * DPCM has support for this, but DPCM is still new, unstable,
> under-documented and apparently has a couple of bugs.
> 
> * With non-DPCM ASoC it is possible to have two DAIs if they are not used at
> the same time (which is what I recommend you implement first, before trying
> to get DPCM running).

If you'd look at my other responses, you'll see that this is what I tried
back in May, and I was unhappy about that solution because:

1. there is no guarantee that they couldn't be used at the same time.
2. this results in two entirely separate "CPU DAI"s, each with their
   own independent sample rate/format settings, which if they happen
   to be used together will result in fighting over the same register(s).

Moreover, this results in a completely different set of changes to the
driver which are in an opposing direction to the DPCM approach.

> I still don't know if you actually need to feature of being able to output
> the same audio signal to both DAIs, do you have such a board?

This board has the SPDIF connected to a TOSlink and a HDMI transmitter.
It also has the I2S connected only to the HDMI transmitter, though it's
common at the moment to only use the SPDIF output to drive them both.

Having recently changed the TV connected to the HDMI, I find that where
audio used to work at 48kHz and 44.1kHz with the old TV, it no longer
works on anything but 44.1kHz.  The old TV converted everything to
analogue internally in its HDMI receiver before passing it for further
processing.  The new TV is a modern full HD model, so keeps everything in
the digital domain.  I have yet to work out why the TV is muting itself
with 48kHz audio.  However, audio continues to work via the TOSlink output
at both sample rates.

What I'm saying there is that we may need to have another codec in there
so the HDMI transmitter has access to parameters like the sample rate,
or we may have to switch it to using I2S for PCM audio and back to SPDIF
for compressed audio (I'm hoping not because I think that's going to be
an extremely hard problem to solve.)

This is a brand new problem which I've only discovered during last week.
As I have no SPDIF or HDMI analysers, I don't have an answer for this
at the moment, and the only way I can solve it is by verifying the
existing setup (which I believe is correct to the HDMI v1.3 spec) and
experimenting, which will take some time.

However, that's not a reason to hold up these patches - these patches
do work, and allow audio to be used on this platform in at least some
configurations.

> But even then
> I still recommend to first get the non-DPCM either/or approach implemented
> and once that's working try to get DPCM running. Which probably involves
> fixing some of the DPCM issues in the core. As I said sending the same audio
> streams to two DAIs is something new and if there was no DPCM yet you'd need
> to add support for sending the same stream to multiple DAIs. So either way
> you'd have to get your hands dirty.

Could you comment on the patch which creates the two front-end DAIs which
I sent in a different sub-thread - the one which I indicated was from back
in May time.  It isn't quite suitable for submission because the base it
applies to has changed since then, but it should be sufficient to give an
idea of the solution I was trying to implement there.

> And I'm sure people are willing to help
> you figure out the parts you don't understand yet if you ask _nicely_.

Can you then please explain why when I ask for help understanding DAPM
in a "nice" way, the response I get is just "it's just a graph walk"
and no further technical details?

I explained DAPM as I understood it to someone who knows nothing about it
a fortnight ago, and this is how I described DAPM with only a basic
understanding of it, most of that gathered by having been through some of
the code with printk()s to work out some of the problems I was seeing:

| DAPM is a set of "widgets" representing various components of an
| audio system.  The widgets are linked together by a graph.  Each
| widget lives in a context - cpu, platform or codec.  Some bindings
| only happen within a context, others cross contexts (so linking the
| CPU audio stream to the codec for example)

I didn't want to go into the complexities of which widgets are activated
when a stream starts playing, or the special cases with the various
different types of widget that affect the walking and activation of the
graph.

Notice how much more information there - though it wasn't _that_ coherent
(rather than using "linked" it should've been "bound").  The point is,
I've described that there are widgets, there's a binding of widgets
together, the widgets are associated with a context, and finally that
there are restrictions on what bindings can happen.

I've probably missed out quite a bit too without really knowing it -
because I don't know it yet either.  Yes, I do know about the
Documentation/sound/alsa/soc/dapm.txt document.

> I mean I don't come to you either if I have a new ARM SoC that's not
> supported yet and demand that you implement support for it and exclaim
> that the ARM port sucks because it doesn't support that SoC yet.

If you come to me and ask about something in ARM, then you will most
likely get something more than a few words explaining a big chunk of
code - a bit like the oops report I disected last night and provided
full reasoning of the conclusion that I came to (SDRAM failure /
hardware fault on bit 8 of the SDRAM data bus.)
