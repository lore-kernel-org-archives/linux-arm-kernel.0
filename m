From: neko@bakuhatsu.net (Matt Sealey)
Date: Sat, 9 Nov 2013 00:11:51 -0600
Subject: imx-drm: Add HDMI support
In-Reply-To: <20131109005317.GW16735@n2100.arm.linux.org.uk>
References: <52602EEA.6060402@prisktech.co.nz>
 <20131017193948.GT25034@n2100.arm.linux.org.uk>
 <1382039535.976669051@f130.i.mail.ru>
 <CAHCPf3viBN5RwxPYGN_gMhbgbJbwJAQDJKHHYFyLUFBqvsFztg@mail.gmail.com>
 <20131030190123.GM16735@n2100.arm.linux.org.uk>
 <CAHCPf3sFe4Z6-pfR+4wk4Z_aSHzyzQN8j1KgpF5Uq+W9HLzoWQ@mail.gmail.com>
 <20131107172920.GH16735@n2100.arm.linux.org.uk>
 <CAHCPf3unnmGDD2jGJYHdmYFALdcNa9OcWejLpUdzaxATSAyjSQ@mail.gmail.com>
 <20131109005317.GW16735@n2100.arm.linux.org.uk>
Message-ID: <CAHCPf3uMnMgTH_ywpuWM5x-1vcvsEVHN8dn6=b26_-s75msbVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 6:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 08, 2013 at 06:23:37PM -0600, Matt Sealey wrote:
>> On Thu, Nov 7, 2013 at 11:29 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>
> Now look at the bigger picture.  What makes the decision about whether
> to use a mode with a particular CRTC?  Is it:
>
> (a) DRM
> (b) Userspace
>
> The answer is not (a) - DRM just does what userspace instructs.  What
> this means is that you can't do per-CRTC validation of mode settings
> without big changes to the API, which aren't going to happen.

That's exactly what I was saying in the first place, and what Alex
Duecher said to me a year ago after I spent 2 days straight crashing
an i.MX51 trying to figure out a way to get the connector to ask the
CRTC for the right information.

So I accept that we can't do validation of modes at a CRTC level, but
what's the solution? I don't accept that it would be to shove mode
culling policy to userspace.

xorg-video-modesetting driver is a gold standard - if all users want
is to get a linear framebuffer with a particular mode (and we should
all be happy for this on ARM since it means KMS is working, horray!),
it should not have to know which modes will actually work or not or be
modified to be platform specific.

In the case of "card drivers" for DRM,  on the kernel side, having a
"card" driver per board to micromanage settings will get as unwieldy
as having multiple platform-specific xorg-video-modesetting patches,
when there are 10 or 20 boards based on a particular chip in mainline,
and 20 or 30 SoCs supported in active use. ALSA is getting away with
it right now because barely anyone has gotten to the point of having
working audio with device tree except the i.MX6 and i.MX5 cases. It
won't scale as it goes forward.

I am betting the one you "have *right* *now*" is the above, you wrote
a driver which, given a very specific set of device tree entries with
specific compatible properties in combination, specifically
initializes several i.MX6-specific components together in the right
order. This also won't scale, going forward.

> Luckily, with imx-drm, in the case of single IPUs, both "crtcs" have
> exactly the same capability as far as clocks go - which is common with
> every other DRM system so far.  So really, there's no need to know which
> CRTC is going to be associated with the connector - we already know the
> capabilities there.

That's not the point I was trying to get across.

> If you'd like to rephrase in a more concise manner then I may read
> your message.

Maybe I am just not explaining it well enough. Here it is in the
shortest way I can do it.

* i.MX6Q - two discrete IPU with two DI. IPU have independent clock,
up to 200MHz for HSC.
* i.MX53/50 - one discrete IPU with two DI. IPU clock up to 150MHz for HSC.
* i.MX51 - one discrete IPU with two DI. IPU clock up to 133MHz for HSC.

Same driver.

DI can divide HSC clock or accept external clock to generate, using a
fractional divider, any clock rate it wants. This clock becomes the
"fundamental timebase" for the DISP_CLK, which is generated as
expected, based on "up" and "down" period values for the fundamental
timebase.

Whether HSC clock or external clock, the maximum DISP_CLK which goes
out to the display is bounded by the current HSC clock rate.

Two problems.

* i.MX51 maximum clock rate (133MHz) is lower than standard pixel
clock rate for 1080p60 and other high-resolution modes with
high-refresh rates

* DI_BS_CLKGEN0 and 1 need to be programmed correctly to generate a
correct DISP_CLK out.

Problem without solution (i.e. DRM filters modes back-asswards):

* i.MX51 connector is probably not part of the SoC, but an independent
and totally divorced component from the IPU. One example is an IPU
parallel display connected to an active HDMI encoder, which may be
provided by companies such as Texas Instruments or Silicon Image.
These things exist in the wild. It is not reasonable for a Silicon
Image transmitter driver as a generic i2c device (which it really is)
to have intimate knowledge of the i.MX51. It is not reasonable for the
Silicon Image transmitter to be predicated upon a specific SoC.

DRM offers no way for an encoder/connector to find out this
information from the correct place - the CRTC driver - at the time it
fetches EDID from the monitor, or gains mode information some other
way. DRM only offers a way to use the maximum TMDS clock from the EDID
to cull modes the *monitor* can't handle in the CVT/GTF mode timing
case (or disable usage of CVT/GTF completely).

Problem with solution (i.e. don't just strip fractions please):

Current programming methodology for DI_BS_CLKGEN1 only takes into
account exact case where DI_BS_CLKGEN0 divider is an integer and is
stuffed into CLKGEN1 "down period" shifted one bit right, which is why
the "strip the fractions" part works.

CLKGEN1 only has a Q8.1 fractional divider whereas CLKGEN0 has a Q12.4
fractional divider.

Any use of anything but the integer part of the CLKGEN0 divider
probably cannot be represented as an exact value in CLKGEN1 without
the original parent clock being multiplied by a suitable value or
CLKGEN0 divider (Q12.4) being further adjusted to allow valid CLKGEN1
values (Q8.1).

Using CLKGEN1 better and doing more comprehensive 'upstream' clock
management may give better results. In the configurations Alex and
yourself tried, it is not possible to derive the correct DISP_CLK from
the fundamental timebase created by CLKGEN0 using the values CLKGEN1
was programmed with. Previous mail, a GEN0 divider of 3.5 ends up as a
GEN1 down period of 1.5. A divider of 3.0 ends up as GEN1 down period
of 1.5.

In this case the solution is to correct the fundamental timebase such
that it is possible to generate that value. Assuming input clock
133MHz, expected rate 38MHz. Simplest case divider is 133/38 = 3.5.
With current code, "down period" will be 1.5 instead of (3/2) but it
should be 1.75 which we cannot represent because of the single
fraction bit.

Possible fix? Set divider to 1.75 instead. DI clock generator will
create a 76MHz clock as fundamental timebase. This *shouldn't* go
directly out on any pins but it's used to synchronize everything else
on the waveform generators. What I could never work out is what to do
next; set GEN1 down period to 3.5? Or 2.0? The diagrams don't explain
whether the period is the relation from timebase to parent clock, or
timebase to DISP_CLK very clearly, bit it seems 2.0 would be the
correct one in this instance (it makes more sense given the current
working divider/down period settings).

Here's my notes from sometime in 2010:

"When the divider is calculated for the pixel clock, what it should be
trying to generate is a Q8.1 number for the "down" and/or "up" periods
in GEN1 (you could just set one of them, dependent on clock polarity
setting, assuming you want your data clocked at the edge of the input
clock.. all stuff the driver kinda glosses over) rather than
concentrating on the fractional divider in GEN0 first. The Q12.4
divider is there so you have more flexibility when you find a perfect
Q8.1 for the up/down clock periods depending on the input clock."

Apart from that contrived case above, I used Alex's case, I couldn't
sit down and write that algorithm even if I had all the coffee in
Columbia (and some other stuff too), I've had 3 years to try and just
didn't. I'm dealing with getting the platform that explains the cases
I have up and running in the first place, dealing with *all* the same
problems you are with the added problem of sometimes ARM not work. I'm
not rushing to get it upstream by a deadline - sometimes my wife
complains that I spent too much time in my office after work - so when
she lets me be, and it actually boots reliably and I figure out a
couple U-Boot problems, maybe we'll get in sync on the issue and be
fixing the same things in collaboration, but until then... I'm
suggesting you might want to do it as it might cause less weird
results later down the road. Of course if you TL;DR it, then you can
live with the broken display driver for as long as you like. Concise?

Thanks :)

Matt Sealey <neko@bakuhatsu.net>
