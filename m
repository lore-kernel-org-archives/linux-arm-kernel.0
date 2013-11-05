From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 5 Nov 2013 16:39:40 -0600
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131030190123.GM16735@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 2:01 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Oct 30, 2013 at 01:01:15PM -0500, Matt Sealey wrote:
>> I seem to
>> remember it needs to be within 2% - 1 bit extra on the fraction and
>> you're 3 times that over the range of accectable clocks monitors MUST
>> accept by specification.
>
> I think 2% may be too generous - that's what I originally tried when
> fiddling around with this and it wasn't good enough in some
> circumstances for my TV to produce a picture.

One day I *will* find the VESA spec where I read that. It is mentioned
somewhere in the HDMI spec as a reference, but the VESA doc isn't
public. There was a time I had access to it - so I have a copy. Will
figure it out...

>> On i.MX51, too, the IPU HSC can't go above 133MHz without making the
>> system unstable, so any mode that needs 148MHz (most high HDMI modes)
>> won't work.
>
> That's where validating the modes you're prepared to support becomes
> important, and there's hooks in DRM for doing that.

Nope! Not in the right place.

> If you can't support those with 148.5MHz dotclocks, then you have to return
> MODE_CLOCK_HIGH from the connector's mode_valid callback.

Here's the problem; connectors and encoders are initialized under DRM
before the display driver. For the connector to even KNOW what the
highest valid clock is, it would need to ask the lower level display
driver, since the connector and even encoder has no clue of this
limitation and shouldn't be hardcoded, or even know what the input
pixel clock capabilities are.

If you specify a mode that the SII9022 can't display at all, or the
monitor connected (via EDID information) says it can't support that
from the maximum TMDS clock field in the EDID, sure, it can send back
MODE_CLOCK_HIGH, but otherwise what needs to happen is the sii9022
driver needs to know FAR too much.

> result in DRM pruning the modes reported by the connector to those
> which the display hardware can support.

Except that the connector cannot know what the display hardware can
support, as above.

I already pointed the above out on the DRM list maybe 18 months ago,
it's a big flaw in the DRM design, and the only way I can figure
around it is to have the connector driver look for it's display
controller in the device tree and read out the clocks from there, or
just a property (max-tmds-clock?) which would hack around it,
overriding a higher value from EDID.

http://thread.gmane.org/gmane.comp.video.dri.devel/65394

>> There's no good reason to use the DI internal clock from IPU HSC,
>> unless you can guarantee an EXACT rate coming out (i.e. if you need
>> 64MHz, then you can get that with 128MHz/2.0 - which is fine.)
>
> This is exactly what I'm doing on my Carrier-1 board.  If the output
> can use the the internal clock (iow, if IPU_DI_CLKMODE_EXT is clear)
> and the IPU clock can generate the dotclock within 1% of the requested
> rate, then we set the DI to use the IPU clock and set the divisor
> appropriately.

In theory there are two things. One is that old VESA spec which says
"we expect some crappy clocks, so anything within a certain range will
work" and the CEA spec which says any mode which is specified as X MHz
as the clock rate would also be required to be displayed at
X*(1000/1001) (which covers NTSC weirdness). So in fact it may only be
0.01% variance that really matters.. 1% could be too high. It depends
if they're following the CEA spec to the letter or the VESA specs to
the letter.

One thing that always got me, and I know this is an aside, is how many
"HDMI" systems people have where they're setting the default video
mode to 1024x768. You'd think nobody ever read the CEA-861 spec, ever
- it specifically states that the ONLY mode guaranteed is 640x480. In
fact, 1024x768 is not in the list for either primary OR secondary
defined CEA modes, so there's a high chance your TV won't do it.
Monitors - sure, they may do it, they may do it because they have to
for Windows Logo certification, but TVs don't get certified by
Microsoft.

> Each of the four cases I handle separately - and I've gotten rid of
> the horrid CCF stuff in ipu-di.c: there's really no need for that
> additional complication here, we're not sharing this mux and divisor
> which are both internal to the DI with anything else.
>
> Consequently, my ipu-di.c (relative to v3.12-rc7) looks like this,
> and works pretty well with HDMI, providing a stable picture with
> almost all mode configurations reported by my TV.
>
> It's also fewer lines too. :)

True, and it looks a lot like the Freescale drivers now, but I do
think creating a clockdev clock is probably the "correct" way to do
it, especially since in debug situations you'd be able to see this -
and it's value, and it's current parent - in sysfs along with the
other clocks.

It might also help to encourage people not to just play with internal
clocks, but to create clock devices and use them inside their drivers
- tons of audio stuff has manual clock management right now, and all
this information gets lost through (IMO) needless abstraction in the
audio subsystem. I might be convinced that it's not needless, but I
would still say there's no good reason NOT to implement any clock
which has a parent which is a registered clkdev clock as a clkdev
clock itself, and expose it with the rest of the clock debug
infrastructure.

I don't think I like that fractional dividers aren't used; until
someone can come up with a great reason why not (except, I think odd
fractions dividers are not stable, so it could be just masking off the
bottom bit of the fraction is the key) and someone tests it on more
than one monitor..

I can break out my monitor testing regime, once I figure out the
i.MX51 stuff. I have a few HDMI monitors I bought over the years which
were notoriously flakey, and a few DVI ones that had real trouble
being connected to a real HDMI source at some point.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
