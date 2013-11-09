From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 8 Nov 2013 18:23:37 -0600
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131107172920.GH16735@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
 <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
 <20131107172920.GH16735@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3unnmGDD2jGJYHdmYFALdcNa9OcWejLpUdzaxATSAyjSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 11:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 05, 2013 at 04:39:40PM -0600, Matt Sealey wrote:
>> On Wed, Oct 30, 2013 at 2:01 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > That's where validating the modes you're prepared to support becomes
>> > important, and there's hooks in DRM for doing that.
>>
>> Nope! Not in the right place.
>
> Sure it's the right place.  It's the connector which gets to read the
> modes, and the connector is part of the DRM system.

It's really not the right place.

>> > If you can't support those with 148.5MHz dotclocks, then you have to return
>> > MODE_CLOCK_HIGH from the connector's mode_valid callback.
>>
>> Here's the problem; connectors and encoders are initialized under DRM
>> before the display driver. For the connector to even KNOW what the
>> highest valid clock is, it would need to ask the lower level display
>> driver, since the connector and even encoder has no clue of this
>> limitation and shouldn't be hardcoded, or even know what the input
>> pixel clock capabilities are.
>
> That's because the way imx-drm is setup with its multitude of individual
> drivers is utter madness;

This is how all DRM cards are written, even the good ones. For the
connector to be able to ask the crtc "is this mode even supportable?"
it would need a mode_valid callback to call, down to the encoder (and
maybe the encoder would call crtc) and down down to the crtc. No such
callback exists for this exact reason. At the point the connector
pulls EDID modes and uses mode_valid, it's entirely possible and
nearly always true that it doesn't even HAVE an encoder or CRTC.

 there's no way that it will ever move out of
> drivers/staging as long as it messes around violating the internals of
> DRM by playing those kinds of games.  This was discussed at some
> considerable length at kernel summit, with me as the main motivator for
> it - including some private discussions with various people involved.

What it lacks, in this case, is not any functional code in those
components, but a workable model to glue those components together in
the correct order, on a per-board basis.

The appropriate card model isn't implemented - except in crazy
functions in imx-drm-core.c - the rest of it is absolutely fine.

What that doesn't fix is the underlying, unescapable fact above. At
the time the encoder or connector actually goes off and pulls EDID,
parses modes and does it's thing, at least until about 6 months ago,
it was long, long before it was attached to a CRTC.

The ONLY thing that can happen is a call to the crtc mode_fixup()
which exists only to say "go fuck yourself" to a mode_set call.
Nothing ever culls these mode lists after the connector generates
them, because it owns that object and ditching items from it is
semi-dangerous layering violation. So here is the user experience with
the current model:

* User clicks a button in GNOME to set the fanciest resolution they
can find, which is listed in their dialog
* User is told "that mode can't be set, sorry"
* User waits for you to go to sleep and then suffocates you with a pillow

And what it should be is:

* User clicks a button in GNOME to set the fanciest resolution
actually supported with this combination, because the drivers knew
enough to pre-filter invalid modes
* User always gets a valid mode set because it only ever reports valid modes

That second, consumer-oriented, model where the usable mode list is
predicated on results from the *entire* card and not just what the
monitor said, simply wasn't - and I assume still isn't - possible. Why
not? Because when a Radeon is plugged into a monitor it bloody well
supports it, and that's the end of it. People don't make displays that
modern graphics cards can't use. By the time 1080p TVs in common
circulation rolled around for consumer devices, WQXGA monitors already
existed, so desktop PC graphics cards followed suit pretty quickly.

However, some embedded devices have restrictions. I have a couple
devices at home that have a maximum resolution of 1280x720 - because
the SoC doesn't provide anything that can do more than a 75MHz pixel
clock or so. So, that sucks, but it's a real limitation of the SoC
that is essentially insurmountable.

In the case on the i.MX51, it was just never designed to be a
1080p-capable device. However, there is NOTHING in the architecture of
the chip except the maximum clock and some bus bandwidth foibles that
says it's impossible. I can run 1080p at 30 and it operates great in 2D
and even does respectable 3D. The video decoders still work - if you
have a low enough bitrate/complexity movie, it *will* decode 1080p at
30fps. So artificially restricting the displays to "720p maximum" is
overly restrictive to customers, considering that 1366x768,1440x900
are well within the performance of the units. 1600x900, 1920x1080 (low
enough refresh rate) are still usable.

The problem is under DRM


> The DRM model is a card model, just like ALSA.  In this model, the
> subsystem gets initialised once, and at that point all components of
> the "card" are expected to be known.  The reverse is true when tearing
> down a card: the whole card goes away in one go, individual components
> do not.
>
> What this means for DRM is that all CRTCs, connectors and encoders are
> registered with DRM entirely within the card-level ->load callback,
> and all of those are torn down at the ->unload callback.  Between those
> two points in time, nothing in the configuration of the "card" ever
> changes.

Right but there is no card driver, and all the current "embedded" DRM
drivers get around this by making some crass assumptions about the
connections - most of them just have an LCD controller and HDMI
controller built-in so they haven't trampled over the case where the
device tree allowed an i2c device to probe and initialize and somehow
needs discovery to glue into the framework as an encoder. The "encoder
slave" system right now is totally futzed, while it would be a GREAT
point to implement every encoder-connector combination that card
drivers need to pick up, it doesn't have the right functionality.

The reason there's no card driver.. discussed below..

> The same is true of ALSA: ALSA too does not support hotplugging
> individual components.  This is why we have ASoC - ASoC handles the
> grouping up of individual components, works out when all components
> are available, and only then does it register the "card" with ALSA.
> When any of those components go away, ASoC pulls the whole card from
> ALSA.

There's a distinct lack of actual procedure and process standardized
for collecting card data from device tree, and in the case of a single
SoC, the current ALSA/DRM model will be one driver for every board,
and every board needs it's own compatible property, and every board
does *the exact same thing*. You can see this with the current
imx{51|53|6x}-board-{codec} driver model. Every single driver is doing
almost identical stuff, where they share codecs they are doing
ABSOLUTELY identical stuff. There is stuff in the card level driver
that doesn't even do anything at the card level (and the card level
always calls down for this functionality to the codec level).

If device trees were adopted with the intent to allow removal of the
"board setup code written in C and glommed in a directory with the SoC
support code", implementing "card support" for every board is just
moving that crappy platform code from one directory to another with
absolutely zero benefit or flexibility or ability to expose a common
configuration.

What happened with ALSA is the same shit we're going to get with DRM.

> No, not at all.  If you build up the set of components first, before
> involving DRM, then you have the full information.  I'm doing that
> today: the DRM "card" can only finish initialisation when all known
> connectors can find their CRTCs within the DRM card.  If any CRTC
> (== IPU DIs) specified in the DT file for a "connector" (eg, HDMI
> interface, lvds bridge, etc) are not present, the DRM card doesn't
> initialise.

And this is what's missing. So, here's the question: how do you
implement a card-level driver model that marshalls this information
together and submits it to the separate components without, in the
process, creating a whole new driver framework? The need for having
the Connector ask the CRTC what a valid mode is doesn't make sense
here, in that DRM doesn't have such a framework to do such a thing
(reasons above). In the i.MX51 case, the maximum display clock is
*absolutely not* a function of the connector, but it must know this
information in the same way that it would also need to know the
maximum TMDS output clock for the encoder (bzzt - sorry, sir, it
doesn't) so that it can validate the modes, and in the way it knows to
gather the maximum supported TMDS clock from the monitor EDID (if
present).

> Once you have that in place, you have a way to find out the properties
> of the CRTC, and you then have a way to validate the modes properly
> against all parts of the display system.

Right, and your card driver "isn't DRM" in the same way as DRM has a
card model - it operates on the level of a PCIe device driver that
probes and magically sets up *all* it's subordinate buses, encoders,
connectors.

You can do that with i.MX6 HDMI because the HDMI is built into the SoC
- if you added a node for it and added a cross-reference to it, then
it's fine.

What happens in the case where you defined an HDMI transmitter as an
external I2C device - it's connected on this bus, Linux already probed
the thing. Your card model would have to go out and find this i2c
device somehow, and there's not a great way of doing it. What if the
EDID can't be obtained by straight I2C and you have to set some weird
bits inside the transmitter to access the DDC bus? That requires an
API that doesn't exist, and any topology-finding drivers that are
built off the single use case of "we just attach a panel direct to the
SoC by some parallel or differential link" rather than the
intermediate-transmitters case is going to miss out the finer points
of the intermediate-transmitters case.

>> True, and it looks a lot like the Freescale drivers now,
>
> Not at all.  The Freescale drivers use the clk API as this did, and just
> as badly.  I'm afraid that by making that comment, you've just shown that
> you much prefer writing long verbose emails rather than actually reading
> and understanding the subject for which you're responding.
>
> I refer you to this:
>
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_disp.c?h=imx_3.0.35_4.1.0#n155
>
> which clearly shows Freescale's 4.1.0 BSP using the clk API to control
> the DI clock mux.

I understand THAT driver like the back of my hand..

>> think creating a clockdev clock is probably the "correct" way to do
>> it, especially since in debug situations you'd be able to see this -
>> and it's value, and it's current parent - in sysfs along with the
>> other clocks.
>
> The clk API just gets in the way of making the correct decisions.
> Really, it does.  We need to calculate the divider to work out what
> is the right clock to use, or whether we can use a clock.  Having
> that hidden behind the clk API does not give us the ability to make
> that decision.

It shouldn't ever have been hidden anyway, someone completely
over-abstracted the clock API at some point by making it a
query/get/set interface for a generic clock object, where the only
reasonable values are the rate and, in a limited fashion, the parent.

Why not add clk_get_divider() which essentially returns 0 for anything
that's not actually a real divider clock?

>> It might also help to encourage people not to just play with internal
>> clocks, but to create clock devices and use them inside their drivers
>
> Drivers playing with their own _internal_ clocks is entirely reasonable,
> and it's entirely reasonable that they need not be exposed to userspace.
> Take for instance your average PC, it has lots of clocks, especially
> on the video card, none of them exposed.  They've gotten away with that
> for decades.  Why are we any different.
>
> "Oh, we're embedded, we're special!" I hear you cry.  No we're not
> special at all.

No, we're not special in that there's no functional difference, but
the real situation is that as a developer it's REALLY difficult to get
the information you want from some internal clock somewhere compared
to a core SoC clock inside the clkdev framework, and every internal
clock needs it's own magic, custom implementation - which just makes
maintaining it more work since 'everyone' then has to learn not only
how to derive operation from a generic clkdev device, but how the
actual implementation of the internal clock works as well underneath
it.

Which is what clkdev was supposed to get rid of, right? What it does
is make simple cases much easier.

I will agree with you that in this case, this is totally screwy, but I
don't want to see it discourage people from still doing it... that
said........

>> I don't think I like that fractional dividers aren't used; until
>> someone can come up with a great reason why not (except, I think odd
>> fractions dividers are not stable, so it could be just masking off the
>> bottom bit of the fraction is the key) and someone tests it on more
>> than one monitor..
>
> Why fractional dividers are bad news - this is the TMDS clock that
> resulted from the DI being configured with a fractional divider:
>
> http://www.home.arm.linux.org.uk/~rmk/cubox/IMG_1545-adj.JPG
>
> No, that's not blur.  That's the result of a fractional divider before
> the HDMI phy PLL.  The result is that the PLL is frequency modulated,
> and the connected TV basically tells the IMX to "piss off".

Understood.

> It's not "odd fractions" that are a problem

Maybe I should have made myself a bit clearer.. the further away from
0.0 or 0.5 fractional part you get, the less it works, and the further
up from 0.5 the less reliable it is regardless.

There are some odd (as in oddball, not the opposite to even) fractions
that don't make any sense and I found I got more monitors to work if I
just masked off the bottom bit of the divider or bottom two, but that
broke a couple monitors more than it fixed.

What the effect for me was, if I quit using the fractional divider
completely, that it would always get caught by the "clock within a
reasonable distance of the requested rate" catch in many cases, and
then we ignore it and use an external clock, and the amount of testing
someone can do with only 11 monitors, limited spare units, and not a
lot of time to spend is limited. Which you propose later.. who gives a
shit if we can't use fractional rates? Just set the clock right!

There's a funky reason why dropping the divider actually works, or why
probably masking off certain parts of it for certain modes works..

> - I believe Freescale's code is correct

I disagree with that and I'll explain why :)

> the problem is that no one has _thought_ about what this is doing:

I disagree with that since I was thinking about it in 2009.. I just
can't figure out EXACTLY what the real fix is, I never had enough
hardware, time, or patience.

I totally agree with the assessment Alexander had, and I trust your
scopes. A screwy clock gets generated. I don't think it's because of
the "fractional part" though.

They've been doing odd tricks, since the earliest BSP I could find,
and I started working on it at this BSP version;

        http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_disp.c?h=imx_2.6.28#n865

Which was modified at this commit, going further back:

        http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/drivers/mxc/ipu3/ipu_disp.c?h=imx_2.6.28&id=1c930f0b2f1a67c7eb46a045c7517376e8ecaa32

I only fiddled with this thing for the shortest time before moving to
2.6.31 as fast as possible; the code reappears in later BSPs just
ported in with no git history... but here, note that set_rate sets
DI_BS_CLKGEN1, too. There's not really a good reason why it WOULDN'T.

        http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/mxc/ipu3/ipu_common.c?h=imx_2.6.31_10.08.01#n151

And we get to more modern times, and DI_BS_CLKGEN1 is not in the clk API code.

The rounding essentially says you can only have a fraction of 1/2 if
your clock divider integer part is odd. If your clock divider integer
part is even, and the fractional part has a particular set of values
(0.75, 0.8125, 0.875, 0.9375), it'll bump it to the next
(odd-integer-part), unfractioned divider. I never got how that even
worked, but it is, in my opinion, somewhat to do with this gem in
setting DI_BS_CLKGEN1:

        div = ipu_di_read(di, DI_BS_CLKGEN0) & 0xfff;
        div = div / 16; /* Now divider is integer portion */

        /* Setup pixel clock timing */
        /* Down time is half of period */
        ipu_di_write(di, (div << 16), DI_BS_CLKGEN1); <-- right here

Recall that the original code (1c930f0b2f1a) also set the "up" portion here.

If you will notice, it writes the integer part of the divider (so in
Alexanders case, 0x3) to the "down period" component of the second
clock generator register by shifting the entire thing up 16 bits.

According to the docs, DI_BS_CLKGEN1[16] is ANOTHER FRACTION BIT (as
is DI_BS_CLKGEN1[0] for the "up period").

My theory that I could never confirm, is that DI_BS_CLKGEN1 has always
been misprogrammed because it's off-by-one on the actual integer part
of the divider, and there's probably a case for setting the delay
period (top of DI_BS_CLKGEN0) and the "up period" of DI_BS_CLKGEN1
too. I just never had the amount of hardware I'd need to do a
functional test with real devices that gave us those clock dividers.

In Alex's case with his 3.5 divider, the down period is being set to
1.5 (i.e. (0x38 >> 4) <<16) in that bit position. With a 3.0 divider,
dropping 1.5 in the down period is sorta correct. Clock works. Yay?

It also *ALWAYS* works in the external clock case, since the external
clock (as per Freescale) is always used as parent, generating the DI
clock with an exact divider of 2, 4, or 8.

Does that maybe go so far as to explain why those fractional dividers
really don't work properly?

There's a REALLY good explanation in the i.MX6QDRM manual around
"34.7.10.3 Timing generator" which gives exactly how this clock is set
up. What you're expecting as a straight fractional division of a clock
isn't true - every pin output on the DI is derived from a fundamental
timebase which is defined by that fractional divider in DI_BS_CLKGEN0.
What actually goes to the display is THEN derived from that
fundamental timebase modified by the valueS (plural!) in
DI_BS_CLKGEN1. There's a significant amount of math to figure out
whether the exact display timing is going to be valid, not being done
here, but it turns out through pure luck, it tends to work out for a
couple cases..

I never sat down and thought of the actual math required and since it
impacts ALL the waveform generation too, it seemed like a lot of work
I wasn't prepared to do@the time. I don't think I was paid enough
for it, when I was being paid to do it. I don't get paid to do it at
all right now (thank Glob) and nobody's giving me any free hardware
that makes me want to do it... so it's in your court.

> I know what that's doing, it's not rocket science.  But if you have to
> resort to using fractional dividers when you have another clock available
> to generate a precise clock without the inherent instability caused by
> fractional dividers

If DI_BS_CLKGEN1 can be proven mis-programmed and fixing that fixes
the instability, then awesome. I'd like to see that investigated
though.

If not, sure, I agree with you 100%. There's no reason

> Moreover, I'm not the only one to run into _real_ problems with fractional
> dividers - other people have too with the iMX stuff, and have also had to
> disable these fractional dividers too.

Well I've been dealing with them since the i.MX51 taped out and
honestly.. it worked a lot better with the 2.6.26 kernel with the
original hacks, but at that time I don't recall we had any support for
an external clock. As soon as 2.6.28 rolled round we found some weird
problems, and Freescale added code to use external clocks and we
stopped caring because it pretty much always worked, with some
veeerrrrrry strange caveats - most of which were masked by API
deficiencies in the framebuffer subsystem and a distinct inability to
ask the IPU driver what clock it actually set from the code in our
transmitter driver.

Which is, back to an earlier point, *why I want real clkdevs internal
to drivers* since it makes it a lot easier to pass the information
around in a standardized way. The transmitter may need to know
*precisely* what pixel clock was set, and at the encoder level what I
can get back is clk_round_rate rounded by the crtc to the exact clock
it's outputting, rather than recalculating the clock from the mode
information (syncs+totals+blah, you patched this out in your fixes)
and not being able to take into account the rounding EXCEPT if I add
my own API.. to fetch the information. It's more reasonable if the
encoder can just request the crtc's clk handle and do what it may,
than for a special API for passing "mode clock information" came into
it.

What we've not ascertained in reality is not "does it generate a weird
clock" but why did Freescale only limit only those very specific
fractions (why would (if (div & 0xc)==0xc) div+=0x1; div &= 0xf be
"working" for them?) and why don't they set the "up period" in their
driver since 2009? And what happens if we really, really properly
configure the clock generation?

Matt Sealey <neko@bakuhatsu.net>
